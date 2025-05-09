package §_-fj§
{
   import §_-Fc§.§_-8a§;
   import §_-az§.§_-AG§;
   import §_-fT§.§_-HM§;
   import §default§.native;
   
   public class §_-1t§ extends §_-Cv§
   {
      private var §_-Cn§:ContactFilter;
      
      public function §_-1t§(component:§_-cx§)
      {
         super(component);
         this.§_-Cn§ = new ContactFilter();
      }
      
      override public function start(data:*) : void
      {
         var gameKernel:§_-AG§ = null;
         var physicsSystem:§_-8a§ = null;
         component.addToScene();
         component.setDetailedCollisionGroup(§_-HM§.TANK);
         component.setSuspensionCollisionMask(§_-HM§.STATIC);
         component.body.postCollisionFilter = this.§_-Cn§;
         var callback:native = native(data);
         if(callback != null)
         {
            gameKernel = component.gameKernel;
            this.§_-Cn§.initCallback(callback);
            gameKernel.getLogicSystem1().addLogicUnit(this.§_-Cn§);
            physicsSystem = gameKernel.§_-m8§();
            physicsSystem.addControllerAfter(this.§_-Cn§);
            physicsSystem.addControllerBefore(this.§_-Cn§);
         }
      }
      
      override public function stop() : void
      {
         var gameKernel:§_-AG§ = null;
         var physicsSystem:§_-8a§ = null;
         component.body.postCollisionFilter = null;
         if(this.§_-Cn§.callback != null)
         {
            gameKernel = component.gameKernel;
            gameKernel.getLogicSystem1().removeLogicUnit(this.§_-Cn§);
            physicsSystem = gameKernel.§_-m8§();
            physicsSystem.removeControllerAfter(this.§_-Cn§);
            physicsSystem.removeControllerBefore(this.§_-Cn§);
            this.§_-Cn§.callback = null;
         }
      }
   }
}

import §_-1e§.§_-p9§;
import §_-Fc§.§catch§;
import §_-US§.§_-BV§;
import §_-lS§.§_-h2§;
import §_-nO§.§_-KI§;
import §default§.native;
import flash.utils.getTimer;

class ContactFilter implements §_-p9§, §catch§, §_-KI§
{
   private static const MIN_TRANSPARENCY_DURATION:int = 3000;
   
   public var callback:native;
   
   private var numContacts:int;
   
   private var canActivate:Boolean;
   
   private var startTime:int;
   
   public function ContactFilter()
   {
      super();
   }
   
   public function initCallback(callback:native) : void
   {
      this.canActivate = false;
      this.startTime = getTimer();
      this.callback = callback;
   }
   
   public function acceptBodiesCollision(body1:§_-BV§, body2:§_-BV§) : Boolean
   {
      ++this.numContacts;
      return false;
   }
   
   public function updateBeforeSimulation(physicsStep:int) : void
   {
      this.numContacts = 0;
   }
   
   public function updateAfterSimulation(physicsStep:int) : void
   {
      if(Boolean(this.canActivate) && this.numContacts == 0)
      {
         this.callback.§_-PH§();
      }
   }
   
   public function interpolate(interpolationCoeff:Number) : void
   {
   }
   
   public function runLogic() : void
   {
      if(§_-h2§.time - this.startTime > MIN_TRANSPARENCY_DURATION)
      {
         this.canActivate = true;
      }
   }
}
