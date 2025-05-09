package alternativa.tanks.game.entities.tank.graphics
{
   public class ActiveState extends ComponentState
   {
      public function ActiveState(component:GraphicsControlComponent)
      {
         super(component);
      }
      
      override public function start(data:*) : void
      {
         component.addToScene();
         component.setMaterial(MaterialType.NORMAL);
      }
   }
}

