package alternativa.tanks.game.subsystems.logicsystem
{
   import alternativa.tanks.game.GameKernel;
   import alternativa.tanks.game.GameTask;
   
   public class LogicSystem extends GameTask implements ILogic
   {
      private var §_-jB§:Vector.<ILogicUnit>;
      
      private var §_-0Y§:int;
      
      private var running:Boolean;
      
      private var gameKernel:GameKernel;
      
      public function LogicSystem(priority:int, gameKernel:GameKernel)
      {
         super(priority);
         this.gameKernel = gameKernel;
         this.§_-jB§ = new Vector.<ILogicUnit>();
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
            if(this.§_-jB§.indexOf(logicUnit) >= 0)
            {
               throw new Error("Logic unit already exists");
            }
            var _loc3_:* = this.§_-0Y§++;
            this.§_-jB§[_loc3_] = logicUnit;
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
            _loc3_ = int(this.§_-jB§.indexOf(logicUnit));
            if(_loc3_ < 0)
            {
               throw new Error("Logic unit not found");
            }
            this.§_-jB§[_loc3_] = this.§_-jB§[--this.§_-0Y§];
            this.§_-jB§[this.§_-0Y§] = null;
         }
      }
      
      override public function run() : void
      {
         this.running = true;
         for(var i:int = 0; i < this.§_-0Y§; i++)
         {
            this.§_-jB§[i].runLogic();
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
