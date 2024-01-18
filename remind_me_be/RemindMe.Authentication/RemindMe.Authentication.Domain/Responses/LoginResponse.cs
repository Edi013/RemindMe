namespace RemindMe.Authentication.Domain.Responses
{
    public class LoginResponse : BaseResponse
    {
        //public string UserId { get; set; }
        public string Jwt { get; set; }
        public DateTime JwtExpiration { get; set; }
    }
}
