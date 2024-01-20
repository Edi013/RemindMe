using MediatR;
using RemindMe.Domain.Results;

namespace RemindMe.Application.Requests.Todos
{
    public class DeleteTodoRequest : IRequest<BaseResult>
    {
        public int Id { get; set; }
    }
}