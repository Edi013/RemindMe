using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.WebUtilities;
using Microsoft.Extensions.Configuration;
using Microsoft.IdentityModel.Tokens;
using RemindMe.Authentication.Domain.DTOs;
using RemindMe.Authentication.Domain.Interfaces.EmailingSystem;
using RemindMe.Authentication.Domain.Models;
using RemindMe.Authentication.Domain.Responses;
using System.IdentityModel.Tokens.Jwt;
using System.Net;
using System.Security.Claims;
using System.Security.Cryptography;
using System.Text;

namespace RemindMe.Authentication.Handlers
{
    public class AuthenticationHandler
    {
        private readonly UserManager<User> _userManager;
        private readonly RoleManager<IdentityRole> _roleManager;
        private readonly IConfiguration _configuration;
        private readonly IEmailService _emailService;

        public AuthenticationHandler(UserManager<User> userManager, RoleManager<IdentityRole> roleManager, IConfiguration configuration, IEmailService emailService)
        {
            _userManager = userManager;
            _roleManager = roleManager;
            _configuration = configuration;
            _emailService = emailService;
        }

        public async Task<BaseResponse> Register(RegisterDto registerDto)
        {
            var existingUser = await _userManager.FindByEmailAsync(registerDto.Email);

            if (existingUser != null) {
                return new BaseResponse()
                {
                    HttpStatusCode = HttpStatusCode.Forbidden,
                    Message = "This email has already been used to register."
                };
            }

            var newUser = new User()
            {
                Email = registerDto.Email,
                NormalizedEmail = registerDto.Email,
                Nickname = registerDto.Nickname,
                NormalizedUserName = registerDto.Nickname,
            };
            newUser.UserName = newUser.Id;

            var result = await _userManager.CreateAsync(newUser, registerDto.Password);

            if(result.Succeeded)
            {
                var accoutDefaultLevel = "Free";
                await _userManager.AddToRoleAsync(newUser, accoutDefaultLevel);

                var rawEmailConfirmationToken = 
                    await _userManager.GenerateEmailConfirmationTokenAsync(newUser);
                var encodedEmailConfirmationToken = Encoding.UTF8.GetBytes(rawEmailConfirmationToken);
                var validEmailConfirmationToken = WebEncoders.Base64UrlEncode(encodedEmailConfirmationToken);

                var authServiceUrl = _configuration.GetSection("AuthServiceUrl").Value;
                var controllerName = "Authentication";
                var enpointName = "ConfirmEmail";
                var emailConfirmationLink = $"{authServiceUrl}/{controllerName}/{enpointName}?userid={newUser.Id}&token={validEmailConfirmationToken}";

                string subject = "Confirmation link for your new account on RemindMe";
                string content = $"To validate your email press this confirmation link {emailConfirmationLink}.\n\nYou can start using your account on RemindMe after you have completed the step above.";
                string[] receivers = new string[] { newUser.Email };
                _emailService.SendEmail(new Domain.Models.EmailingSystem.Message(subject, content, receivers));

                return new BaseResponse()
                {
                    HttpStatusCode = HttpStatusCode.Created,
                    Message = "Account created. Confirmation email has been sent."
                };
            }
            return new BaseResponse()
            {
                HttpStatusCode = HttpStatusCode.InternalServerError,
                Message = "Unexpected error happened on register. Please contact application staff.",
            };
        }

        public async Task<BaseResponse> Login(LoginDto loginDto, HttpContext httpContext)
        {
            var existingUser = await _userManager.FindByEmailAsync(loginDto.Email);

            if (existingUser == null)
            {
                return new BaseResponse()
                {
                    HttpStatusCode = HttpStatusCode.BadRequest,
                    Message = "This email is not registered."
                };
            }

            if(existingUser.EmailConfirmed == false)
            {
                return new BaseResponse()
                {
                    HttpStatusCode = HttpStatusCode.Unauthorized,
                    Message = "You can't log in before validating your accout. Please confirm your email before proceeding again. You can do that by accesing the email sent to you after registering your account here."
                };
            }

            if(!await _userManager.CheckPasswordAsync(existingUser, loginDto.Password)){
                return new BaseResponse()
                {
                    HttpStatusCode = HttpStatusCode.Unauthorized,
                    Message = "Login failed. Invalid password."
                };
            }

            DateTime jwtExpirationDate = DateTime.UtcNow.AddMinutes(30);
            var jwt = await GenerateJwtAsync(existingUser, jwtExpirationDate);

            //string refreshToken = GenerateRefreshToken();
            //DateTime jwtRefreshTokenExpirationDate = DateTime.UtcNow.AddHours(5);

            /*existingUser.Jwt = jwt.ToString();
            existingUser.JwtExpirationDate = jwtExpirationDate;
            existingUser.JwtRefreshToken = refreshToken;
            existingUser.JwtRefreshTokenExpirationDate = jwtRefreshTokenExpirationDate;
*/
            //use cookies

            httpContext.Response.Cookies.Append("Jwt",
                jwt,
                new CookieOptions{
                    HttpOnly = false,
                    Secure = false,  // Set to true if using HTTPS
                    SameSite = SameSiteMode.Lax,  
                    Expires = jwtExpirationDate
                });
            /*httpContext.Response.Cookies.Append("JwtRefreshToken",
                refreshToken,
                new CookieOptions
                {
                    HttpOnly = true,
                    Secure = true,  
                    SameSite = SameSiteMode.Strict, 
                    Expires = jwtRefreshTokenExpirationDate
                });*/

            // sau 

            //httpContext.Response.Cookies.Append("Jwt", jwt);
            //httpContext.Response.Cookies.Append("JwtRefreshToken", refreshToken);

            // use headers : 
            //httpContext.Response.Headers.Add("Authorization", "Bearer " + jwt);
            //httpContext.Response.Headers.Add("Token-Expiration", jwtExpirationDate.ToString(
            //  _configuration.GetSection("DateTimeFormat").Value));

            return new BaseResponse()
            {
                HttpStatusCode = HttpStatusCode.Accepted,
                Message = "Login succesful.",
                //Jwt = jwt,  
                //JwtExpiration = jwtExpirationDate
            };
        }

