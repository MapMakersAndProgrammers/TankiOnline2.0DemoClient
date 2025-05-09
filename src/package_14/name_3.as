package package_14
{
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   import package_31.name_113;
   import package_31.name_114;
   import package_32.name_115;
   
   public class name_3
   {
      public static var clientLog:name_115;
      
      private static var instance:name_3;
      
      private static const LOG_CHANNEL:String = "osgi";
      
      private var var_52:Object = {};
      
      private var services:Dictionary = new Dictionary();
      
      private var var_51:Dictionary = new Dictionary();
      
      public function name_3()
      {
         super();
         if(instance == null)
         {
            instance = this;
            return;
         }
         throw new Error("Only one instance of OSGi class is allowed");
      }
      
      public static function name_8() : name_3
      {
         return instance;
      }
      
      public function method_44(bundleDescriptor:name_113) : void
      {
         var activators:Vector.<name_114> = null;
         var i:int = 0;
         var activator:name_114 = null;
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
      
      public function method_43(bundleName:String) : void
      {
         var i:int = 0;
         var activator:name_114 = null;
         if(bundleName == null)
         {
            throw new ArgumentError("Bundle name is null");
         }
         var bundleDescriptor:name_113 = this.var_52[bundleName];
         if(bundleDescriptor == null)
         {
            throw new Error("Bundle " + bundleName + " not found");
         }
         var activators:Vector.<name_114> = bundleDescriptor.activators;
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
      
      public function method_38(serviceInterface:Class, serviceImplementation:Object) : void
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
      
      public function method_40(serviceInterfaces:Array, serviceImplementation:Object) : void
      {
         var serviceInterface:Class = null;
         for each(serviceInterface in serviceInterfaces)
         {
            this.method_38(serviceInterface,serviceImplementation);
         }
      }
      
      public function method_39(serviceInterface:Class) : void
      {
         if(this.services[serviceInterface] != null)
         {
            delete this.services[serviceInterface];
            delete this.var_51[serviceInterface];
            clientLog.log(LOG_CHANNEL,"Service has been unregistered: " + serviceInterface);
         }
      }
      
      public function name_21(serviceInterface:Class) : Object
      {
         return this.services[serviceInterface];
      }
      
      public function method_42(serviceInterface:Class, injectFieldOwner:Class, injectFieldName:String) : void
      {
         if(!this.var_51[serviceInterface])
         {
            this.var_51[serviceInterface] = new Vector.<InjectPoint>();
         }
         this.var_51[serviceInterface].push(new InjectPoint(injectFieldOwner,injectFieldName));
         injectFieldOwner[injectFieldName] = this.services[serviceInterface];
         clientLog.log(LOG_CHANNEL,"Inject %1 have been processed. Current value is %2",injectFieldOwner + "." + injectFieldName,this.services[serviceInterface]);
      }
      
      public function get method_45() : Vector.<name_113>
      {
         var bundleDescriptor:name_113 = null;
         var list:Vector.<name_113> = new Vector.<name_113>();
         for each(bundleDescriptor in this.var_52)
         {
            list.push(bundleDescriptor);
         }
         return list;
      }
      
      public function get method_41() : Vector.<Object>
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
