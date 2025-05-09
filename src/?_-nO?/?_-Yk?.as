package §_-nO§
{
   import §_-az§.§_-AG§;
   import §_-az§.§_-ps§;
   
   public class §_-Yk§ extends §_-ps§ implements §_-5B§
   {
      private var §_-jB§:Vector.<§_-KI§>;
      
      private var §_-0Y§:int;
      
      private var running:Boolean;
      
      private var gameKernel:§_-AG§;
      
      public function §_-Yk§(priority:int, gameKernel:§_-AG§)
      {
         super(priority);
         this.gameKernel = gameKernel;
         this.§_-jB§ = new Vector.<§_-KI§>();
      }
      
      public function addLogicUnit(logicUnit:§_-KI§) : void
      {
         var actionAddUnit:ActionAddUnit = null;
         if(this.running)
         {
            actionAddUnit = ActionAddUnit(this.gameKernel.§_-11§().§_-kP§(ActionAddUnit));
            this.§_-5W§(actionAddUnit,logicUnit);
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
      
      public function removeLogicUnit(logicUnit:§_-KI§) : void
      {
         var actionRemoveUnit:ActionRemoveUnit = null;
         var index:int = 0;
         if(this.running)
         {
            actionRemoveUnit = ActionRemoveUnit(this.gameKernel.§_-11§().§_-kP§(ActionRemoveUnit));
            this.§_-5W§(actionRemoveUnit,logicUnit);
         }
         else
         {
            index = int(this.§_-jB§.indexOf(logicUnit));
            if(index < 0)
            {
               throw new Error("Logic unit not found");
            }
            this.§_-jB§[index] = this.§_-jB§[--this.§_-0Y§];
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
      
      private function §_-5W§(action:DeferredAction, unit:§_-KI§) : void
      {
         action.system = this;
         action.unit = unit;
         this.gameKernel.§_-L§(action);
      }
   }
}

import §_-RQ§.§_-HE§;
import §_-RQ§.§_-Va§;
import §in §.§_-eF§;

class DeferredAction extends §_-eF§
{
   public var system:§_-5B§;
   
   public var unit:§_-KI§;
   
   public function DeferredAction(objectPool:§_-Va§)
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
   public function ActionAddUnit(objectPool:§_-Va§)
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
   public function ActionRemoveUnit(objectPool:§_-Va§)
   {
      super(objectPool);
   }
   
   override protected function doExecute() : void
   {
      system.removeLogicUnit(unit);
   }
}
