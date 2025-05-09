package alternativa.osgi.service.launcherparams
{
   import alternativa.startup.LibraryInfo;
   
   public interface ILauncherParams
   {
      function getParameter(param1:String) : String;
      
      function get parameterNames() : Vector.<String>;
      
      function get startupLibraryInfos() : Vector.<LibraryInfo>;
      
      function get isDebug() : Boolean;
   }
}

