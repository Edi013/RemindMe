using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using RemindMe.Authentication.Domain.DTOs;
using RemindMe.Authentication.Domain.Models;
using System.Net;

namespace RemindMe.Authentication.Handlers
{
    public class AuthenticationHandler
    {
        private readonly UserManager<User> _userManager;
        private readonly RoleManager<IdentityRole> _roleManager;
        private readonly IConfiguration _configuration;

        public AuthenticationHandler(UserManager<User> userManager, RoleManager<IdentityRole> roleManager, IConfiguration configuration)
        {
            _userManager = userManager;
            _roleManager = roleManager;
            _configuration = configuration;
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
                await _userManager.AddToRoleAsync(newUser, "Free"); //AccountLevel.Levels.First()

                //send confirmation email

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
    }
}

