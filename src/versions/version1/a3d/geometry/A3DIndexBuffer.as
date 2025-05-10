package versions.version1.a3d.geometry
{
   import flash.utils.ByteArray;
   
   public class A3DIndexBuffer
   {
      private var name_79:ByteArray;
      
      private var name_m0:int;
      
      public function A3DIndexBuffer(byteBuffer:ByteArray, indexCount:int)
      {
         super();
         this.name_79 = byteBuffer;
         this.name_m0 = indexCount;
      }
      
      public function get byteBuffer() : ByteArray
      {
         return this.name_79;
      }
      
      public function set byteBuffer(value:ByteArray) : void
      {
         this.name_79 = value;
      }
      
      public function get indexCount() : int
      {
         return this.name_m0;
      }
      
      public function set indexCount(value:int) : void
      {
         this.name_m0 = value;
      }
      
      public function toString() : String
      {
         var result:String = "A3DIndexBuffer [";
         result += "byteBuffer = " + this.byteBuffer + " ";
         result += "indexCount = " + this.indexCount + " ";
         return result + "]";
      }
   }
}

