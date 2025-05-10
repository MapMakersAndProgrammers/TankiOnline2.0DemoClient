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
      
      public const name_PI:TimeStat = new TimeStat(20);
      
      private var name_We:Stage;
      
      private var name_D9:Object;
      
      private var name_IC:IGameLogger = new DummyLogger();
      
      private var name_Uw:TaskManager;
      
      private var name_f2:TimeSystem;
      
      private var inputSystem:InputSystem;
      
      private var eventSystem:EventSystem;
      
      private var logicSystem1:LogicSystem;
      
      private var logicSystem2:LogicSystem;
      
      private var physicsSystem:PhysicsSystem;
      
      private var renderSystem:RenderSystem;
      
      private var name_0s:DeferredCommandsSystem;
      
      private var name_jZ:Vector.<Entity>;
      
      private var name_TA:int;
      
      private var name_XC:ObjectPoolManager;
      
      public function GameKernel(stage:Stage, options:Object)
      {
         super();
         this.name_We = stage;
         this.name_D9 = options || {};
         this.name_jZ = new Vector.<Entity>();
         this.name_XC = new ObjectPoolManager();
         this.name_Uw = new TaskManager();
         this.name_f2 = new TimeSystem(TIME_SYSTEM_PRIORITY);
         this.name_Uw.addTask(this.name_f2);
         this.inputSystem = new InputSystem(INPUT_SYSTEM_PRIORITY,stage);
         this.name_Uw.addTask(this.inputSystem);
         this.eventSystem = new EventSystem(EVENT_SYSTEM_PRIORITY);
         this.name_Uw.addTask(this.eventSystem);
         this.logicSystem1 = new LogicSystem(LOGIC_SYSTEM_1_PRIORITY,this);
         this.name_Uw.addTask(this.logicSystem1);
         this.logicSystem2 = new LogicSystem(LOGIC_SYSTEM_2_PRIORITY,this);
         this.name_Uw.addTask(this.logicSystem2);
         this.physicsSystem = new PhysicsSystem(PHYSICS_SYSTEM_PRIORITY,this.name_XC);
         this.name_Uw.addTask(this.physicsSystem);
         this.renderSystem = new RenderSystem(RENDER_SYSTEM_PRIORITY,stage);
         this.name_Uw.addTask(this.renderSystem);
         this.name_0s = new DeferredCommandsSystem(CLEANUP_SYSTEM_PRIORITY);
         this.name_Uw.addTask(this.name_0s);
      }
      
      public function get logger() : IGameLogger
      {
         return this.name_IC;
      }
      
      public function set logger(value:IGameLogger) : void
      {
         if(value == null)
         {
            throw new ArgumentError("Logger is null");
         }
         this.name_IC = value;
      }
      
      public function get stage() : Stage
      {
         return this.name_We;
      }
      
      public function get options() : Object
      {
         return this.name_D9;
      }
      
      public function addDeferredCommand(command:DeferredCommand) : void
      {
         this.name_0s.addCommand(command);
      }
      
      public function getObjectPoolManager() : ObjectPoolManager
      {
         return this.name_XC;
      }
      
      public function addTask(gameTask:GameTask) : void
      {
         this.name_Uw.addTask(gameTask);
      }
      
      public function addEntity(entity:Entity) : void
      {
         if(entity.index < 0)
         {
            entity.index = this.name_TA;
            var _loc2_:* = this.name_TA++;
            this.name_jZ[_loc2_] = entity;
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
         var lastEntity:Entity = this.name_jZ[--this.name_TA];
         lastEntity.index = index;
         this.name_jZ[index] = lastEntity;
         this.name_jZ[this.name_TA] = null;
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
         this.name_PI.startTick();
         this.name_Uw.runTasks();
         this.name_PI.stopTick();
      }
      
      public function shutdown() : void
      {
         this.name_Uw.killAll();
         this.name_Uw.runTasks();
      }
   }
}

import alternativa.tanks.game.IGameLogger;

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
