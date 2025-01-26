package package_77
{
   import package_10.name_17;
   import package_44.name_178;
   import package_71.name_720;
   import package_86.name_257;
   
   public class name_576 extends class_39
   {
      private var var_644:ContactFilter;
      
      public function name_576(component:name_237)
      {
         super(component);
         this.var_644 = new ContactFilter();
      }
      
      override public function start(data:*) : void
      {
         var gameKernel:name_17 = null;
         var physicsSystem:name_178 = null;
         component.addToScene();
         component.setDetailedCollisionGroup(name_257.TANK);
         component.setSuspensionCollisionMask(name_257.STATIC);
         component.body.postCollisionFilter = this.var_644;
         var callback:name_720 = name_720(data);
         if(callback != null)
         {
            gameKernel = component.gameKernel;
            this.var_644.initCallback(callback);
            gameKernel.getLogicSystem1().addLogicUnit(this.var_644);
            physicsSystem = gameKernel.method_112();
            physicsSystem.addControllerAfter(this.var_644);
            physicsSystem.addControllerBefore(this.var_644);
         }
      }
      
      override public function stop() : void
      {
         var gameKernel:name_17 = null;
         var physicsSystem:name_178 = null;
         component.body.postCollisionFilter = null;
         if(this.var_644.callback != null)
         {
            gameKernel = component.gameKernel;
            gameKernel.getLogicSystem1().removeLogicUnit(this.var_644);
            physicsSystem = gameKernel.method_112();
            physicsSystem.removeControllerAfter(this.var_644);
            physicsSystem.removeControllerBefore(this.var_644);
            this.var_644.callback = null;
         }
      }
   }
}

import flash.utils.getTimer;
import package_42.name_477;
import package_44.name_465;
import package_45.name_182;
import package_71.name_720;
import package_76.name_604;
import package_92.name_271;

class ContactFilter implements name_604, name_465, name_477
{
   private static const MIN_TRANSPARENCY_DURATION:int = 3000;
   
   public var callback:name_720;
   
   private var numContacts:int;
   
   private var canActivate:Boolean;
   
   private var startTime:int;
   
   public function ContactFilter()
   {
      super();
   }
   
   public function initCallback(callback:name_720) : void
   {
      this.canActivate = false;
      this.startTime = getTimer();
      this.callback = callback;
   }
   
   public function acceptBodiesCollision(body1:name_271, body2:name_271) : Boolean
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
         this.callback.name_721();
      }
   }
   
   public function interpolate(interpolationCoeff:Number) : void
   {
   }
   
   public function runLogic() : void
   {
      if(name_182.time - this.startTime > MIN_TRANSPARENCY_DURATION)
      {
         this.canActivate = true;
      }
   }
}
