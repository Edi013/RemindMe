using BusinessTrips.Domain.Results;
using MediatR;

namespace RemindMe.Application.Requests.ToDos
{
    public class DeleteToDoRequest : IRequest<BaseResult>
    {
        public int Id { get; set; }
    }
}