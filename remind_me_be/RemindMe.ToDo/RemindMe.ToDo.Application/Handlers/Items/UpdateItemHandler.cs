using MediatR;
using Microsoft.Extensions.Configuration;
using RemindMe.Application.Requests.Todos;
using RemindMe.Domain.Entities;
using RemindMe.Domain.Interfaces;
using RemindMe.ToDo.Domain.Results;
using System.Globalization;
using System.Net;

namespace RemindMe.Application.Handlers.Todos
{
    public class UpdateItemHandler : IRequestHandler<UpdateItemRequest, ItemResponse>
    {
        private IItemRepository repository;
        private readonly IConfiguration configuration;


        public UpdateItemHandler(IItemRepository _repository, IConfiguration _configuration)
        {
            repository = _repository;
            configuration = _configuration;
        }

        public async Task<ItemResponse> Handle(UpdateItemRequest request, CancellationToken cancellationToken)
        {
            if (request.Difficulty < 1 || request.Difficulty > 10)
            {
                return new ItemResponse()
                {
                    HttpCodeStatus = System.Net.HttpStatusCode.BadRequest,
                    Message = "Item's difficulty has to be between 1-10.",
                    Id = null,
                    Title = null,
                    Description = null,
                    CreationDate = null,
                    StartDate = null,
                    EndDate = null,
                    IsFinished = null,
                    Difficulty = null,
                    OwnerId = null
                };
            }

            string dateTimeFormat = configuration.GetValue<string>("DateTimeFormat");
            var toUpdateTodo = await repository.SingleOrDefaultAsync(request.Id);
            
            Item newTodo = new Item()
            {
                Id = toUpdateTodo.Id,
                CreationDate = toUpdateTodo.CreationDate,
                OwnerId = toUpdateTodo.OwnerId,

                Title = request.Title,
                Description = request.Description,

                StartDate = DateTime.ParseExact(request.StartDate, dateTimeFormat, null, DateTimeStyles.AssumeUniversal).ToUniversalTime(),
                EndDate = DateTime.ParseExact(request.EndDate, dateTimeFormat, null, DateTimeStyles.AssumeUniversal).ToUniversalTime(),
                IsFinished = request.IsFinished,
                Difficulty = request.Difficulty,
            };
            newTodo = await repository.Update(newTodo); ;
            return  new ItemResponse(){ 
                HttpCodeStatus = HttpStatusCode.OK,
                Message = "Item updated.",
                Id = newTodo.Id,
                Title = newTodo.Title,
                Description = newTodo.Description,
                CreationDate = newTodo.CreationDate,
                StartDate = newTodo.StartDate,
                EndDate = newTodo.EndDate,
                IsFinished = newTodo.IsFinished,
                Difficulty = newTodo.Difficulty,
                OwnerId = newTodo.OwnerId
            };
        }
    }
}
