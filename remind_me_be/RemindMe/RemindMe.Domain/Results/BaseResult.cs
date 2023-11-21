using System.Net;

namespace RemindMe.Domain.Results
{
    public class BaseResult
    {
        public HttpStatusCode HttpCodeStatus { get; set; }
        public string Message { get; set; }
    }
}