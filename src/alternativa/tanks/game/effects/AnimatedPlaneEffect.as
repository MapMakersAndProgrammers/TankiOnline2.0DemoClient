package alternativa.tanks.game.effects
{
   import alternativa.engine3d.alternativa3d;
   import alternativa.engine3d.materials.Material;
   import alternativa.engine3d.objects.Mesh;
   import alternativa.engine3d.resources.Geometry;
   import alternativa.math.Vector3;
   import alternativa.tanks.game.subsystems.rendersystem.GameCamera;
   import alternativa.tanks.game.subsystems.rendersystem.IGraphicEffect;
   import alternativa.tanks.game.subsystems.rendersystem.RenderSystem;
   import alternativa.tanks.game.subsystems.timesystem.TimeSystem;
   import alternativa.tanks.game.utils.objectpool.ObjectPool;
   import alternativa.tanks.game.utils.objectpool.PooledObject;
   
   use namespace alternativa3d;
   
   public class AnimatedPlaneEffect extends PooledObject implements IGraphicEffect
   {
      private static var geometry:Geometry;
      
      private var plane:Mesh;
      
      private var frames:Vector.<Material>;
      
      private var fps:Number;
      
      private var §_-5m§:Number;
      
      private var numFrames:int;
      
      private var sizeGrowSpeed:Number;
      
      private var size:Number;
      
      private var renderSystem:RenderSystem;
      
      public function AnimatedPlaneEffect(objectPool:ObjectPool)
      {
         super(objectPool);
         if(geometry == null)
         {
            this.initGeometry();
         }
         this.plane = new Mesh();
         this.plane.geometry = geometry;
         this.plane.addSurface(null,0,geometry.numTriangles);
         this.plane.calculateBoundBox();
      }
      
      public function init(startSize:Number, position:Vector3, rotation:Vector3, frames:Vector.<Material>, fps:Number, sizeGrowSpeed:Number) : void
      {
         this.frames = frames;
         this.fps = fps;
         this.sizeGrowSpeed = sizeGrowSpeed;
         this.§_-5m§ = 0;
         this.numFrames = frames.length;
         this.size = startSize;
         this.plane.scaleX = startSize;
         this.plane.scaleY = startSize;
         this.plane.x = position.x;
         this.plane.y = position.y;
         this.plane.z = position.z;
         this.plane.rotationX = rotation.x;
         this.plane.rotationY = rotation.y;
         this.plane.rotationZ = rotation.z;
      }
      
      public function addedToRenderSystem(renderSystem:RenderSystem) : void
      {
         this.renderSystem = renderSystem;
         renderSystem.useResource(geometry);
         renderSystem.getEffectsContainer().addChild(this.plane);
      }
      
      public function play(camera:GameCamera) : Boolean
      {
         if(this.§_-5m§ >= this.numFrames)
         {
            return false;
         }
         this.plane.setMaterialToAllSurfaces(this.frames[int(this.§_-5m§)]);
         this.plane.scaleX = this.size;
         this.plane.scaleY = this.size;
         var dt:Number = TimeSystem.timeDeltaSeconds;
         this.size += this.sizeGrowSpeed * dt;
         this.§_-5m§ += this.fps * dt;
         return true;
      }
      
      public function destroy() : void
      {
         this.renderSystem.releaseResource(geometry);
         this.plane.alternativa3d::removeFromParent();
         this.plane.setMaterialToAllSurfaces(null);
         this.frames = null;
         storeInPool();
      }
      
      private function initGeometry() : void
      {
         geometry = new Plane(1,1).geometry;
      }
   }
}

