package package_77
{
   public class name_569 extends class_39
   {
      public function name_569(component:name_237)
      {
         super(component);
      }
      
      override public function start(data:*) : void
      {
         component.setChassisControls(0,0,false);
         component.removeFromScene();
      }
      
      override public function stop() : void
      {
         component.setLinearVelocityXYZ(0,0,0);
         component.setAngularVelocityXYZ(0,0,0);
      }
   }
}

