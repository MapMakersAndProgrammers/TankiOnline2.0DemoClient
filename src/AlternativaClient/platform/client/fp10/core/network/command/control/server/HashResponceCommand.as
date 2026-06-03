package platform.client.fp10.core.network.command.control.server
{
   import flash.utils.ByteArray;
   import platform.client.fp10.core.network.ControlChannelContext;
   import platform.client.fp10.core.network.command.ControlCommand;
   import platform.client.fp10.core.network.command.IServerControlCommand;
   
   public class HashResponceCommand extends ControlCommand implements IServerControlCommand
   {
      
      public var hash:ByteArray;
      
      public function HashResponceCommand(param1:ByteArray)
      {
         super(ControlCommand.SV_HASH_RESPONCE,"Hash response");
         this.hash = param1;
      }
      
      public function execute(param1:ControlChannelContext) : void
      {
         param1.hash = this.hash;
      }
   }
}

