package alternativa.engine3d.effects
{
   import alternativa.engine3d.alternativa3d;
   import alternativa.engine3d.core.Transform3D;
   import flash.display3D.textures.TextureBase;
   import flash.geom.Vector3D;
   
   use namespace alternativa3d;
   
   public class ParticlePrototype
   {
      public var atlas:TextureAtlas;
      
      private var blendSource:String;
      
      private var blendDestination:String;
      
      private var animated:Boolean;
      
      private var width:Number;
      
      private var height:Number;
      
      private var name_gV:Vector.<Number> = new Vector.<Number>();
      
      private var name_0r:Vector.<Number> = new Vector.<Number>();
      
      private var name_4e:Vector.<Number> = new Vector.<Number>();
      
      private var name_Oj:Vector.<Number> = new Vector.<Number>();
      
      private var name_07:Vector.<Number> = new Vector.<Number>();
      
      private var name_3l:Vector.<Number> = new Vector.<Number>();
      
      private var name_7S:Vector.<Number> = new Vector.<Number>();
      
      private var name_Ch:Vector.<Number> = new Vector.<Number>();
      
      private var name_kf:int = 0;
      
      public function ParticlePrototype(width:Number, height:Number, atlas:TextureAtlas, animated:Boolean = false, blendSource:String = "sourceAlpha", blendDestination:String = "oneMinusSourceAlpha")
      {
         super();
         this.width = width;
         this.height = height;
         this.atlas = atlas;
         this.animated = animated;
         this.blendSource = blendSource;
         this.blendDestination = blendDestination;
      }
      
      public function addKey(time:Number, rotation:Number = 0, scaleX:Number = 1, scaleY:Number = 1, red:Number = 1, green:Number = 1, blue:Number = 1, alpha:Number = 1) : void
      {
         var lastIndex:int = this.name_kf - 1;
         if(this.name_kf > 0 && time <= this.name_gV[lastIndex])
         {
            throw new Error("Keys must be successively.");
         }
         this.name_gV[this.name_kf] = time;
         this.name_0r[this.name_kf] = rotation;
         this.name_4e[this.name_kf] = scaleX;
         this.name_Oj[this.name_kf] = scaleY;
         this.name_07[this.name_kf] = red;
         this.name_3l[this.name_kf] = green;
         this.name_7S[this.name_kf] = blue;
         this.name_Ch[this.name_kf] = alpha;
         ++this.name_kf;
      }
      
      public function createParticle(effect:ParticleEffect, time:Number, position:Vector3D, rotation:Number = 0, scaleX:Number = 1, scaleY:Number = 1, alpha:Number = 1, firstFrame:int = 0) : void
      {
         var systemScale:Number = NaN;
         var effectScale:Number = NaN;
         var transform:Transform3D = null;
         var wind:Vector3D = null;
         var gravity:Vector3D = null;
         var a:int = 0;
         var t:Number = NaN;
         var pos:int = 0;
         var col:int = 0;
         var row:int = 0;
         var particle:Particle = null;
         var cx:Number = NaN;
         var cy:Number = NaN;
         var cz:Number = NaN;
         var rot:Number = NaN;
         var b:int = this.name_kf - 1;
         if(this.atlas.diffuse.alternativa3d::_texture != null && this.name_kf > 1 && time >= this.name_gV[0] && time < this.name_gV[b])
         {
            for(b = 1; b < this.name_kf; )
            {
               if(time < this.name_gV[b])
               {
                  systemScale = Number(effect.alternativa3d::system.alternativa3d::scale);
                  effectScale = effect.scale;
                  transform = effect.alternativa3d::system.alternativa3d::localToCameraTransform;
                  wind = effect.alternativa3d::system.wind;
                  gravity = effect.alternativa3d::system.gravity;
                  a = b - 1;
                  t = (time - this.name_gV[a]) / (this.name_gV[b] - this.name_gV[a]);
                  pos = firstFrame + (this.animated ? time * this.atlas.fps : 0);
                  if(this.atlas.loop)
                  {
                     pos %= this.atlas.rangeLength;
                     if(pos < 0)
                     {
                        pos += this.atlas.rangeLength;
                     }
                  }
                  else
                  {
                     if(pos < 0)
                     {
                        pos = 0;
                     }
                     if(pos >= this.atlas.rangeLength)
                     {
                        pos = this.atlas.rangeLength - 1;
                     }
                  }
                  pos += this.atlas.rangeBegin;
                  col = pos % this.atlas.columnsCount;
                  row = pos / this.atlas.columnsCount;
                  particle = Particle.create();
                  particle.diffuse = this.atlas.diffuse.alternativa3d::_texture;
                  particle.opacity = this.atlas.opacity != null ? this.atlas.opacity.alternativa3d::_texture : null;
                  particle.blendSource = this.blendSource;
                  particle.blendDestination = this.blendDestination;
                  cx = effect.name_M7.x + position.x * effectScale;
                  cy = effect.name_M7.y + position.y * effectScale;
                  cz = effect.name_M7.z + position.z * effectScale;
                  particle.x = cx * transform.a + cy * transform.b + cz * transform.c + transform.d;
                  particle.y = cx * transform.e + cy * transform.f + cz * transform.g + transform.h;
                  particle.z = cx * transform.i + cy * transform.j + cz * transform.k + transform.l;
                  rot = this.name_0r[a] + (this.name_0r[b] - this.name_0r[a]) * t;
                  particle.rotation = scaleX * scaleY > 0 ? rotation + rot : rotation - rot;
                  particle.width = systemScale * effectScale * scaleX * this.width * (this.name_4e[a] + (this.name_4e[b] - this.name_4e[a]) * t);
                  particle.height = systemScale * effectScale * scaleY * this.height * (this.name_Oj[a] + (this.name_Oj[b] - this.name_Oj[a]) * t);
                  particle.originX = this.atlas.originX;
                  particle.originY = this.atlas.originY;
                  particle.name_q = 1 / this.atlas.columnsCount;
                  particle.name_Ts = 1 / this.atlas.rowsCount;
                  particle.name_ej = col / this.atlas.columnsCount;
                  particle.name_W5 = row / this.atlas.rowsCount;
                  particle.red = this.name_07[a] + (this.name_07[b] - this.name_07[a]) * t;
                  particle.green = this.name_3l[a] + (this.name_3l[b] - this.name_3l[a]) * t;
                  particle.blue = this.name_7S[a] + (this.name_7S[b] - this.name_7S[a]) * t;
                  particle.alpha = alpha * (this.name_Ch[a] + (this.name_Ch[b] - this.name_Ch[a]) * t);
                  particle.next = effect.alternativa3d::particleList;
                  effect.alternativa3d::particleList = particle;
                  break;
               }
               b++;
            }
         }
      }
      
      public function get lifeTime() : Number
      {
         var lastIndex:int = this.name_kf - 1;
         return this.name_gV[lastIndex];
      }
   }
}

