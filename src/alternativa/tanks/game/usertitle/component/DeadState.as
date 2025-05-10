package alternativa.tanks.game.usertitle.component
{
   public class DeadState extends ComponentStateBase
   {
      public function DeadState(component:UserTitleComponent)
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

