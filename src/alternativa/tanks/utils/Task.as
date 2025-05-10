package alternativa.tanks.utils
{
   import flash.events.EventDispatcher;
   
   public class Task extends EventDispatcher
   {
      private var name_UZ:TaskSequence;
      
      public function Task()
      {
         super();
      }
      
      public function run() : void
      {
         throw new Error("Not implemented");
      }
      
      internal function set taskSequence(param1:TaskSequence) : void
      {
         this.name_UZ = param1;
      }
      
      final protected function completeTask() : void
      {
         dispatchEvent(new TaskEvent(TaskEvent.TASK_COMPLETE,1,1));
         this.name_UZ.taskComplete(this);
      }
   }
}

