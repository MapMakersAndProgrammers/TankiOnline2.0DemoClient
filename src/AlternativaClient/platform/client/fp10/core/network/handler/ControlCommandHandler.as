package platform.client.fp10.core.network.handler
{
   import alternativa.osgi.OSGi;
   import alternativa.osgi.service.clientlog.IClientLog;
   import alternativa.osgi.service.dump.IDumpService;
   import alternativa.osgi.service.dump.IDumper;
   import alternativa.osgi.service.launcherparams.ILauncherParams;
   import alternativa.protocol.IProtocol;
   import platform.client.fp10.core.dispatcher.Dispatcher;
   import platform.client.fp10.core.dispatcher.IDispatcherListener;
   import platform.client.fp10.core.network.ConnectionCloseStatus;
   import platform.client.fp10.core.network.ControlChannelContext;
   import platform.client.fp10.core.network.ICommandHandler;
   import platform.client.fp10.core.network.ICommandSender;
   import platform.client.fp10.core.network.command.IServerControlCommand;
   import platform.client.fp10.core.network.command.control.client.DependenciesLoadedCommand;
   import platform.client.fp10.core.network.command.control.client.HashRequestCommand;
   import platform.client.fp10.core.network.command.control.client.LoaderParamsCommand;
   import platform.client.fp10.core.registry.SpaceRegistry;
   import platform.client.fp10.core.service.messagebox.IMessageBoxService;
   import platform.client.fp10.core.service.messagebox.MessageBoxType;
   import platform.client.fp10.core.type.ISpace;
   
   public class ControlCommandHandler implements ICommandHandler, IDispatcherListener
   {
      
      [Inject]
      public static var clientLog:IClientLog;
      
      [Inject]
      public static var messageBoxService:IMessageBoxService;
      
      [Inject]
      public static var spaceRegistry:SpaceRegistry;
      
      private static const LOG_CHANNEL:String = "control";
      
      private var protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));
      
      private var channelContext:ControlChannelContext = new ControlChannelContext();
      
      private var commandSender:ICommandSender;
      
      public function ControlCommandHandler(param1:OSGi)
      {
         super();
         this.channelContext.spaceProtocol = this.protocol;
         this.channelContext.dispatcher = new Dispatcher(this,this.protocol);
      }
      
      public function onConnectionOpen(param1:ICommandSender) : void
      {
         this.commandSender = param1;
         this.sendConnectionResponce();
      }
      
      public function onConnectionClose(param1:ConnectionCloseStatus, param2:String = null) : void
      {
         var _loc3_:String = null;
         var _loc4_:ISpace = null;
         while(spaceRegistry.spaces.length > 0)
         {
            _loc4_ = spaceRegistry.spaces[0];
            _loc4_.close();
         }
         switch(param1)
         {
            case ConnectionCloseStatus.CLOSED_BY_SERVER:
               _loc3_ = "Connection closed by server";
               break;
            case ConnectionCloseStatus.CONNECTION_ERROR:
               _loc3_ = "Connection error: " + (param2 || "");
         }
         messageBoxService.showMessage(MessageBoxType.ERROR,"",_loc3_,0);
         this.commandSender = null;
         this.logDumpers();
      }
      
      public function executeCommand(param1:Object) : void
      {
         IServerControlCommand(param1).execute(this.channelContext);
      }
      
      public function onPacketLoadingComplete() : void
      {
         if(this.commandSender != null)
         {
            this.commandSender.sendCommand(new DependenciesLoadedCommand());
         }
      }
      
      private function sendConnectionResponce() : void
      {
         var _loc4_:String = null;
         this.commandSender.sendCommand(new HashRequestCommand());
         var _loc1_:ILauncherParams = ILauncherParams(OSGi.getInstance().getService(ILauncherParams));
         var _loc2_:Array = [];
         var _loc3_:Array = [];
         for each(_loc4_ in _loc1_.parameterNames)
         {
            _loc2_.push(_loc4_);
            _loc3_.push(_loc1_.getParameter(_loc4_));
         }
         this.commandSender.sendCommand(new LoaderParamsCommand(_loc2_,_loc3_));
      }
      
      private function logDumpers() : void
      {
         var _loc2_:IDumper = null;
         var _loc1_:IDumpService = IDumpService(OSGi.getInstance().getService(IDumpService));
         for each(_loc2_ in _loc1_.dumpersList)
         {
            clientLog.log("dumper_" + _loc2_.dumperName,_loc2_.dump([]));
         }
      }
   }
}

