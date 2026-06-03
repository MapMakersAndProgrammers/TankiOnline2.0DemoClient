package platform.client.fp10.core.network.command.control.client
{
   import platform.client.fp10.core.network.command.ControlCommand;
   
   public class LoaderParamsCommand extends ControlCommand
   {
      
      public var parameterNames:Array;
      
      public var parameterValues:Array;
      
      public function LoaderParamsCommand(param1:Array, param2:Array)
      {
         super(ControlCommand.CL_PARAMS,"Loader params");
         if(param1 == null)
         {
            throw new ArgumentError("Parameter parameterNames is null");
         }
         if(param2 == null)
         {
            throw new ArgumentError("Parameter parameterValues is null");
         }
         this.parameterNames = param1;
         this.parameterValues = param2;
      }
   }
}

