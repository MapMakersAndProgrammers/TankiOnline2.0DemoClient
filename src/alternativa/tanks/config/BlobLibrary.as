package alternativa.tanks.config
{
   public class BlobLibrary
   {
      private var name_GF:Object;
      
      public function BlobLibrary()
      {
         super();
         this.name_GF = new Object();
      }
      
      public function get categoryIds() : Vector.<String>
      {
         var _loc2_:String = null;
         var _loc1_:Vector.<String> = new Vector.<String>();
         for(_loc2_ in this.name_GF)
         {
            _loc1_.push(_loc2_);
         }
         return _loc1_;
      }
      
      public function getCategory(param1:String) : BlobCategory
      {
         return this.name_GF[param1];
      }
      
      public function setCategory(param1:String, param2:BlobCategory) : void
      {
         this.name_GF[param1] = param2;
      }
   }
}

