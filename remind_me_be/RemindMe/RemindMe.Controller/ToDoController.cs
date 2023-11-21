using MediatR;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
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

        public ToDoController(IMediator mediator, IConfiguration configuration)
        {
            this.mediator = mediator;
            this.configuration = configuration;
        }

        [HttpGet("GetAll")]
        public async Task<IEnumerable<ToDo>> GetAll()
        {
            var req = new GetAllToDoRequest();

            return await mediator.Send(req, CancellationToken.None);
        }

        [HttpPost("Create")]
        public async Task<ToDo> CreateToDo(CreateToDoRequest req)
        {
            return await mediator.Send(req, CancellationToken.None);
        }

        [HttpDelete("Delete")]
        public async Task<BaseResult> DeleteToDo(DeleteToDoRequest req)
        {
            return await mediator.Send(req, CancellationToken.None);
        }

        [HttpPut("Edit")]
        public async Task<ToDo> EditToDo(EditToDoRequest req)
        {
            return await mediator.Send(req, CancellationToken.None);
        }


    }
}
