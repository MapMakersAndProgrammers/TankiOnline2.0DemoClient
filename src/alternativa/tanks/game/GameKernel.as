package alternativa.tanks.game
{
   import flash.display.Stage;
   import alternativa.tanks.game.subsystems.rendersystem.RenderSystem;
   import alternativa.tanks.game.subsystems.eventsystem.EventSystem;
   import alternativa.tanks.game.subsystems.eventsystem.IEventSystem;
   import alternativa.tanks.game.subsystems.inputsystem.InputSystem;
   import alternativa.tanks.game.subsystems.inputsystem.IInput;
   import alternativa.tanks.game.utils.objectpool.ObjectPoolManager;
   import package_27.name_180;
   import package_42.name_177;
   import package_42.name_184;
   import package_43.name_183;
   import package_43.name_190;
   import package_44.name_178;
   import package_45.name_182;
   
   public class GameKernel
   {
      public static const TIME_SYSTEM_PRIORITY:int = 0;
      
      public static const INPUT_SYSTEM_PRIORITY:int = 1000;
      
      public static const EVENT_SYSTEM_PRIORITY:int = 2000;
      
      public static const LOGIC_SYSTEM_1_PRIORITY:int = 3000;
      
      public static const LOGIC_SYSTEM_2_PRIORITY:int = 3001;
      
      public static const PHYSICS_SYSTEM_PRIORITY:int = 4000;
      
      public static const RENDER_SYSTEM_PRIORITY:int = 5000;
      
      public static const CLEANUP_SYSTEM_PRIORITY:int = 6000;
      
      public const const_1:name_180 = new name_180(20);
      
      private var var_43:Stage;
      
      private var var_36:Object;
      
      private var var_41:IGameLogger = new DummyLogger();
      
      private var var_4:TaskManager;
      
      private var var_44:name_182;
      
      private var inputSystem:InputSystem;
      
      private var eventSystem:EventSystem;
      
      private var logicSystem1:name_177;
      
      private var logicSystem2:name_177;
      
      private var physicsSystem:name_178;
      
      private var renderSystem:RenderSystem;
      
      private var var_42:name_183;
      
      private var var_39:Vector.<Entity>;
      
      private var var_38:int;
      
      private var var_40:ObjectPoolManager;
      
      public function GameKernel(stage:Stage, options:Object)
      {
         super();
         this.var_43 = stage;
         this.var_36 = options || {};
         this.var_39 = new Vector.<Entity>();
         this.var_40 = new ObjectPoolManager();
         this.var_4 = new TaskManager();
         this.var_44 = new name_182(TIME_SYSTEM_PRIORITY);
         this.var_4.addTask(this.var_44);
         this.inputSystem = new InputSystem(INPUT_SYSTEM_PRIORITY,stage);
         this.var_4.addTask(this.inputSystem);
         this.eventSystem = new EventSystem(EVENT_SYSTEM_PRIORITY);
         this.var_4.addTask(this.eventSystem);
         this.logicSystem1 = new name_177(LOGIC_SYSTEM_1_PRIORITY,this);
         this.var_4.addTask(this.logicSystem1);
         this.logicSystem2 = new name_177(LOGIC_SYSTEM_2_PRIORITY,this);
         this.var_4.addTask(this.logicSystem2);
         this.physicsSystem = new name_178(PHYSICS_SYSTEM_PRIORITY,this.var_40);
         this.var_4.addTask(this.physicsSystem);
         this.renderSystem = new RenderSystem(RENDER_SYSTEM_PRIORITY,stage);
         this.var_4.addTask(this.renderSystem);
         this.var_42 = new name_183(CLEANUP_SYSTEM_PRIORITY);
         this.var_4.addTask(this.var_42);
      }
      
      public function get logger() : IGameLogger
      {
         return this.var_41;
      }
      
      public function set logger(value:IGameLogger) : void
      {
         if(value == null)
         {
            throw new ArgumentError("Logger is null");
         }
         this.var_41 = value;
      }
      
      public function get stage() : Stage
      {
         return this.var_43;
      }
      
      public function get options() : Object
      {
         return this.var_36;
      }
      
      public function method_111(command:name_190) : void
      {
         this.var_42.name_187(command);
      }
      
      public function method_108() : ObjectPoolManager
      {
         return this.var_40;
      }
      
      public function addTask(gameTask:GameTask) : void
      {
         this.var_4.addTask(gameTask);
      }
      
      public function name_73(entity:Entity) : void
      {
         if(entity.index < 0)
         {
            entity.index = this.var_38;
            var _loc2_:* = this.var_38++;
            this.var_39[_loc2_] = entity;
            entity.addToGame(this);
            return;
         }
         throw new Error("Entity " + entity + " is already in game");
      }
      
      public function method_109(entity:Entity) : void
      {
         var index:int = int(entity.index);
         if(index < 0)
         {
            throw new Error("Entity " + entity + " is not in game");
         }
         var lastEntity:Entity = this.var_39[--this.var_38];
         lastEntity.index = index;
         this.var_39[index] = lastEntity;
         this.var_39[this.var_38] = null;
         entity.index = -1;
         entity.removeFromGame(this);
      }
      
      public function name_66() : IInput
      {
         return this.inputSystem;
      }
      
      public function name_61() : IEventSystem
      {
         return this.eventSystem;
      }
      
      public function getLogicSystem1() : name_184
      {
         return this.logicSystem1;
      }
      
      public function getLogicSystem2() : name_184
      {
         return this.logicSystem2;
      }
      
      public function method_112() : name_178
      {
         return this.physicsSystem;
      }
      
      public function name_5() : RenderSystem
      {
         return this.renderSystem;
      }
      
      public function name_51() : void
      {
         this.const_1.name_188();
         this.var_4.name_185();
         this.const_1.name_186();
      }
      
      public function method_110() : void
      {
         this.var_4.name_189();
         this.var_4.name_185();
      }
   }
}

class DummyLogger implements IGameLogger
{
   public function DummyLogger()
   {
      super();
   }
   
   public function log(channel:String, text:String) : void
   {
   }
}
