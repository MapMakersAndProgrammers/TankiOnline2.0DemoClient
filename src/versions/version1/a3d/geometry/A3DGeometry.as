package versions.version1.a3d.geometry
{
   import commons.Id;
   
   public class A3DGeometry
   {
      private var §_-3I§:Id;
      
      private var §_-EM§:A3DIndexBuffer;
      
      private var §_-0B§:Vector.<A3DVertexBuffer>;
      
      public function A3DGeometry(id:Id, indexBuffer:A3DIndexBuffer, vertexBuffers:Vector.<A3DVertexBuffer>)
      {
         super();
         this.§_-3I§ = id;
         this.§_-EM§ = indexBuffer;
         this.§_-0B§ = vertexBuffers;
      }
      
      public function get id() : Id
      {
         return this.§_-3I§;
      }
      
      public function set id(value:Id) : void
      {
         this.§_-3I§ = value;
      }
      
      public function get indexBuffer() : A3DIndexBuffer
      {
         return this.§_-EM§;
      }
      
      public function set indexBuffer(value:A3DIndexBuffer) : void
      {
         this.§_-EM§ = value;
      }
      
      public function get vertexBuffers() : Vector.<A3DVertexBuffer>
      {
         return this.§_-0B§;
      }
      
      public function set vertexBuffers(value:Vector.<A3DVertexBuffer>) : void
      {
         this.§_-0B§ = value;
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

