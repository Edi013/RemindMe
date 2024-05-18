using RemindMe.Authentication.Domain.DTOs;
using RemindMe.Authentication.Domain.Responses;

namespace RemindMe.Authentication.Domain.Interfaces
{
    public interface IAuthenticationHandler
    {
        public  Task<BaseResponse> Register(RegisterDto registerDto);

        public  Task<LoginResponse> Login(LoginDto loginDto);

        public  Task<BaseResponse> SeedRoles();

        public  Task<BaseResponse> ConfirmEmail(string userId, string token);
    }
}
