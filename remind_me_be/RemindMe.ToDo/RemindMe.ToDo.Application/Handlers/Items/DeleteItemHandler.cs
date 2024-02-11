using MediatR;
using RemindMe.Application.Requests.Todos;
using RemindMe.Domain.Interfaces;
using RemindMe.Domain.Results;

namespace RemindMe.Application.Handlers.Todos
{
    public class DeleteItemHandler : IRequestHandler<DeleteItemRequest, BaseResponse>
    {
        private IItemRepository repository;

        public DeleteItemHandler(IItemRepository _repository)
        {
            repository = _repository;
        }

        public async Task<BaseResponse> Handle(DeleteItemRequest request, CancellationToken cancellationToken)
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
