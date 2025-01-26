package alternativa.osgi.service.console.variables
{
   public class ConsoleVarString extends ConsoleVar
   {
      public var value:String;
      
      public function ConsoleVarString(consoleVarName:String, initialValue:String, inputListener:Function = null)
      {
         super(consoleVarName,inputListener);
         this.value = initialValue;
      }
      
      override protected function acceptInput(value:String) : String
      {
         this.value = value;
         return null;
      }
      
      override public function toString() : String
      {
         return this.value;
      }
   }
}

