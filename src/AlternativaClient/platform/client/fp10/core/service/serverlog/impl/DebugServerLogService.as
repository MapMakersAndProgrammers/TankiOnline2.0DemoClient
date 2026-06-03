package platform.client.fp10.core.service.serverlog.impl
{
   import alternativa.osgi.OSGi;
   import alternativa.osgi.service.clientlog.IClientLog;
   import alternativa.osgi.service.launcherparams.ILauncherParams;
   import flash.display.Stage;
   import platform.client.fp10.core.network.ICommandSender;
   import platform.client.fp10.core.network.command.control.client.LogCommand;
   import platform.client.fp10.core.service.serverlog.IServerLog;
   import platform.client.fp10.core.service.serverlog.LogLevel;
   
   public class DebugServerLogService implements IServerLog
   {
      
      private var levelNames:Array;
      
      private var levelNameIndex:Object;
      
      private var enabledLevels:Object;
      
      private var commandSender:ICommandSender;
      
      private var errorLog:ErrorLog;
      
      public function DebugServerLogService(param1:ICommandSender, param2:Stage)
      {
         var _loc6_:Array = null;
         var _loc7_:String = null;
         super();
         this.commandSender = param1;
         this.errorLog = new ErrorLog(param2);
         this.levelNames = ["TRACE","DEBUG","INFO","WARNING","ERROR"];
         this.levelNameIndex = {};
         this.levelNameIndex[LogLevel.TRACE] = 0;
         this.levelNameIndex[LogLevel.DEBUG] = 1;
         this.levelNameIndex[LogLevel.INFO] = 2;
         this.levelNameIndex[LogLevel.WARNING] = 3;
         this.levelNameIndex[LogLevel.ERROR] = 4;
         var _loc3_:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));
         this.enabledLevels = {};
         var _loc4_:ILauncherParams = ILauncherParams(OSGi.getInstance().getService(ILauncherParams));
         var _loc5_:String = _loc4_.getParameter("enableserverlogs");
         if(Boolean(_loc5_))
         {
            _loc6_ = _loc5_.split(",");
            for each(_loc7_ in _loc6_)
            {
               _loc7_ = _loc7_.toUpperCase();
               if(this.levelNames.indexOf(_loc7_) >= 0)
               {
                  this.enabledLevels[_loc7_] = true;
               }
            }
         }
      }
      
      public function log(param1:int, param2:String) : void
      {
         var _loc3_:String = this.levelNames[this.levelNameIndex[param1]];
         this.errorLog.addLogMessage(_loc3_,param2);
         if(Boolean(this.enabledLevels[_loc3_]))
         {
            this.commandSender.sendCommand(new LogCommand(param1,param2));
         }
      }
   }
}

