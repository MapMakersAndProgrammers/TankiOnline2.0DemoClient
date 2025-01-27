package package_72
{
   import alternativa.engine3d.alternativa3d;
   import package_18.name_44;
   import package_18.name_85;
   import package_18.name_90;
   import package_19.name_380;
   import alternativa.tanks.game.utils.objectpool.PooledObject;
   import alternativa.tanks.game.utils.objectpool.ObjectPool;
   import package_28.name_119;
   import package_4.class_4;
   import package_45.name_182;
   import package_46.name_194;
   
   use namespace alternativa3d;
   
   public class name_264 extends PooledObject implements name_85
   {
      private static var geometry:name_119;
      
      private var plane:name_380;
      
      private var frames:Vector.<class_4>;
      
      private var fps:Number;
      
      private var var_472:Number;
      
      private var numFrames:int;
      
      private var sizeGrowSpeed:Number;
      
      private var size:Number;
      
      private var renderSystem:name_44;
      
      public function name_264(objectPool:ObjectPool)
      {
         super(objectPool);
         if(geometry == null)
         {
            this.method_471();
         }
         this.plane = new name_380();
         this.plane.geometry = geometry;
         this.plane.addSurface(null,0,geometry.numTriangles);
         this.plane.calculateBoundBox();
      }
      
      public function init(startSize:Number, position:name_194, rotation:name_194, frames:Vector.<class_4>, fps:Number, sizeGrowSpeed:Number) : void
      {
         this.frames = frames;
         this.fps = fps;
         this.sizeGrowSpeed = sizeGrowSpeed;
         this.var_472 = 0;
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
      
      public function addedToRenderSystem(renderSystem:name_44) : void
      {
         this.renderSystem = renderSystem;
         renderSystem.method_29(geometry);
         renderSystem.method_60().addChild(this.plane);
      }
      
      public function play(camera:name_90) : Boolean
      {
         if(this.var_472 >= this.numFrames)
         {
            return false;
         }
         this.plane.setMaterialToAllSurfaces(this.frames[int(this.var_472)]);
         this.plane.scaleX = this.size;
         this.plane.scaleY = this.size;
         var dt:Number = name_182.timeDeltaSeconds;
         this.size += this.sizeGrowSpeed * dt;
         this.var_472 += this.fps * dt;
         return true;
      }
      
      public function destroy() : void
      {
         this.renderSystem.method_28(geometry);
         this.plane.alternativa3d::removeFromParent();
         this.plane.setMaterialToAllSurfaces(null);
         this.frames = null;
         method_254();
      }
      
      private function method_471() : void
      {
         geometry = new name_520(1,1).geometry;
      }
   }
}

