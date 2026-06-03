package platform.client.fp10.core.network.command.control.client
{
   import platform.client.fp10.core.network.command.ControlCommand;
   
   public class LogCommand extends ControlCommand
   {
      
      public var level:int;
      
      public var message:String;
      
      public function LogCommand(param1:int, param2:String)
      {
         super(ControlCommand.CL_LOG,"Log");
         this.level = param1;
         this.message = param2;
      }
   }
}

