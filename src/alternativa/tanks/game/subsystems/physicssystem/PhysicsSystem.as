package alternativa.tanks.game.subsystems.physicssystem
{
   import alternativa.math.Vector3;
   import alternativa.physics.PhysicsScene;
   import alternativa.physics.collision.CollisionPrimitive;
   import alternativa.physics.collision.types.BoundBox;
   import alternativa.tanks.game.GameTask;
   import alternativa.tanks.game.physics.ITanksCollisionDetector;
   import alternativa.tanks.game.physics.TanksCollisionDetector;
   import alternativa.tanks.game.physics.collision.uniformgrid.UniformGridCollisionDetector;
   import alternativa.tanks.game.subsystems.deferredcommandssystem.DeferredCommand;
   import alternativa.tanks.game.subsystems.timesystem.TimeSystem;
   import alternativa.tanks.game.utils.objectpool.ObjectPoolManager;
   import flash.utils.getTimer;
   
   public class PhysicsSystem extends GameTask
   {
      private static var USE_GRID_COLLISION_DETECTOR:Boolean = true;
      
      public var interpolationCoeff:Number;
      
      private var physicsStep:int = 33;
      
      private var physicsScene:PhysicsScene;
      
      private var §_-hl§:Vector.<IPhysicsController>;
      
      private var §_-g7§:int;
      
      private var §_-b5§:Vector.<IPhysicsController>;
      
      private var §_-f5§:int;
      
      private var §_-ST§:Vector.<IPhysicsController>;
      
      private var §_-7y§:int;
      
      private var §_-jp§:UniformGridCollisionDetector;
      
      private var §_-FE§:int;
      
      private var running:Boolean;
      
      private var §_-pR§:DeferredCommand;
      
      private var objectPoolManager:ObjectPoolManager;
      
      public function PhysicsSystem(priority:int, objectPoolManager:ObjectPoolManager)
      {
         super(priority);
         this.objectPoolManager = objectPoolManager;
         this.§_-hl§ = new Vector.<IPhysicsController>();
         this.§_-b5§ = new Vector.<IPhysicsController>();
         this.§_-ST§ = new Vector.<IPhysicsController>();
         this.physicsScene = new PhysicsScene();
         this.physicsScene.§_-06§ = true;
         this.physicsScene.§_-YB§ = 5;
         this.physicsScene.dynamic = 100;
         this.physicsScene.gravity = new Vector3(0,0,-1000);
         if(USE_GRID_COLLISION_DETECTOR)
         {
            this.§_-jp§ = new UniformGridCollisionDetector();
            this.physicsScene.collisionDetector = this.§_-jp§;
         }
         else
         {
            this.physicsScene.collisionDetector = new TanksCollisionDetector();
         }
      }
      
      override protected function onPause() : void
      {
         this.§_-FE§ = getTimer();
      }
      
      override protected function onResume() : void
      {
         this.§_-FE§ = getTimer() - this.§_-FE§;
         this.physicsScene.time += this.§_-FE§;
      }
      
      public function getGridCollisionDetector() : UniformGridCollisionDetector
      {
         return this.§_-jp§;
      }
      
      public function getPhysicsStep() : int
      {
         return this.physicsStep;
      }
      
      public function getPhysicsScene() : PhysicsScene
      {
         return this.physicsScene;
      }
      
      public function initCollisionGeometry(collisionPrimitives:Vector.<CollisionPrimitive>) : void
      {
         var gridCellSize:Number = NaN;
         var _loc3_:TanksCollisionDetector = null;
         var _loc4_:BoundBox = null;
         var _loc5_:Number = NaN;
         if(USE_GRID_COLLISION_DETECTOR)
         {
            gridCellSize = 800;
            this.§_-jp§.createGrid(gridCellSize,collisionPrimitives);
         }
         else
         {
            _loc3_ = TanksCollisionDetector(this.physicsScene.collisionDetector);
            _loc4_ = new BoundBox();
            _loc5_ = 20000;
            _loc4_.setSize(-_loc5_,-_loc5_,-_loc5_,_loc5_,_loc5_,_loc5_);
            _loc3_.prepareForRaycasts(collisionPrimitives,_loc4_);
         }
      }
      
      public function addControllerBefore(controller:IPhysicsController) : void
      {
         var deferredActionAddBefore:DeferredActionAddBefore = null;
         if(this.running)
         {
            deferredActionAddBefore = DeferredActionAddBefore(this.objectPoolManager.getObject(DeferredActionAddBefore));
            this.addDeferredAction(deferredActionAddBefore,controller);
         }
         else
         {
            if(this.§_-hl§.indexOf(controller) >= 0)
            {
               throw new Error("Controller " + controller + " already exists");
            }
            var _loc3_:* = this.§_-g7§++;
            this.§_-hl§[_loc3_] = controller;
         }
      }
      
      public function addControllerAfter(controller:IPhysicsController) : void
      {
         var deferredActionAddAfter:DeferredActionAddAfter = null;
         if(this.running)
         {
            deferredActionAddAfter = DeferredActionAddAfter(this.objectPoolManager.getObject(DeferredActionAddAfter));
            this.addDeferredAction(deferredActionAddAfter,controller);
         }
         else
         {
            if(this.§_-b5§.indexOf(controller) >= 0)
            {
               throw new Error("Controller " + controller + " already exists");
            }
            var _loc3_:* = this.§_-f5§++;
            this.§_-b5§[_loc3_] = controller;
         }
      }
      
      public function addInterpolationController(controller:IPhysicsController) : void
      {
         if(this.§_-ST§.indexOf(controller) >= 0)
         {
            throw new Error("Controller " + controller + " already exists");
         }
         var _loc2_:* = this.§_-7y§++;
         this.§_-ST§[_loc2_] = controller;
      }
      
      public function removeControllerBefore(controller:IPhysicsController) : void
      {
         var deferredActionRemoveBefore:DeferredActionRemoveBefore = null;
         var _loc3_:int = 0;
         if(this.running)
         {
            deferredActionRemoveBefore = DeferredActionRemoveBefore(this.objectPoolManager.getObject(DeferredActionRemoveBefore));
            this.addDeferredAction(deferredActionRemoveBefore,controller);
         }
         else
         {
            _loc3_ = int(this.§_-hl§.indexOf(controller));
            if(_loc3_ < 0)
            {
               throw new Error("Controller " + controller + " not found");
            }
            this.§_-hl§[_loc3_] = this.§_-hl§[--this.§_-g7§];
            this.§_-hl§[this.§_-g7§] = null;
         }
      }
      
      public function removeControllerAfter(controller:IPhysicsController) : void
      {
         var deferredActionRemoveAfter:DeferredActionRemoveAfter = null;
         var _loc3_:int = 0;
         if(this.running)
         {
            deferredActionRemoveAfter = DeferredActionRemoveAfter(this.objectPoolManager.getObject(DeferredActionRemoveAfter));
            this.addDeferredAction(deferredActionRemoveAfter,controller);
         }
         else
         {
            _loc3_ = int(this.§_-b5§.indexOf(controller));
            if(_loc3_ < 0)
            {
               throw new Error("Controller " + controller + " not found");
            }
            this.§_-b5§[_loc3_] = this.§_-b5§[--this.§_-f5§];
            this.§_-b5§[this.§_-f5§] = null;
         }
      }
      
      public function removeInterpolationController(controller:IPhysicsController) : void
      {
         var index:int = int(this.§_-ST§.indexOf(controller));
         if(index < 0)
         {
            throw new Error("Controller " + controller + " not found");
         }
         this.§_-ST§[index] = this.§_-ST§[--this.§_-7y§];
         this.§_-ST§[this.§_-7y§] = null;
      }
      
      override public function start() : void
      {
         this.physicsScene.time = TimeSystem.time;
      }
      
      override public function run() : void
      {
         var i:int = 0;
         var controller:IPhysicsController = null;
         var action:DeferredCommand = null;
         var currentTime:int = TimeSystem.time;
         if(this.physicsScene.time < currentTime)
         {
            while(this.physicsScene.time < currentTime)
            {
               this.running = true;
               ITanksCollisionDetector(this.physicsScene.collisionDetector).prepareForRaycasts();
               for(i = 0; i < this.§_-g7§; i++)
               {
                  controller = this.§_-hl§[i];
                  controller.updateBeforeSimulation(this.physicsStep);
               }
               this.physicsScene.update(this.physicsStep);
               ITanksCollisionDetector(this.physicsScene.collisionDetector).prepareForRaycasts();
               for(i = 0; i < this.§_-f5§; i++)
               {
                  controller = this.§_-b5§[i];
                  controller.updateAfterSimulation(this.physicsStep);
               }
               for(this.running = false; this.§_-pR§ != null; )
               {
                  action = this.§_-pR§;
                  this.§_-pR§ = this.§_-pR§.next;
                  action.next = null;
                  action.execute();
                  action.storeInPool();
               }
            }
         }
         this.interpolationCoeff = 1 - (this.physicsScene.time - currentTime) / this.physicsStep;
         for(i = 0; i < this.§_-7y§; i++)
         {
            controller = this.§_-ST§[i];
            controller.interpolate(this.interpolationCoeff);
         }
      }
      
      private function addDeferredAction(deferredAction:DeferredAction, controller:IPhysicsController) : void
      {
         deferredAction.system = this;
         deferredAction.controller = controller;
         deferredAction.next = this.§_-pR§;
         this.§_-pR§ = deferredAction;
      }
   }
}

