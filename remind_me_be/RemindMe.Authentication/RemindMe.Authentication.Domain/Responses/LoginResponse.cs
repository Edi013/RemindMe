namespace RemindMe.Authentication.Domain.Responses
{
    public class LoginResponse : BaseResponse
    {
        public string Jwt { get; set; } = String.Empty;
        public string JwtExpiration { get; set; } = String.Empty;
    }
}
