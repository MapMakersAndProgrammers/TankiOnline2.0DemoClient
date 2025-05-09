package package_42
{
   import package_14.name_3;
   import package_15.class_18;
   import package_15.name_17;
   import package_15.name_56;
   import package_27.name_352;
   import package_27.name_98;
   import package_30.name_103;
   import package_32.name_180;
   import package_38.Matrix3;
   import package_38.Matrix4;
   import package_38.name_145;
   import package_38.name_405;
   import package_39.class_21;
   import package_39.name_161;
   import package_39.name_164;
   import package_41.class_12;
   import package_41.name_146;
   import package_41.name_229;
   import package_51.name_276;
   import package_54.name_170;
   import package_54.name_357;
   import package_54.name_406;
   import package_54.name_410;
   import package_58.name_334;
   import package_61.name_186;
   import package_61.name_356;
   import package_61.name_416;
   import package_80.name_311;
   import package_82.name_409;
   import package_82.name_414;
   
   public class name_147 extends class_18 implements name_352, name_146, class_21
   {
      private static var lastId:int;
      
      private static const RAY_OFFSET:Number = 5;
      
      private static var _v:name_145 = new name_145();
      
      public var gameKernel:name_17;
      
      public var body:name_186;
      
      public var name_261:name_384;
      
      public var name_266:name_384;
      
      public var maxSpeed:Number = 0;
      
      private var var_480:ValueSmoother = new ValueSmoother(100,1000,0,0);
      
      public var maxTurnSpeed:Number = 0;
      
      private var var_478:ValueSmoother = new ValueSmoother(0.3,10,0,0);
      
      private var var_477:Number = 0;
      
      private var var_482:Number = 0;
      
      private var var_484:Boolean;
      
      private var var_486:Boolean;
      
      private var var_475:Vector.<name_276>;
      
      public var var_476:Vector.<name_276>;
      
      public var var_479:Vector.<name_276>;
      
      public var name_205:name_145 = new name_145();
      
      public var name_258:name_405 = new name_405();
      
      public var var_483:Matrix4 = new Matrix4();
      
      public var name_389:name_408 = new name_408();
      
      public var moveDirection:int;
      
      public var turnDirection:int;
      
      private var hull:name_161;
      
      private var var_485:name_406;
      
      private var var_424:name_409;
      
      private var var_426:Boolean;
      
      private var turret:class_12;
      
      private var var_481:Vector.<name_145>;
      
      private var mass:Number = 1;
      
      private var power:Number = 0;
      
      private var reverseBackTurn:Boolean;
      
      public function name_147(hull:name_161, mass:Number, power:Number)
      {
         super();
         this.mass = mass;
         this.power = power;
         this.var_481 = new Vector.<name_145>();
         this.body = new name_186(1,Matrix3.IDENTITY);
         this.body.id = lastId++;
         this.var_475 = new Vector.<name_276>();
         this.var_479 = new Vector.<name_276>();
         this.var_476 = new Vector.<name_276>();
         this.var_485 = new name_406(this.body,this.var_476,this.var_479);
         this.method_178(hull);
      }
      
      public function method_192() : Vector.<name_145>
      {
         return this.var_481;
      }
      
      public function getBody() : name_186
      {
         return this.body;
      }
      
      public function method_190(wheelName:String) : Number
      {
         var lastHitLength:Number = this.name_261.name_415(wheelName,this.name_389.rayLength);
         if(lastHitLength < 0)
         {
            lastHitLength = this.name_266.name_415(wheelName,this.name_389.rayLength);
         }
         if(lastHitLength < 0)
         {
            return 0;
         }
         return this.name_389.name_420 - lastHitLength;
      }
      
      public function method_183() : Number
      {
         return this.name_261.name_411;
      }
      
      public function method_194() : Number
      {
         return this.name_266.name_411;
      }
      
      public function method_178(hull:name_161) : void
      {
         if(hull == null)
         {
            throw new ArgumentError("Parameter hull is null");
         }
         if(this.hull == hull)
         {
            return;
         }
         this.hull = hull;
         this.method_175(hull.name_396,this.var_475,name_170.TANK,name_170.TANK | name_170.STATIC);
         this.method_175(hull.name_397,this.var_476,name_170.TANK,name_170.TANK);
         if(this.turret != null)
         {
            this.turret.setTurretMountPoint(hull.name_395);
         }
         this.method_172();
         this.method_180();
         var rayZ:Number = this.method_177();
         this.setSuspensionCollisionMask(name_170.TANK | name_170.STATIC);
         this.name_389.rayLength = 75;
         this.name_389.name_420 = rayZ - hull.name_400.z;
         this.name_389.name_423 = 1000;
         this.body.material.name_422 = 0.1;
         this.setChassisControls(this.moveDirection,this.turnDirection,true);
         var bb:name_334 = new name_334();
         this.calculateBoundBox(bb);
         this.method_181(bb);
      }
      
      public function name_259(value:Number, immediate:Boolean) : void
      {
         if(immediate)
         {
            this.maxTurnSpeed = value;
            this.var_478.reset(value);
         }
         else
         {
            this.var_478.targetValue = value;
         }
      }
      
      public function name_243(value:Number, immediate:Boolean) : void
      {
         if(immediate)
         {
            this.maxSpeed = value;
            this.var_480.reset(value);
         }
         else
         {
            this.var_480.targetValue = value;
         }
      }
      
      private function method_177() : Number
      {
         var matrix:Matrix4 = new Matrix4();
         matrix.name_230(this.hull.name_400);
         this.name_261 = new name_384(this.body,matrix,this.hull.name_247);
         this.name_266 = new name_384(this.body,matrix,this.hull.name_245);
         return this.name_261.rays[0].getRelativeZ();
      }
      
      private function method_180() : void
      {
         var dimensions:name_145 = null;
         var xx:Number = NaN;
         var yy:Number = NaN;
         var zz:Number = NaN;
         if(this.mass == Infinity)
         {
            this.body.invMass = 0;
            this.body.invInertia.copy(Matrix3.ZERO);
         }
         else
         {
            dimensions = this.hull.name_388.hs.clone();
            dimensions.scale(2);
            this.body.invMass = 1 / this.mass;
            xx = dimensions.x * dimensions.x;
            yy = dimensions.y * dimensions.y;
            zz = dimensions.z * dimensions.z;
            this.body.invInertia.a = 12 * this.body.invMass / (yy + zz);
            this.body.invInertia.f = 12 * this.body.invMass / (zz + xx);
            this.body.invInertia.k = 12 * this.body.invMass / (xx + yy);
         }
      }
      
      private function calculateBoundBox(boundBox:name_334) : void
      {
         var collisionPrimitive:name_276 = null;
         var primitiveTransform:Matrix4 = null;
         boundBox.name_426();
         for each(collisionPrimitive in this.var_475)
         {
            primitiveTransform = collisionPrimitive.transform;
            collisionPrimitive.transform = collisionPrimitive.localTransform || Matrix4.IDENTITY;
            boundBox.name_424(collisionPrimitive.calculateAABB());
            collisionPrimitive.transform = primitiveTransform;
         }
      }
      
      private function method_181(boundBox:name_334) : void
      {
         var z:int = (boundBox.maxZ - boundBox.minZ) / 2;
         this.method_171(0,boundBox.maxX,boundBox.maxY,z);
         this.method_171(1,boundBox.minX,boundBox.maxY,z);
         this.method_171(2,boundBox.minX,boundBox.minY,z);
         this.method_171(3,boundBox.maxX,boundBox.minY,z);
      }
      
      private function method_171(index:int, x:Number, y:Number, z:Number) : void
      {
         var point:name_145 = null;
         var clientLog:name_180 = null;
         clientLog = name_180(name_3.name_8().name_21(name_180));
         clientLog.log("tank","LegacyTrackedChassisComponent::setBoundPoint() point %1: %2, %3, %4",index,x.toFixed(2),y.toFixed(2),z.toFixed(2));
         if(index < this.var_481.length)
         {
            point = this.var_481[index];
         }
         if(point == null)
         {
            point = new name_145();
            this.var_481[index] = point;
         }
         point.reset(x,y,z);
      }
      
      public function method_172() : void
      {
         var collisionPrimitive:name_276 = null;
         var turretPrimitives:Vector.<name_276> = null;
         if(this.body.collisionPrimitives != null)
         {
            this.body.collisionPrimitives.clear();
         }
         this.method_173(this.var_475);
         this.method_173(this.var_476);
         this.var_479.length = 0;
         for each(collisionPrimitive in this.var_475)
         {
            this.var_479.push(collisionPrimitive);
         }
         if(this.turret != null)
         {
            turretPrimitives = this.turret.getTurretPrimitives();
            this.method_173(turretPrimitives);
            for each(collisionPrimitive in turretPrimitives)
            {
               this.var_479.push(collisionPrimitive);
            }
         }
      }
      
      public function method_187(velocity:name_145) : void
      {
         this.body.name_429(velocity);
      }
      
      public function method_184(velocity:name_145) : void
      {
         this.body.name_431(velocity);
      }
      
      public function name_282(orientation:name_405) : void
      {
         this.body.name_282(orientation);
      }
      
      public function name_74(x:Number, y:Number, z:Number) : void
      {
         this.body.name_74(x,y,z);
      }
      
      public function method_174(w:Number, x:Number, y:Number, z:Number) : void
      {
         this.body.method_174(w,x,y,z);
      }
      
      public function method_185(x:Number, y:Number, z:Number) : void
      {
         var w:Number = 1 - x * x - y * y - z * z;
         this.body.method_174(w < 0 ? 0 : Number(Math.sqrt(w)),x,y,z);
      }
      
      public function setLinearVelocityXYZ(x:Number, y:Number, z:Number) : void
      {
         this.body.name_430(x,y,z);
      }
      
      public function setAngularVelocityXYZ(x:Number, y:Number, z:Number) : void
      {
         this.body.name_256(x,y,z);
      }
      
      public function name_230(position:name_145) : void
      {
         this.body.name_230(position);
      }
      
      public function method_188() : void
      {
         this.body.name_428();
      }
      
      private function method_176(throttleLeft:Number, throttleRight:Number) : void
      {
         this.var_477 = throttleLeft;
         this.var_482 = throttleRight;
      }
      
      private function method_170(lb:Boolean, rb:Boolean) : void
      {
         this.var_484 = lb;
         this.var_486 = rb;
      }
      
      public function setChassisControls(moveDirection:int, turnDirection:int, reverseBackTurn:Boolean, force:Boolean = false) : Boolean
      {
         var throttle:Number = NaN;
         var throttleLeft:Number = NaN;
         var throttleRight:Number = NaN;
         var k:Number = NaN;
         turnDirection = -turnDirection;
         if(force || this.moveDirection != moveDirection || this.turnDirection != turnDirection)
         {
            this.moveDirection = moveDirection;
            this.turnDirection = turnDirection;
            this.reverseBackTurn = reverseBackTurn;
            throttle = this.power;
            throttleLeft = moveDirection * throttle;
            throttleRight = moveDirection * throttle;
            if(moveDirection == 0)
            {
               this.method_170(false,false);
               k = 0.8;
               throttleLeft -= turnDirection * throttle * k;
               throttleRight += turnDirection * throttle * k;
            }
            else
            {
               k = 0.4;
               if(moveDirection == 1)
               {
                  this.method_170(turnDirection == 1,turnDirection == -1);
                  if(turnDirection == 1)
                  {
                     throttleLeft -= throttle * k;
                  }
                  if(turnDirection == -1)
                  {
                     throttleRight -= throttle * k;
                  }
               }
               else if(reverseBackTurn)
               {
                  this.method_170(turnDirection == -1,turnDirection == 1);
                  if(turnDirection == -1)
                  {
                     throttleLeft += throttle * k;
                  }
                  if(turnDirection == 1)
                  {
                     throttleRight += throttle * k;
                  }
               }
               else
               {
                  this.method_170(turnDirection == 1,turnDirection == -1);
                  if(turnDirection == 1)
                  {
                     throttleLeft += throttle * k;
                  }
                  if(turnDirection == -1)
                  {
                     throttleRight += throttle * k;
                  }
               }
            }
            this.method_176(throttleLeft,throttleRight);
            return true;
         }
         return false;
      }
      
      override public function addToGame(gameKernel:name_17) : void
      {
         this.gameKernel = gameKernel;
      }
      
      override public function removeFromGame(gameKernel:name_17) : void
      {
         this.var_424.name_371.stop();
         this.removeFromScene();
         gameKernel = null;
      }
      
      override public function initComponent() : void
      {
         name_229(entity.getComponentStrict(name_229)).name_425(this);
         this.method_172();
         this.var_424 = new name_409();
         var respawnState:name_407 = new name_407(this);
         this.var_424.name_404(entity,name_164.SET_RESPAWN_STATE,respawnState);
         this.var_424.name_404(entity,name_164.SET_ACTIVATING_STATE,new name_417(this));
         this.var_424.name_404(entity,name_164.SET_ACTIVE_STATE,new name_412(this));
         this.var_424.name_404(entity,name_164.SET_DEAD_STATE,new name_419(this));
         this.var_424.name_371 = name_414.INSTANCE;
         entity.addEventHandler(name_56.BATTLE_FINISHED,this.method_179);
      }
      
      public function method_189(point:name_145) : void
      {
         point.copy(this.hull.name_398);
      }
      
      public function method_191() : Matrix4
      {
         return this.var_483;
      }
      
      public function setTurret(turret:class_12) : void
      {
         this.turret = turret;
         if(turret != null)
         {
            this.method_172();
         }
      }
      
      public function method_193(point:name_145) : void
      {
         point.copy(this.hull.name_395);
      }
      
      public function updateBeforeSimulation(physicsStep:int) : void
      {
         var d:Number = NaN;
         var limit:Number = NaN;
         var dt:Number = Number(name_103.timeDeltaSeconds);
         if(this.maxSpeed != this.var_480.targetValue)
         {
            this.maxSpeed = this.var_480.update(dt);
         }
         if(this.maxTurnSpeed != this.var_478.targetValue)
         {
            this.maxTurnSpeed = this.var_478.update(dt);
         }
         var slipTerm:int = this.var_477 > this.var_482 ? -1 : (this.var_477 < this.var_482 ? 1 : 0);
         var world:name_356 = this.body.scene;
         var weight:Number = this.mass * world.name_403.length();
         var k:Number = this.var_477 != this.var_482 && !(this.var_484 || this.var_486) && this.body.state.rotation.length() > this.maxTurnSpeed ? 0.1 : 1;
         this.name_261.name_413(dt,k * this.var_477,this.maxSpeed,slipTerm,weight,this.name_389,this.var_484);
         this.name_266.name_413(dt,k * this.var_482,this.maxSpeed,slipTerm,weight,this.name_389,this.var_486);
         var baseMatrix:Matrix3 = this.body.baseMatrix;
         if(this.name_266.name_418 >= this.name_266.numRays >> 1 || this.name_261.name_418 >= this.name_261.numRays >> 1)
         {
            d = world.name_403.x * baseMatrix.c + world.name_403.y * baseMatrix.g + world.name_403.z * baseMatrix.k;
            limit = Math.SQRT1_2 * world.name_403.length();
            if(d < -limit || d > limit)
            {
               _v.x = (baseMatrix.c * d - world.name_403.x) * this.mass;
               _v.y = (baseMatrix.g * d - world.name_403.y) * this.mass;
               _v.z = (baseMatrix.k * d - world.name_403.z) * this.mass;
               this.body.name_427(_v);
            }
         }
      }
      
      public function updateAfterSimulation(physicsStep:int) : void
      {
      }
      
      public function interpolate(interpolationCoeff:Number) : void
      {
         this.body.interpolate(interpolationCoeff,this.name_205,this.name_258);
         this.name_258.normalize();
         this.name_258.toMatrix4(this.var_483);
         this.var_483.name_230(this.name_205);
      }
      
      public function method_182(mask:int) : void
      {
         for(var i:int = 0; i < this.var_476.length; i++)
         {
            this.var_476[i].collisionMask = mask;
         }
      }
      
      public function setDetailedCollisionGroup(collisionGroup:int) : void
      {
         var collisionPrimitive:name_276 = null;
         for each(collisionPrimitive in this.var_475)
         {
            collisionPrimitive.collisionGroup = collisionGroup;
         }
         if(this.turret != null)
         {
            for each(collisionPrimitive in this.turret.getTurretPrimitives())
            {
               collisionPrimitive.collisionGroup = collisionGroup;
            }
         }
      }
      
      public function setSuspensionCollisionMask(collisionMask:int) : void
      {
         this.name_261.collisionMask = collisionMask;
         this.name_266.collisionMask = collisionMask;
      }
      
      public function addToScene() : void
      {
         var physicsSystem:name_98 = null;
         var physicsScene:name_356 = null;
         var collisionDetector:name_357 = null;
         if(!this.var_426)
         {
            physicsSystem = this.gameKernel.method_37();
            physicsScene = physicsSystem.name_157();
            collisionDetector = name_357(physicsScene.collisionDetector);
            physicsScene.name_435(this.body);
            collisionDetector.name_434(this.var_485);
            physicsSystem.addControllerBefore(this);
            this.var_426 = true;
         }
      }
      
      public function removeFromScene() : void
      {
         var physicsSystem:name_98 = null;
         var physicsScene:name_356 = null;
         var collisionDetector:name_357 = null;
         if(this.var_426)
         {
            physicsSystem = this.gameKernel.method_37();
            physicsScene = physicsSystem.name_157();
            collisionDetector = name_357(physicsScene.collisionDetector);
            physicsScene.name_436(this.body);
            collisionDetector.name_433(this.var_485);
            physicsSystem.removeControllerBefore(this);
            this.var_426 = false;
         }
      }
      
      private function method_186(value:Number) : void
      {
         if(value <= 0)
         {
            throw new ArgumentError("Mass must have a positive value");
         }
         this.body.invMass = 1 / value;
         if(this.hull != null)
         {
            name_416.name_432(value,this.hull.name_388.hs,this.body.invInertia);
         }
      }
      
      private function method_175(geometryData:Vector.<name_410>, primitives:Vector.<name_276>, collisionGroup:int, collisionMask:int) : void
      {
         var boxData:name_410 = null;
         var primitive:name_311 = null;
         primitives.length = 0;
         for each(boxData in geometryData)
         {
            primitive = new name_311(boxData.hs,collisionGroup,collisionMask);
            primitive.localTransform = boxData.matrix.clone();
            primitive.body = this.body;
            primitives.push(primitive);
         }
      }
      
      private function method_173(primitives:Vector.<name_276>) : void
      {
         var collisionPrimitive:name_276 = null;
         for each(collisionPrimitive in primitives)
         {
            this.body.name_421(collisionPrimitive,collisionPrimitive.localTransform);
         }
      }
      
      private function method_179(gameType:String, gameData:*) : void
      {
         this.setChassisControls(0,0,false);
      }
   }
}

class ValueSmoother
{
   public var currentValue:Number;
   
   public var targetValue:Number;
   
   public var smoothingSpeedUp:Number;
   
   public var smoothingSpeedDown:Number;
   
   public function ValueSmoother(smoothingSpeedUp:Number, smoothingSpeedDown:Number, targetValue:Number, currentValue:Number)
   {
      super();
      this.smoothingSpeedUp = smoothingSpeedUp;
      this.smoothingSpeedDown = smoothingSpeedDown;
      this.targetValue = targetValue;
      this.currentValue = currentValue;
   }
   
   public function reset(value:Number) : void
   {
      this.currentValue = value;
      this.targetValue = value;
   }
   
   public function update(dt:Number) : Number
   {
      if(this.currentValue < this.targetValue)
      {
         this.currentValue += this.smoothingSpeedUp * dt;
         if(this.currentValue > this.targetValue)
         {
            this.currentValue = this.targetValue;
         }
      }
      else if(this.currentValue > this.targetValue)
      {
         this.currentValue -= this.smoothingSpeedDown * dt;
         if(this.currentValue < this.targetValue)
         {
            this.currentValue = this.targetValue;
         }
      }
      return this.currentValue;
   }
}
