package §_-Fc§
{
   import §_-1e§.§_-Nh§;
   import §_-KA§.§_-FW§;
   import §_-RQ§.§_-Q9§;
   import §_-US§.§_-DB§;
   import §_-az§.§_-ps§;
   import §_-bJ§.§_-eG§;
   import §_-fT§.§_-ZI§;
   import §_-fT§.§_-Zm§;
   import §_-lS§.§_-h2§;
   import §_-nl§.§_-bj§;
   import flash.utils.getTimer;
   import §in §.§_-eF§;
   
   public class §_-8a§ extends §_-ps§
   {
      private static var USE_GRID_COLLISION_DETECTOR:Boolean = true;
      
      public var interpolationCoeff:Number;
      
      private var physicsStep:int = 33;
      
      private var physicsScene:§_-DB§;
      
      private var §_-hl§:Vector.<§catch§>;
      
      private var §_-g7§:int;
      
      private var §_-b5§:Vector.<§catch§>;
      
      private var §_-f5§:int;
      
      private var §_-ST§:Vector.<§catch§>;
      
      private var §_-7y§:int;
      
      private var §_-jp§:§_-eG§;
      
      private var §_-FE§:int;
      
      private var running:Boolean;
      
      private var §_-pR§:§_-eF§;
      
      private var objectPoolManager:§_-Q9§;
      
      public function §_-8a§(priority:int, objectPoolManager:§_-Q9§)
      {
         super(priority);
         this.objectPoolManager = objectPoolManager;
         this.§_-hl§ = new Vector.<§catch§>();
         this.§_-b5§ = new Vector.<§catch§>();
         this.§_-ST§ = new Vector.<§catch§>();
         this.physicsScene = new §_-DB§();
         this.physicsScene.§_-06§ = true;
         this.physicsScene.§_-YB§ = 5;
         this.physicsScene.dynamic = 100;
         this.physicsScene.gravity = new §_-bj§(0,0,-1000);
         if(USE_GRID_COLLISION_DETECTOR)
         {
            this.§_-jp§ = new §_-eG§();
            this.physicsScene.collisionDetector = this.§_-jp§;
         }
         else
         {
            this.physicsScene.collisionDetector = new §_-ZI§();
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
      
      public function §_-Zo§() : §_-eG§
      {
         return this.§_-jp§;
      }
      
      public function §_-Xh§() : int
      {
         return this.physicsStep;
      }
      
      public function §_-d-§() : §_-DB§
      {
         return this.physicsScene;
      }
      
      public function §_-kO§(collisionPrimitives:Vector.<§_-Nh§>) : void
      {
         var gridCellSize:Number = NaN;
         var collisionDetector:§_-ZI§ = null;
         var bb:§_-FW§ = null;
         var size:Number = NaN;
         if(USE_GRID_COLLISION_DETECTOR)
         {
            gridCellSize = 800;
            this.§_-jp§.§_-hS§(gridCellSize,collisionPrimitives);
         }
         else
         {
            collisionDetector = §_-ZI§(this.physicsScene.collisionDetector);
            bb = new §_-FW§();
            size = 20000;
            bb.§_-k2§(-size,-size,-size,size,size,size);
            collisionDetector.§_-Vy§(collisionPrimitives,bb);
         }
      }
      
      public function addControllerBefore(controller:§catch§) : void
      {
         var deferredActionAddBefore:DeferredActionAddBefore = null;
         if(this.running)
         {
            deferredActionAddBefore = DeferredActionAddBefore(this.objectPoolManager.§_-kP§(DeferredActionAddBefore));
            this.§_-5W§(deferredActionAddBefore,controller);
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
      
      public function addControllerAfter(controller:§catch§) : void
      {
         var deferredActionAddAfter:DeferredActionAddAfter = null;
         if(this.running)
         {
            deferredActionAddAfter = DeferredActionAddAfter(this.objectPoolManager.§_-kP§(DeferredActionAddAfter));
            this.§_-5W§(deferredActionAddAfter,controller);
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
      
      public function §_-Ve§(controller:§catch§) : void
      {
         if(this.§_-ST§.indexOf(controller) >= 0)
         {
            throw new Error("Controller " + controller + " already exists");
         }
         var _loc2_:* = this.§_-7y§++;
         this.§_-ST§[_loc2_] = controller;
      }
      
      public function removeControllerBefore(controller:§catch§) : void
      {
         var deferredActionRemoveBefore:DeferredActionRemoveBefore = null;
         var index:int = 0;
         if(this.running)
         {
            deferredActionRemoveBefore = DeferredActionRemoveBefore(this.objectPoolManager.§_-kP§(DeferredActionRemoveBefore));
            this.§_-5W§(deferredActionRemoveBefore,controller);
         }
         else
         {
            index = int(this.§_-hl§.indexOf(controller));
            if(index < 0)
            {
               throw new Error("Controller " + controller + " not found");
            }
            this.§_-hl§[index] = this.§_-hl§[--this.§_-g7§];
            this.§_-hl§[this.§_-g7§] = null;
         }
      }
      
      public function removeControllerAfter(controller:§catch§) : void
      {
         var deferredActionRemoveAfter:DeferredActionRemoveAfter = null;
         var index:int = 0;
         if(this.running)
         {
            deferredActionRemoveAfter = DeferredActionRemoveAfter(this.objectPoolManager.§_-kP§(DeferredActionRemoveAfter));
            this.§_-5W§(deferredActionRemoveAfter,controller);
         }
         else
         {
            index = int(this.§_-b5§.indexOf(controller));
            if(index < 0)
            {
               throw new Error("Controller " + controller + " not found");
            }
            this.§_-b5§[index] = this.§_-b5§[--this.§_-f5§];
            this.§_-b5§[this.§_-f5§] = null;
         }
      }
      
      public function §_-Fs§(controller:§catch§) : void
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
         this.physicsScene.time = §_-h2§.time;
      }
      
      override public function run() : void
      {
         var i:int = 0;
         var controller:§catch§ = null;
         var action:§_-eF§ = null;
         var currentTime:int = int(§_-h2§.time);
         if(this.physicsScene.time < currentTime)
         {
            while(this.physicsScene.time < currentTime)
            {
               this.running = true;
               §_-Zm§(this.physicsScene.collisionDetector).§_-9F§();
               for(i = 0; i < this.§_-g7§; i++)
               {
                  controller = this.§_-hl§[i];
                  controller.updateBeforeSimulation(this.physicsStep);
               }
               this.physicsScene.update(this.physicsStep);
               §_-Zm§(this.physicsScene.collisionDetector).§_-9F§();
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
                  action.§_-DQ§();
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
      
      private function §_-5W§(deferredAction:DeferredAction, controller:§catch§) : void
      {
         deferredAction.system = this;
         deferredAction.controller = controller;
         deferredAction.next = this.§_-pR§;
         this.§_-pR§ = deferredAction;
      }
   }
}

import §_-RQ§.§_-HE§;
import §_-RQ§.§_-Va§;
import §in §.§_-eF§;

class DeferredAction extends §_-eF§
{
   public var system:§_-8a§;
   
   public var controller:§catch§;
   
   public function DeferredAction(objectPool:§_-Va§)
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
   public function DeferredActionAddBefore(objectPool:§_-Va§)
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
   public function DeferredActionAddAfter(objectPool:§_-Va§)
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
   public function DeferredActionRemoveBefore(objectPool:§_-Va§)
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
   public function DeferredActionRemoveAfter(objectPool:§_-Va§)
   {
      super(objectPool);
   }
   
   override protected function doExecute() : void
   {
      system.removeControllerAfter(controller);
   }
}
