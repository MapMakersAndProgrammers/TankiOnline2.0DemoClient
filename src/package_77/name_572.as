package package_77
{
   import package_86.name_257;
   
   public class name_572 extends class_39
   {
      public function name_572(component:name_237)
      {
         super(component);
      }
      
      override public function start(data:*) : void
      {
         component.addToScene();
         component.setDetailedCollisionGroup(name_257.TANK | name_257.WEAPON);
         component.setSuspensionCollisionMask(name_257.STATIC | name_257.TANK);
      }
   }
}

