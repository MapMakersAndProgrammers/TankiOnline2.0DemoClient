package package_41
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import package_112.class_33;
   import package_40.name_170;
   import package_71.name_333;
   
   [Event(name="complete",type="flash.events.Event")]
   public class name_461 extends EventDispatcher
   {
      public var parts:Vector.<name_333>;
      
      private var var_34:name_170;
      
      public function name_461()
      {
         super();
      }
      
      public function load(param1:String, param2:XMLList, param3:class_33) : void
      {
         var _loc4_:XML = null;
         this.parts = new Vector.<name_333>();
         this.var_34 = new name_170();
         for each(_loc4_ in param2)
         {
            this.var_34.addTask(param3.method_648(param1,_loc4_,this.parts));
         }
         this.var_34.addEventListener(Event.COMPLETE,this.method_107);
         this.var_34.run();
      }
      
      private function method_107(param1:Event) : void
      {
         this.var_34 = null;
         if(hasEventListener(Event.COMPLETE))
         {
            dispatchEvent(new Event(Event.COMPLETE));
         }
      }
   }
}

