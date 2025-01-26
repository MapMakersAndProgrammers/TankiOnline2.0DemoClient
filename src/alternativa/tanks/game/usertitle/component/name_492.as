package alternativa.tanks.game.usertitle.component
{
   public class name_492 extends class_40
   {
      public function name_492(component:name_245)
      {
         super(component);
      }
      
      override public function start(data:*) : void
      {
         component.addToScene();
         component.getTitle().setDeadState();
      }
   }
}

