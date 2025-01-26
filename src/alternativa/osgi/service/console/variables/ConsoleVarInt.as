package alternativa.osgi.service.console.variables
{
   public class ConsoleVarInt extends ConsoleVar
   {
      public var value:int;
      
      private var minValue:int;
      
      private var maxValue:int;
      
      public function ConsoleVarInt(consoleVarName:String, initialValue:int, minValue:int, maxValue:int, inputListener:Function = null)
      {
         super(consoleVarName,inputListener);
         this.value = initialValue;
         this.minValue = minValue;
         this.maxValue = maxValue;
      }
      
      override protected function acceptInput(value:String) : String
      {
         var f:int = int(int(value));
         if(f < this.minValue || f > this.maxValue)
         {
            return "Value is out of bounds [" + this.minValue + ", " + this.maxValue + "]";
         }
         this.value = f;
         return null;
      }
      
      override public function toString() : String
      {
         return this.value.toString();
      }
   }
}

