package versions.version1.a3d.geometry
{
   import flash.utils.ByteArray;
   
   public class A3DIndexBuffer
   {
      private var var_271:ByteArray;
      
      private var var_379:int;
      
      public function A3DIndexBuffer(byteBuffer:ByteArray, indexCount:int)
      {
         super();
         this.var_271 = byteBuffer;
         this.var_379 = indexCount;
      }
      
      public function get byteBuffer() : ByteArray
      {
         return this.var_271;
      }
      
      public function set byteBuffer(value:ByteArray) : void
      {
         this.var_271 = value;
      }
      
      public function get indexCount() : int
      {
         return this.var_379;
      }
      
      public function set indexCount(value:int) : void
      {
         this.var_379 = value;
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

