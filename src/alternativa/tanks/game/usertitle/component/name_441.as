package alternativa.tanks.game.usertitle.component
{
   public class name_441 extends class_29
   {
      public function name_441(component:name_156)
      {
         super(component);
      }
      
      override public function start(data:*) : void
      {
         component.addToScene();
         component.getTitle().clearDeadState();
      }
   }
}

