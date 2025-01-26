package package_77
{
   import package_1.name_1;
   import package_27.name_501;
   import package_46.Matrix4;
   import package_46.name_194;
   import package_71.name_318;
   import package_92.name_271;
   
   public class name_515
   {
      private static var conSpeedDamping:name_1 = new name_1("track_damping",0,0,1000);
      
      public var chassisBody:name_271;
      
      public var rays:Vector.<name_510>;
      
      public var numRays:int;
      
      public var name_577:int;
      
      public var name_571:Number = 0;
      
      private var var_624:Object;
      
      public function name_515(chassisBody:name_271, matrix:Matrix4, wheels:Vector.<name_318>)
      {
         super();
         this.chassisBody = chassisBody;
         this.method_706(matrix,wheels);
      }
      
      public function set collisionMask(value:int) : void
      {
         for(var i:int = 0; i < this.numRays; i++)
         {
            name_510(this.rays[i]).collisionMask = value;
         }
      }
      
      private function method_707(tankWheel:name_318) : Boolean
      {
         var parts:Array = tankWheel.name.split("_");
         return parts[1] == "1";
      }
      
      public function method_706(matrix:Matrix4, wheels:Vector.<name_318>) : void
      {
         var position:name_194;
         var i:int;
         var tankWheel:name_318 = null;
         var mainWheel:name_318 = null;
         var ray:name_510 = null;
         var mainWheels:Vector.<name_318> = new Vector.<name_318>();
         for each(tankWheel in wheels)
         {
            if(this.method_707(tankWheel))
            {
               mainWheels.push(tankWheel);
            }
         }
         if(mainWheels.length == 0)
         {
            throw new Error("No main wheels found");
         }
         mainWheels.sort(function(a:name_318, b:name_318):Number
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
         this.rays = new Vector.<name_510>(this.numRays);
         position = new name_194();
         for(i = 0; i < this.numRays; i++)
         {
            mainWheel = mainWheels[i];
            matrix.method_353(mainWheel.position,position);
            ray = new name_510(this.chassisBody,position,new name_194(0,0,-1));
            this.rays[i] = ray;
            this.var_624[mainWheel.name] = ray;
         }
      }
      
      public function name_574(name:String, maxRayLength:Number) : Number
      {
         var ray:name_510 = this.var_624[name];
         if(ray == null)
         {
            return -1;
         }
         return ray.name_514 ? ray.name_516.t : maxRayLength;
      }
      
      public function name_573(dt:Number, throttle:Number, maxSpeed:Number, slipTerm:int, weight:Number, data:name_570, brake:Boolean) : void
      {
         var i:int = 0;
         var springCoeff:Number = NaN;
         var mid:int = 0;
         var ray:name_510 = null;
         this.name_577 = 0;
         for(i = 0; i < this.numRays; )
         {
            if(name_510(this.rays[i]).name_693(data.rayLength))
            {
               ++this.name_577;
            }
            i++;
         }
         if(this.name_577 > 0)
         {
            this.name_571 = 0;
            springCoeff = 0.5 * weight / (this.name_577 * (data.rayLength - data.name_579));
            throttle *= this.numRays / this.name_577;
            mid = this.numRays >> 1;
            if(Boolean(this.numRays & 1 == 0))
            {
               for(i = 0; i < this.numRays; i++)
               {
                  ray = this.rays[i];
                  ray.name_585(dt,throttle,maxSpeed,i <= mid ? slipTerm : int(-slipTerm),springCoeff,data,brake);
                  this.name_571 += ray.name_692;
               }
            }
            else
            {
               for(i = 0; i < this.numRays; )
               {
                  ray = this.rays[i];
                  ray.name_585(dt,throttle,maxSpeed,i < mid ? slipTerm : (i > mid ? int(-slipTerm) : 0),springCoeff,data,brake);
                  this.name_571 += ray.name_692;
                  i++;
               }
            }
            this.name_571 /= this.name_577;
         }
         else
         {
            this.name_571 = name_501.name_504(this.name_571,0,conSpeedDamping.value * dt);
         }
      }
   }
}

