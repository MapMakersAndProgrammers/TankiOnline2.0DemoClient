package alternativa.engine3d.materials.compiler
{
   import flash.utils.ByteArray;
   
   public class Variable
   {
      private static var collector:Variable;
      
      protected static const X_CHAR_CODE:Number = "x".charCodeAt(0);
      
      public var name:String;
      
      public var index:int;
      
      public var type:uint;
      
      public var position:uint = 0;
      
      public var next:Variable;
      
      public var name_0J:uint;
      
      public var name_oc:uint;
      
      public var isRelative:Boolean;
      
      private var name_RS:uint = 1;
      
      public function Variable()
      {
         super();
      }
      
      public static function create() : Variable
      {
         if(collector == null)
         {
            collector = new Variable();
         }
         var output:Variable = collector;
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
         return this.name_RS;
      }
      
      public function set size(value:uint) : void
      {
         this.name_RS = value;
      }
      
      public function writeToByteArray(byteCode:ByteArray, newIndex:int, newType:int) : void
      {
         byteCode.position = this.position;
         byteCode.writeShort(newIndex);
      }
   }
}

