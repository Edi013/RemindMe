using MediatR;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using RemindMe.Application.Requests.Todos;
using RemindMe.Domain.Entities;
using RemindMe.Domain.Results;

namespace RemindMe.Controller
{
    [ApiController]
    [Route("Api/[controller]")]
    public class ToDoController : ControllerBase
    {
        private readonly IMediator _mediator;
        private readonly ILogger<ToDoController> _logger;

        public ToDoController(IMediator mediator, ILogger<ToDoController> logger)
        {
            this._mediator = mediator;
            this._logger = logger;
        }

        //[Authorize]
        [HttpGet("GetAll")]
        public async Task<IEnumerable<Item>> GetAll()
        {
            var req = new GetAllTodoRequest();

            _logger.LogInformation("GetAll [GET] request for Todos / Items.");
            var result = await _mediator.Send(req, CancellationToken.None);
            return result;
        }

        [HttpPost("Create")]
        public async Task<Item> CreateTodo(CreateTodoRequest req)
        {
            _logger.LogInformation("Create [POST] request for a Todo / Item.");

            return await _mediator.Send(req, CancellationToken.None);
        }

        [HttpDelete("Delete")]
        public async Task<BaseResult> DeleteTodo(DeleteTodoRequest req)
        {
            _logger.LogInformation($"Delete [DELETE] request for Todo / Item with id {req.Id}.");

            return await _mediator.Send(req, CancellationToken.None);
        }

        [HttpPut("Update")]
        public async Task<Item> UpdateTodo(UpdateTodoRequest req)
        {
            _logger.LogInformation($"Update [PUT] request for Todo / Item with id {req.Id}.");

            return await _mediator.Send(req, CancellationToken.None);
        }


    }
}
