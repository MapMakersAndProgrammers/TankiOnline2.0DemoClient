package alternativa.osgi.bundle
{
   import alternativa.osgi.OSGi;
   import alternativa.osgi.service.clientlog.IClientLog;
   import alternativa.utils.Properties;
   import flash.system.ApplicationDomain;
   
   public class BundleDescriptor implements IBundleDescriptor
   {
      private static var LOG_CHANNEL:String = "osgi";
      
      private static var clientLog:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));
      
      private var _name:String;
      
      private var var_566:Vector.<IBundleActivator>;
      
      private var var_567:Properties;
      
      public function BundleDescriptor(properties:Properties)
      {
         var activatorClassName:String = null;
         var isActivatorExists:Boolean = false;
         var activatorClass:Class = null;
         super();
         this.var_567 = properties || new Properties();
         this._name = properties.getProperty("Bundle-Name");
         clientLog.log(LOG_CHANNEL,"BundleDescriptor: Bundle name: %1",this._name);
         var activatorClassNames:Array = [properties.getProperty("Bundle-Activator")];
         if(Boolean(this._name))
         {
            activatorClassNames.push(this._name.toLowerCase() + ".Activator");
         }
         this.var_566 = new Vector.<IBundleActivator>();
         for each(activatorClassName in activatorClassNames)
         {
            isActivatorExists = Boolean(ApplicationDomain.currentDomain.hasDefinition(activatorClassName));
            if(isActivatorExists)
            {
               activatorClass = Class(ApplicationDomain.currentDomain.getDefinition(activatorClassName));
               this.var_566.push(IBundleActivator(new activatorClass()));
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
      
      public function get activators() : Vector.<IBundleActivator>
      {
         return this.var_566;
      }
      
      public function get properties() : Properties
      {
         return this.var_567;
      }
   }
}

