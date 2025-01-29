package package_72
{
   import alternativa.engine3d.alternativa3d;
   import alternativa.tanks.game.subsystems.rendersystem.RenderSystem;
   import alternativa.tanks.game.subsystems.rendersystem.IGraphicEffect;
   import alternativa.tanks.game.subsystems.rendersystem.GameCamera;
   import package_19.name_494;
   import alternativa.tanks.game.utils.objectpool.PooledObject;
   import alternativa.tanks.game.utils.objectpool.ObjectPool;
   import package_4.class_4;
   import package_45.name_182;
   import package_46.name_194;
   
   public class name_239 extends PooledObject implements IGraphicEffect
   {
      private static var toCamera:name_194 = new name_194();
      
      private var sprite:name_494;
      
      private var offsetToCamera:Number;
      
      private var var_458:Number;
      
      private var currFrame:Number;
      
      private var frames:Vector.<class_4>;
      
      private var numFrames:int;
      
      private var position:name_194 = new name_194();
      
      private var loop:Boolean;
      
      public function name_239(objectPool:ObjectPool)
      {
         super(objectPool);
      }
      
      public function init(width:Number, height:Number, frames:Vector.<class_4>, position:name_194, rotation:Number, offsetToCamera:Number, fps:Number, loop:Boolean, originX:Number = 0.5, originY:Number = 0.5) : void
      {
         this.method_444(width,height,rotation,originX,originY);
         this.frames = frames;
         this.offsetToCamera = offsetToCamera;
         this.var_458 = 0.001 * fps;
         this.position.copy(position);
         this.loop = loop;
         this.numFrames = frames.length;
         this.currFrame = 0;
      }
      
      public function name_201(position:name_194) : void
      {
         this.position.copy(position);
      }
      
      public function addedToRenderSystem(system:RenderSystem) : void
      {
         system.method_62().addChild(this.sprite);
      }
      
      public function play(camera:GameCamera) : Boolean
      {
         if(!this.loop && this.currFrame >= this.numFrames)
         {
            return false;
         }
         toCamera.x = camera.x - this.position.x;
         toCamera.y = camera.y - this.position.y;
         toCamera.z = camera.z - this.position.z;
         toCamera.normalize();
         this.sprite.x = this.position.x + this.offsetToCamera * toCamera.x;
         this.sprite.y = this.position.y + this.offsetToCamera * toCamera.y;
         this.sprite.z = this.position.z + this.offsetToCamera * toCamera.z;
         this.sprite.material = this.frames[int(this.currFrame)];
         this.currFrame += this.var_458 * name_182.timeDelta;
         if(this.loop)
         {
            while(this.currFrame >= this.numFrames)
            {
               this.currFrame -= this.numFrames;
            }
         }
         return true;
      }
      
      public function destroy() : void
      {
         this.sprite.alternativa3d::removeFromParent();
         this.sprite.material = null;
         this.frames = null;
         method_254();
      }
      
      public function method_255() : void
      {
         this.loop = false;
         this.currFrame = this.numFrames;
      }
      
      private function method_444(width:Number, height:Number, rotation:Number, originX:Number, originY:Number) : void
      {
         if(this.sprite == null)
         {
            this.sprite = new name_494(width,height);
         }
         else
         {
            this.sprite.width = width;
            this.sprite.height = height;
         }
         this.sprite.rotation = rotation;
         this.sprite.originX = originX;
         this.sprite.originY = originY;
      }
   }
}

