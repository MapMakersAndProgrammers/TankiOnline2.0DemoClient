package package_10
{
   public class name_54
   {
      private static var lastId:int;
      
      private var var_101:int;
      
      private var components:Vector.<class_17>;
      
      private var var_100:Object;
      
      internal var index:int = -1;
      
      public function name_54(id:int)
      {
         super();
         this.var_101 = id;
         this.components = new Vector.<class_17>();
         this.var_100 = new Object();
      }
      
      public static function name_74() : int
      {
         return ++lastId;
      }
      
      public function get id() : int
      {
         return this.var_101;
      }
      
      public function name_60(component:class_17) : void
      {
         this.components.push(component);
         component.method_197(this);
      }
      
      public function name_64() : void
      {
         var entityComponent:class_17 = null;
         for each(entityComponent in this.components)
         {
            entityComponent.initComponent();
         }
      }
      
      public function getComponent(cls:Class) : class_17
      {
         var component:class_17 = null;
         for each(component in this.components)
         {
            if(component is cls)
            {
               return component;
            }
         }
         return null;
      }
      
      public function getComponentStrict(cls:Class) : class_17
      {
         var component:class_17 = this.getComponent(cls);
         if(component == null)
         {
            throw new Error("Component " + cls + " not found");
         }
         return component;
      }
      
      public function addToGame(gameKernel:name_17) : void
      {
         var entityComponent:class_17 = null;
         for each(entityComponent in this.components)
         {
            entityComponent.addToGame(gameKernel);
         }
      }
      
      public function removeFromGame(gameKernel:name_17) : void
      {
         var entityComponent:class_17 = null;
         for each(entityComponent in this.components)
         {
            entityComponent.removeFromGame(gameKernel);
         }
      }
      
      public function dispatchEvent(eventType:String, eventData:* = undefined) : void
      {
         var numListeners:uint = 0;
         var i:int = 0;
         var listeners:Vector.<Function> = this.var_100[eventType];
         if(listeners != null)
         {
            numListeners = uint(listeners.length);
            for(i = 0; i < numListeners; i++)
            {
               listeners[i].call(null,eventType,eventData);
            }
         }
      }
      
      public function addEventHandler(eventType:String, handler:Function) : void
      {
         var handlers:Vector.<Function> = this.var_100[eventType];
         if(handlers == null)
         {
            handlers = new Vector.<Function>();
            this.var_100[eventType] = handlers;
         }
         handlers.push(handler);
      }
   }
}

