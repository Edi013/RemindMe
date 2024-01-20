using MediatR;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using RemindMe.Application.Requests.ToDos;
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

        [Authorize]
        [HttpGet("GetAll")]
        public async Task<IEnumerable<ToDo>> GetAll()
        {
            var req = new GetAllToDoRequest();

            _logger.LogInformation("GetAll [GET] request for ToDos.");
            var result = await _mediator.Send(req, CancellationToken.None);
            return result;
        }

        [HttpPost("Create")]
        public async Task<ToDo> CreateToDo(CreateToDoRequest req)
        {
            _logger.LogInformation("Create [POST] request for a ToDo.");

            return await _mediator.Send(req, CancellationToken.None);
        }

        [HttpDelete("Delete")]
        public async Task<BaseResult> DeleteToDo(DeleteToDoRequest req)
        {
            _logger.LogInformation($"Delete [DELETE] request for ToDo with id {req.Id}.");

            return await _mediator.Send(req, CancellationToken.None);
        }

        [HttpPut("Update")]
        public async Task<ToDo> UpdateToDo(UpdateToDoRequest req)
        {
            _logger.LogInformation($"Update [PUT] request for ToDo with id {req.Id}.");

            return await _mediator.Send(req, CancellationToken.None);
        }


    }
}
