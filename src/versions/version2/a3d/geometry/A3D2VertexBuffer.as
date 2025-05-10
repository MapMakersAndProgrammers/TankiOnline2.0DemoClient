package versions.version2.a3d.geometry
{
   import flash.utils.ByteArray;
   
   public class A3D2VertexBuffer
   {
      private var name_96:Vector.<A3D2VertexAttributes>;
      
      private var name_79:ByteArray;
      
      private var name_3I:int;
      
      private var name_g1:uint;
      
      public function A3D2VertexBuffer(attributes:Vector.<A3D2VertexAttributes>, byteBuffer:ByteArray, id:int, vertexCount:uint)
      {
         super();
         this.name_96 = attributes;
         this.name_79 = byteBuffer;
         this.name_3I = id;
         this.name_g1 = vertexCount;
      }
      
      public function get attributes() : Vector.<A3D2VertexAttributes>
      {
         return this.name_96;
      }
      
      public function set attributes(value:Vector.<A3D2VertexAttributes>) : void
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
      
      public function get id() : int
      {
         return this.name_3I;
      }
      
      public function set id(value:int) : void
      {
         this.name_3I = value;
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
         var result:String = "A3D2VertexBuffer [";
         result += "attributes = " + this.attributes + " ";
         result += "byteBuffer = " + this.byteBuffer + " ";
         result += "id = " + this.id + " ";
         result += "vertexCount = " + this.vertexCount + " ";
         return result + "]";
      }
   }
}

