package alternativa.tanks.config
{
   public class BlobLibrary
   {
      private var var_199:Object;
      
      public function BlobLibrary()
      {
         super();
         this.var_199 = new Object();
      }
      
      public function get categoryIds() : Vector.<String>
      {
         var _loc2_:String = null;
         var _loc1_:Vector.<String> = new Vector.<String>();
         for(_loc2_ in this.var_199)
         {
            _loc1_.push(_loc2_);
         }
         return _loc1_;
      }
      
      public function getCategory(param1:String) : BlobCategory
      {
         return this.var_199[param1];
      }
      
      public function setCategory(param1:String, param2:BlobCategory) : void
      {
         this.var_199[param1] = param2;
      }
   }
}

