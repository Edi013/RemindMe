using RemindMe.Domain.Results;
using System.Net;

namespace RemindMe.ToDo.Domain.Results
{
    public class ItemResponse : BaseResponse
    {
        public int? Id { get; set; }
        public string? Title { get; set; }
        public string? Description { get; set; }
        public DateTime? CreationDate { get; set; }
        public DateTime? StartDate { get; set; }
        public DateTime? EndDate { get; set; }
        public bool? IsFinished { get; set; }
        public int? Difficulty { get; set; }
        public int? OwnerId { get; set; }
    }
}
