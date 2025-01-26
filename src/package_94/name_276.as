package package_94
{
   import package_10.class_17;
   import package_10.name_17;
   import package_10.name_57;
   import package_114.name_488;
   import package_114.name_489;
   import package_27.name_501;
   import package_44.name_465;
   import package_46.Matrix4;
   import package_46.name_194;
   import package_71.name_234;
   import package_71.name_252;
   import package_75.class_15;
   import package_75.name_236;
   import package_75.name_309;
   import package_76.name_235;
   import package_86.name_257;
   import package_86.name_484;
   import package_86.name_500;
   
   public class name_276 extends class_17 implements class_15, name_465
   {
      public var var_430:Number;
      
      private var turnDirection:int;
      
      private var direction:Number = 0;
      
      private var var_433:Number = 0;
      
      private var maxRotationSpeed:Number = 0;
      
      private var rotationAcceleration:Number = 0;
      
      private var var_431:Number = 0;
      
      private var var_434:Boolean;
      
      private var chassisComponent:name_236;
      
      private var gameKernel:name_17;
      
      private var turret:name_234;
      
      private var primitives:Vector.<name_235>;
      
      private var var_432:name_194;
      
      private var var_426:Boolean;
      
      private var var_424:name_488;
      
      private var var_429:Matrix4 = new Matrix4();
      
      public function name_276(turret:name_234, maxRotationSpeed:Number, rotationAcceleration:Number)
      {
         super();
         this.maxRotationSpeed = maxRotationSpeed;
         this.rotationAcceleration = rotationAcceleration;
         this.primitives = new Vector.<name_235>();
         this.var_432 = new name_194();
         this.setTurret(turret);
      }
      
      override public function addToGame(gameKernel:name_17) : void
      {
         this.gameKernel = gameKernel;
      }
      
      override public function initComponent() : void
      {
         this.chassisComponent = name_236(entity.getComponentStrict(name_236));
         this.chassisComponent.name_503(this.var_432);
         this.chassisComponent.setTurret(this);
         this.method_384();
         name_309(entity.getComponentStrict(name_309)).name_507(this);
         this.var_424 = new name_488();
         this.var_424.name_486(entity,name_252.SET_RESPAWN_STATE,new name_487(this));
         var activeState:name_491 = new name_491(this);
         this.var_424.name_486(entity,name_252.SET_ACTIVATING_STATE,activeState);
         this.var_424.name_486(entity,name_252.SET_ACTIVE_STATE,activeState);
         this.var_424.name_486(entity,name_252.SET_DEAD_STATE,new name_492(this));
         this.var_424.name_493 = name_489.INSTANCE;
         entity.addEventHandler(name_57.BATTLE_FINISHED,this.method_386);
      }
      
      public function getBarrelCount() : int
      {
         return this.turret.var_421.length;
      }
      
      public function getGunData(barrelIndex:int, barrelOrigin:name_194, gunDirection:name_194, gunElevationAxis:name_194) : void
      {
         var muzzlePoint:name_194 = this.method_385(barrelIndex);
         barrelOrigin.reset(muzzlePoint.x,0,muzzlePoint.z);
         barrelOrigin.transform4(this.var_429);
         this.var_429.getAxis(0,gunElevationAxis);
         this.var_429.getAxis(1,gunDirection);
      }
      
      public function getGunMuzzleData(barrelIndex:int, muzzlePosition:name_194, gunDirection:name_194) : void
      {
         var localMuzzlePoint:name_194 = this.method_385(barrelIndex);
         this.var_429.method_353(localMuzzlePoint,muzzlePosition);
         this.var_429.getAxis(1,gunDirection);
      }
      
      public function getGunMuzzleData2(barrelIndex:int, barrelOrigin:name_194, muzzlePosition:name_194) : void
      {
         var localMuzzlePoint:name_194 = this.method_385(barrelIndex);
         barrelOrigin.reset(localMuzzlePoint.x,0,localMuzzlePoint.z);
         barrelOrigin.transform4(this.var_429);
         this.var_429.method_353(localMuzzlePoint,muzzlePosition);
      }
      
      public function getBarrelLength(barrelIndex:int) : Number
      {
         return this.turret.var_421[barrelIndex].y;
      }
      
      public function getInterpolatedTurretDirection() : Number
      {
         return this.var_430;
      }
      
      public function getChassisMatrix() : Matrix4
      {
         return this.chassisComponent.name_502();
      }
      
      public function getSkinMountPoint(vector:name_194) : void
      {
         this.chassisComponent.name_505(vector);
      }
      
      public function setTurret(turret:name_234) : void
      {
         if(turret == null)
         {
            throw new ArgumentError("Parameter turret is null");
         }
         if(this.turret == turret)
         {
            return;
         }
         this.turret = turret;
         this.method_387(name_257.TANK,name_257.TANK | name_257.STATIC);
         if(this.chassisComponent != null)
         {
            this.chassisComponent.setTurret(this);
            this.method_384();
         }
      }
      
      public function setTurretMountPoint(point:name_194) : void
      {
         this.var_432.copy(point);
         this.method_384();
      }
      
      public function getTurretDirection() : Number
      {
         return this.direction;
      }
      
      public function setTurretDirection(value:Number) : void
      {
         this.direction = name_501.name_506(value);
         this.method_384();
      }
      
      public function setTurretControls(turretTurnDirection:int) : Boolean
      {
         if(this.turnDirection == turretTurnDirection)
         {
            return false;
         }
         this.turnDirection = turretTurnDirection;
         this.var_434 = false;
         return true;
      }
      
      public function centerTurret(value:Boolean) : void
      {
         this.var_434 = value;
      }
      
      public function getTurretPrimitives() : Vector.<name_235>
      {
         return this.primitives;
      }
      
      public function updateBeforeSimulation(physicsStep:int) : void
      {
         var dt:Number = NaN;
         this.var_433 = this.direction;
         if(!this.var_434 && this.turnDirection == 0)
         {
            this.var_431 = 0;
         }
         else
         {
            dt = 0.001 * physicsStep;
            this.var_431 += this.rotationAcceleration * dt;
            if(this.var_431 > this.maxRotationSpeed)
            {
               this.var_431 = this.maxRotationSpeed;
            }
            if(this.var_434)
            {
               this.direction = name_501.name_504(this.direction,0,this.var_431 * dt);
               if(this.direction == 0)
               {
                  this.var_434 = false;
               }
               this.method_384();
            }
            else
            {
               this.setTurretDirection(this.direction + this.turnDirection * this.var_431 * dt);
            }
         }
      }
      
      public function updateAfterSimulation(physicsStep:int) : void
      {
      }
      
      public function interpolate(interpolationCoeff:Number) : void
      {
         var angleDiff:Number = this.direction - this.var_433;
         if(angleDiff > Math.PI)
         {
            angleDiff = 2 * Math.PI - angleDiff;
            this.var_430 = this.var_433 - angleDiff * interpolationCoeff;
            if(this.var_430 < -Math.PI)
            {
               this.var_430 += 2 * Math.PI;
            }
         }
         else if(angleDiff < -Math.PI)
         {
            angleDiff += 2 * Math.PI;
            this.var_430 = this.var_433 + angleDiff * interpolationCoeff;
            if(this.var_430 > Math.PI)
            {
               this.var_430 -= 2 * Math.PI;
            }
         }
         else
         {
            this.var_430 = this.var_433 * (1 - interpolationCoeff) + this.direction * interpolationCoeff;
         }
         this.var_429.method_347();
         this.var_429.name_196(0,0,this.var_430);
         this.var_429.name_201(this.var_432);
         this.var_429.append(this.chassisComponent.name_502());
      }
      
      internal function addToScene() : void
      {
         if(!this.var_426)
         {
            this.gameKernel.method_112().addControllerBefore(this);
            this.var_426 = true;
         }
      }
      
      internal function removeFromScene() : void
      {
         if(this.var_426)
         {
            this.gameKernel.method_112().removeControllerBefore(this);
            this.var_426 = false;
         }
      }
      
      private function method_385(barrelIndex:int) : name_194
      {
         return this.turret.var_421[barrelIndex];
      }
      
      private function method_387(collisionGroup:int, collisionMask:int) : void
      {
         var boxData:name_484 = null;
         var collisioinBox:name_500 = null;
         this.primitives.length = 0;
         for each(boxData in this.turret.var_422)
         {
            collisioinBox = new name_500(boxData.hs,boxData.matrix,collisionGroup,collisionMask);
            collisioinBox.localTransform = new Matrix4();
            this.primitives.push(collisioinBox);
         }
      }
      
      private function method_384() : void
      {
         var collisionPrimitive:name_500 = null;
         var m:Matrix4 = null;
         var actualDirection:Number = -this.direction;
         var cos:Number = Number(Math.cos(actualDirection));
         var sin:Number = Number(Math.sin(actualDirection));
         var numPrimitives:uint = uint(this.primitives.length);
         for(var i:int = 0; i < numPrimitives; i++)
         {
            collisionPrimitive = name_500(this.primitives[i]);
            m = collisionPrimitive.localTransform;
            m.method_347();
            m.a = cos;
            m.b = sin;
            m.e = -sin;
            m.f = cos;
            m.d = this.var_432.x;
            m.h = this.var_432.y;
            m.l = this.var_432.z;
            m.prepend(collisionPrimitive.m);
         }
      }
      
      private function method_386(gameType:String, gameData:*) : void
      {
         this.setTurretControls(0);
      }
   }
}

