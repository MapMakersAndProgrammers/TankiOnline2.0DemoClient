package package_10
{
   public class class_1
   {
      public var var_4:name_52;
      
      public var priority:int;
      
      protected var var_3:Boolean;
      
      public function class_1(priority:int)
      {
         super();
         this.priority = priority;
      }
      
      public function start() : void
      {
      }
      
      public function stop() : void
      {
      }
      
      public function run() : void
      {
      }
      
      final public function get method_20() : Boolean
      {
         return this.var_3;
      }
      
      final public function set method_20(value:Boolean) : void
      {
         if(value)
         {
            this.method_21();
         }
         else
         {
            this.method_22();
         }
      }
      
      final public function method_21() : void
      {
         if(!this.var_3)
         {
            this.var_3 = true;
            this.onPause();
         }
      }
      
      final public function method_22() : void
      {
         if(this.var_3)
         {
            this.var_3 = false;
            this.onResume();
         }
      }
      
      protected function onPause() : void
      {
      }
      
      protected function onResume() : void
      {
      }
   }
}

