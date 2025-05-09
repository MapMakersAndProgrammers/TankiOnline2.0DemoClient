package versions.version2.a3d.geometry
{
   import flash.utils.ByteArray;
   
   public class A3D2IndexBuffer
   {
      private var var_271:ByteArray;
      
      private var var_101:int;
      
      private var var_379:int;
      
      public function A3D2IndexBuffer(byteBuffer:ByteArray, id:int, indexCount:int)
      {
         super();
         this.var_271 = byteBuffer;
         this.var_101 = id;
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
      
      public function get id() : int
      {
         return this.var_101;
      }
      
      public function set id(value:int) : void
      {
         this.var_101 = value;
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
         var result:String = "A3D2IndexBuffer [";
         result += "byteBuffer = " + this.byteBuffer + " ";
         result += "id = " + this.id + " ";
         result += "indexCount = " + this.indexCount + " ";
         return result + "]";
      }
   }
}

