using MediatR;
using RemindMe.Domain.Entities;

namespace RemindMe.Application.Requests.ToDos
{
    public class EditToDoRequest : IRequest<ToDo>
    {
        public int Id { get; set; }
        public string Title { get; set; }
        public string Description { get; set; }
        public string StartDate { get; set; }
        public string EndDate { get; set; }
        public bool IsFinished { get; set; }
        public int Difficulty { get; set; }
        public int OwnerId { get; set; }
    }
}
