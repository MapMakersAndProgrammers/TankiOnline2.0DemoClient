package platform.client.fp10.core.dispatcher
{
   import platform.client.fp10.core.resource.ResourceInfo;
   
   public class ResourceDispatcherItem extends DispatcherItem
   {
      
      public var resourceInfo:ResourceInfo;
      
      public var resourceParams:Object;
      
      public function ResourceDispatcherItem(param1:ResourceInfo, param2:Object)
      {
         var _loc3_:int = 0;
         super(DispatcherItem.RESOURCE);
         this.resourceInfo = param1;
         this.resourceParams = param2;
         if(param1.locales != null)
         {
            _loc3_ = 0;
            while(_loc3_ < param1.locales.length)
            {
               param1.locales[_loc3_] = param1.locales[_loc3_].toLowerCase();
               _loc3_++;
            }
         }
      }
      
      override public function toString() : String
      {
         return "[Resource id=" + this.resourceInfo.id + "]";
      }
   }
}

