package package_94
{
   import package_114.class_35;
   
   public class name_492 implements class_35
   {
      private var component:name_276;
      
      public function name_492(component:name_276)
      {
         super();
         this.component = component;
      }
      
      public function start(data:*) : void
      {
         this.component.setTurretControls(0);
         this.component.centerTurret(false);
      }
      
      public function stop() : void
      {
      }
   }
}

