package package_103
{
   import package_15.name_19;
   import package_8.name_24;
   
   public class name_361 implements name_365
   {
      private var urlParams:name_19;
      
      private var var_553:Vector.<name_24>;
      
      public function name_361(urlParams:name_19, startupLibraryInfos:Vector.<name_24>)
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
      
      public function get startupLibraryInfos() : Vector.<name_24>
      {
         return this.var_553;
      }
      
      public function get method_609() : Boolean
      {
         return Boolean(this.urlParams.method_24("debug"));
      }
   }
}

