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
      
      private var name_hl:Vector.<IPhysicsController>;
      
      private var name_g7:int;
      
      private var name_b5:Vector.<IPhysicsController>;
      
      private var name_f5:int;
      
      private var name_ST:Vector.<IPhysicsController>;
      
      private var name_7y:int;
      
      private var name_jp:UniformGridCollisionDetector;
      
      private var name_FE:int;
      
      private var running:Boolean;
      
      private var name_pR:DeferredCommand;
      
      private var objectPoolManager:ObjectPoolManager;
      
      public function PhysicsSystem(priority:int, objectPoolManager:ObjectPoolManager)
      {
         super(priority);
         this.objectPoolManager = objectPoolManager;
         this.name_hl = new Vector.<IPhysicsController>();
         this.name_b5 = new Vector.<IPhysicsController>();
         this.name_ST = new Vector.<IPhysicsController>();
         this.physicsScene = new PhysicsScene();
         this.physicsScene.name_06 = true;
         this.physicsScene.name_YB = 5;
         this.physicsScene.dynamic = 100;
         this.physicsScene.gravity = new Vector3(0,0,-1000);
         if(USE_GRID_COLLISION_DETECTOR)
         {
            this.name_jp = new UniformGridCollisionDetector();
            this.physicsScene.collisionDetector = this.name_jp;
         }
         else
         {
            this.physicsScene.collisionDetector = new TanksCollisionDetector();
         }
      }
      
      override protected function onPause() : void
      {
         this.name_FE = getTimer();
      }
      
      override protected function onResume() : void
      {
         this.name_FE = getTimer() - this.name_FE;
         this.physicsScene.time += this.name_FE;
      }
      
      public function getGridCollisionDetector() : UniformGridCollisionDetector
      {
         return this.name_jp;
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
            this.name_jp.createGrid(gridCellSize,collisionPrimitives);
         }
         else
         {
            _loc3_ = TanksCollisionDetector(this.physicsScene.collisionDetector);
            _loc4_ = new BoundBox();
            _loc5_ = 20000;
            _loc4_.setSize(-_loc5_,-_loc5_,-_loc5_,_loc5_,_loc5_,_loc5_);
            _loc3_.buildKdTree(collisionPrimitives,_loc4_);
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
            if(this.name_hl.indexOf(controller) >= 0)
            {
               throw new Error("Controller " + controller + " already exists");
            }
            var _loc3_:* = this.name_g7++;
            this.name_hl[_loc3_] = controller;
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
            if(this.name_b5.indexOf(controller) >= 0)
            {
               throw new Error("Controller " + controller + " already exists");
            }
            var _loc3_:* = this.name_f5++;
            this.name_b5[_loc3_] = controller;
         }
      }
      
      public function addInterpolationController(controller:IPhysicsController) : void
      {
         if(this.name_ST.indexOf(controller) >= 0)
         {
            throw new Error("Controller " + controller + " already exists");
         }
         var _loc2_:* = this.name_7y++;
         this.name_ST[_loc2_] = controller;
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
            _loc3_ = int(this.name_hl.indexOf(controller));
            if(_loc3_ < 0)
            {
               throw new Error("Controller " + controller + " not found");
            }
            this.name_hl[_loc3_] = this.name_hl[--this.name_g7];
            this.name_hl[this.name_g7] = null;
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
            _loc3_ = int(this.name_b5.indexOf(controller));
            if(_loc3_ < 0)
            {
               throw new Error("Controller " + controller + " not found");
            }
            this.name_b5[_loc3_] = this.name_b5[--this.name_f5];
            this.name_b5[this.name_f5] = null;
         }
      }
      
      public function removeInterpolationController(controller:IPhysicsController) : void
      {
         var index:int = int(this.name_ST.indexOf(controller));
         if(index < 0)
         {
            throw new Error("Controller " + controller + " not found");
         }
         this.name_ST[index] = this.name_ST[--this.name_7y];
         this.name_ST[this.name_7y] = null;
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
               for(i = 0; i < this.name_g7; i++)
               {
                  controller = this.name_hl[i];
                  controller.updateBeforeSimulation(this.physicsStep);
               }
               this.physicsScene.update(this.physicsStep);
               ITanksCollisionDetector(this.physicsScene.collisionDetector).prepareForRaycasts();
               for(i = 0; i < this.name_f5; i++)
               {
                  controller = this.name_b5[i];
                  controller.updateAfterSimulation(this.physicsStep);
               }
               for(this.running = false; this.name_pR != null; )
               {
                  action = this.name_pR;
                  this.name_pR = this.name_pR.next;
                  action.next = null;
                  action.execute();
                  action.storeInPool();
               }
            }
         }
         this.interpolationCoeff = 1 - (this.physicsScene.time - currentTime) / this.physicsStep;
         for(i = 0; i < this.name_7y; i++)
         {
            controller = this.name_ST[i];
            controller.interpolate(this.interpolationCoeff);
         }
      }
      
      private function addDeferredAction(deferredAction:DeferredAction, controller:IPhysicsController) : void
      {
         deferredAction.system = this;
         deferredAction.controller = controller;
         deferredAction.next = this.name_pR;
         this.name_pR = deferredAction;
      }
   }
}

import alternativa.tanks.game.subsystems.deferredcommandssystem.DeferredCommand;
import alternativa.tanks.game.utils.objectpool.ObjectPool;
import alternativa.tanks.game.utils.objectpool.PooledObject;
import alternativa.tanks.game.subsystems.physicssystem.PhysicsSystem;
import alternativa.tanks.game.subsystems.physicssystem.IPhysicsController;

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
