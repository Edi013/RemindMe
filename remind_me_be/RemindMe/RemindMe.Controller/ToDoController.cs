using log4net;
using MediatR;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Logging;
using RemindMe.Application.Handlers.Logging;
using RemindMe.Application.Requests.ToDos;
using RemindMe.Domain.Entities;
using RemindMe.Domain.Results;

namespace RemindMe.Controller
{
    [ApiController]
    [Route("Api/[controller]")]
    public class ToDoController : ControllerBase
    {
        private readonly IMediator mediator;
        private readonly IConfiguration configuration;
        private readonly ILogger<ToDoController> logger;

        public ToDoController(IMediator mediator, IConfiguration configuration, ILogger<ToDoController> logger)
        {
            this.mediator = mediator;
            this.configuration = configuration;
            this.logger = logger;
        }

        [HttpGet("GetAll")]
        public async Task<IEnumerable<ToDo>> GetAll()
        {
            var req = new GetAllToDoRequest();

            logger.LogInformation("GetAll [GET] request for ToDos.");
            var result = await mediator.Send(req, CancellationToken.None);
            return result;
        }

        [HttpPost("Create")]
        public async Task<ToDo> CreateToDo(CreateToDoRequest req)
        {
            logger.LogInformation("Create [POST] request for a ToDo.");

            return await mediator.Send(req, CancellationToken.None);
        }

        [HttpDelete("Delete")]
        public async Task<BaseResult> DeleteToDo(DeleteToDoRequest req)
        {
            logger.LogInformation($"Delete [DELETE] request for ToDo with id {req.Id}.");

            return await mediator.Send(req, CancellationToken.None);
        }

        [HttpPut("Update")]
        public async Task<ToDo> UpdateToDo(UpdateToDoRequest req)
        {
            logger.LogInformation($"Update [PUT] request for ToDo with id {req.Id}.");

            return await mediator.Send(req, CancellationToken.None);
        }


    }
}
