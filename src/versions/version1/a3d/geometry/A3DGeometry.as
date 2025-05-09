package versions.version1.a3d.geometry
{
   import commons.Id;
   
   public class A3DGeometry
   {
      private var var_101:Id;
      
      private var name_78:A3DIndexBuffer;
      
      private var var_276:Vector.<A3DVertexBuffer>;
      
      public function A3DGeometry(id:Id, indexBuffer:A3DIndexBuffer, vertexBuffers:Vector.<A3DVertexBuffer>)
      {
         super();
         this.var_101 = id;
         this.name_78 = indexBuffer;
         this.var_276 = vertexBuffers;
      }
      
      public function get id() : Id
      {
         return this.var_101;
      }
      
      public function set id(value:Id) : void
      {
         this.var_101 = value;
      }
      
      public function get indexBuffer() : A3DIndexBuffer
      {
         return this.name_78;
      }
      
      public function set indexBuffer(value:A3DIndexBuffer) : void
      {
         this.name_78 = value;
      }
      
      public function get vertexBuffers() : Vector.<A3DVertexBuffer>
      {
         return this.var_276;
      }
      
      public function set vertexBuffers(value:Vector.<A3DVertexBuffer>) : void
      {
         this.var_276 = value;
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

