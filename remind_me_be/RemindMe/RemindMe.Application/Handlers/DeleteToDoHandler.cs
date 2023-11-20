using BusinessTrips.Domain.Results;
using MediatR;
using RemindMe.Application.Requests.ToDos;
using RemindMe.Domain.Entities;
using RemindMe.Domain.Interfaces;

namespace RemindMe.Application.Handlers
{
    public class DeleteToDoHandler : IRequestHandler<DeleteToDoRequest, BaseResult>
    {
        private IToDoRepository repository;

        public DeleteToDoHandler(IToDoRepository _repository)
        {
            repository = _repository;
        }

        public async Task<BaseResult> Handle(DeleteToDoRequest request, CancellationToken cancellationToken)
        {
            await repository.DeleteById(request.Id);

            return new BaseResult()
            {
                HttpCodeStatus = System.Net.HttpStatusCode.OK,
                Message = "Item deleted."
            };
        }
    }
}
