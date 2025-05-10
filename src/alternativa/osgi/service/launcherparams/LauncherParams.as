package alternativa.osgi.service.launcherparams
{
   import alternativa.startup.LibraryInfo;
   import alternativa.utils.Properties;
   
   public class LauncherParams implements ILauncherParams
   {
      private var urlParams:Properties;
      
      private var §_-QJ§:Vector.<LibraryInfo>;
      
      public function LauncherParams(urlParams:Properties, startupLibraryInfos:Vector.<LibraryInfo>)
      {
         super();
         this.urlParams = urlParams;
         this.§_-QJ§ = startupLibraryInfos;
      }
      
      public function getParameter(parameterName:String) : String
      {
         return this.urlParams.getProperty(parameterName);
      }
      
      public function get parameterNames() : Vector.<String>
      {
         return this.urlParams.propertyNames;
      }
      
      public function get startupLibraryInfos() : Vector.<LibraryInfo>
      {
         return this.§_-QJ§;
      }
      
      public function get isDebug() : Boolean
      {
         return Boolean(this.urlParams.getProperty("debug"));
      }
   }
}

