using MediatR;
using RemindMe.ToDo.Domain.Results;

namespace RemindMe.Application.Requests.Todos
{
    public class CreateItemRequest : IRequest<ItemResponse>
    {
        public string Title { get; set; }
        public string Description { get; set; }
        public string CreationDate { get; set; }
        public string StartDate { get; set; }
        public string EndDate { get; set; }
        public bool IsFinished { get; set; }
        public int Difficulty { get; set; }
        public string OwnerId { get; set; }
    }
}
