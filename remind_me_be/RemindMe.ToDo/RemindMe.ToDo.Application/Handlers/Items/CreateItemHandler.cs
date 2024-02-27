using MediatR;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Configuration;
using Microsoft.SqlServer.Server;
using RemindMe.Application.Requests.Todos;
using RemindMe.Domain.Entities;
using RemindMe.Domain.Interfaces;
using RemindMe.ToDo.Domain.Results;
using System.Globalization;
using System.Net;
using System.Text.Json;

namespace RemindMe.Application.Handlers.Todos
{
    public class CreateItemHandler : IRequestHandler<CreateItemRequest, ItemResponse>
    {
        private IItemRepository repository;
        private readonly IConfiguration configuration;

        public CreateItemHandler(IItemRepository _repository, IConfiguration _configuration)
        {
            repository = _repository;
            configuration = _configuration;
        }

        public async Task<ItemResponse> Handle(CreateItemRequest request, CancellationToken cancellationToken)
        {
            if(request.Difficulty < 1 || request.Difficulty > 10)
            {
                return new ItemResponse
                {
                    HttpCodeStatus = HttpStatusCode.BadRequest,
                    Message = "Item created successfully",
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
            var newTodo = new Item()
            {
                Title = request.Title,
                Description = request.Description,
                CreationDate = DateTime.ParseExact(request.CreationDate, dateTimeFormat, null, DateTimeStyles.AssumeUniversal).ToUniversalTime(),
                StartDate = DateTime.ParseExact(request.StartDate, dateTimeFormat, null, DateTimeStyles.AssumeUniversal).ToUniversalTime(),
                EndDate = DateTime.ParseExact(request.EndDate, dateTimeFormat, null, DateTimeStyles.AssumeUniversal).ToUniversalTime(),
                IsFinished = request.IsFinished,
                Difficulty = request.Difficulty,
                OwnerId = request.OwnerId,
            };
            Item operationResult = await repository.Add(newTodo);
            return new ItemResponse
            {
                HttpCodeStatus = HttpStatusCode.Created,
                Message = "Item created succesfully",
                Id = operationResult.Id,
                Title = operationResult.Title,
                Description = operationResult.Description,
                CreationDate = operationResult.CreationDate,
                StartDate = operationResult.StartDate,
                EndDate = operationResult.EndDate,
                IsFinished = operationResult.IsFinished,
                Difficulty = operationResult.Difficulty,
                OwnerId = operationResult.OwnerId
            };
        }
    }
}
