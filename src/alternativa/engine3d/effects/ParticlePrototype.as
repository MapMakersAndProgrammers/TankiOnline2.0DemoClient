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
      
      private var var_151:Vector.<Number> = new Vector.<Number>();
      
      private var var_657:Vector.<Number> = new Vector.<Number>();
      
      private var var_659:Vector.<Number> = new Vector.<Number>();
      
      private var var_662:Vector.<Number> = new Vector.<Number>();
      
      private var var_656:Vector.<Number> = new Vector.<Number>();
      
      private var var_658:Vector.<Number> = new Vector.<Number>();
      
      private var var_660:Vector.<Number> = new Vector.<Number>();
      
      private var var_661:Vector.<Number> = new Vector.<Number>();
      
      private var var_148:int = 0;
      
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
         var lastIndex:int = this.var_148 - 1;
         if(this.var_148 > 0 && time <= this.var_151[lastIndex])
         {
            throw new Error("Keys must be successively.");
         }
         this.var_151[this.var_148] = time;
         this.var_657[this.var_148] = rotation;
         this.var_659[this.var_148] = scaleX;
         this.var_662[this.var_148] = scaleY;
         this.var_656[this.var_148] = red;
         this.var_658[this.var_148] = green;
         this.var_660[this.var_148] = blue;
         this.var_661[this.var_148] = alpha;
         ++this.var_148;
      }
      
      public function createParticle(effect:name_77, time:Number, position:Vector3D, rotation:Number = 0, scaleX:Number = 1, scaleY:Number = 1, alpha:Number = 1, firstFrame:int = 0) : void
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
         var b:int = this.var_148 - 1;
         if(this.atlas.diffuse.alternativa3d::_texture != null && this.var_148 > 1 && time >= this.var_151[0] && time < this.var_151[b])
         {
            for(b = 1; b < this.var_148; )
            {
               if(time < this.var_151[b])
               {
                  systemScale = Number(effect.alternativa3d::system.alternativa3d::scale);
                  effectScale = Number(effect.scale);
                  transform = effect.alternativa3d::system.alternativa3d::localToCameraTransform;
                  wind = effect.alternativa3d::system.wind;
                  gravity = effect.alternativa3d::system.gravity;
                  a = b - 1;
                  t = (time - this.var_151[a]) / (this.var_151[b] - this.var_151[a]);
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
                  cx = effect.alternativa3d::var_157.x + position.x * effectScale;
                  cy = effect.alternativa3d::var_157.y + position.y * effectScale;
                  cz = effect.alternativa3d::var_157.z + position.z * effectScale;
                  particle.x = cx * transform.a + cy * transform.b + cz * transform.c + transform.d;
                  particle.y = cx * transform.e + cy * transform.f + cz * transform.g + transform.h;
                  particle.z = cx * transform.i + cy * transform.j + cz * transform.k + transform.l;
                  rot = this.var_657[a] + (this.var_657[b] - this.var_657[a]) * t;
                  particle.rotation = scaleX * scaleY > 0 ? rotation + rot : rotation - rot;
                  particle.width = systemScale * effectScale * scaleX * this.width * (this.var_659[a] + (this.var_659[b] - this.var_659[a]) * t);
                  particle.height = systemScale * effectScale * scaleY * this.height * (this.var_662[a] + (this.var_662[b] - this.var_662[a]) * t);
                  particle.originX = this.atlas.originX;
                  particle.originY = this.atlas.originY;
                  particle.name_333 = 1 / this.atlas.columnsCount;
                  particle.name_330 = 1 / this.atlas.rowsCount;
                  particle.name_332 = col / this.atlas.columnsCount;
                  particle.name_331 = row / this.atlas.rowsCount;
                  particle.red = this.var_656[a] + (this.var_656[b] - this.var_656[a]) * t;
                  particle.green = this.var_658[a] + (this.var_658[b] - this.var_658[a]) * t;
                  particle.blue = this.var_660[a] + (this.var_660[b] - this.var_660[a]) * t;
                  particle.alpha = alpha * (this.var_661[a] + (this.var_661[b] - this.var_661[a]) * t);
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
         var lastIndex:int = this.var_148 - 1;
         return this.var_151[lastIndex];
      }
   }
}

