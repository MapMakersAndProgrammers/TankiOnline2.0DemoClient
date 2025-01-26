package package_54
{
   import flash.utils.ByteArray;
   
   public class A3DVertexBuffer
   {
      private var var_273:Vector.<int>;
      
      private var var_271:ByteArray;
      
      private var var_272:uint;
      
      public function A3DVertexBuffer(attributes:Vector.<int>, byteBuffer:ByteArray, vertexCount:uint)
      {
         super();
         this.var_273 = attributes;
         this.var_271 = byteBuffer;
         this.var_272 = vertexCount;
      }
      
      public function get attributes() : Vector.<int>
      {
         return this.var_273;
      }
      
      public function set attributes(value:Vector.<int>) : void
      {
         this.var_273 = value;
      }
      
      public function get byteBuffer() : ByteArray
      {
         return this.var_271;
      }
      
      public function set byteBuffer(value:ByteArray) : void
      {
         this.var_271 = value;
      }
      
      public function get vertexCount() : uint
      {
         return this.var_272;
      }
      
      public function set vertexCount(value:uint) : void
      {
         this.var_272 = value;
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

