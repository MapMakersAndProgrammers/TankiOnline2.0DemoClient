package alternativa.tanks.game.subsystems.deferredcommandssystem
{
   import alternativa.tanks.game.GameTask;
   
   public class DeferredCommandsSystem extends GameTask
   {
      private var commands:DeferredCommand;
      
      public function DeferredCommandsSystem(priority:int)
      {
         super(priority);
      }
      
      public function addCommand(command:DeferredCommand) : void
      {
         command.next = this.commands;
         this.commands = command;
      }
      
      override public function run() : void
      {
         for(var command:DeferredCommand = null; this.commands != null; )
         {
            command = this.commands;
            this.commands = this.commands.next;
            command.next = null;
            command.execute();
            command.storeInPool();
         }
      }
   }
}

