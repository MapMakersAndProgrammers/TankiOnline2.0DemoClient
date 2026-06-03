package platform.client.fp10.core.resource
{
   import alternativa.startup.LibraryInfo;
   import alternativa.types.Long;
   import flash.display.Loader;
   
   public class LibraryResourceWrapper extends Resource
   {
      
      private var loader:Loader;
      
      private var libraryInfo:LibraryInfo;
      
      public function LibraryResourceWrapper(param1:LibraryInfo)
      {
         super(new ResourceInfo(ResourceType.SWF_LIBRARY,Long.fromHexString(param1.resourceId),Long.fromHexString(param1.resourceVersion),false,null,null));
         this.loader = param1.loader;
         this.libraryInfo = param1;
      }
      
      override public function toString() : String
      {
         return "[" + super.toString() + ", name = " + this.libraryInfo.name + "]";
      }
   }
}

