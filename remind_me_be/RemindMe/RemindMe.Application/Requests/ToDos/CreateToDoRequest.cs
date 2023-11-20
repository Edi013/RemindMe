using MediatR;
using RemindMe.Domain.Entities;

namespace RemindMe.Application.Requests.ToDos
{
    public class CreateToDoRequest : IRequest<ToDo>
    {
        public string? Title { get; set; }
        public string? Description { get; set; }
        public DateTime? CreationDate { get; set; }
        public DateTime StartDate { get; set; }
        public DateTime? EndDate { get; set; }
        public bool IsFinished { get; set; }
        public int Difficulty { get; set; }
        public int OwnerId { get; set; }

    }
}
