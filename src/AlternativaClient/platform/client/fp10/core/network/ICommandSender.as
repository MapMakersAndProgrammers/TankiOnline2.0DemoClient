package platform.client.fp10.core.network
{
   public interface ICommandSender
   {
      
      function get id() : int;
      
      function sendCommand(param1:Object) : void;
   }
}

