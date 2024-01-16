using System.Net;

namespace RemindMe.Emailing.Domain.Models
{
    public class BaseResult
    {
        public HttpStatusCode HttpStatusCode { get; set; }
        public string Message { get; set; }
    }
}
