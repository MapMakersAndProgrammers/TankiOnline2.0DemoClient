package alternativa.osgi
{
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   import package_31.class_6;
   import package_31.name_202;
   import package_39.name_203;
   
   public class OSGi
   {
      public static var clientLog:name_203;
      
      private static var instance:OSGi;
      
      private static const LOG_CHANNEL:String = "osgi";
      
      private var var_52:Object = {};
      
      private var services:Dictionary = new Dictionary();
      
      private var var_51:Dictionary = new Dictionary();
      
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
      
      public static function name_8() : OSGi
      {
         return instance;
      }
      
      public function method_121(bundleDescriptor:name_202) : void
      {
         var activators:Vector.<class_6> = null;
         var i:int = 0;
         var activator:class_6 = null;
         if(this.var_52[bundleDescriptor.name] == null)
         {
            clientLog.log(LOG_CHANNEL,"Installing bundle %1",bundleDescriptor.name);
            clientLog.log(LOG_CHANNEL,"Bundle activators: %1",bundleDescriptor.activators);
            this.var_52[bundleDescriptor.name] = bundleDescriptor;
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
      
      public function method_120(bundleName:String) : void
      {
         var i:int = 0;
         var activator:class_6 = null;
         if(bundleName == null)
         {
            throw new ArgumentError("Bundle name is null");
         }
         var bundleDescriptor:name_202 = this.var_52[bundleName];
         if(bundleDescriptor == null)
         {
            throw new Error("Bundle " + bundleName + " not found");
         }
         var activators:Vector.<class_6> = bundleDescriptor.activators;
         if(activators != null)
         {
            for(i = 0; i < activators.length; i++)
            {
               activator = activators[i];
               clientLog.log(LOG_CHANNEL,"Invoking stop() on activator " + getQualifiedClassName(activator));
               activator.stop(this);
            }
         }
         delete this.var_52[bundleName];
         clientLog.log(LOG_CHANNEL,"Bundle " + bundleName + " has been uninstalled");
      }
      
      public function method_116(serviceInterface:Class, serviceImplementation:Object) : void
      {
         var injectPoints:Vector.<InjectPoint> = null;
         var ip:InjectPoint = null;
         if(this.services[serviceInterface] == null)
         {
            this.services[serviceInterface] = serviceImplementation;
            if(this.var_51[serviceInterface] != null)
            {
               injectPoints = this.var_51[serviceInterface];
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
      
      public function method_118(serviceInterfaces:Array, serviceImplementation:Object) : void
      {
         var serviceInterface:Class = null;
         for each(serviceInterface in serviceInterfaces)
         {
            this.method_116(serviceInterface,serviceImplementation);
         }
      }
      
      public function method_117(serviceInterface:Class) : void
      {
         if(this.services[serviceInterface] != null)
         {
            delete this.services[serviceInterface];
            delete this.var_51[serviceInterface];
            clientLog.log(LOG_CHANNEL,"Service has been unregistered: " + serviceInterface);
         }
      }
      
      public function name_30(serviceInterface:Class) : Object
      {
         return this.services[serviceInterface];
      }
      
      public function name_161(serviceInterface:Class, injectFieldOwner:Class, injectFieldName:String) : void
      {
         if(!this.var_51[serviceInterface])
         {
            this.var_51[serviceInterface] = new Vector.<InjectPoint>();
         }
         this.var_51[serviceInterface].push(new InjectPoint(injectFieldOwner,injectFieldName));
         injectFieldOwner[injectFieldName] = this.services[serviceInterface];
         clientLog.log(LOG_CHANNEL,"Inject %1 have been processed. Current value is %2",injectFieldOwner + "." + injectFieldName,this.services[serviceInterface]);
      }
      
      public function get method_122() : Vector.<name_202>
      {
         var bundleDescriptor:name_202 = null;
         var list:Vector.<name_202> = new Vector.<name_202>();
         for each(bundleDescriptor in this.var_52)
         {
            list.push(bundleDescriptor);
         }
         return list;
      }
      
      public function get method_119() : Vector.<Object>
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
