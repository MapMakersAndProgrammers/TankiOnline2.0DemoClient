package platform.client.fp10.core.network.command.control.server
{
   import platform.client.fp10.core.dispatcher.DispatcherItem;
   import platform.client.fp10.core.network.ControlChannelContext;
   import platform.client.fp10.core.network.command.ControlCommand;
   import platform.client.fp10.core.network.command.IServerControlCommand;
   
   public class LoadDependenciesCommand extends ControlCommand implements IServerControlCommand
   {
      
      public var items:Vector.<DispatcherItem>;
      
      public function LoadDependenciesCommand(param1:Vector.<DispatcherItem>)
      {
         super(ControlCommand.SV_LOAD_DEPENDENCIES,"Load dependencies");
         if(param1 == null)
         {
            throw new ArgumentError("Parameter items is null");
         }
         this.items = param1;
      }
      
      public function execute(param1:ControlChannelContext) : void
      {
         param1.dispatcher.loadPacket(this.items);
      }
   }
}

