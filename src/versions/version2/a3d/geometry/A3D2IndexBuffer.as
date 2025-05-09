package versions.version2.a3d.geometry
{
   import flash.utils.ByteArray;
   
   public class A3D2IndexBuffer
   {
      private var §_-79§:ByteArray;
      
      private var §_-3I§:int;
      
      private var §_-m0§:int;
      
      public function A3D2IndexBuffer(byteBuffer:ByteArray, id:int, indexCount:int)
      {
         super();
         this.§_-79§ = byteBuffer;
         this.§_-3I§ = id;
         this.§_-m0§ = indexCount;
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
      
      public function get indexCount() : int
      {
         return this.§_-m0§;
      }
      
      public function set indexCount(value:int) : void
      {
         this.§_-m0§ = value;
      }
      
      public function toString() : String
      {
         var result:String = "A3D2IndexBuffer [";
         result += "byteBuffer = " + this.byteBuffer + " ";
         result += "id = " + this.id + " ";
         result += "indexCount = " + this.indexCount + " ";
         return result + "]";
      }
   }
}

