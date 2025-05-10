package alternativa.osgi
{
   import alternativa.osgi.bundle.IBundleActivator;
   import alternativa.osgi.bundle.IBundleDescriptor;
   import alternativa.osgi.service.clientlog.IClientLogBase;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   
   public class OSGi
   {
      public static var clientLog:IClientLogBase;
      
      private static var instance:OSGi;
      
      private static const LOG_CHANNEL:String = "osgi";
      
      private var name_2M:Object = {};
      
      private var services:Dictionary = new Dictionary();
      
      private var name_dp:Dictionary = new Dictionary();
      
      public function OSGi()
      {
         super();
         if(instance == null)
         {
            instance = this;
            return;
         }
         throw new Error("Only one instance of OSGi class is allowed");
      }
      
      public static function getInstance() : OSGi
      {
         return instance;
      }
      
      public function installBundle(bundleDescriptor:IBundleDescriptor) : void
      {
         var activators:Vector.<IBundleActivator> = null;
         var i:int = 0;
         var activator:IBundleActivator = null;
         if(this.name_2M[bundleDescriptor.name] == null)
         {
            clientLog.log(LOG_CHANNEL,"Installing bundle %1",bundleDescriptor.name);
            clientLog.log(LOG_CHANNEL,"Bundle activators: %1",bundleDescriptor.activators);
            this.name_2M[bundleDescriptor.name] = bundleDescriptor;
            activators = bundleDescriptor.activators;
            if(activators != null)
            {
               for(i = 0; i < activators.length; i++)
               {
                  activator = activators[i];
                  clientLog.log(LOG_CHANNEL,"Invoking start() on activator " + getQualifiedClassName(activator));
                  activator.start(this);
               }
            }
            clientLog.log(LOG_CHANNEL,"Bundle " + bundleDescriptor.name + " has been installed");
            return;
         }
         throw new Error("Bundle " + bundleDescriptor.name + " is already installed");
      }
      
      public function uninstallBundle(bundleName:String) : void
      {
         var i:int = 0;
         var activator:IBundleActivator = null;
         if(bundleName == null)
         {
            throw new ArgumentError("Bundle name is null");
         }
         var bundleDescriptor:IBundleDescriptor = this.name_2M[bundleName];
         if(bundleDescriptor == null)
         {
            throw new Error("Bundle " + bundleName + " not found");
         }
         var activators:Vector.<IBundleActivator> = bundleDescriptor.activators;
         if(activators != null)
         {
            for(i = 0; i < activators.length; i++)
            {
               activator = activators[i];
               clientLog.log(LOG_CHANNEL,"Invoking stop() on activator " + getQualifiedClassName(activator));
               activator.stop(this);
            }
         }
         delete this.name_2M[bundleName];
         clientLog.log(LOG_CHANNEL,"Bundle " + bundleName + " has been uninstalled");
      }
      
      public function registerService(serviceInterface:Class, serviceImplementation:Object) : void
      {
         var injectPoints:Vector.<InjectPoint> = null;
         var ip:InjectPoint = null;
         if(this.services[serviceInterface] == null)
         {
            this.services[serviceInterface] = serviceImplementation;
            if(this.name_dp[serviceInterface] != null)
            {
               injectPoints = this.name_dp[serviceInterface];
               for each(ip in injectPoints)
               {
                  ip.injectOwner[ip.injectFieldName] = serviceImplementation;
                  clientLog.log(LOG_CHANNEL,"Service %1 has been injected at %2",serviceInterface,ip.injectOwner + "." + ip.injectFieldName);
               }
            }
            clientLog.log(LOG_CHANNEL,"Service has been registered: " + serviceInterface);
            return;
         }
         throw new Error("Service " + serviceInterface + " is already registered");
      }
      
      public function registerServiceMulty(serviceInterfaces:Array, serviceImplementation:Object) : void
      {
         var serviceInterface:Class = null;
         for each(serviceInterface in serviceInterfaces)
         {
            this.registerService(serviceInterface,serviceImplementation);
         }
      }
      
      public function unregisterService(serviceInterface:Class) : void
      {
         if(this.services[serviceInterface] != null)
         {
            delete this.services[serviceInterface];
            delete this.name_dp[serviceInterface];
            clientLog.log(LOG_CHANNEL,"Service has been unregistered: " + serviceInterface);
         }
      }
      
      public function getService(serviceInterface:Class) : Object
      {
         return this.services[serviceInterface];
      }
      
      public function injectService(serviceInterface:Class, injectFieldOwner:Class, injectFieldName:String) : void
      {
         if(!this.name_dp[serviceInterface])
         {
            this.name_dp[serviceInterface] = new Vector.<InjectPoint>();
         }
         this.name_dp[serviceInterface].push(new InjectPoint(injectFieldOwner,injectFieldName));
         injectFieldOwner[injectFieldName] = this.services[serviceInterface];
         clientLog.log(LOG_CHANNEL,"Inject %1 have been processed. Current value is %2",injectFieldOwner + "." + injectFieldName,this.services[serviceInterface]);
      }
      
      public function get bundleList() : Vector.<IBundleDescriptor>
      {
         var bundleDescriptor:IBundleDescriptor = null;
         var list:Vector.<IBundleDescriptor> = new Vector.<IBundleDescriptor>();
         for each(bundleDescriptor in this.name_2M)
         {
            list.push(bundleDescriptor);
         }
         return list;
      }
      
      public function get serviceList() : Vector.<Object>
      {
         var service:Object = null;
         var list:Vector.<Object> = new Vector.<Object>();
         for each(service in this.services)
         {
            list.push(service);
         }
         return list;
      }
   }
}

class InjectPoint
{
   public var injectOwner:Class;
   
   public var injectFieldName:String;
   
   public function InjectPoint(injectOwner:Class, injectFieldName:String)
   {
      super();
      this.injectOwner = injectOwner;
      this.injectFieldName = injectFieldName;
   }
}
