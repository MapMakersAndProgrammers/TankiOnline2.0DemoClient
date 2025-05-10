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
      
      alternativa3d var name_implements:ParticleEffect;
      
      alternativa3d var system:ParticleSystem;
      
      alternativa3d var startTime:Number;
      
      alternativa3d var lifeTime:Number = 1.7976931348623157e+308;
      
      alternativa3d var particleList:Particle;
      
      alternativa3d var aabb:BoundBox;
      
      alternativa3d var name_M7:Vector3D;
      
      protected var name_cF:Vector3D;
      
      protected var name_gV:Vector.<Number>;
      
      protected var name_lB:Vector.<Vector3D>;
      
      protected var name_ib:Vector.<Vector3D>;
      
      protected var name_Nz:Vector.<Function>;
      
      protected var name_kf:int = 0;
      
      private var name_TK:int;
      
      private var name_hs:int;
      
      private var name_G1:Vector3D;
      
      private var name_Q2:Vector3D;
      
      public function ParticleEffect()
      {
         var i:int = 0;
         this.alternativa3d::aabb = new BoundBox();
         this.name_gV = new Vector.<Number>();
         this.name_lB = new Vector.<Vector3D>();
         this.name_ib = new Vector.<Vector3D>();
         this.name_Nz = new Vector.<Function>();
         this.name_G1 = new Vector3D(0,0,0);
         this.name_Q2 = new Vector3D(0,0,1);
         super();
         if(randomNumbers == null)
         {
            randomNumbers = new Vector.<Number>();
            for(i = 0; i < randomNumbersCount; randomNumbers[i] = Math.random(),i++)
            {
            }
         }
         this.name_TK = Math.random() * randomNumbersCount;
      }
      
      public function get position() : Vector3D
      {
         return this.name_G1.clone();
      }
      
      public function set position(value:Vector3D) : void
      {
         this.name_G1.x = value.x;
         this.name_G1.y = value.y;
         this.name_G1.z = value.z;
         this.name_G1.w = value.w;
         if(this.alternativa3d::system != null)
         {
            this.alternativa3d::setPositionKeys(this.alternativa3d::system.alternativa3d::getTime() - this.alternativa3d::startTime);
         }
      }
      
      public function get direction() : Vector3D
      {
         return this.name_Q2.clone();
      }
      
      public function set direction(value:Vector3D) : void
      {
         this.name_Q2.x = value.x;
         this.name_Q2.y = value.y;
         this.name_Q2.z = value.z;
         this.name_Q2.w = value.w;
         if(this.alternativa3d::system != null)
         {
            this.alternativa3d::setDirectionKeys(this.alternativa3d::system.alternativa3d::getTime() - this.alternativa3d::startTime);
         }
      }
      
      public function stop() : void
      {
         var time:Number = this.alternativa3d::system.alternativa3d::getTime() - this.alternativa3d::startTime;
         for(var i:int = 0; i < this.name_kf; )
         {
            if(time < this.name_gV[i])
            {
               break;
            }
            i++;
         }
         this.name_kf = i;
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
         var res:Number = randomNumbers[this.name_hs];
         ++this.name_hs;
         if(this.name_hs == randomNumbersCount)
         {
            this.name_hs = 0;
         }
         return res;
      }
      
      protected function addKey(time:Number, script:Function) : void
      {
         this.name_gV[this.name_kf] = time;
         this.name_lB[this.name_kf] = new Vector3D();
         this.name_ib[this.name_kf] = new Vector3D();
         this.name_Nz[this.name_kf] = script;
         ++this.name_kf;
      }
      
      protected function setLife(time:Number) : void
      {
         this.alternativa3d::lifeTime = time;
      }
      
      alternativa3d function calculateAABB() : void
      {
         this.alternativa3d::aabb.minX = this.boundBox.minX * this.scale + this.name_G1.x;
         this.alternativa3d::aabb.minY = this.boundBox.minY * this.scale + this.name_G1.y;
         this.alternativa3d::aabb.minZ = this.boundBox.minZ * this.scale + this.name_G1.z;
         this.alternativa3d::aabb.maxX = this.boundBox.maxX * this.scale + this.name_G1.x;
         this.alternativa3d::aabb.maxY = this.boundBox.maxY * this.scale + this.name_G1.y;
         this.alternativa3d::aabb.maxZ = this.boundBox.maxZ * this.scale + this.name_G1.z;
      }
      
      alternativa3d function setPositionKeys(time:Number) : void
      {
         var pos:Vector3D = null;
         for(var i:int = 0; i < this.name_kf; )
         {
            if(time <= this.name_gV[i])
            {
               pos = this.name_lB[i];
               pos.x = this.name_G1.x;
               pos.y = this.name_G1.y;
               pos.z = this.name_G1.z;
            }
            i++;
         }
      }
      
      alternativa3d function setDirectionKeys(time:Number) : void
      {
         var dir:Vector3D = null;
         vector.x = this.name_Q2.x;
         vector.y = this.name_Q2.y;
         vector.z = this.name_Q2.z;
         vector.normalize();
         for(var i:int = 0; i < this.name_kf; )
         {
            if(time <= this.name_gV[i])
            {
               dir = this.name_ib[i];
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
         this.name_hs = this.name_TK;
         for(var i:int = 0; i < this.name_kf; )
         {
            keyTime = this.name_gV[i];
            if(time < keyTime)
            {
               break;
            }
            this.name_M7 = this.name_lB[i];
            this.name_cF = this.name_ib[i];
            script = this.name_Nz[i];
            script.call(this,keyTime,time - keyTime);
            i++;
         }
         return i < this.name_kf || this.alternativa3d::particleList != null;
      }
   }
}

