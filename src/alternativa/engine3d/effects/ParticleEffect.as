package alternativa.engine3d.effects
{
   import alternativa.engine3d.alternativa3d;
   import alternativa.engine3d.core.BoundBox;
   import alternativa.engine3d.core.Transform3D;
   import flash.geom.Vector3D;
   
   use namespace alternativa3d;
   
   public class ParticleEffect
   {
      private static var randomNumbers:Vector.<Number>;
      
      private static const randomNumbersCount:int = 1000;
      
      private static const vector:Vector3D = new Vector3D();
      
      public var name:String;
      
      public var scale:Number = 1;
      
      public var boundBox:BoundBox;
      
      alternativa3d var next:ParticleEffect;
      
      alternativa3d var §implements§:ParticleEffect;
      
      alternativa3d var system:ParticleSystem;
      
      alternativa3d var startTime:Number;
      
      alternativa3d var lifeTime:Number = 1.7976931348623157e+308;
      
      alternativa3d var particleList:Particle;
      
      alternativa3d var aabb:BoundBox;
      
      alternativa3d var §_-M7§:Vector3D;
      
      protected var §_-cF§:Vector3D;
      
      protected var §_-gV§:Vector.<Number>;
      
      protected var §_-lB§:Vector.<Vector3D>;
      
      protected var §_-ib§:Vector.<Vector3D>;
      
      protected var §_-Nz§:Vector.<Function>;
      
      protected var §_-kf§:int = 0;
      
      private var §_-TK§:int;
      
      private var §_-hs§:int;
      
      private var §_-G1§:Vector3D;
      
      private var §_-Q2§:Vector3D;
      
      public function ParticleEffect()
      {
         var i:int = 0;
         this.alternativa3d::aabb = new BoundBox();
         this.§_-gV§ = new Vector.<Number>();
         this.§_-lB§ = new Vector.<Vector3D>();
         this.§_-ib§ = new Vector.<Vector3D>();
         this.§_-Nz§ = new Vector.<Function>();
         this.§_-G1§ = new Vector3D(0,0,0);
         this.§_-Q2§ = new Vector3D(0,0,1);
         super();
         if(randomNumbers == null)
         {
            randomNumbers = new Vector.<Number>();
            for(i = 0; i < randomNumbersCount; randomNumbers[i] = Math.random(),i++)
            {
            }
         }
         this.§_-TK§ = Math.random() * randomNumbersCount;
      }
      
      public function get position() : Vector3D
      {
         return this.§_-G1§.clone();
      }
      
      public function set position(value:Vector3D) : void
      {
         this.§_-G1§.x = value.x;
         this.§_-G1§.y = value.y;
         this.§_-G1§.z = value.z;
         this.§_-G1§.w = value.w;
         if(this.alternativa3d::system != null)
         {
            this.alternativa3d::setPositionKeys(this.alternativa3d::system.alternativa3d::getTime() - this.alternativa3d::startTime);
         }
      }
      
      public function get direction() : Vector3D
      {
         return this.§_-Q2§.clone();
      }
      
      public function set direction(value:Vector3D) : void
      {
         this.§_-Q2§.x = value.x;
         this.§_-Q2§.y = value.y;
         this.§_-Q2§.z = value.z;
         this.§_-Q2§.w = value.w;
         if(this.alternativa3d::system != null)
         {
            this.alternativa3d::setDirectionKeys(this.alternativa3d::system.alternativa3d::getTime() - this.alternativa3d::startTime);
         }
      }
      
      public function stop() : void
      {
         var time:Number = this.alternativa3d::system.alternativa3d::getTime() - this.alternativa3d::startTime;
         for(var i:int = 0; i < this.§_-kf§; )
         {
            if(time < this.§_-gV§[i])
            {
               break;
            }
            i++;
         }
         this.§_-kf§ = i;
      }
      
      protected function get particleSystem() : ParticleSystem
      {
         return this.alternativa3d::system;
      }
      
      protected function get cameraTransform() : Transform3D
      {
         return this.alternativa3d::system.alternativa3d::cameraToLocalTransform;
      }
      
      protected function random() : Number
      {
         var res:Number = randomNumbers[this.§_-hs§];
         ++this.§_-hs§;
         if(this.§_-hs§ == randomNumbersCount)
         {
            this.§_-hs§ = 0;
         }
         return res;
      }
      
      protected function addKey(time:Number, script:Function) : void
      {
         this.§_-gV§[this.§_-kf§] = time;
         this.§_-lB§[this.§_-kf§] = new Vector3D();
         this.§_-ib§[this.§_-kf§] = new Vector3D();
         this.§_-Nz§[this.§_-kf§] = script;
         ++this.§_-kf§;
      }
      
      protected function setLife(time:Number) : void
      {
         this.alternativa3d::lifeTime = time;
      }
      
      alternativa3d function calculateAABB() : void
      {
         this.alternativa3d::aabb.minX = this.boundBox.minX * this.scale + this.§_-G1§.x;
         this.alternativa3d::aabb.minY = this.boundBox.minY * this.scale + this.§_-G1§.y;
         this.alternativa3d::aabb.minZ = this.boundBox.minZ * this.scale + this.§_-G1§.z;
         this.alternativa3d::aabb.maxX = this.boundBox.maxX * this.scale + this.§_-G1§.x;
         this.alternativa3d::aabb.maxY = this.boundBox.maxY * this.scale + this.§_-G1§.y;
         this.alternativa3d::aabb.maxZ = this.boundBox.maxZ * this.scale + this.§_-G1§.z;
      }
      
      alternativa3d function setPositionKeys(time:Number) : void
      {
         var pos:Vector3D = null;
         for(var i:int = 0; i < this.§_-kf§; )
         {
            if(time <= this.§_-gV§[i])
            {
               pos = this.§_-lB§[i];
               pos.x = this.§_-G1§.x;
               pos.y = this.§_-G1§.y;
               pos.z = this.§_-G1§.z;
            }
            i++;
         }
      }
      
      alternativa3d function setDirectionKeys(time:Number) : void
      {
         var dir:Vector3D = null;
         vector.x = this.§_-Q2§.x;
         vector.y = this.§_-Q2§.y;
         vector.z = this.§_-Q2§.z;
         vector.normalize();
         for(var i:int = 0; i < this.§_-kf§; )
         {
            if(time <= this.§_-gV§[i])
            {
               dir = this.§_-ib§[i];
               dir.x = vector.x;
               dir.y = vector.y;
               dir.z = vector.z;
            }
            i++;
         }
      }
      
      alternativa3d function calculate(time:Number) : Boolean
      {
         var keyTime:Number = NaN;
         var script:Function = null;
         this.§_-hs§ = this.§_-TK§;
         for(var i:int = 0; i < this.§_-kf§; )
         {
            keyTime = this.§_-gV§[i];
            if(time < keyTime)
            {
               break;
            }
            this.alternativa3d::_-M7 = this.§_-lB§[i];
            this.§_-cF§ = this.§_-ib§[i];
            script = this.§_-Nz§[i];
            script.call(this,keyTime,time - keyTime);
            i++;
         }
         return i < this.§_-kf§ || this.alternativa3d::particleList != null;
      }
   }
}

