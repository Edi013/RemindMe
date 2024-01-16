using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.WebUtilities;
using Microsoft.Extensions.Configuration;
using RemindMe.Authentication.Domain.DTOs;
using RemindMe.Authentication.Domain.Interfaces.EmailingSystem;
using RemindMe.Authentication.Domain.Models;
using System.Net;
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

        public async Task<BaseResult> Register(RegisterDto registerDto)
        {
            var existingUser = await _userManager.FindByEmailAsync(registerDto.Email);

            if (existingUser != null) {
                return new BaseResult()
                {
                    HttpStatusCode = HttpStatusCode.Forbidden,
                    Message = "This email has already been used to register."
                };
            }

            var newUser = new User()
            {
                Email = registerDto.Email,
                NormalizedEmail = registerDto.Email,
                Username = registerDto.Username,
                NormalizedUserName = registerDto.Username,
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

                var appUrl = _configuration.GetSection("AppUrl").Value;
                var controllerName = "Authentication";
                var enpointName = "ConfirmEmail";
                var emailConfirmationLink = $"{appUrl}/{controllerName}/{enpointName}?userid={newUser.Id}&token={validEmailConfirmationToken}";

                string subject = "Confirmation link for your new account on RemindMe";
                string content = $"To validate your email press this link <a href=\"{emailConfirmationLink}\"> confirmation link </a>.\n\nYou can start using your account on RemindMe after you have completed the step above.";
                string[] receivers = new string[] { newUser.Email };
                _emailService.SendEmail(new Domain.Models.EmailingSystem.Message(subject, content, receivers));

                return new BaseResult()
                {
                    HttpStatusCode = HttpStatusCode.Created,
                    Message = "Account created. Confirmation email has been sent."
                };
            }
            return new BaseResult()
            {
                HttpStatusCode = HttpStatusCode.InternalServerError,
                Message = "Unexpected error happened on register. Please contact application staff.",
            };
        }

        public async Task<BaseResult> Login(LoginDto loginDto)
        {
            var existingUser = await _userManager.FindByEmailAsync(loginDto.Email);

            if (existingUser == null)
            {
                return new BaseResult()
                {
                    HttpStatusCode = HttpStatusCode.BadRequest,
                    Message = "This email is not registered."
                };
            }

            if(existingUser.EmailConfirmed == false)
            {
                return new BaseResult()
                {
                    HttpStatusCode = HttpStatusCode.Unauthorized,
                    Message = "You can't log in before validating your accout. Please confirm your email before proceeding again. You can do that by accesing the email sent to you after registering your account here."
                };
            }

            if(!await _userManager.CheckPasswordAsync(existingUser, loginDto.Password)){
                return new BaseResult()
                {
                    HttpStatusCode = HttpStatusCode.Unauthorized,
                    Message = "Login failed. Invalid password."
                };
            }
            return new BaseResult()
            {
                HttpStatusCode = HttpStatusCode.Accepted,
                Message = "Login succesful."
            };
        }

        public async Task<BaseResult> SeedRoles()
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

            return new BaseResult()
            {
                HttpStatusCode = HttpStatusCode.Created,
                Message = "Roles have been seed."
            };
        }

        public async Task<BaseResult> ConfirmEmail(string userId, string token)
        {
            var invalidRequestDataResponse = new BaseResult()
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
                return new BaseResult()
                {
                    HttpStatusCode = System.Net.HttpStatusCode.OK,
                    Message = "Email was confirmed"
                };
            }

            return new BaseResult()
            {
                HttpStatusCode = HttpStatusCode.InternalServerError,
                Message = "Unexpected error happened on confirming email. Please contact application staff.",
            };
        }
    }
}

