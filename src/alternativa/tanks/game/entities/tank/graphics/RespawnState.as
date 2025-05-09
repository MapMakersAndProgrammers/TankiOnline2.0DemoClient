package alternativa.tanks.game.entities.tank.graphics
{
   public class RespawnState extends ComponentState
   {
      public function RespawnState(component:GraphicsControlComponent)
      {
         super(component);
      }
      
      override public function start(data:*) : void
      {
         component.removeFromScene();
      }
   }
}

