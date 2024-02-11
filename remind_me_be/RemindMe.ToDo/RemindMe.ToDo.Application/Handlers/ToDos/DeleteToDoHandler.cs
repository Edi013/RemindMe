using MediatR;
using RemindMe.Application.Requests.Todos;
using RemindMe.Domain.Interfaces;
using RemindMe.Domain.Results;

namespace RemindMe.Application.Handlers.Todos
{
    public class DeleteTodoHandler : IRequestHandler<DeleteTodoRequest, BaseResponse>
    {
        private ITodoRepository repository;

        public DeleteTodoHandler(ITodoRepository _repository)
        {
            repository = _repository;
        }

        public async Task<BaseResponse> Handle(DeleteTodoRequest request, CancellationToken cancellationToken)
        {
            await repository.DeleteById(request.Id);

            return new BaseResponse()
            {
                HttpCodeStatus = System.Net.HttpStatusCode.OK,
                Message = "Item deleted."
            };
        }
    }
}
