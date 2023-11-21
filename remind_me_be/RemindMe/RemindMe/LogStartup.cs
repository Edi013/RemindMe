using log4net;
using RemindMe.Controller;

namespace RemindMe
{
    public static class LogStartup
    {
        private static readonly ILog Logger = LogManager.GetLogger(typeof(Program));

        public static void LogStartupInformation() 
        {
            Logger.Info("Application started.");
        }
    }
}
