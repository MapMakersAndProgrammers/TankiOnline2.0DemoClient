package alternativa.tanks.game
{
   public class Entity
   {
      private static var lastId:int;
      
      private var name_3I:int;
      
      private var components:Vector.<EntityComponent>;
      
      private var name_ax:Object;
      
      internal var index:int = -1;
      
      public function Entity(id:int)
      {
         super();
         this.name_3I = id;
         this.components = new Vector.<EntityComponent>();
         this.name_ax = new Object();
      }
      
      public static function generateId() : int
      {
         return ++lastId;
      }
      
      public function get id() : int
      {
         return this.name_3I;
      }
      
      public function addComponent(component:EntityComponent) : void
      {
         this.components.push(component);
         component.setEntity(this);
      }
      
      public function initComponents() : void
      {
         var entityComponent:EntityComponent = null;
         for each(entityComponent in this.components)
         {
            entityComponent.initComponent();
         }
      }
      
      public function getComponent(cls:Class) : EntityComponent
      {
         var component:EntityComponent = null;
         for each(component in this.components)
         {
            if(component is cls)
            {
               return component;
            }
         }
         return null;
      }
      
      public function getComponentStrict(cls:Class) : EntityComponent
      {
         var component:EntityComponent = this.getComponent(cls);
         if(component == null)
         {
            throw new Error("Component " + cls + " not found");
         }
         return component;
      }
      
      public function addToGame(gameKernel:GameKernel) : void
      {
         var entityComponent:EntityComponent = null;
         for each(entityComponent in this.components)
         {
            entityComponent.addToGame(gameKernel);
         }
      }
      
      public function removeFromGame(gameKernel:GameKernel) : void
      {
         var entityComponent:EntityComponent = null;
         for each(entityComponent in this.components)
         {
            entityComponent.removeFromGame(gameKernel);
         }
      }
      
      public function dispatchEvent(eventType:String, eventData:* = undefined) : void
      {
         var numListeners:uint = 0;
         var i:int = 0;
         var listeners:Vector.<Function> = this.name_ax[eventType];
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
         var handlers:Vector.<Function> = this.name_ax[eventType];
         if(handlers == null)
         {
            handlers = new Vector.<Function>();
            this.name_ax[eventType] = handlers;
         }
         handlers.push(handler);
      }
   }
}

