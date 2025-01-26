package package_40
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
      
      public function get length() : uint
      {
         return this.tasks.length;
      }
      
      public function addTask(param1:class_7) : void
      {
         if(this.tasks.indexOf(param1) < 0)
         {
            this.tasks.push(param1);
            param1.method_101 = this;
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
         this.tasks[this.var_192].run();
      }
      
      internal function taskComplete(param1:class_7) : void
      {
         dispatchEvent(new name_169(name_169.TASK_COMPLETE,1,this.tasks.length));
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

