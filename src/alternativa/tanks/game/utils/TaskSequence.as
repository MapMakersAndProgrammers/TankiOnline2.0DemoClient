package alternativa.tanks.game.utils
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   
   public class TaskSequence extends EventDispatcher
   {
      private var tasks:Vector.<Task>;
      
      private var name_LN:int;
      
      public function TaskSequence()
      {
         super();
         this.tasks = new Vector.<Task>();
      }
      
      public function addTask(task:Task) : void
      {
         if(this.tasks.indexOf(task) < 0)
         {
            this.tasks.push(task);
            task.taskSequence = this;
         }
      }
      
      public function run() : void
      {
         if(this.tasks.length > 0)
         {
            this.name_LN = 0;
            this.runCurrentTask();
         }
         else
         {
            dispatchEvent(new Event(Event.COMPLETE));
         }
      }
      
      private function runCurrentTask() : void
      {
         Task(this.tasks[this.name_LN]).run();
      }
      
      internal function taskComplete(task:Task) : void
      {
         if(++this.name_LN < this.tasks.length)
         {
            this.runCurrentTask();
         }
         else
         {
            dispatchEvent(new Event(Event.COMPLETE));
         }
      }
   }
}

