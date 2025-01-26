package package_54
{
   import package_57.name_213;
   
   public class A3DGeometry
   {
      private var var_101:name_213;
      
      private var name_132:A3DIndexBuffer;
      
      private var var_277:Vector.<A3DVertexBuffer>;
      
      public function A3DGeometry(id:name_213, indexBuffer:A3DIndexBuffer, vertexBuffers:Vector.<A3DVertexBuffer>)
      {
         super();
         this.var_101 = id;
         this.name_132 = indexBuffer;
         this.var_277 = vertexBuffers;
      }
      
      public function get id() : name_213
      {
         return this.var_101;
      }
      
      public function set id(value:name_213) : void
      {
         this.var_101 = value;
      }
      
      public function get indexBuffer() : A3DIndexBuffer
      {
         return this.name_132;
      }
      
      public function set indexBuffer(value:A3DIndexBuffer) : void
      {
         this.name_132 = value;
      }
      
      public function get vertexBuffers() : Vector.<A3DVertexBuffer>
      {
         return this.var_277;
      }
      
      public function set vertexBuffers(value:Vector.<A3DVertexBuffer>) : void
      {
         this.var_277 = value;
      }
      
      public function toString() : String
      {
         var result:String = "A3DGeometry [";
         result += "id = " + this.id + " ";
         result += "indexBuffer = " + this.indexBuffer + " ";
         result += "vertexBuffers = " + this.vertexBuffers + " ";
         return result + "]";
      }
   }
}

