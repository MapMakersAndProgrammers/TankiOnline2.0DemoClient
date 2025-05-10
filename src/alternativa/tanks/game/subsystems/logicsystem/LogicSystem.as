package alternativa.tanks.game.subsystems.logicsystem
{
   import alternativa.tanks.game.GameKernel;
   import alternativa.tanks.game.GameTask;
   
   public class LogicSystem extends GameTask implements ILogic
   {
      private var name_jB:Vector.<ILogicUnit>;
      
      private var name_0Y:int;
      
      private var running:Boolean;
      
      private var gameKernel:GameKernel;
      
      public function LogicSystem(priority:int, gameKernel:GameKernel)
      {
         super(priority);
         this.gameKernel = gameKernel;
         this.name_jB = new Vector.<ILogicUnit>();
      }
      
      public function addLogicUnit(logicUnit:ILogicUnit) : void
      {
         var actionAddUnit:ActionAddUnit = null;
         if(this.running)
         {
            actionAddUnit = ActionAddUnit(this.gameKernel.getObjectPoolManager().getObject(ActionAddUnit));
            this.addDeferredAction(actionAddUnit,logicUnit);
         }
         else
         {
            if(this.name_jB.indexOf(logicUnit) >= 0)
            {
               throw new Error("Logic unit already exists");
            }
            var _loc3_:* = this.name_0Y++;
            this.name_jB[_loc3_] = logicUnit;
         }
      }
      
      public function removeLogicUnit(logicUnit:ILogicUnit) : void
      {
         var actionRemoveUnit:ActionRemoveUnit = null;
         var _loc3_:int = 0;
         if(this.running)
         {
            actionRemoveUnit = ActionRemoveUnit(this.gameKernel.getObjectPoolManager().getObject(ActionRemoveUnit));
            this.addDeferredAction(actionRemoveUnit,logicUnit);
         }
         else
         {
            _loc3_ = int(this.name_jB.indexOf(logicUnit));
            if(_loc3_ < 0)
            {
               throw new Error("Logic unit not found");
            }
            this.name_jB[_loc3_] = this.name_jB[--this.name_0Y];
            this.name_jB[this.name_0Y] = null;
         }
      }
      
      override public function run() : void
      {
         this.running = true;
         for(var i:int = 0; i < this.name_0Y; i++)
         {
            this.name_jB[i].runLogic();
         }
         this.running = false;
      }
      
      private function addDeferredAction(action:DeferredAction, unit:ILogicUnit) : void
      {
         action.system = this;
         action.unit = unit;
         this.gameKernel.addDeferredCommand(action);
      }
   }
}

import alternativa.tanks.game.subsystems.deferredcommandssystem.DeferredCommand;
import alternativa.tanks.game.utils.objectpool.ObjectPool;
import alternativa.tanks.game.utils.objectpool.PooledObject;
import alternativa.tanks.game.subsystems.logicsystem.ILogic;
import alternativa.tanks.game.subsystems.logicsystem.ILogicUnit;

class DeferredAction extends DeferredCommand
{
   public var system:ILogic;
   
   public var unit:ILogicUnit;
   
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
