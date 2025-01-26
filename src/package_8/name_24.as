package package_8
{
   import flash.display.Loader;
   import package_15.name_19;
   
   public class name_24
   {
      public var name:String;
      
      public var resourceId:String;
      
      public var resourceVersion:String;
      
      public var manifestProperties:name_19;
      
      public var loader:Loader;
      
      public var size:int;
      
      public function name_24(name:String, resourceId:String, resourceVersion:String, manifestProperties:name_19, size:int)
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

