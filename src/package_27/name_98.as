package package_27
{
   import flash.utils.getTimer;
   import package_15.class_1;
   import package_25.name_97;
   import package_26.name_111;
   import package_30.name_103;
   import package_38.name_145;
   import package_51.name_276;
   import package_54.name_354;
   import package_54.name_357;
   import package_58.name_334;
   import package_61.name_356;
   import package_79.name_358;
   
   public class name_98 extends class_1
   {
      private static var USE_GRID_COLLISION_DETECTOR:Boolean = true;
      
      public var interpolationCoeff:Number;
      
      private var physicsStep:int = 33;
      
      private var physicsScene:name_356;
      
      private var var_202:Vector.<name_352>;
      
      private var var_203:int;
      
      private var var_200:Vector.<name_352>;
      
      private var var_205:int;
      
      private var var_201:Vector.<name_352>;
      
      private var var_204:int;
      
      private var var_207:name_358;
      
      private var var_206:int;
      
      private var running:Boolean;
      
      private var var_11:name_111;
      
      private var objectPoolManager:name_97;
      
      public function name_98(priority:int, objectPoolManager:name_97)
      {
         super(priority);
         this.objectPoolManager = objectPoolManager;
         this.var_202 = new Vector.<name_352>();
         this.var_200 = new Vector.<name_352>();
         this.var_201 = new Vector.<name_352>();
         this.physicsScene = new name_356();
         this.physicsScene.name_366 = true;
         this.physicsScene.name_360 = 5;
         this.physicsScene.name_365 = 100;
         this.physicsScene.gravity = new name_145(0,0,-1000);
         if(USE_GRID_COLLISION_DETECTOR)
         {
            this.var_207 = new name_358();
            this.physicsScene.collisionDetector = this.var_207;
         }
         else
         {
            this.physicsScene.collisionDetector = new name_354();
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
      
      public function method_140() : name_358
      {
         return this.var_207;
      }
      
      public function method_138() : int
      {
         return this.physicsStep;
      }
      
      public function name_157() : name_356
      {
         return this.physicsScene;
      }
      
      public function method_136(collisionPrimitives:Vector.<name_276>) : void
      {
         var gridCellSize:Number = NaN;
         var collisionDetector:name_354 = null;
         var bb:name_334 = null;
         var size:Number = NaN;
         if(USE_GRID_COLLISION_DETECTOR)
         {
            gridCellSize = 800;
            this.var_207.name_362(gridCellSize,collisionPrimitives);
         }
         else
         {
            collisionDetector = name_354(this.physicsScene.collisionDetector);
            bb = new name_334();
            size = 20000;
            bb.name_361(-size,-size,-size,size,size,size);
            collisionDetector.name_364(collisionPrimitives,bb);
         }
      }
      
      public function addControllerBefore(controller:name_352) : void
      {
         var deferredActionAddBefore:DeferredActionAddBefore = null;
         if(this.running)
         {
            deferredActionAddBefore = DeferredActionAddBefore(this.objectPoolManager.name_165(DeferredActionAddBefore));
            this.method_135(deferredActionAddBefore,controller);
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
      
      public function addControllerAfter(controller:name_352) : void
      {
         var deferredActionAddAfter:DeferredActionAddAfter = null;
         if(this.running)
         {
            deferredActionAddAfter = DeferredActionAddAfter(this.objectPoolManager.name_165(DeferredActionAddAfter));
            this.method_135(deferredActionAddAfter,controller);
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
      
      public function method_137(controller:name_352) : void
      {
         if(this.var_201.indexOf(controller) >= 0)
         {
            throw new Error("Controller " + controller + " already exists");
         }
         var _loc2_:* = this.var_204++;
         this.var_201[_loc2_] = controller;
      }
      
      public function removeControllerBefore(controller:name_352) : void
      {
         var deferredActionRemoveBefore:DeferredActionRemoveBefore = null;
         var index:int = 0;
         if(this.running)
         {
            deferredActionRemoveBefore = DeferredActionRemoveBefore(this.objectPoolManager.name_165(DeferredActionRemoveBefore));
            this.method_135(deferredActionRemoveBefore,controller);
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
      
      public function removeControllerAfter(controller:name_352) : void
      {
         var deferredActionRemoveAfter:DeferredActionRemoveAfter = null;
         var index:int = 0;
         if(this.running)
         {
            deferredActionRemoveAfter = DeferredActionRemoveAfter(this.objectPoolManager.name_165(DeferredActionRemoveAfter));
            this.method_135(deferredActionRemoveAfter,controller);
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
      
      public function method_139(controller:name_352) : void
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
         this.physicsScene.time = name_103.time;
      }
      
      override public function run() : void
      {
         var i:int = 0;
         var controller:name_352 = null;
         var action:name_111 = null;
         var currentTime:int = int(name_103.time);
         if(this.physicsScene.time < currentTime)
         {
            while(this.physicsScene.time < currentTime)
            {
               this.running = true;
               name_357(this.physicsScene.collisionDetector).name_359();
               for(i = 0; i < this.var_203; i++)
               {
                  controller = this.var_202[i];
                  controller.updateBeforeSimulation(this.physicsStep);
               }
               this.physicsScene.update(this.physicsStep);
               name_357(this.physicsScene.collisionDetector).name_359();
               for(i = 0; i < this.var_205; i++)
               {
                  controller = this.var_200[i];
                  controller.updateAfterSimulation(this.physicsStep);
               }
               for(this.running = false; this.var_11 != null; )
               {
                  action = this.var_11;
                  this.var_11 = this.var_11.next;
                  action.next = null;
                  action.execute();
                  action.name_363();
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
      
      private function method_135(deferredAction:DeferredAction, controller:name_352) : void
      {
         deferredAction.system = this;
         deferredAction.controller = controller;
         deferredAction.next = this.var_11;
         this.var_11 = deferredAction;
      }
   }
}

import package_25.name_353;
import package_25.name_355;
import package_26.name_111;

class DeferredAction extends name_111
{
   public var system:name_98;
   
   public var controller:name_352;
   
   public function DeferredAction(objectPool:name_355)
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
   public function DeferredActionAddBefore(objectPool:name_355)
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
   public function DeferredActionAddAfter(objectPool:name_355)
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
   public function DeferredActionRemoveBefore(objectPool:name_355)
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
   public function DeferredActionRemoveAfter(objectPool:name_355)
   {
      super(objectPool);
   }
   
   override protected function doExecute() : void
   {
      system.removeControllerAfter(controller);
   }
}
