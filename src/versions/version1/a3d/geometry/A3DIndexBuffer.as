package versions.version1.a3d.geometry
{
   import flash.utils.ByteArray;
   
   public class A3DIndexBuffer
   {
      private var §_-79§:ByteArray;
      
      private var §_-m0§:int;
      
      public function A3DIndexBuffer(byteBuffer:ByteArray, indexCount:int)
      {
         super();
         this.§_-79§ = byteBuffer;
         this.§_-m0§ = indexCount;
      }
      
      public function get byteBuffer() : ByteArray
      {
         return this.§_-79§;
      }
      
      public function set byteBuffer(value:ByteArray) : void
      {
         this.§_-79§ = value;
      }
      
      public function get indexCount() : int
      {
         return this.§_-m0§;
      }
      
      public function set indexCount(value:int) : void
      {
         this.§_-m0§ = value;
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

