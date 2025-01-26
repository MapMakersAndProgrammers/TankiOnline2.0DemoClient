package package_1
{
   public class name_1 extends name_22
   {
      public var value:Number;
      
      private var minValue:Number;
      
      private var maxValue:Number;
      
      public function name_1(consoleVarName:String, initialValue:Number, minValue:Number, maxValue:Number, changeListener:Function = null)
      {
         super(consoleVarName,changeListener);
         this.value = initialValue;
         this.minValue = minValue;
         this.maxValue = maxValue;
      }
      
      override protected function acceptInput(value:String) : String
      {
         var f:Number = Number(Number(value));
         if(isNaN(f))
         {
            return "Incorrect number";
         }
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

