package alternativa.tanks.config
{
   public class BlobCategory
   {
      private var groups:Object;
      
      public function BlobCategory()
      {
         super();
         this.groups = new Object();
      }
      
      public function get groupIds() : Vector.<String>
      {
         var _loc2_:String = null;
         var _loc1_:Vector.<String> = new Vector.<String>();
         for(_loc2_ in this.groups)
         {
            _loc1_.push(_loc2_);
         }
         return _loc1_;
      }
      
      public function getGroup(param1:String) : BlobGroup
      {
         return this.groups[param1];
      }
      
      public function setGroup(param1:String, param2:BlobGroup) : void
      {
         this.groups[param1] = param2;
      }
   }
}

