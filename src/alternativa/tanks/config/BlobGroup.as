package alternativa.tanks.config
{
   import flash.utils.ByteArray;
   
   public class BlobGroup
   {
      private var blobs:Object;
      
      public function BlobGroup()
      {
         super();
         this.blobs = new Object();
      }
      
      public function get blobIds() : Vector.<String>
      {
         var _loc2_:String = null;
         var _loc1_:Vector.<String> = new Vector.<String>();
         for(_loc2_ in this.blobs)
         {
            _loc1_.push(_loc2_);
         }
         return _loc1_;
      }
      
      public function getBlob(param1:String) : ByteArray
      {
         return this.blobs[param1];
      }
      
      public function setBlob(param1:String, param2:ByteArray) : void
      {
         this.blobs[param1] = param2;
      }
   }
}

