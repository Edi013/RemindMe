using MediatR;
using RemindMe.Domain.Entities;

namespace RemindMe.Application.Requests.Todos
{
    public class CreateTodoRequest : IRequest<Item>
    {
        public string Title { get; set; }
        public string Description { get; set; }
        public string CreationDate { get; set; }
        public string StartDate { get; set; }
        public string EndDate { get; set; }
        public bool IsFinished { get; set; }
        public int Difficulty { get; set; }
        public int OwnerId { get; set; }

    }
}
