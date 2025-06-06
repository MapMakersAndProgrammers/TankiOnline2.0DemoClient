package alternativa.tanks.game.entities.tank.physics.chassis.tracked.legacy
{
   import alternativa.math.Matrix4;
   import alternativa.math.Vector3;
   import alternativa.osgi.service.console.variables.ConsoleVarFloat;
   import alternativa.physics.Body;
   import alternativa.tanks.game.entities.tank.TankWheel;
   import alternativa.tanks.game.utils.GameMathUtils;
   
   public class LegacyTrack
   {
      private static var conSpeedDamping:ConsoleVarFloat = new ConsoleVarFloat("track_damping",0,0,1000);
      
      public var chassisBody:Body;
      
      public var rays:Vector.<LegacySuspensionRay>;
      
      public var numRays:int;
      
      public var name_Ca:int;
      
      public var name_gt:Number = 0;
      
      private var name_Ce:Object;
      
      public function LegacyTrack(chassisBody:Body, matrix:Matrix4, wheels:Vector.<TankWheel>)
      {
         super();
         this.chassisBody = chassisBody;
         this.setTrackParams(matrix,wheels);
      }
      
      public function set collisionMask(value:int) : void
      {
         for(var i:int = 0; i < this.numRays; i++)
         {
            LegacySuspensionRay(this.rays[i]).collisionMask = value;
         }
      }
      
      private function isMainWheel(tankWheel:TankWheel) : Boolean
      {
         var parts:Array = tankWheel.name.split("_");
         return parts[1] == "1";
      }
      
      public function setTrackParams(matrix:Matrix4, wheels:Vector.<TankWheel>) : void
      {
         var position:Vector3;
         var i:int;
         var tankWheel:TankWheel = null;
         var mainWheel:TankWheel = null;
         var ray:LegacySuspensionRay = null;
         var mainWheels:Vector.<TankWheel> = new Vector.<TankWheel>();
         for each(tankWheel in wheels)
         {
            if(this.isMainWheel(tankWheel))
            {
               mainWheels.push(tankWheel);
            }
         }
         if(mainWheels.length == 0)
         {
            throw new Error("No main wheels found");
         }
         mainWheels.sort(function(a:TankWheel, b:TankWheel):Number
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
         this.name_Ce = {};
         this.numRays = mainWheels.length;
         this.rays = new Vector.<LegacySuspensionRay>(this.numRays);
         position = new Vector3();
         for(i = 0; i < this.numRays; i++)
         {
            mainWheel = mainWheels[i];
            matrix.transformPoint(mainWheel.position,position);
            ray = new LegacySuspensionRay(this.chassisBody,position,new Vector3(0,0,-1));
            this.rays[i] = ray;
            this.name_Ce[mainWheel.name] = ray;
         }
      }
      
      public function getRayLastHitLength(name:String, maxRayLength:Number) : Number
      {
         var ray:LegacySuspensionRay = this.name_Ce[name];
         if(ray == null)
         {
            return -1;
         }
         return ray.name_n3 ? ray.name_ZA.t : maxRayLength;
      }
      
      public function addForces(dt:Number, throttle:Number, maxSpeed:Number, slipTerm:int, weight:Number, data:SuspensionData, brake:Boolean) : void
      {
         var i:int = 0;
         var springCoeff:Number = NaN;
         var mid:int = 0;
         var ray:LegacySuspensionRay = null;
         this.name_Ca = 0;
         for(i = 0; i < this.numRays; )
         {
            if(LegacySuspensionRay(this.rays[i]).calculateIntersection(data.rayLength))
            {
               ++this.name_Ca;
            }
            i++;
         }
         if(this.name_Ca > 0)
         {
            this.name_gt = 0;
            springCoeff = 0.5 * weight / (this.name_Ca * (data.rayLength - data.name_Fw));
            throttle *= this.numRays / this.name_Ca;
            mid = this.numRays >> 1;
            //if(Boolean(this.numRays & 1 == 0)) //XXX: I have no clue man
            if((this.numRays & 1) == 0)
            {
               for(i = 0; i < this.numRays; i++)
               {
                  ray = this.rays[i];
                  ray.addForce(dt,throttle,maxSpeed,i <= mid ? slipTerm : int(-slipTerm),springCoeff,data,brake);
                  this.name_gt += ray.name_bv;
               }
            }
            else
            {
               for(i = 0; i < this.numRays; )
               {
                  ray = this.rays[i];
                  ray.addForce(dt,throttle,maxSpeed,i < mid ? slipTerm : (i > mid ? int(-slipTerm) : 0),springCoeff,data,brake);
                  this.name_gt += ray.name_bv;
                  i++;
               }
            }
            this.name_gt /= this.name_Ca;
         }
         else
         {
            this.name_gt = GameMathUtils.advanceValueTowards(this.name_gt,0,conSpeedDamping.value * dt);
         }
      }
   }
}

