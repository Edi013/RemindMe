using System.Net;

namespace RemindMe.Domain.Results
{
    public class BaseResponse
    {
        public HttpStatusCode HttpCodeStatus { get; set; }
        public string Message { get; set; }
    }
}