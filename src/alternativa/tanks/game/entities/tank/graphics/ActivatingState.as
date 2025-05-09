package alternativa.tanks.game.entities.tank.graphics
{
   public class ActivatingState extends ComponentState
   {
      public function ActivatingState(component:GraphicsControlComponent)
      {
         super(component);
      }
      
      override public function start(data:*) : void
      {
         component.addToScene();
         component.setMaterial(MaterialType.ACTIVATING);
      }
   }
}

