package package_42
{
   import package_2.name_1;
   import package_29.name_459;
   import package_38.Matrix4;
   import package_38.name_145;
   import package_39.name_240;
   import package_61.name_186;
   
   public class name_384
   {
      private static var conSpeedDamping:name_1 = new name_1("track_damping",0,0,1000);
      
      public var chassisBody:name_186;
      
      public var rays:Vector.<name_377>;
      
      public var numRays:int;
      
      public var name_418:int;
      
      public var name_411:Number = 0;
      
      private var var_624:Object;
      
      public function name_384(chassisBody:name_186, matrix:Matrix4, wheels:Vector.<name_240>)
      {
         super();
         this.chassisBody = chassisBody;
         this.method_278(matrix,wheels);
      }
      
      public function set collisionMask(value:int) : void
      {
         for(var i:int = 0; i < this.numRays; i++)
         {
            name_377(this.rays[i]).collisionMask = value;
         }
      }
      
      private function method_279(tankWheel:name_240) : Boolean
      {
         var parts:Array = tankWheel.name.split("_");
         return parts[1] == "1";
      }
      
      public function method_278(matrix:Matrix4, wheels:Vector.<name_240>) : void
      {
         var position:name_145;
         var i:int;
         var tankWheel:name_240 = null;
         var mainWheel:name_240 = null;
         var ray:name_377 = null;
         var mainWheels:Vector.<name_240> = new Vector.<name_240>();
         for each(tankWheel in wheels)
         {
            if(this.method_279(tankWheel))
            {
               mainWheels.push(tankWheel);
            }
         }
         if(mainWheels.length == 0)
         {
            throw new Error("No main wheels found");
         }
         mainWheels.sort(function(a:name_240, b:name_240):Number
         {
            if(a.position.y > b.position.y)
            {
               return -1;
            }
            if(a.position.y < b.position.y)
            {
               return 1;
            }
            return 0;
         });
         this.var_624 = {};
         this.numRays = mainWheels.length;
         this.rays = new Vector.<name_377>(this.numRays);
         position = new name_145();
         for(i = 0; i < this.numRays; i++)
         {
            mainWheel = mainWheels[i];
            matrix.name_462(mainWheel.position,position);
            ray = new name_377(this.chassisBody,position,new name_145(0,0,-1));
            this.rays[i] = ray;
            this.var_624[mainWheel.name] = ray;
         }
      }
      
      public function name_415(name:String, maxRayLength:Number) : Number
      {
         var ray:name_377 = this.var_624[name];
         if(ray == null)
         {
            return -1;
         }
         return !!ray.name_382 ? Number(ray.name_385.t) : maxRayLength;
      }
      
      public function name_413(dt:Number, throttle:Number, maxSpeed:Number, slipTerm:int, weight:Number, data:name_408, brake:Boolean) : void
      {
         var i:int = 0;
         var springCoeff:Number = NaN;
         var mid:int = 0;
         var ray:name_377 = null;
         this.name_418 = 0;
         for(i = 0; i < this.numRays; )
         {
            if(name_377(this.rays[i]).name_517(data.rayLength))
            {
               ++this.name_418;
            }
            i++;
         }
         if(this.name_418 > 0)
         {
            this.name_411 = 0;
            springCoeff = 0.5 * weight / (this.name_418 * (data.rayLength - data.name_420));
            throttle *= this.numRays / this.name_418;
            mid = this.numRays >> 1;
            if(Boolean(this.numRays & 1 == 0))
            {
               for(i = 0; i < this.numRays; i++)
               {
                  ray = this.rays[i];
                  ray.name_427(dt,throttle,maxSpeed,i <= mid ? slipTerm : int(-slipTerm),springCoeff,data,brake);
                  this.name_411 += ray.name_515;
               }
            }
            else
            {
               for(i = 0; i < this.numRays; )
               {
                  ray = this.rays[i];
                  ray.name_427(dt,throttle,maxSpeed,i < mid ? slipTerm : (i > mid ? int(-slipTerm) : 0),springCoeff,data,brake);
                  this.name_411 += ray.name_515;
                  i++;
               }
            }
            this.name_411 /= this.name_418;
         }
         else
         {
            this.name_411 = name_459.name_516(this.name_411,0,conSpeedDamping.value * dt);
         }
      }
   }
}

