using MediatR;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using RemindMe.Application.Requests.ToDos;
using RemindMe.Domain.Entities;

namespace RemindMe.Controller
{
    [ApiController]
    [Route("api/[controller]")]
    public class ToDoController
    {
        private readonly IMediator mediator;
        private readonly IConfiguration configuration;

        public ToDoController(IMediator mediator, IConfiguration configuration)
        {
            this.mediator = mediator;
            this.configuration = configuration;
        }

        [HttpGet("test")]
        public async Task<IEnumerable<ToDo>> GetAll()
        {
            var req = new GetAllToDoRequest();

            return await mediator.Send(req, CancellationToken.None);
        }
    }
}
