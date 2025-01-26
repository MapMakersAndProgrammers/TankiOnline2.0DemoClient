package package_1
{
   public class name_13 extends name_22
   {
      public var value:String;
      
      public function name_13(consoleVarName:String, initialValue:String, inputListener:Function = null)
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

