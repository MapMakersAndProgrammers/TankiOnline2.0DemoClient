package package_123
{
   public class name_743
   {
      public function name_743()
      {
         super();
      }
      
      private function method_896(message:String, element:XML) : void
      {
         var name:String = element.nodeKind() == "attribute" ? "@" + element.localName() : element.localName() + "";
         for(var parent:* = element.parent(); parent != null; )
         {
            name = parent.localName() + "" + "." + name;
            parent = parent.parent();
         }
         trace(message,"| \"" + name + "\"");
      }
      
      private function logError(message:String, element:XML) : void
      {
         this.method_896("[ERROR] " + message,element);
      }
      
      public function name_745(element:XML) : void
      {
         this.logError("External urls don\'t supported",element);
      }
      
      public function logSkewError(element:XML) : void
      {
         this.logError("<skew> don\'t supported",element);
      }
      
      public function method_897(element:XML) : void
      {
         this.logError("Joints in different scenes don\'t supported",element);
      }
      
      public function logInstanceNodeError(element:XML) : void
      {
         this.logError("<instance_node> don\'t supported",element);
      }
      
      public function logNotFoundError(element:XML) : void
      {
         this.logError("Element with url \"" + element.toString() + "\" not found",element);
      }
      
      public function logNotEnoughDataError(element:XML) : void
      {
         this.logError("Not enough data",element);
      }
   }
}

