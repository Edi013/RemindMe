using RemindMe.Authentication.Domain.DTOs;

namespace RemindMe.Authentication.Domain.Interfaces
{
    public interface IRepository
    {
        IRepository Register(RegisterDto registerDto);
    }
}
