package §_-fj§
{
   import §_-KT§.§_-Ju§;
   import §_-US§.§_-BV§;
   import §_-V-§.§_-aY§;
   import §_-nl§.Matrix4;
   import §_-nl§.§_-bj§;
   import §default§.§_-49§;
   
   public class §_-nL§
   {
      private static var conSpeedDamping:§_-Ju§ = new §_-Ju§("track_damping",0,0,1000);
      
      public var chassisBody:§_-BV§;
      
      public var rays:Vector.<§_-gd§>;
      
      public var numRays:int;
      
      public var §_-Ca§:int;
      
      public var §_-gt§:Number = 0;
      
      private var §_-Ce§:Object;
      
      public function §_-nL§(chassisBody:§_-BV§, matrix:Matrix4, wheels:Vector.<§_-49§>)
      {
         super();
         this.chassisBody = chassisBody;
         this.§_-TD§(matrix,wheels);
      }
      
      public function set collisionMask(value:int) : void
      {
         for(var i:int = 0; i < this.numRays; i++)
         {
            §_-gd§(this.rays[i]).collisionMask = value;
         }
      }
      
      private function §_-eO§(tankWheel:§_-49§) : Boolean
      {
         var parts:Array = tankWheel.name.split("_");
         return parts[1] == "1";
      }
      
      public function §_-TD§(matrix:Matrix4, wheels:Vector.<§_-49§>) : void
      {
         var position:§_-bj§;
         var i:int;
         var tankWheel:§_-49§ = null;
         var mainWheel:§_-49§ = null;
         var ray:§_-gd§ = null;
         var mainWheels:Vector.<§_-49§> = new Vector.<§_-49§>();
         for each(tankWheel in wheels)
         {
            if(this.§_-eO§(tankWheel))
            {
               mainWheels.push(tankWheel);
            }
         }
         if(mainWheels.length == 0)
         {
            throw new Error("No main wheels found");
         }
         mainWheels.sort(function(a:§_-49§, b:§_-49§):Number
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
         this.§_-Ce§ = {};
         this.numRays = mainWheels.length;
         this.rays = new Vector.<§_-gd§>(this.numRays);
         position = new §_-bj§();
         for(i = 0; i < this.numRays; i++)
         {
            mainWheel = mainWheels[i];
            matrix.§_-eP§(mainWheel.position,position);
            ray = new §_-gd§(this.chassisBody,position,new §_-bj§(0,0,-1));
            this.rays[i] = ray;
            this.§_-Ce§[mainWheel.name] = ray;
         }
      }
      
      public function §_-fG§(name:String, maxRayLength:Number) : Number
      {
         var ray:§_-gd§ = this.§_-Ce§[name];
         if(ray == null)
         {
            return -1;
         }
         return !!ray.§_-n3§ ? Number(ray.§_-ZA§.t) : maxRayLength;
      }
      
      public function §_-HQ§(dt:Number, throttle:Number, maxSpeed:Number, slipTerm:int, weight:Number, data:§_-8C§, brake:Boolean) : void
      {
         var i:int = 0;
         var springCoeff:Number = NaN;
         var mid:int = 0;
         var ray:§_-gd§ = null;
         this.§_-Ca§ = 0;
         for(i = 0; i < this.numRays; )
         {
            if(§_-gd§(this.rays[i]).§_-1l§(data.rayLength))
            {
               ++this.§_-Ca§;
            }
            i++;
         }
         if(this.§_-Ca§ > 0)
         {
            this.§_-gt§ = 0;
            springCoeff = 0.5 * weight / (this.§_-Ca§ * (data.rayLength - data.§_-Fw§));
            throttle *= this.numRays / this.§_-Ca§;
            mid = this.numRays >> 1;
            if(Boolean(this.numRays & 1 == 0))
            {
               for(i = 0; i < this.numRays; i++)
               {
                  ray = this.rays[i];
                  ray.§_-Qy§(dt,throttle,maxSpeed,i <= mid ? slipTerm : int(-slipTerm),springCoeff,data,brake);
                  this.§_-gt§ += ray.§_-bv§;
               }
            }
            else
            {
               for(i = 0; i < this.numRays; )
               {
                  ray = this.rays[i];
                  ray.§_-Qy§(dt,throttle,maxSpeed,i < mid ? slipTerm : (i > mid ? int(-slipTerm) : 0),springCoeff,data,brake);
                  this.§_-gt§ += ray.§_-bv§;
                  i++;
               }
            }
            this.§_-gt§ /= this.§_-Ca§;
         }
         else
         {
            this.§_-gt§ = §_-aY§.§_-Fi§(this.§_-gt§,0,conSpeedDamping.value * dt);
         }
      }
   }
}

