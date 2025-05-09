package alternativa.tanks.utils
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
      
      public function get length() : uint
      {
         return this.tasks.length;
      }
      
      public function addTask(param1:Task) : void
      {
         if(this.tasks.indexOf(param1) < 0)
         {
            this.tasks.push(param1);
            param1.taskSequence = this;
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
         this.tasks[this.var_192].run();
      }
      
      internal function taskComplete(param1:Task) : void
      {
         dispatchEvent(new TaskEvent(TaskEvent.TASK_COMPLETE,1,this.tasks.length));
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

