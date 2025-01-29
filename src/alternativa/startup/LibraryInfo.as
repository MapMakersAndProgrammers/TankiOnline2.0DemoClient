package alternativa.startup
{
   import flash.display.Loader;
   import alternativa.utils.Properties;
   
   public class LibraryInfo
   {
      public var name:String;
      
      public var resourceId:String;
      
      public var resourceVersion:String;
      
      public var manifestProperties:Properties;
      
      public var loader:Loader;
      
      public var size:int;
      
      public function LibraryInfo(name:String, resourceId:String, resourceVersion:String, manifestProperties:Properties, size:int)
      {
         super();
         this.name = name;
         this.resourceId = resourceId;
         this.resourceVersion = resourceVersion;
         this.manifestProperties = manifestProperties;
         this.size = size;
      }
      
      public function toString() : String
      {
         return "[BundleInfo name=" + this.name + ", id=" + this.resourceId + ", version=" + this.resourceVersion + ", manifestProperties=" + this.manifestProperties + ", size=" + this.size;
      }
   }
}

