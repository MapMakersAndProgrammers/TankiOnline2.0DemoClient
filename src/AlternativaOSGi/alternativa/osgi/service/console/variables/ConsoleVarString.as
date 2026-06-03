package alternativa.osgi.service.console.variables
{
   public class ConsoleVarString extends ConsoleVar
   {
      
      public var value:String;
      
      public function ConsoleVarString(param1:String, param2:String, param3:Function = null)
      {
         super(param1,param3);
         this.value = param2;
      }
      
      override protected function acceptInput(param1:String) : String
      {
         this.value = param1;
         return null;
      }
      
      override public function toString() : String
      {
         return this.value;
      }
   }
}

