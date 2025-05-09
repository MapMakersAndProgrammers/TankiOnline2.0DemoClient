package alternativa.engine3d.loaders.collada
{
   import alternativa.engine3d.animation.§_-FA§;
   import alternativa.engine3d.core.Object3D;
   
   public class DaeObject
   {
      public var object:Object3D;
      
      public var animation:§_-FA§;
      
      public var jointNode:DaeNode;
      
      public function DaeObject(object:Object3D, animation:§_-FA§ = null)
      {
         super();
         this.object = object;
         this.animation = animation;
      }
   }
}

