package versions.version1.a3d.geometry
{
   import commons.Id;
   
   public class A3DGeometry
   {
      private var name_3I:Id;
      
      private var name_EM:A3DIndexBuffer;
      
      private var name_0B:Vector.<A3DVertexBuffer>;
      
      public function A3DGeometry(id:Id, indexBuffer:A3DIndexBuffer, vertexBuffers:Vector.<A3DVertexBuffer>)
      {
         super();
         this.name_3I = id;
         this.name_EM = indexBuffer;
         this.name_0B = vertexBuffers;
      }
      
      public function get id() : Id
      {
         return this.name_3I;
      }
      
      public function set id(value:Id) : void
      {
         this.name_3I = value;
      }
      
      public function get indexBuffer() : A3DIndexBuffer
      {
         return this.name_EM;
      }
      
      public function set indexBuffer(value:A3DIndexBuffer) : void
      {
         this.name_EM = value;
      }
      
      public function get vertexBuffers() : Vector.<A3DVertexBuffer>
      {
         return this.name_0B;
      }
      
      public function set vertexBuffers(value:Vector.<A3DVertexBuffer>) : void
      {
         this.name_0B = value;
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

