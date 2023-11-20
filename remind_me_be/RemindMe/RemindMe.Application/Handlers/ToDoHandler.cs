using MediatR;
using Microsoft.AspNetCore.Mvc;
using RemindMe.Application.Requests.ToDos;
using RemindMe.DataAcces.Repositories;
using RemindMe.Domain.Entities;
using RemindMe.Domain.Interfaces;

namespace RemindMe.Application.Handlers
{
    public class ToDoHandler : IRequestHandler<GetAllToDoRequest, IEnumerable<ToDo>>
    {
        private IToDoRepository repository;

        public ToDoHandler(IToDoRepository _repository)
        {
           this.repository = _repository;
        }

        [HttpGet("todos")]
        public Task<IEnumerable<ToDo>> Handle(GetAllToDoRequest request, CancellationToken cancellationToken)
        {
            return repository.GetAll();
        }
    }
}
