package alternativa.tanks.game.usertitle.component
{
   public class VisibleState extends ComponentStateBase
   {
      public function VisibleState(component:UserTitleComponent)
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

