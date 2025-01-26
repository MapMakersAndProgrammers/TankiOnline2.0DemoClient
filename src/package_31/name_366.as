package package_31
{
   import flash.system.ApplicationDomain;
   import package_15.name_19;
   import package_39.name_160;
   import alternativa.osgi.OSGi;
   
   public class name_366 implements name_202
   {
      private static var LOG_CHANNEL:String = "osgi";
      
      private static var clientLog:name_160 = name_160(OSGi.name_8().name_30(name_160));
      
      private var _name:String;
      
      private var var_566:Vector.<class_6>;
      
      private var var_567:name_19;
      
      public function name_366(properties:name_19)
      {
         var activatorClassName:String = null;
         var isActivatorExists:Boolean = false;
         var activatorClass:Class = null;
         super();
         this.var_567 = properties || new name_19();
         this._name = properties.method_24("Bundle-Name");
         clientLog.log(LOG_CHANNEL,"BundleDescriptor: Bundle name: %1",this._name);
         var activatorClassNames:Array = [properties.method_24("Bundle-Activator")];
         if(Boolean(this._name))
         {
            activatorClassNames.push(this._name.toLowerCase() + ".Activator");
         }
         this.var_566 = new Vector.<class_6>();
         for each(activatorClassName in activatorClassNames)
         {
            isActivatorExists = Boolean(ApplicationDomain.currentDomain.hasDefinition(activatorClassName));
            if(isActivatorExists)
            {
               activatorClass = Class(ApplicationDomain.currentDomain.getDefinition(activatorClassName));
               this.var_566.push(class_6(new activatorClass()));
               clientLog.log(LOG_CHANNEL,"BundleDescriptor: Activator has been created: %1",activatorClassName);
            }
            else
            {
               clientLog.log(LOG_CHANNEL,"BundleDescriptor: Activator NOT FOUND: %1 ",activatorClassName);
            }
         }
      }
      
      public function get name() : String
      {
         return this._name;
      }
      
      public function get activators() : Vector.<class_6>
      {
         return this.var_566;
      }
      
      public function get properties() : name_19
      {
         return this.var_567;
      }
   }
}

