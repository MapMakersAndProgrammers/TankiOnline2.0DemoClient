package package_103
{
   import alternativa.utils.Properties;
   import alternativa.startup.LibraryInfo;
   
   public class name_361 implements name_365
   {
      private var urlParams:Properties;
      
      private var var_553:Vector.<LibraryInfo>;
      
      public function name_361(urlParams:Properties, startupLibraryInfos:Vector.<LibraryInfo>)
      {
         super();
         this.urlParams = urlParams;
         this.var_553 = startupLibraryInfos;
      }
      
      public function method_608(parameterName:String) : String
      {
         return this.urlParams.method_24(parameterName);
      }
      
      public function get method_607() : Vector.<String>
      {
         return this.urlParams.method_26;
      }
      
      public function get startupLibraryInfos() : Vector.<LibraryInfo>
      {
         return this.var_553;
      }
      
      public function get method_609() : Boolean
      {
         return Boolean(this.urlParams.method_24("debug"));
      }
   }
}

