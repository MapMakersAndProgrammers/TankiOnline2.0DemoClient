package package_42
{
   import alternativa.tanks.game.GameTask;
   import alternativa.tanks.game.GameKernel;
   
   public class name_177 extends GameTask implements name_184
   {
      private var var_214:Vector.<name_477>;
      
      private var var_215:int;
      
      private var running:Boolean;
      
      private var gameKernel:GameKernel;
      
      public function name_177(priority:int, gameKernel:GameKernel)
      {
         super(priority);
         this.gameKernel = gameKernel;
         this.var_214 = new Vector.<name_477>();
      }
      
      public function addLogicUnit(logicUnit:name_477) : void
      {
         var actionAddUnit:ActionAddUnit = null;
         if(this.running)
         {
            actionAddUnit = ActionAddUnit(this.gameKernel.method_108().name_110(ActionAddUnit));
            this.method_329(actionAddUnit,logicUnit);
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
      
      public function removeLogicUnit(logicUnit:name_477) : void
      {
         var actionRemoveUnit:ActionRemoveUnit = null;
         var index:int = 0;
         if(this.running)
         {
            actionRemoveUnit = ActionRemoveUnit(this.gameKernel.method_108().name_110(ActionRemoveUnit));
            this.method_329(actionRemoveUnit,logicUnit);
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
      
      private function method_329(action:DeferredAction, unit:name_477) : void
      {
         action.system = this;
         action.unit = unit;
         this.gameKernel.method_111(action);
      }
   }
}

import alternativa.tanks.game.utils.objectpool.PooledObject;
import alternativa.tanks.game.utils.objectpool.ObjectPool;
import package_43.name_190;

class DeferredAction extends name_190
{
   public var system:name_184;
   
   public var unit:name_477;
   
   public function DeferredAction(objectPool:ObjectPool)
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
   public function ActionAddUnit(objectPool:ObjectPool)
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
   public function ActionRemoveUnit(objectPool:ObjectPool)
   {
      super(objectPool);
   }
   
   override protected function doExecute() : void
   {
      system.removeLogicUnit(unit);
   }
}
