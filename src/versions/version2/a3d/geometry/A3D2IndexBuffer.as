package versions.version2.a3d.geometry
{
   import flash.utils.ByteArray;
   
   public class A3D2IndexBuffer
   {
      private var name_79:ByteArray;
      
      private var name_3I:int;
      
      private var name_m0:int;
      
      public function A3D2IndexBuffer(byteBuffer:ByteArray, id:int, indexCount:int)
      {
         super();
         this.name_79 = byteBuffer;
         this.name_3I = id;
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
      
      public function get id() : int
      {
         return this.name_3I;
      }
      
      public function set id(value:int) : void
      {
         this.name_3I = value;
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
         var result:String = "A3D2IndexBuffer [";
         result += "byteBuffer = " + this.byteBuffer + " ";
         result += "id = " + this.id + " ";
         result += "indexCount = " + this.indexCount + " ";
         return result + "]";
      }
   }
}

