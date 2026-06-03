package platform.client.fp10.core.network.command.control.client
{
   import platform.client.fp10.core.network.command.ControlCommand;
   
   public class HashRequestCommand extends ControlCommand
   {
      
      public function HashRequestCommand()
      {
         super(ControlCommand.CL_HASH_REQUEST,"Hash request");
      }
   }
}

