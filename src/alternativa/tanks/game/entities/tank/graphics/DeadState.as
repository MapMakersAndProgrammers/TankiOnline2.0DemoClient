package alternativa.tanks.game.entities.tank.graphics
{
   public class DeadState extends ComponentState
   {
      public function DeadState(component:GraphicsControlComponent)
      {
         super(component);
      }
      
      override public function start(data:*) : void
      {
         component.addToScene();
         component.setMaterial(MaterialType.DEAD);
      }
   }
}

