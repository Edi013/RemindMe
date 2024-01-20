using MediatR;
using RemindMe.Domain.Results;

namespace RemindMe.Application.Requests.ToDos
{
    public class DeleteToDoRequest : IRequest<BaseResult>
    {
        public int Id { get; set; }
    }
}