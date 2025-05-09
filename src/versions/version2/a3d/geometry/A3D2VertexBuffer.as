package versions.version2.a3d.geometry
{
   import flash.utils.ByteArray;
   
   public class A3D2VertexBuffer
   {
      private var var_272:Vector.<A3D2VertexAttributes>;
      
      private var var_271:ByteArray;
      
      private var var_101:int;
      
      private var var_273:uint;
      
      public function A3D2VertexBuffer(attributes:Vector.<A3D2VertexAttributes>, byteBuffer:ByteArray, id:int, vertexCount:uint)
      {
         super();
         this.var_272 = attributes;
         this.var_271 = byteBuffer;
         this.var_101 = id;
         this.var_273 = vertexCount;
      }
      
      public function get attributes() : Vector.<A3D2VertexAttributes>
      {
         return this.var_272;
      }
      
      public function set attributes(value:Vector.<A3D2VertexAttributes>) : void
      {
         this.var_272 = value;
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
      
      public function get vertexCount() : uint
      {
         return this.var_273;
      }
      
      public function set vertexCount(value:uint) : void
      {
         this.var_273 = value;
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

