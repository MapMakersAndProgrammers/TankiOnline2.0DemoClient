package alternativa.tanks.game
{
   import alternativa.tanks.game.subsystems.deferredcommandssystem.DeferredCommand;
   import alternativa.tanks.game.subsystems.deferredcommandssystem.DeferredCommandsSystem;
   import alternativa.tanks.game.subsystems.eventsystem.EventSystem;
   import alternativa.tanks.game.subsystems.eventsystem.IEventSystem;
   import alternativa.tanks.game.subsystems.inputsystem.IInput;
   import alternativa.tanks.game.subsystems.inputsystem.InputSystem;
   import alternativa.tanks.game.subsystems.logicsystem.ILogic;
   import alternativa.tanks.game.subsystems.logicsystem.LogicSystem;
   import alternativa.tanks.game.subsystems.physicssystem.PhysicsSystem;
   import alternativa.tanks.game.subsystems.rendersystem.RenderSystem;
   import alternativa.tanks.game.subsystems.timesystem.TimeSystem;
   import alternativa.tanks.game.utils.TimeStat;
   import alternativa.tanks.game.utils.objectpool.ObjectPoolManager;
   import flash.display.Stage;
   
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
      
      public const §_-PI§:TimeStat = new TimeStat(20);
      
      private var §_-We§:Stage;
      
      private var §_-D9§:Object;
      
      private var §_-IC§:IGameLogger = new DummyLogger();
      
      private var §_-Uw§:TaskManager;
      
      private var §_-f2§:TimeSystem;
      
      private var inputSystem:InputSystem;
      
      private var eventSystem:EventSystem;
      
      private var logicSystem1:LogicSystem;
      
      private var logicSystem2:LogicSystem;
      
      private var physicsSystem:PhysicsSystem;
      
      private var renderSystem:RenderSystem;
      
      private var §_-0s§:DeferredCommandsSystem;
      
      private var §_-jZ§:Vector.<Entity>;
      
      private var §_-TA§:int;
      
      private var §_-XC§:ObjectPoolManager;
      
      public function GameKernel(stage:Stage, options:Object)
      {
         super();
         this.§_-We§ = stage;
         this.§_-D9§ = options || {};
         this.§_-jZ§ = new Vector.<Entity>();
         this.§_-XC§ = new ObjectPoolManager();
         this.§_-Uw§ = new TaskManager();
         this.§_-f2§ = new TimeSystem(TIME_SYSTEM_PRIORITY);
         this.§_-Uw§.addTask(this.§_-f2§);
         this.inputSystem = new InputSystem(INPUT_SYSTEM_PRIORITY,stage);
         this.§_-Uw§.addTask(this.inputSystem);
         this.eventSystem = new EventSystem(EVENT_SYSTEM_PRIORITY);
         this.§_-Uw§.addTask(this.eventSystem);
         this.logicSystem1 = new LogicSystem(LOGIC_SYSTEM_1_PRIORITY,this);
         this.§_-Uw§.addTask(this.logicSystem1);
         this.logicSystem2 = new LogicSystem(LOGIC_SYSTEM_2_PRIORITY,this);
         this.§_-Uw§.addTask(this.logicSystem2);
         this.physicsSystem = new PhysicsSystem(PHYSICS_SYSTEM_PRIORITY,this.§_-XC§);
         this.§_-Uw§.addTask(this.physicsSystem);
         this.renderSystem = new RenderSystem(RENDER_SYSTEM_PRIORITY,stage);
         this.§_-Uw§.addTask(this.renderSystem);
         this.§_-0s§ = new DeferredCommandsSystem(CLEANUP_SYSTEM_PRIORITY);
         this.§_-Uw§.addTask(this.§_-0s§);
      }
      
      public function get logger() : IGameLogger
      {
         return this.§_-IC§;
      }
      
      public function set logger(value:IGameLogger) : void
      {
         if(value == null)
         {
            throw new ArgumentError("Logger is null");
         }
         this.§_-IC§ = value;
      }
      
      public function get stage() : Stage
      {
         return this.§_-We§;
      }
      
      public function get options() : Object
      {
         return this.§_-D9§;
      }
      
      public function addDeferredCommand(command:DeferredCommand) : void
      {
         this.§_-0s§.addCommand(command);
      }
      
      public function getObjectPoolManager() : ObjectPoolManager
      {
         return this.§_-XC§;
      }
      
      public function addTask(gameTask:GameTask) : void
      {
         this.§_-Uw§.addTask(gameTask);
      }
      
      public function addEntity(entity:Entity) : void
      {
         if(entity.index < 0)
         {
            entity.index = this.§_-TA§;
            var _loc2_:* = this.§_-TA§++;
            this.§_-jZ§[_loc2_] = entity;
            entity.addToGame(this);
            return;
         }
         throw new Error("Entity " + entity + " is already in game");
      }
      
      public function removeEntity(entity:Entity) : void
      {
         var index:int = entity.index;
         if(index < 0)
         {
            throw new Error("Entity " + entity + " is not in game");
         }
         var lastEntity:Entity = this.§_-jZ§[--this.§_-TA§];
         lastEntity.index = index;
         this.§_-jZ§[index] = lastEntity;
         this.§_-jZ§[this.§_-TA§] = null;
         entity.index = -1;
         entity.removeFromGame(this);
      }
      
      public function getInputSystem() : IInput
      {
         return this.inputSystem;
      }
      
      public function getEventSystem() : IEventSystem
      {
         return this.eventSystem;
      }
      
      public function getLogicSystem1() : ILogic
      {
         return this.logicSystem1;
      }
      
      public function getLogicSystem2() : ILogic
      {
         return this.logicSystem2;
      }
      
      public function getPhysicsSystem() : PhysicsSystem
      {
         return this.physicsSystem;
      }
      
      public function getRenderSystem() : RenderSystem
      {
         return this.renderSystem;
      }
      
      public function tick() : void
      {
         this.§_-PI§.startTick();
         this.§_-Uw§.runTasks();
         this.§_-PI§.stopTick();
      }
      
      public function shutdown() : void
      {
         this.§_-Uw§.killAll();
         this.§_-Uw§.runTasks();
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
