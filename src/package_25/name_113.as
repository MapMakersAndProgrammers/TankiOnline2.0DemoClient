package package_25
{
   import alternativa.engine3d.alternativa3d;
   import flash.geom.Vector3D;
   import package_21.name_139;
   import package_21.name_386;
   
   use namespace alternativa3d;
   
   public class name_113
   {
      private static var randomNumbers:Vector.<Number>;
      
      private static const randomNumbersCount:int = 1000;
      
      private static const vector:Vector3D = new Vector3D();
      
      public var name:String;
      
      public var scale:Number = 1;
      
      public var boundBox:name_386;
      
      alternativa3d var next:name_113;
      
      alternativa3d var name_413:name_113;
      
      alternativa3d var system:name_98;
      
      alternativa3d var startTime:Number;
      
      alternativa3d var lifeTime:Number = 1.7976931348623157e+308;
      
      alternativa3d var particleList:Particle;
      
      alternativa3d var aabb:name_386;
      
      alternativa3d var var_157:Vector3D;
      
      protected var var_156:Vector3D;
      
      protected var var_151:Vector.<Number>;
      
      protected var var_152:Vector.<Vector3D>;
      
      protected var var_153:Vector.<Vector3D>;
      
      protected var var_154:Vector.<Function>;
      
      protected var var_148:int = 0;
      
      private var var_155:int;
      
      private var var_150:int;
      
      private var var_147:Vector3D;
      
      private var var_149:Vector3D;
      
      public function name_113()
      {
         var i:int = 0;
         this.alternativa3d::aabb = new name_386();
         this.var_151 = new Vector.<Number>();
         this.var_152 = new Vector.<Vector3D>();
         this.var_153 = new Vector.<Vector3D>();
         this.var_154 = new Vector.<Function>();
         this.var_147 = new Vector3D(0,0,0);
         this.var_149 = new Vector3D(0,0,1);
         super();
         if(randomNumbers == null)
         {
            randomNumbers = new Vector.<Number>();
            for(i = 0; i < randomNumbersCount; randomNumbers[i] = Math.random(),i++)
            {
            }
         }
         this.var_155 = Math.random() * randomNumbersCount;
      }
      
      public function get position() : Vector3D
      {
         return this.var_147.clone();
      }
      
      public function set position(value:Vector3D) : void
      {
         this.var_147.x = value.x;
         this.var_147.y = value.y;
         this.var_147.z = value.z;
         this.var_147.w = value.w;
         if(this.alternativa3d::system != null)
         {
            this.alternativa3d::name_421(this.alternativa3d::system.alternativa3d::method_247() - this.alternativa3d::startTime);
         }
      }
      
      public function get direction() : Vector3D
      {
         return this.var_149.clone();
      }
      
      public function set direction(value:Vector3D) : void
      {
         this.var_149.x = value.x;
         this.var_149.y = value.y;
         this.var_149.z = value.z;
         this.var_149.w = value.w;
         if(this.alternativa3d::system != null)
         {
            this.alternativa3d::name_415(this.alternativa3d::system.alternativa3d::method_247() - this.alternativa3d::startTime);
         }
      }
      
      public function stop() : void
      {
         var time:Number = this.alternativa3d::system.alternativa3d::method_247() - this.alternativa3d::startTime;
         for(var i:int = 0; i < this.var_148; )
         {
            if(time < this.var_151[i])
            {
               break;
            }
            i++;
         }
         this.var_148 = i;
      }
      
      protected function get var_5() : name_98
      {
         return this.alternativa3d::system;
      }
      
      protected function get method_256() : name_139
      {
         return this.alternativa3d::system.alternativa3d::cameraToLocalTransform;
      }
      
      protected function random() : Number
      {
         var res:Number = randomNumbers[this.var_150];
         ++this.var_150;
         if(this.var_150 == randomNumbersCount)
         {
            this.var_150 = 0;
         }
         return res;
      }
      
      protected function method_257(time:Number, script:Function) : void
      {
         this.var_151[this.var_148] = time;
         this.var_152[this.var_148] = new Vector3D();
         this.var_153[this.var_148] = new Vector3D();
         this.var_154[this.var_148] = script;
         ++this.var_148;
      }
      
      protected function method_258(time:Number) : void
      {
         this.alternativa3d::lifeTime = time;
      }
      
      alternativa3d function calculateAABB() : void
      {
         this.alternativa3d::aabb.minX = this.boundBox.minX * this.scale + this.var_147.x;
         this.alternativa3d::aabb.minY = this.boundBox.minY * this.scale + this.var_147.y;
         this.alternativa3d::aabb.minZ = this.boundBox.minZ * this.scale + this.var_147.z;
         this.alternativa3d::aabb.maxX = this.boundBox.maxX * this.scale + this.var_147.x;
         this.alternativa3d::aabb.maxY = this.boundBox.maxY * this.scale + this.var_147.y;
         this.alternativa3d::aabb.maxZ = this.boundBox.maxZ * this.scale + this.var_147.z;
      }
      
      alternativa3d function name_421(time:Number) : void
      {
         var pos:Vector3D = null;
         for(var i:int = 0; i < this.var_148; )
         {
            if(time <= this.var_151[i])
            {
               pos = this.var_152[i];
               pos.x = this.var_147.x;
               pos.y = this.var_147.y;
               pos.z = this.var_147.z;
            }
            i++;
         }
      }
      
      alternativa3d function name_415(time:Number) : void
      {
         var dir:Vector3D = null;
         vector.x = this.var_149.x;
         vector.y = this.var_149.y;
         vector.z = this.var_149.z;
         vector.normalize();
         for(var i:int = 0; i < this.var_148; )
         {
            if(time <= this.var_151[i])
            {
               dir = this.var_153[i];
               dir.x = vector.x;
               dir.y = vector.y;
               dir.z = vector.z;
            }
            i++;
         }
      }
      
      alternativa3d function name_418(time:Number) : Boolean
      {
         var keyTime:Number = NaN;
         var script:Function = null;
         this.var_150 = this.var_155;
         for(var i:int = 0; i < this.var_148; )
         {
            keyTime = this.var_151[i];
            if(time < keyTime)
            {
               break;
            }
            this.alternativa3d::var_157 = this.var_152[i];
            this.var_156 = this.var_153[i];
            script = this.var_154[i];
            script.call(this,keyTime,time - keyTime);
            i++;
         }
         return i < this.var_148 || this.alternativa3d::particleList != null;
      }
   }
}

