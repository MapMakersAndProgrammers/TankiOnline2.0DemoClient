package package_94
{
   import package_114.class_35;
   
   public class name_487 implements class_35
   {
      private var component:name_276;
      
      public function name_487(component:name_276)
      {
         super();
         this.component = component;
      }
      
      public function start(data:*) : void
      {
         this.component.setTurretControls(0);
         this.component.centerTurret(false);
         this.component.setTurretDirection(0);
         this.component.removeFromScene();
      }
      
      public function stop() : void
      {
         this.component.addToScene();
      }
   }
}

