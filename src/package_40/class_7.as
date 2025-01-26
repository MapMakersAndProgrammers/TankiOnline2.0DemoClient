package package_40
{
   import flash.events.EventDispatcher;
   
   public class class_7 extends EventDispatcher
   {
      private var var_33:name_170;
      
      public function class_7()
      {
         super();
      }
      
      public function run() : void
      {
         throw new Error("Not implemented");
      }
      
      internal function set method_101(param1:name_170) : void
      {
         this.var_33 = param1;
      }
      
      final protected function method_102() : void
      {
         dispatchEvent(new name_169(name_169.TASK_COMPLETE,1,1));
         this.var_33.taskComplete(this);
      }
   }
}

