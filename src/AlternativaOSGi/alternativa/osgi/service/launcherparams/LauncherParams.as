package alternativa.osgi.service.launcherparams
{
   import alternativa.startup.LibraryInfo;
   import alternativa.utils.Properties;
   
   public class LauncherParams implements ILauncherParams
   {
      
      private var urlParams:Properties;
      
      private var _startupLibraryInfos:Vector.<LibraryInfo>;
      
      public function LauncherParams(param1:Properties, param2:Vector.<LibraryInfo>)
      {
         super();
         this.urlParams = param1;
         this._startupLibraryInfos = param2;
      }
      
      public function getParameter(param1:String) : String
      {
         return this.urlParams.getProperty(param1);
      }
      
      public function get parameterNames() : Vector.<String>
      {
         return this.urlParams.propertyNames;
      }
      
      public function get startupLibraryInfos() : Vector.<LibraryInfo>
      {
         return this._startupLibraryInfos;
      }
      
      public function get isDebug() : Boolean
      {
         return Boolean(this.urlParams.getProperty("debug"));
      }
   }
}