        private async Task<string> GenerateJwtAsync(User user, DateTime jwtExpirationDate)
        {
            var audience = new List<string>{
                            _configuration.GetSection("JWT:ValidAudience:Postman").Value,
                            _configuration.GetSection("JWT:ValidAudience:FlutterClient").Value,
                            _configuration.GetSection("JWT:ValidAudience:ToDoService").Value,

            };
            var authClaims = new List<Claim>
            {
                //this jwt id
                new Claim(JwtRegisteredClaimNames.Jti, Guid.NewGuid().ToString()),

                new Claim("Email", user.Email),
                new Claim("Username", user.Nickname),
                new Claim(JwtRegisteredClaimNames.Aud, audience[0]),
                new Claim(JwtRegisteredClaimNames.Aud, audience[1])
            };

            var userRoles = await _userManager.GetRolesAsync(user);
            for(var i = 0; i < userRoles.Count; i++)
            {
                authClaims.Add(new Claim($"Role", userRoles[i])); //  "Role {i}"
            }

            var key = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(
                _configuration["Jwt:Secret"] ?? throw new InvalidOperationException("Secret key not present")
            ));
            var signingCredentials = new SigningCredentials(key, SecurityAlgorithms.HmacSha512Signature);

           
            var token = new JwtSecurityToken(
                issuer: _configuration["JWT:ValidIssuer"],
                //audience: audience,
                expires: jwtExpirationDate,
                claims: authClaims,
                signingCredentials: signingCredentials
            );

            return new JwtSecurityTokenHandler().WriteToken(token);
        }

        private static string GenerateRefreshToken()
        {
            var randomNumber = new byte[64];

            using var generator = RandomNumberGenerator.Create();

            generator.GetBytes(randomNumber);

            return Convert.ToBase64String(randomNumber);
        }

        public async Task<BaseResponse> SeedRoles()
        {
            if(! await _roleManager.RoleExistsAsync("Free"))
            {
                await _roleManager.CreateAsync(new IdentityRole()
                {
                    Name = "Free",
                    NormalizedName = "Free",
                });
            }

            if (!await _roleManager.RoleExistsAsync("Premium"))
            { 
                await _roleManager.CreateAsync(new IdentityRole()
                {
                    Name = "Premium",
                    NormalizedName = "Premium",
                });
            }

            return new BaseResponse()
            {
                HttpStatusCode = HttpStatusCode.Created,
                Message = "Roles have been seed."
            };
        }

        public async Task<BaseResponse> ConfirmEmail(string userId, string token)
        {
            var invalidRequestDataResponse = new BaseResponse()
            {
                HttpStatusCode = System.Net.HttpStatusCode.BadRequest,
                Message = "Confirmation data is invalid. Email was not confirmed."
            };

            if (string.IsNullOrEmpty(userId) || string.IsNullOrEmpty(token))
            {
                return invalidRequestDataResponse;
            }

            var user = await _userManager.FindByIdAsync(userId);
            if (user == null) {
                return invalidRequestDataResponse;
            }

            var encodedToken = WebEncoders.Base64UrlDecode(token); 
            var rawToken = Encoding.UTF8.GetString(encodedToken);

            var result = await _userManager.ConfirmEmailAsync(user, rawToken);

            if(result.Succeeded)
            {
                return new BaseResponse()
                {
                    HttpStatusCode = System.Net.HttpStatusCode.OK,
                    Message = "Email was confirmed"
                };
            }

            return new BaseResponse()
            {
                HttpStatusCode = HttpStatusCode.InternalServerError,
                Message = "Unexpected error happened on confirming email. Please contact application staff.",
            };
        }

        // endpoint to check if a token is valid
        // correct format or not
        // expired or not
        // endpoint to refresh the jwt/token being given the refresh token
        //refresh model
        // if jwt is valid but expired
        //      check if the refresh token is valid and not expired
        //          return new jwt
    }
}

