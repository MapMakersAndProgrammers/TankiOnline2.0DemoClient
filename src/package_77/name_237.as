package package_77
{
   import alternativa.tanks.game.EntityComponent;
   import alternativa.tanks.game.GameKernel;
   import alternativa.tanks.game.GameEvents;
   import package_109.name_377;
   import package_114.name_488;
   import package_114.name_489;
   import package_39.name_160;
   import package_44.name_178;
   import package_44.name_465;
   import package_45.name_182;
   import package_46.Matrix3;
   import package_46.Matrix4;
   import package_46.name_194;
   import package_46.name_566;
   import alternativa.osgi.OSGi;
   import package_71.class_30;
   import package_71.name_249;
   import package_71.name_252;
   import package_75.class_15;
   import package_75.name_236;
   import package_75.name_309;
   import package_76.name_235;
   import package_86.name_257;
   import package_86.name_468;
   import package_86.name_484;
   import package_86.name_568;
   import package_90.name_386;
   import package_92.name_271;
   import package_92.name_467;
   import package_92.name_575;
   
   public class name_237 extends EntityComponent implements name_465, name_236, class_30
   {
      private static var lastId:int;
      
      private static const RAY_OFFSET:Number = 5;
      
      private static var _v:name_194 = new name_194();
      
      public var gameKernel:GameKernel;
      
      public var body:name_271;
      
      public var name_337:name_515;
      
      public var name_340:name_515;
      
      public var maxSpeed:Number = 0;
      
      private var var_480:ValueSmoother = new ValueSmoother(100,1000,0,0);
      
      public var maxTurnSpeed:Number = 0;
      
      private var var_478:ValueSmoother = new ValueSmoother(0.3,10,0,0);
      
      private var var_477:Number = 0;
      
      private var var_482:Number = 0;
      
      private var var_484:Boolean;
      
      private var var_486:Boolean;
      
      private var var_475:Vector.<name_235>;
      
      public var var_476:Vector.<name_235>;
      
      public var var_479:Vector.<name_235>;
      
      public var name_288:name_194 = new name_194();
      
      public var name_334:name_566 = new name_566();
      
      public var var_483:Matrix4 = new Matrix4();
      
      public var name_518:name_570 = new name_570();
      
      public var moveDirection:int;
      
      public var turnDirection:int;
      
      private var hull:name_249;
      
      private var var_485:name_568;
      
      private var var_424:name_488;
      
      private var var_426:Boolean;
      
      private var turret:class_15;
      
      private var var_481:Vector.<name_194>;
      
      private var mass:Number = 1;
      
      private var power:Number = 0;
      
      private var reverseBackTurn:Boolean;
      
      public function name_237(hull:name_249, mass:Number, power:Number)
      {
         super();
         this.mass = mass;
         this.power = power;
         this.var_481 = new Vector.<name_194>();
         this.body = new name_271(1,Matrix3.IDENTITY);
         this.body.id = lastId++;
         this.var_475 = new Vector.<name_235>();
         this.var_479 = new Vector.<name_235>();
         this.var_476 = new Vector.<name_235>();
         this.var_485 = new name_568(this.body,this.var_476,this.var_479);
         this.method_488(hull);
      }
      
      public function method_473() : Vector.<name_194>
      {
         return this.var_481;
      }
      
      public function getBody() : name_271
      {
         return this.body;
      }
      
      public function method_474(wheelName:String) : Number
      {
         var lastHitLength:Number = this.name_337.name_574(wheelName,this.name_518.rayLength);
         if(lastHitLength < 0)
         {
            lastHitLength = this.name_340.name_574(wheelName,this.name_518.rayLength);
         }
         if(lastHitLength < 0)
         {
            return 0;
         }
         return this.name_518.name_579 - lastHitLength;
      }
      
      public function method_492() : Number
      {
         return this.name_337.name_571;
      }
      
      public function method_495() : Number
      {
         return this.name_340.name_571;
      }
      
      public function method_488(hull:name_249) : void
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
         this.method_485(hull.name_534,this.var_475,name_257.TANK,name_257.TANK | name_257.STATIC);
         this.method_485(hull.name_535,this.var_476,name_257.TANK,name_257.TANK);
         if(this.turret != null)
         {
            this.turret.setTurretMountPoint(hull.name_533);
         }
         this.method_482();
         this.method_489();
         var rayZ:Number = this.method_487();
         this.setSuspensionCollisionMask(name_257.TANK | name_257.STATIC);
         this.name_518.rayLength = 75;
         this.name_518.name_579 = rayZ - hull.name_538.z;
         this.name_518.name_582 = 1000;
         this.body.material.name_581 = 0.1;
         this.setChassisControls(this.moveDirection,this.turnDirection,true);
         var bb:name_386 = new name_386();
         this.calculateBoundBox(bb);
         this.method_490(bb);
      }
      
      public function name_335(value:Number, immediate:Boolean) : void
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
      
      public function name_321(value:Number, immediate:Boolean) : void
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
      
      private function method_487() : Number
      {
         var matrix:Matrix4 = new Matrix4();
         matrix.name_201(this.hull.name_538);
         this.name_337 = new name_515(this.body,matrix,this.hull.name_325);
         this.name_340 = new name_515(this.body,matrix,this.hull.name_323);
         return this.name_337.rays[0].getRelativeZ();
      }
      
      private function method_489() : void
      {
         var dimensions:name_194 = null;
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
            dimensions = this.hull.name_517.hs.clone();
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
      
      private function calculateBoundBox(boundBox:name_386) : void
      {
         var collisionPrimitive:name_235 = null;
         var primitiveTransform:Matrix4 = null;
         boundBox.name_584();
         for each(collisionPrimitive in this.var_475)
         {
            primitiveTransform = collisionPrimitive.transform;
            collisionPrimitive.transform = collisionPrimitive.localTransform || Matrix4.IDENTITY;
            boundBox.name_583(collisionPrimitive.calculateAABB());
            collisionPrimitive.transform = primitiveTransform;
         }
      }
      
      private function method_490(boundBox:name_386) : void
      {
         var z:int = (boundBox.maxZ - boundBox.minZ) / 2;
         this.method_481(0,boundBox.maxX,boundBox.maxY,z);
         this.method_481(1,boundBox.minX,boundBox.maxY,z);
         this.method_481(2,boundBox.minX,boundBox.minY,z);
         this.method_481(3,boundBox.maxX,boundBox.minY,z);
      }
      
      private function method_481(index:int, x:Number, y:Number, z:Number) : void
      {
         var point:name_194 = null;
         var clientLog:name_160 = null;
         clientLog = name_160(OSGi.name_8().name_30(name_160));
         clientLog.log("tank","LegacyTrackedChassisComponent::setBoundPoint() point %1: %2, %3, %4",index,x.toFixed(2),y.toFixed(2),z.toFixed(2));
         if(index < this.var_481.length)
         {
            point = this.var_481[index];
         }
         if(point == null)
         {
            point = new name_194();
            this.var_481[index] = point;
         }
         point.reset(x,y,z);
      }
      
      public function method_482() : void
      {
         var collisionPrimitive:name_235 = null;
         var turretPrimitives:Vector.<name_235> = null;
         if(this.body.collisionPrimitives != null)
         {
            this.body.collisionPrimitives.clear();
         }
         this.method_483(this.var_475);
         this.method_483(this.var_476);
         this.var_479.length = 0;
         for each(collisionPrimitive in this.var_475)
         {
            this.var_479.push(collisionPrimitive);
         }
         if(this.turret != null)
         {
            turretPrimitives = this.turret.getTurretPrimitives();
            this.method_483(turretPrimitives);
            for each(collisionPrimitive in turretPrimitives)
            {
               this.var_479.push(collisionPrimitive);
            }
         }
      }
      
      public function method_478(velocity:name_194) : void
      {
         this.body.name_587(velocity);
      }
      
      public function method_477(velocity:name_194) : void
      {
         this.body.method_368(velocity);
      }
      
      public function name_352(orientation:name_566) : void
      {
         this.body.name_352(orientation);
      }
      
      public function name_75(x:Number, y:Number, z:Number) : void
      {
         this.body.name_75(x,y,z);
      }
      
      public function method_484(w:Number, x:Number, y:Number, z:Number) : void
      {
         this.body.method_484(w,x,y,z);
      }
      
      public function method_479(x:Number, y:Number, z:Number) : void
      {
         var w:Number = 1 - x * x - y * y - z * z;
         this.body.method_484(w < 0 ? 0 : Number(Math.sqrt(w)),x,y,z);
      }
      
      public function setLinearVelocityXYZ(x:Number, y:Number, z:Number) : void
      {
         this.body.name_588(x,y,z);
      }
      
      public function setAngularVelocityXYZ(x:Number, y:Number, z:Number) : void
      {
         this.body.name_332(x,y,z);
      }
      
      public function name_201(position:name_194) : void
      {
         this.body.name_201(position);
      }
      
      public function method_494() : void
      {
         this.body.name_586();
      }
      
      private function method_486(throttleLeft:Number, throttleRight:Number) : void
      {
         this.var_477 = throttleLeft;
         this.var_482 = throttleRight;
      }
      
      private function method_480(lb:Boolean, rb:Boolean) : void
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
               this.method_480(false,false);
               k = 0.8;
               throttleLeft -= turnDirection * throttle * k;
               throttleRight += turnDirection * throttle * k;
            }
            else
            {
               k = 0.4;
               if(moveDirection == 1)
               {
                  this.method_480(turnDirection == 1,turnDirection == -1);
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
                  this.method_480(turnDirection == -1,turnDirection == 1);
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
                  this.method_480(turnDirection == 1,turnDirection == -1);
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
            this.method_486(throttleLeft,throttleRight);
            return true;
         }
         return false;
      }
      
      override public function addToGame(gameKernel:GameKernel) : void
      {
         this.gameKernel = gameKernel;
      }
      
      override public function removeFromGame(gameKernel:GameKernel) : void
      {
         this.var_424.name_493.stop();
         this.removeFromScene();
         gameKernel = null;
      }
      
      override public function initComponent() : void
      {
         name_309(entity.getComponentStrict(name_309)).method_463(this);
         this.method_482();
         this.var_424 = new name_488();
         var respawnState:name_569 = new name_569(this);
         this.var_424.name_486(entity,name_252.SET_RESPAWN_STATE,respawnState);
         this.var_424.name_486(entity,name_252.SET_ACTIVATING_STATE,new name_576(this));
         this.var_424.name_486(entity,name_252.SET_ACTIVE_STATE,new name_572(this));
         this.var_424.name_486(entity,name_252.SET_DEAD_STATE,new name_578(this));
         this.var_424.name_493 = name_489.INSTANCE;
         entity.addEventHandler(GameEvents.BATTLE_FINISHED,this.method_386);
      }
      
      public function name_505(point:name_194) : void
      {
         point.copy(this.hull.name_536);
      }
      
      public function name_502() : Matrix4
      {
         return this.var_483;
      }
      
      public function setTurret(turret:class_15) : void
      {
         this.turret = turret;
         if(turret != null)
         {
            this.method_482();
         }
      }
      
      public function name_503(point:name_194) : void
      {
         point.copy(this.hull.name_533);
      }
      
      public function updateBeforeSimulation(physicsStep:int) : void
      {
         var d:Number = NaN;
         var limit:Number = NaN;
         var dt:Number = name_182.timeDeltaSeconds;
         if(this.maxSpeed != this.var_480.targetValue)
         {
            this.maxSpeed = this.var_480.update(dt);
         }
         if(this.maxTurnSpeed != this.var_478.targetValue)
         {
            this.maxTurnSpeed = this.var_478.update(dt);
         }
         var slipTerm:int = this.var_477 > this.var_482 ? -1 : (this.var_477 < this.var_482 ? 1 : 0);
         var world:name_467 = this.body.scene;
         var weight:Number = this.mass * world.name_567.length();
         var k:Number = this.var_477 != this.var_482 && !(this.var_484 || this.var_486) && this.body.state.rotation.length() > this.maxTurnSpeed ? 0.1 : 1;
         this.name_337.name_573(dt,k * this.var_477,this.maxSpeed,slipTerm,weight,this.name_518,this.var_484);
         this.name_340.name_573(dt,k * this.var_482,this.maxSpeed,slipTerm,weight,this.name_518,this.var_486);
         var baseMatrix:Matrix3 = this.body.baseMatrix;
         if(this.name_340.name_577 >= this.name_340.numRays >> 1 || this.name_337.name_577 >= this.name_337.numRays >> 1)
         {
            d = world.name_567.x * baseMatrix.c + world.name_567.y * baseMatrix.g + world.name_567.z * baseMatrix.k;
            limit = Math.SQRT1_2 * world.name_567.length();
            if(d < -limit || d > limit)
            {
               _v.x = (baseMatrix.c * d - world.name_567.x) * this.mass;
               _v.y = (baseMatrix.g * d - world.name_567.y) * this.mass;
               _v.z = (baseMatrix.k * d - world.name_567.z) * this.mass;
               this.body.name_585(_v);
            }
         }
      }
      
      public function updateAfterSimulation(physicsStep:int) : void
      {
      }
      
      public function interpolate(interpolationCoeff:Number) : void
      {
         this.body.interpolate(interpolationCoeff,this.name_288,this.name_334);
         this.name_334.normalize();
         this.name_334.toMatrix4(this.var_483);
         this.var_483.name_201(this.name_288);
      }
      
      public function method_491(mask:int) : void
      {
         for(var i:int = 0; i < this.var_476.length; i++)
         {
            this.var_476[i].collisionMask = mask;
         }
      }
      
      public function setDetailedCollisionGroup(collisionGroup:int) : void
      {
         var collisionPrimitive:name_235 = null;
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
         this.name_337.collisionMask = collisionMask;
         this.name_340.collisionMask = collisionMask;
      }
      
      public function addToScene() : void
      {
         var physicsSystem:name_178 = null;
         var physicsScene:name_467 = null;
         var collisionDetector:name_468 = null;
         if(!this.var_426)
         {
            physicsSystem = this.gameKernel.method_112();
            physicsScene = physicsSystem.name_246();
            collisionDetector = name_468(physicsScene.collisionDetector);
            physicsScene.name_592(this.body);
            collisionDetector.name_591(this.var_485);
            physicsSystem.addControllerBefore(this);
            this.var_426 = true;
         }
      }
      
      public function removeFromScene() : void
      {
         var physicsSystem:name_178 = null;
         var physicsScene:name_467 = null;
         var collisionDetector:name_468 = null;
         if(this.var_426)
         {
            physicsSystem = this.gameKernel.method_112();
            physicsScene = physicsSystem.name_246();
            collisionDetector = name_468(physicsScene.collisionDetector);
            physicsScene.name_593(this.body);
            collisionDetector.name_590(this.var_485);
            physicsSystem.removeControllerBefore(this);
            this.var_426 = false;
         }
      }
      
      private function method_493(value:Number) : void
      {
         if(value <= 0)
         {
            throw new ArgumentError("Mass must have a positive value");
         }
         this.body.invMass = 1 / value;
         if(this.hull != null)
         {
            name_575.name_589(value,this.hull.name_517.hs,this.body.invInertia);
         }
      }
      
      private function method_485(geometryData:Vector.<name_484>, primitives:Vector.<name_235>, collisionGroup:int, collisionMask:int) : void
      {
         var boxData:name_484 = null;
         var primitive:name_377 = null;
         primitives.length = 0;
         for each(boxData in geometryData)
         {
            primitive = new name_377(boxData.hs,collisionGroup,collisionMask);
            primitive.localTransform = boxData.matrix.clone();
            primitive.body = this.body;
            primitives.push(primitive);
         }
      }
      
      private function method_483(primitives:Vector.<name_235>) : void
      {
         var collisionPrimitive:name_235 = null;
         for each(collisionPrimitive in primitives)
         {
            this.body.name_580(collisionPrimitive,collisionPrimitive.localTransform);
         }
      }
      
      private function method_386(gameType:String, gameData:*) : void
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
