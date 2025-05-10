package versions.version1.a3d.geometry
{
   import flash.utils.ByteArray;
   
   public class A3DVertexBuffer
   {
      private var name_96:Vector.<int>;
      
      private var name_79:ByteArray;
      
      private var name_g1:uint;
      
      public function A3DVertexBuffer(attributes:Vector.<int>, byteBuffer:ByteArray, vertexCount:uint)
      {
         super();
         this.name_96 = attributes;
         this.name_79 = byteBuffer;
         this.name_g1 = vertexCount;
      }
      
      public function get attributes() : Vector.<int>
      {
         return this.name_96;
      }
      
      public function set attributes(value:Vector.<int>) : void
      {
         this.name_96 = value;
      }
      
      public function get byteBuffer() : ByteArray
      {
         return this.name_79;
      }
      
      public function set byteBuffer(value:ByteArray) : void
      {
         this.name_79 = value;
      }
      
      public function get vertexCount() : uint
      {
         return this.name_g1;
      }
      
      public function set vertexCount(value:uint) : void
      {
         this.name_g1 = value;
      }
      
      public function toString() : String
      {
         var result:String = "A3DVertexBuffer [";
         result += "attributes = " + this.attributes + " ";
         result += "byteBuffer = " + this.byteBuffer + " ";
         result += "vertexCount = " + this.vertexCount + " ";
         return result + "]";
      }
   }
}

