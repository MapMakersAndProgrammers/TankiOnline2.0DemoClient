package alternativa.engine3d.loaders.collada
{
   import alternativa.engine3d.animation.name_550;
   import alternativa.engine3d.core.Object3D;
   
   public class DaeObject
   {
      public var object:Object3D;
      
      public var animation:name_550;
      
      public var jointNode:DaeNode;
      
      public function DaeObject(object:Object3D, animation:name_550 = null)
      {
         super();
         this.object = object;
         this.animation = animation;
      }
   }
}

