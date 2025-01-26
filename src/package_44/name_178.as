package package_44
{
   import flash.utils.getTimer;
   import package_10.class_1;
   import package_113.name_469;
   import package_26.name_100;
   import package_43.name_190;
   import package_45.name_182;
   import package_46.name_194;
   import package_76.name_235;
   import package_86.name_466;
   import package_86.name_468;
   import package_90.name_386;
   import package_92.name_467;
   
   public class name_178 extends class_1
   {
      private static var USE_GRID_COLLISION_DETECTOR:Boolean = true;
      
      public var interpolationCoeff:Number;
      
      private var physicsStep:int = 33;
      
      private var physicsScene:name_467;
      
      private var var_202:Vector.<name_465>;
      
      private var var_203:int;
      
      private var var_200:Vector.<name_465>;
      
      private var var_205:int;
      
      private var var_201:Vector.<name_465>;
      
      private var var_204:int;
      
      private var var_207:name_469;
      
      private var var_206:int;
      
      private var running:Boolean;
      
      private var var_10:name_190;
      
      private var objectPoolManager:name_100;
      
      public function name_178(priority:int, objectPoolManager:name_100)
      {
         super(priority);
         this.objectPoolManager = objectPoolManager;
         this.var_202 = new Vector.<name_465>();
         this.var_200 = new Vector.<name_465>();
         this.var_201 = new Vector.<name_465>();
         this.physicsScene = new name_467();
         this.physicsScene.name_475 = true;
         this.physicsScene.name_471 = 5;
         this.physicsScene.name_474 = 100;
         this.physicsScene.gravity = new name_194(0,0,-1000);
         if(USE_GRID_COLLISION_DETECTOR)
         {
            this.var_207 = new name_469();
            this.physicsScene.collisionDetector = this.var_207;
         }
         else
         {
            this.physicsScene.collisionDetector = new name_466();
         }
      }
      
      override protected function onPause() : void
      {
         this.var_206 = getTimer();
      }
      
      override protected function onResume() : void
      {
         this.var_206 = getTimer() - this.var_206;
         this.physicsScene.time += this.var_206;
      }
      
      public function method_333() : name_469
      {
         return this.var_207;
      }
      
      public function method_331() : int
      {
         return this.physicsStep;
      }
      
      public function name_246() : name_467
      {
         return this.physicsScene;
      }
      
      public function name_382(collisionPrimitives:Vector.<name_235>) : void
      {
         var gridCellSize:Number = NaN;
         var collisionDetector:name_466 = null;
         var bb:name_386 = null;
         var size:Number = NaN;
         if(USE_GRID_COLLISION_DETECTOR)
         {
            gridCellSize = 800;
            this.var_207.name_472(gridCellSize,collisionPrimitives);
         }
         else
         {
            collisionDetector = name_466(this.physicsScene.collisionDetector);
            bb = new name_386();
            size = 20000;
            bb.method_140(-size,-size,-size,size,size,size);
            collisionDetector.name_473(collisionPrimitives,bb);
         }
      }
      
      public function addControllerBefore(controller:name_465) : void
      {
         var deferredActionAddBefore:DeferredActionAddBefore = null;
         if(this.running)
         {
            deferredActionAddBefore = DeferredActionAddBefore(this.objectPoolManager.name_110(DeferredActionAddBefore));
            this.method_329(deferredActionAddBefore,controller);
         }
         else
         {
            if(this.var_202.indexOf(controller) >= 0)
            {
               throw new Error("Controller " + controller + " already exists");
            }
            var _loc3_:* = this.var_203++;
            this.var_202[_loc3_] = controller;
         }
      }
      
      public function addControllerAfter(controller:name_465) : void
      {
         var deferredActionAddAfter:DeferredActionAddAfter = null;
         if(this.running)
         {
            deferredActionAddAfter = DeferredActionAddAfter(this.objectPoolManager.name_110(DeferredActionAddAfter));
            this.method_329(deferredActionAddAfter,controller);
         }
         else
         {
            if(this.var_200.indexOf(controller) >= 0)
            {
               throw new Error("Controller " + controller + " already exists");
            }
            var _loc3_:* = this.var_205++;
            this.var_200[_loc3_] = controller;
         }
      }
      
      public function method_330(controller:name_465) : void
      {
         if(this.var_201.indexOf(controller) >= 0)
         {
            throw new Error("Controller " + controller + " already exists");
         }
         var _loc2_:* = this.var_204++;
         this.var_201[_loc2_] = controller;
      }
      
      public function removeControllerBefore(controller:name_465) : void
      {
         var deferredActionRemoveBefore:DeferredActionRemoveBefore = null;
         var index:int = 0;
         if(this.running)
         {
            deferredActionRemoveBefore = DeferredActionRemoveBefore(this.objectPoolManager.name_110(DeferredActionRemoveBefore));
            this.method_329(deferredActionRemoveBefore,controller);
         }
         else
         {
            index = int(this.var_202.indexOf(controller));
            if(index < 0)
            {
               throw new Error("Controller " + controller + " not found");
            }
            this.var_202[index] = this.var_202[--this.var_203];
            this.var_202[this.var_203] = null;
         }
      }
      
      public function removeControllerAfter(controller:name_465) : void
      {
         var deferredActionRemoveAfter:DeferredActionRemoveAfter = null;
         var index:int = 0;
         if(this.running)
         {
            deferredActionRemoveAfter = DeferredActionRemoveAfter(this.objectPoolManager.name_110(DeferredActionRemoveAfter));
            this.method_329(deferredActionRemoveAfter,controller);
         }
         else
         {
            index = int(this.var_200.indexOf(controller));
            if(index < 0)
            {
               throw new Error("Controller " + controller + " not found");
            }
            this.var_200[index] = this.var_200[--this.var_205];
            this.var_200[this.var_205] = null;
         }
      }
      
      public function method_332(controller:name_465) : void
      {
         var index:int = int(this.var_201.indexOf(controller));
         if(index < 0)
         {
            throw new Error("Controller " + controller + " not found");
         }
         this.var_201[index] = this.var_201[--this.var_204];
         this.var_201[this.var_204] = null;
      }
      
      override public function start() : void
      {
         this.physicsScene.time = name_182.time;
      }
      
      override public function run() : void
      {
         var i:int = 0;
         var controller:name_465 = null;
         var action:name_190 = null;
         var currentTime:int = name_182.time;
         if(this.physicsScene.time < currentTime)
         {
            while(this.physicsScene.time < currentTime)
            {
               this.running = true;
               name_468(this.physicsScene.collisionDetector).name_470();
               for(i = 0; i < this.var_203; i++)
               {
                  controller = this.var_202[i];
                  controller.updateBeforeSimulation(this.physicsStep);
               }
               this.physicsScene.update(this.physicsStep);
               name_468(this.physicsScene.collisionDetector).name_470();
               for(i = 0; i < this.var_205; i++)
               {
                  controller = this.var_200[i];
                  controller.updateAfterSimulation(this.physicsStep);
               }
               for(this.running = false; this.var_10 != null; )
               {
                  action = this.var_10;
                  this.var_10 = this.var_10.next;
                  action.next = null;
                  action.execute();
                  action.method_254();
               }
            }
         }
         this.interpolationCoeff = 1 - (this.physicsScene.time - currentTime) / this.physicsStep;
         for(i = 0; i < this.var_204; i++)
         {
            controller = this.var_201[i];
            controller.interpolate(this.interpolationCoeff);
         }
      }
      
      private function method_329(deferredAction:DeferredAction, controller:name_465) : void
      {
         deferredAction.system = this;
         deferredAction.controller = controller;
         deferredAction.next = this.var_10;
         this.var_10 = deferredAction;
      }
   }
}

import package_26.class_18;
import package_26.name_402;
import package_43.name_190;

class DeferredAction extends name_190
{
   public var system:name_178;
   
   public var controller:name_465;
   
   public function DeferredAction(objectPool:name_402)
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
   public function DeferredActionAddBefore(objectPool:name_402)
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
   public function DeferredActionAddAfter(objectPool:name_402)
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
   public function DeferredActionRemoveBefore(objectPool:name_402)
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
   public function DeferredActionRemoveAfter(objectPool:name_402)
   {
      super(objectPool);
   }
   
   override protected function doExecute() : void
   {
      system.removeControllerAfter(controller);
   }
}
