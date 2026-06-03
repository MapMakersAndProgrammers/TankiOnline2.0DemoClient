package platform.client.fp10.core.service.serverlog.impl
{
   import alternativa.osgi.OSGi;
   import alternativa.osgi.service.clientlog.IClientLog;
   import platform.client.fp10.core.service.serverlog.IServerLog;
   import platform.client.fp10.core.service.serverlog.LogLevel;
   
   public class ReleaseServerLogService implements IServerLog
   {
      
      private var clientLog:IClientLog;
      
      public function ReleaseServerLogService()
      {
         super();
         this.clientLog = IClientLog(OSGi.getInstance().getService(IClientLog));
      }
      
      public function log(param1:int, param2:String) : void
      {
         if(param1 == LogLevel.ERROR)
         {
            this.clientLog.log("srvlog_error",param2);
         }
      }
   }
}

