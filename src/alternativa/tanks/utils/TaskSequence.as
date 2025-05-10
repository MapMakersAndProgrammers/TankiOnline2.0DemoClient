package alternativa.tanks.utils
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
         this.tasks[this.name_LN].run();
      }
      
      internal function taskComplete(param1:Task) : void
      {
         dispatchEvent(new TaskEvent(TaskEvent.TASK_COMPLETE,1,this.tasks.length));
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

