using RemindMe.Emailing.Domain.Interfaces;
using RemindMe.Emailing.Domain.Models;

namespace RemindMe.Emailing.Business
{
    public class EmailingHandler
    {
        private readonly IEmailService _emailService;
        private readonly IRepository _emailingRepository;

        public EmailingHandler(IEmailService emailService, IRepository emailingRepository)
        {
            _emailService = emailService;
            _emailingRepository = emailingRepository;
        }

        public BaseResult TestEmail()
        {
            var receivers = new string[]{
                "edymare97@yahoo.com"
            };
            var message = new Message("Test email - emailing service", "Email for test - emailing service.", receivers);

            _emailService.SendEmail(message);

            return new BaseResult()
            {
                HttpStatusCode = System.Net.HttpStatusCode.OK,
                Message = "Email was sent successfully"
            };
        }

        public BaseResult SendEmail(SendEmailRequest request)
        {
            var badRequestResponse = new BaseResult()
            {
                HttpStatusCode = System.Net.HttpStatusCode.BadRequest,
                Message = "Email has not been sent. You have to provide an email and id foreach receiver."
            };

            if (request.ReceiversEmail.Length != request.ReceiversId.Length)
            {
                return badRequestResponse;
            }
            for (var i = 0; i < request.ReceiversEmail.Length; i++)
            {
                if (string.IsNullOrEmpty(request.ReceiversEmail[i]) || string.IsNullOrEmpty(request.ReceiversId[i]))
                {
                    return badRequestResponse;
                }
            }

            if (string.IsNullOrEmpty(request.Subject) || string.IsNullOrEmpty(request.Content))
            {
                return new BaseResult()
                {
                    HttpStatusCode = System.Net.HttpStatusCode.BadRequest,
                    Message = "Email has not been sent. The subject or content is/are empty. Please provide a subject or a content. "
                };
            }

            var message = new Message(request.Subject, request.Content, request.ReceiversEmail);
            _emailService.SendEmail(message);
            var date = DateTime.Now;
            foreach (var receiverId in request.ReceiversId)
            {
                _emailingRepository.StoreEmailSentToUserActivity(receiverId, date);
            }
            return new BaseResult()
            {
                HttpStatusCode = System.Net.HttpStatusCode.OK,
                Message = "Email has been sent."
            };
        }

    }
}
