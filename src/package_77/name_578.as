package package_77
{
   import package_86.name_257;
   import package_92.name_271;
   
   public class name_578 extends class_39
   {
      public function name_578(component:name_237)
      {
         super(component);
      }
      
      override public function start(data:*) : void
      {
         component.addToScene();
         component.setDetailedCollisionGroup(name_257.TANK | name_257.WEAPON);
         component.setSuspensionCollisionMask(name_257.STATIC | name_257.TANK);
         component.setChassisControls(0,0,false);
         var body:name_271 = component.getBody();
         body.state.velocity.z += 500;
         body.state.rotation.reset(2,2,2);
      }
   }
}

