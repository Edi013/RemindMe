using System.Net;

namespace RemindMe.Authentication.Domain.Responses
{
    public class BaseResponse
    {
        public HttpStatusCode HttpStatusCode { get; set; }
        public string Message { get; set; }
    }
}
