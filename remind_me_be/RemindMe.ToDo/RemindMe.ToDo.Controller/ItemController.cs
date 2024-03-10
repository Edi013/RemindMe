using MediatR;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using RemindMe.Application.Requests.Todos;
using RemindMe.Domain.Entities;
using RemindMe.Domain.Results;
using RemindMe.ToDo.Application.Requests.Items;
using RemindMe.ToDo.Domain.Results;

namespace RemindMe.Controller
{
    [ApiController]
    [Route("Api/[controller]")]
    public class ItemController : ControllerBase
    {
        private readonly IMediator _mediator;
        private readonly ILogger<ItemController> _logger;

        public ItemController(IMediator mediator, ILogger<ItemController> logger)
        {
            this._mediator = mediator;
            this._logger = logger;
        }

        [Authorize]
        [HttpGet("GetAllByUserId/{ownerId}")]
        public async Task<IEnumerable<Item>> GetAllByUserId(String ownerId)
        {
            var req = new GetAllItemRequest() { UserId = ownerId };

            _logger.LogInformation("GetAll [GET] request for Todos / Items.");
            var result = await _mediator.Send(req, CancellationToken.None);
            return result;
        }

        [Authorize]
        [HttpGet("GetAllActiveByUserIdItem/{ownerId}")]
        public async Task<IEnumerable<Item>> GetAllActiveByUserIdItem(String ownerId)
        {
            var req = new GetAllActiveItemRequest() { UserId = ownerId };
            _logger.LogInformation("GetAllActiveItem [GET] request for Todos / Items.");
            var result = await _mediator.Send(req, CancellationToken.None);
            return result;
        }

        [Authorize]
        [HttpPost("Create")]
        public async Task<ItemResponse> CreateTodo(CreateItemRequest req)
        {
            _logger.LogInformation("Create [POST] request for a Todo / Item.");
            var result = await _mediator.Send(req, CancellationToken.None);
            return result;
        }

        [Authorize]
        [HttpDelete("Delete")]
        public async Task<BaseResponse> DeleteTodo(DeleteItemRequest req)
        {
            _logger.LogInformation($"Delete [DELETE] request for Todo / Item with id {req.Id}.");
            var result = await _mediator.Send(req, CancellationToken.None);
            return result;
        }

        [Authorize]
        [HttpPut("Update")]
        public async Task<ItemResponse> UpdateTodo(UpdateItemRequest req)
        {
            _logger.LogInformation($"Update [PUT] request for Todo / Item with id {req.Id}.");
            var result = await _mediator.Send(req, CancellationToken.None);
            return result;
        }
    }
}
