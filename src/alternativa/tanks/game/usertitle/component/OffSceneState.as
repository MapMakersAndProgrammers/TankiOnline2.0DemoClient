package alternativa.tanks.game.usertitle.component
{
   public class OffSceneState extends ComponentStateBase
   {
      public function OffSceneState(component:UserTitleComponent)
      {
         super(component);
      }
      
      override public function start(data:*) : void
      {
         component.removeFromScene();
      }
   }
}

