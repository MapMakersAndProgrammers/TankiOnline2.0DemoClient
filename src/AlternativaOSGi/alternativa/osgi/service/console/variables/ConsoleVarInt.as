package alternativa.osgi.service.console.variables
{
   public class ConsoleVarInt extends ConsoleVar
   {
      
      public var value:int;
      
      private var minValue:int;
      
      private var maxValue:int;
      
      public function ConsoleVarInt(param1:String, param2:int, param3:int, param4:int, param5:Function = null)
      {
         super(param1,param5);
         this.value = param2;
         this.minValue = param3;
         this.maxValue = param4;
      }
      
      override protected function acceptInput(param1:String) : String
      {
         var _loc2_:int = int(param1);
         if(_loc2_ < this.minValue || _loc2_ > this.maxValue)
         {
            return "Value is out of bounds [" + this.minValue + ", " + this.maxValue + "]";
         }
         this.value = _loc2_;
         return null;
      }
      
      override public function toString() : String
      {
         return this.value.toString();
      }
   }
}

