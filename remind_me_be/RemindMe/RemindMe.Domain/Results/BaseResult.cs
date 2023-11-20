using System.Net;

namespace BusinessTrips.Domain.Results
{
    public class BaseResult
    {
        public HttpStatusCode HttpCodeStatus { get; set; }
        public string Message { get; set; }
    }
}