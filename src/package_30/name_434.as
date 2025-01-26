package package_30
{
   import flash.utils.ByteArray;
   
   public class name_434
   {
      private static var collector:name_434;
      
      protected static const X_CHAR_CODE:Number = "x".charCodeAt(0);
      
      public var name:String;
      
      public var index:int;
      
      public var type:uint;
      
      public var position:uint = 0;
      
      public var next:name_434;
      
      public var name_438:uint;
      
      public var name_439:uint;
      
      public var isRelative:Boolean;
      
      private var var_32:uint = 1;
      
      public function name_434()
      {
         super();
      }
      
      public static function create() : name_434
      {
         if(collector == null)
         {
            collector = new name_434();
         }
         var output:name_434 = collector;
         collector = collector.next;
         output.next = null;
         return output;
      }
      
      public function dispose() : void
      {
         this.next = collector;
         collector = this;
      }
      
      public function get size() : uint
      {
         return this.var_32;
      }
      
      public function set size(value:uint) : void
      {
         this.var_32 = value;
      }
      
      public function writeToByteArray(byteCode:ByteArray, newIndex:int, newType:int) : void
      {
         byteCode.position = this.position;
         byteCode.writeShort(newIndex);
      }
   }
}

