package versions.version2.a3d.geometry
{
   import flash.utils.ByteArray;
   
   public class A3D2VertexBuffer
   {
      private var §_-96§:Vector.<A3D2VertexAttributes>;
      
      private var §_-79§:ByteArray;
      
      private var §_-3I§:int;
      
      private var §_-g1§:uint;
      
      public function A3D2VertexBuffer(attributes:Vector.<A3D2VertexAttributes>, byteBuffer:ByteArray, id:int, vertexCount:uint)
      {
         super();
         this.§_-96§ = attributes;
         this.§_-79§ = byteBuffer;
         this.§_-3I§ = id;
         this.§_-g1§ = vertexCount;
      }
      
      public function get attributes() : Vector.<A3D2VertexAttributes>
      {
         return this.§_-96§;
      }
      
      public function set attributes(value:Vector.<A3D2VertexAttributes>) : void
      {
         this.§_-96§ = value;
      }
      
      public function get byteBuffer() : ByteArray
      {
         return this.§_-79§;
      }
      
      public function set byteBuffer(value:ByteArray) : void
      {
         this.§_-79§ = value;
      }
      
      public function get id() : int
      {
         return this.§_-3I§;
      }
      
      public function set id(value:int) : void
      {
         this.§_-3I§ = value;
      }
      
      public function get vertexCount() : uint
      {
         return this.§_-g1§;
      }
      
      public function set vertexCount(value:uint) : void
      {
         this.§_-g1§ = value;
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

