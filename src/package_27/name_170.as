package package_27
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   
   public class name_170 extends EventDispatcher
   {
      private var tasks:Vector.<class_7>;
      
      private var var_192:int;
      
      public function name_170()
      {
         super();
         this.tasks = new Vector.<class_7>();
      }
      
      public function addTask(task:class_7) : void
      {
         if(this.tasks.indexOf(task) < 0)
         {
            this.tasks.push(task);
            task.method_101 = this;
         }
      }
      
      public function run() : void
      {
         if(this.tasks.length > 0)
         {
            this.var_192 = 0;
            this.method_309();
         }
         else
         {
            dispatchEvent(new Event(Event.COMPLETE));
         }
      }
      
      private function method_309() : void
      {
         class_7(this.tasks[this.var_192]).run();
      }
      
      internal function taskComplete(task:class_7) : void
      {
         if(++this.var_192 < this.tasks.length)
         {
            this.method_309();
         }
         else
         {
            dispatchEvent(new Event(Event.COMPLETE));
         }
      }
   }
}

