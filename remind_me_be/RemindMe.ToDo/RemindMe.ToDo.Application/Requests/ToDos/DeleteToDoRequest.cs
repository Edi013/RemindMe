using MediatR;
using RemindMe.Domain.Results;

namespace RemindMe.Application.Requests.Todos
{
    public class DeleteTodoRequest : IRequest<BaseResponse>
    {
        public int Id { get; set; }
    }
}