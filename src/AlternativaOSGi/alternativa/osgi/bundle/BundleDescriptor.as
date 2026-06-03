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
      
      private var _activators:Vector.<IBundleActivator>;
      
      private var _properties:Properties;
      
      public function BundleDescriptor(param1:Properties)
      {
         var _loc3_:String = null;
         var _loc4_:Boolean = false;
         var _loc5_:Class = null;
         super();
         this._properties = param1 || new Properties();
         this._name = param1.getProperty("Bundle-Name");
         clientLog.log(LOG_CHANNEL,"BundleDescriptor: Bundle name: %1",this._name);
         var _loc2_:Array = [param1.getProperty("Bundle-Activator")];
         if(Boolean(this._name))
         {
            _loc2_.push(this._name.toLowerCase() + ".Activator");
         }
         this._activators = new Vector.<IBundleActivator>();
         for each(_loc3_ in _loc2_)
         {
            _loc4_ = ApplicationDomain.currentDomain.hasDefinition(_loc3_);
            if(_loc4_)
            {
               _loc5_ = Class(ApplicationDomain.currentDomain.getDefinition(_loc3_));
               this._activators.push(IBundleActivator(new _loc5_()));
               clientLog.log(LOG_CHANNEL,"BundleDescriptor: Activator has been created: %1",_loc3_);
            }
            else
            {
               clientLog.log(LOG_CHANNEL,"BundleDescriptor: Activator NOT FOUND: %1 ",_loc3_);
            }
         }
      }
      
      public function get name() : String
      {
         return this._name;
      }
      
      public function get activators() : Vector.<IBundleActivator>
      {
         return this._activators;
      }
      
      public function get properties() : Properties
      {
         return this._properties;
      }
   }
}

