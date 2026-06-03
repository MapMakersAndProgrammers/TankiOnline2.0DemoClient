package platform.client.fp10.core.network.command.control.client
{
   import platform.client.fp10.core.network.command.ControlCommand;
   
   public class DependenciesLoadedCommand extends ControlCommand
   {
      
      public function DependenciesLoadedCommand()
      {
         super(ControlCommand.CL_DEPENDENCIES_LOADED,"Dependencies loaded");
      }
   }
}

