package package_42
{
   import package_15.name_17;
   import package_27.name_98;
   import package_39.name_555;
   import package_54.name_170;
   
   public class name_417 extends class_27
   {
      private var var_644:ContactFilter;
      
      public function name_417(component:name_147)
      {
         super(component);
         this.var_644 = new ContactFilter();
      }
      
      override public function start(data:*) : void
      {
         var gameKernel:name_17 = null;
         var physicsSystem:name_98 = null;
         component.addToScene();
         component.setDetailedCollisionGroup(name_170.TANK);
         component.setSuspensionCollisionMask(name_170.STATIC);
         component.body.postCollisionFilter = this.var_644;
         var callback:name_555 = name_555(data);
         if(callback != null)
         {
            gameKernel = component.gameKernel;
            this.var_644.initCallback(callback);
            gameKernel.getLogicSystem1().addLogicUnit(this.var_644);
            physicsSystem = gameKernel.method_37();
            physicsSystem.addControllerAfter(this.var_644);
            physicsSystem.addControllerBefore(this.var_644);
         }
      }
      
      override public function stop() : void
      {
         var gameKernel:name_17 = null;
         var physicsSystem:name_98 = null;
         component.body.postCollisionFilter = null;
         if(this.var_644.callback != null)
         {
            gameKernel = component.gameKernel;
            gameKernel.getLogicSystem1().removeLogicUnit(this.var_644);
            physicsSystem = gameKernel.method_37();
            physicsSystem.removeControllerAfter(this.var_644);
            physicsSystem.removeControllerBefore(this.var_644);
            this.var_644.callback = null;
         }
      }
   }
}

import flash.utils.getTimer;
import package_24.name_367;
import package_27.name_352;
import package_30.name_103;
import package_39.name_555;
import package_51.class_28;
import package_61.name_186;

class ContactFilter implements class_28, name_352, name_367
{
   private static const MIN_TRANSPARENCY_DURATION:int = 3000;
   
   public var callback:name_555;
   
   private var numContacts:int;
   
   private var canActivate:Boolean;
   
   private var startTime:int;
   
   public function ContactFilter()
   {
      super();
   }
   
   public function initCallback(callback:name_555) : void
   {
      this.canActivate = false;
      this.startTime = getTimer();
      this.callback = callback;
   }
   
   public function acceptBodiesCollision(body1:name_186, body2:name_186) : Boolean
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
         this.callback.name_556();
      }
   }
   
   public function interpolate(interpolationCoeff:Number) : void
   {
   }
   
   public function runLogic() : void
   {
      if(name_103.time - this.startTime > MIN_TRANSPARENCY_DURATION)
      {
         this.canActivate = true;
      }
   }
}
