package alternativa.tanks.game.utils
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   
   public class TaskSequence extends EventDispatcher
   {
      private var tasks:Vector.<Task>;
      
      private var var_192:int;
      
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
            this.var_192 = 0;
            this.runCurrentTask();
         }
         else
         {
            dispatchEvent(new Event(Event.COMPLETE));
         }
      }
      
      private function runCurrentTask() : void
      {
         Task(this.tasks[this.var_192]).run();
      }
      
      internal function taskComplete(task:Task) : void
      {
         if(++this.var_192 < this.tasks.length)
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

