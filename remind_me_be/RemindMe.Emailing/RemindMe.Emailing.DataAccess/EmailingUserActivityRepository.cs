using Microsoft.EntityFrameworkCore;
using RemindMe.Emailing.Domain.Interfaces;
using RemindMe.Emailing.Domain.Models;
using System;

namespace RemindMe.Emailing.DataAccess
{
    public class EmailingUserActivityRepository : IRepository
    {
        private readonly EmailingDbContext _context;

        public EmailingUserActivityRepository(EmailingDbContext _context)
        {
            this._context = _context;
        }
        public async Task<BaseResult> StoreEmailSentToUserActivity(string userId, DateTime date)
        {
            EmailingUserActivity activity;
            var internalErrorResult = new BaseResult
            {
                HttpStatusCode = System.Net.HttpStatusCode.InternalServerError,
                Message = "Emailing activity has not been recorded. Internal error occured. Please contact the staff."
            };
            var successResult = new BaseResult
            {
                HttpStatusCode = System.Net.HttpStatusCode.Created,
                Message = "Emailing activity has been recorded."
            };

            if (await _context.Set<EmailingUserActivity>().AnyAsync(x => x.UserId == userId))
            {
                activity =
                     _context.Set<EmailingUserActivity>().Where(x => x.UserId == userId).First();

                if(activity == null)
                {
                    return internalErrorResult;
                }

                activity.EmailsSent++;
                activity.UtcDates.Append(date);
                var resultFromSavingTheUpdate = await _context.SaveChangesAsync();
                if (resultFromSavingTheUpdate == 0)
                {
                    return internalErrorResult;
                }

                return successResult;
            }

            activity = new EmailingUserActivity
            {
                UserId = userId,
                UtcDates = new DateTime[] { date },
                EmailsSent = 1,
            };
            var resultAdd = await _context.Set<EmailingUserActivity>().AddAsync(activity);
            var resultFromSavingTheAditionOfNewRecord = await _context.SaveChangesAsync();


            if (resultFromSavingTheAditionOfNewRecord == 0 || resultAdd == null)
            {
                return internalErrorResult;
            }

            return successResult;
        }
    }
}
