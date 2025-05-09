package package_24
{
   import package_15.class_1;
   import package_15.name_17;
   
   public class name_96 extends class_1 implements name_105
   {
      private var var_214:Vector.<name_367>;
      
      private var var_215:int;
      
      private var running:Boolean;
      
      private var gameKernel:name_17;
      
      public function name_96(priority:int, gameKernel:name_17)
      {
         super(priority);
         this.gameKernel = gameKernel;
         this.var_214 = new Vector.<name_367>();
      }
      
      public function addLogicUnit(logicUnit:name_367) : void
      {
         var actionAddUnit:ActionAddUnit = null;
         if(this.running)
         {
            actionAddUnit = ActionAddUnit(this.gameKernel.method_33().name_165(ActionAddUnit));
            this.method_135(actionAddUnit,logicUnit);
         }
         else
         {
            if(this.var_214.indexOf(logicUnit) >= 0)
            {
               throw new Error("Logic unit already exists");
            }
            var _loc3_:* = this.var_215++;
            this.var_214[_loc3_] = logicUnit;
         }
      }
      
      public function removeLogicUnit(logicUnit:name_367) : void
      {
         var actionRemoveUnit:ActionRemoveUnit = null;
         var index:int = 0;
         if(this.running)
         {
            actionRemoveUnit = ActionRemoveUnit(this.gameKernel.method_33().name_165(ActionRemoveUnit));
            this.method_135(actionRemoveUnit,logicUnit);
         }
         else
         {
            index = int(this.var_214.indexOf(logicUnit));
            if(index < 0)
            {
               throw new Error("Logic unit not found");
            }
            this.var_214[index] = this.var_214[--this.var_215];
            this.var_214[this.var_215] = null;
         }
      }
      
      override public function run() : void
      {
         this.running = true;
         for(var i:int = 0; i < this.var_215; i++)
         {
            this.var_214[i].runLogic();
         }
         this.running = false;
      }
      
      private function method_135(action:DeferredAction, unit:name_367) : void
      {
         action.system = this;
         action.unit = unit;
         this.gameKernel.method_36(action);
      }
   }
}

import package_25.name_353;
import package_25.name_355;
import package_26.name_111;

class DeferredAction extends name_111
{
   public var system:name_105;
   
   public var unit:name_367;
   
   public function DeferredAction(objectPool:name_355)
   {
      super(objectPool);
   }
   
   override public function execute() : void
   {
      this.doExecute();
      this.system = null;
      this.unit = null;
   }
   
   protected function doExecute() : void
   {
   }
}

class ActionAddUnit extends DeferredAction
{
   public function ActionAddUnit(objectPool:name_355)
   {
      super(objectPool);
   }
   
   override protected function doExecute() : void
   {
      system.addLogicUnit(unit);
   }
}

class ActionRemoveUnit extends DeferredAction
{
   public function ActionRemoveUnit(objectPool:name_355)
   {
      super(objectPool);
   }
   
   override protected function doExecute() : void
   {
      system.removeLogicUnit(unit);
   }
}
