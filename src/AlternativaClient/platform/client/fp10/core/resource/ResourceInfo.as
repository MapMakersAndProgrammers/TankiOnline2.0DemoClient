package platform.client.fp10.core.resource
{
   import alternativa.types.Long;
   
   public class ResourceInfo
   {
      
      public var type:int;
      
      public var id:Long;
      
      public var version:Long;
      
      public var isLazy:Boolean;
      
      public var locales:Vector.<String>;
      
      public var fileInfos:Vector.<ResourceFileInfo>;
      
      private var fileInfoByName:Object;
      
      public function ResourceInfo(param1:int, param2:Long, param3:Long, param4:Boolean, param5:Vector.<String>, param6:Vector.<ResourceFileInfo>)
      {
         var _loc7_:ResourceFileInfo = null;
         this.fileInfoByName = {};
         super();
         this.type = param1;
         this.id = param2;
         this.version = param3;
         this.isLazy = param4;
         this.locales = param5;
         this.fileInfos = param6;
         for each(_loc7_ in param6)
         {
            this.fileInfoByName[_loc7_.fileName] = _loc7_;
         }
      }
      
      public function getFileInfo(param1:String) : ResourceFileInfo
      {
         return this.fileInfoByName[param1];
      }
      
      public function toString() : String
      {
         return "[ResourceInfo type=" + this.type + ", id=" + this.id + ", version=" + this.version + ", isLazy=" + this.isLazy + ", locales=" + this.locales + ", fileInfos=" + this.fileInfos + "]";
      }
   }
}

