package alternativa.tanks.game.entities.tank.graphics
{
   import alternativa.engine3d.core.Object3D;
   import alternativa.tanks.game.subsystems.rendersystem.IRenderer;
   
   public interface ITankGraphicsComponent extends IRenderer
   {
      function addToScene() : void;
      
      function removeFromScene() : void;
      
      function setMaterial(param1:MaterialType) : void;
      
      function setAlpha(param1:Number) : void;
      
      function getObject3D() : Object3D;
   }
}

