package versions.version1.a3d.geometry
{
   import flash.utils.ByteArray;
   
   public class A3DVertexBuffer
   {
      private var §_-96§:Vector.<int>;
      
      private var §_-79§:ByteArray;
      
      private var §_-g1§:uint;
      
      public function A3DVertexBuffer(attributes:Vector.<int>, byteBuffer:ByteArray, vertexCount:uint)
      {
         super();
         this.§_-96§ = attributes;
         this.§_-79§ = byteBuffer;
         this.§_-g1§ = vertexCount;
      }
      
      public function get attributes() : Vector.<int>
      {
         return this.§_-96§;
      }
      
      public function set attributes(value:Vector.<int>) : void
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
         var result:String = "A3DVertexBuffer [";
         result += "attributes = " + this.attributes + " ";
         result += "byteBuffer = " + this.byteBuffer + " ";
         result += "vertexCount = " + this.vertexCount + " ";
         return result + "]";
      }
   }
}