import alternativa.tanks.game.subsystems.deferredcommandssystem.DeferredCommand;
import alternativa.tanks.game.utils.objectpool.ObjectPool;
import alternativa.tanks.game.utils.objectpool.PooledObject;

class DeferredAction extends DeferredCommand
{
   public var system:PhysicsSystem;
   
   public var controller:IPhysicsController;
   
   public function DeferredAction(objectPool:ObjectPool)
   {
      super(objectPool);
   }
   
   override public function execute() : void
   {
      this.doExecute();
      this.system = null;
      this.controller = null;
   }
   
   protected function doExecute() : void
   {
   }
}

class DeferredActionAddBefore extends DeferredAction
{
   public function DeferredActionAddBefore(objectPool:ObjectPool)
   {
      super(objectPool);
   }
   
   override protected function doExecute() : void
   {
      system.addControllerBefore(controller);
   }
}

class DeferredActionAddAfter extends DeferredAction
{
   public function DeferredActionAddAfter(objectPool:ObjectPool)
   {
      super(objectPool);
   }
   
   override protected function doExecute() : void
   {
      system.addControllerAfter(controller);
   }
}

class DeferredActionRemoveBefore extends DeferredAction
{
   public function DeferredActionRemoveBefore(objectPool:ObjectPool)
   {
      super(objectPool);
   }
   
   override protected function doExecute() : void
   {
      system.removeControllerBefore(controller);
   }
}

class DeferredActionRemoveAfter extends DeferredAction
{
   public function DeferredActionRemoveAfter(objectPool:ObjectPool)
   {
      super(objectPool);
   }
   
   override protected function doExecute() : void
   {
      system.removeControllerAfter(controller);
   }
}
