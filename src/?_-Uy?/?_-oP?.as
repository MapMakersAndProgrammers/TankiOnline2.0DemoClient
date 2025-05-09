package §_-Uy§
{
   import §_-HW§.§_-C§;
   import §_-HW§.§_-pF§;
   import §_-MU§.§_-bV§;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   
   public class §_-oP§
   {
      public static var clientLog:§_-bV§;
      
      private static var instance:§_-oP§;
      
      private static const LOG_CHANNEL:String = "osgi";
      
      private var §_-2M§:Object = {};
      
      private var services:Dictionary = new Dictionary();
      
      private var §_-dp§:Dictionary = new Dictionary();
      
      public function §_-oP§()
      {
         super();
         if(instance == null)
         {
            instance = this;
            return;
         }
         throw new Error("Only one instance of OSGi class is allowed");
      }
      
      public static function §_-nQ§() : §_-oP§
      {
         return instance;
      }
      
      public function §_-XK§(bundleDescriptor:§_-C§) : void
      {
         var activators:Vector.<§_-pF§> = null;
         var i:int = 0;
         var activator:§_-pF§ = null;
         if(this.§_-2M§[bundleDescriptor.name] == null)
         {
            clientLog.log(LOG_CHANNEL,"Installing bundle %1",bundleDescriptor.name);
            clientLog.log(LOG_CHANNEL,"Bundle activators: %1",bundleDescriptor.activators);
            this.§_-2M§[bundleDescriptor.name] = bundleDescriptor;
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
      
      public function §_-PX§(bundleName:String) : void
      {
         var i:int = 0;
         var activator:§_-pF§ = null;
         if(bundleName == null)
         {
            throw new ArgumentError("Bundle name is null");
         }
         var bundleDescriptor:§_-C§ = this.§_-2M§[bundleName];
         if(bundleDescriptor == null)
         {
            throw new Error("Bundle " + bundleName + " not found");
         }
         var activators:Vector.<§_-pF§> = bundleDescriptor.activators;
         if(activators != null)
         {
            for(i = 0; i < activators.length; i++)
            {
               activator = activators[i];
               clientLog.log(LOG_CHANNEL,"Invoking stop() on activator " + getQualifiedClassName(activator));
               activator.stop(this);
            }
         }
         delete this.§_-2M§[bundleName];
         clientLog.log(LOG_CHANNEL,"Bundle " + bundleName + " has been uninstalled");
      }
      
      public function §_-g2§(serviceInterface:Class, serviceImplementation:Object) : void
      {
         var injectPoints:Vector.<InjectPoint> = null;
         var ip:InjectPoint = null;
         if(this.services[serviceInterface] == null)
         {
            this.services[serviceInterface] = serviceImplementation;
            if(this.§_-dp§[serviceInterface] != null)
            {
               injectPoints = this.§_-dp§[serviceInterface];
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
      
      public function §_-pC§(serviceInterfaces:Array, serviceImplementation:Object) : void
      {
         var serviceInterface:Class = null;
         for each(serviceInterface in serviceInterfaces)
         {
            this.§_-g2§(serviceInterface,serviceImplementation);
         }
      }
      
      public function §_-5n§(serviceInterface:Class) : void
      {
         if(this.services[serviceInterface] != null)
         {
            delete this.services[serviceInterface];
            delete this.§_-dp§[serviceInterface];
            clientLog.log(LOG_CHANNEL,"Service has been unregistered: " + serviceInterface);
         }
      }
      
      public function §_-N6§(serviceInterface:Class) : Object
      {
         return this.services[serviceInterface];
      }
      
      public function §_-oK§(serviceInterface:Class, injectFieldOwner:Class, injectFieldName:String) : void
      {
         if(!this.§_-dp§[serviceInterface])
         {
            this.§_-dp§[serviceInterface] = new Vector.<InjectPoint>();
         }
         this.§_-dp§[serviceInterface].push(new InjectPoint(injectFieldOwner,injectFieldName));
         injectFieldOwner[injectFieldName] = this.services[serviceInterface];
         clientLog.log(LOG_CHANNEL,"Inject %1 have been processed. Current value is %2",injectFieldOwner + "." + injectFieldName,this.services[serviceInterface]);
      }
      
      public function get §_-01§() : Vector.<§_-C§>
      {
         var bundleDescriptor:§_-C§ = null;
         var list:Vector.<§_-C§> = new Vector.<§_-C§>();
         for each(bundleDescriptor in this.§_-2M§)
         {
            list.push(bundleDescriptor);
         }
         return list;
      }
      
      public function get §_-cA§() : Vector.<Object>
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
