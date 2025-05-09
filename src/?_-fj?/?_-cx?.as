package §_-fj§
{
   import §_-1e§.§_-Nh§;
   import §_-78§.§_-GH§;
   import §_-78§.§_-M2§;
   import §_-7A§.§_-3e§;
   import §_-7A§.§_-Is§;
   import §_-7A§.§_-U-§;
   import §_-Fc§.§_-8a§;
   import §_-Fc§.§catch§;
   import §_-KA§.§_-FW§;
   import §_-MU§.§_-5-§;
   import §_-US§.§_-BV§;
   import §_-US§.§_-DB§;
   import §_-US§.§_-kG§;
   import §_-Uy§.§_-oP§;
   import §_-az§.§_-2J§;
   import §_-az§.§_-AG§;
   import §_-az§.§_-Ss§;
   import §_-fT§.§_-HM§;
   import §_-fT§.§_-WY§;
   import §_-fT§.§_-YY§;
   import §_-fT§.§_-Zm§;
   import §_-lS§.§_-h2§;
   import §_-nl§.Matrix3;
   import §_-nl§.Matrix4;
   import §_-nl§.§_-Ok§;
   import §_-nl§.§_-bj§;
   import §_-pe§.§_-m3§;
   import §default§.§_-BH§;
   import §default§.§_-dT§;
   import §default§.§_-kU§;
   
   public class §_-cx§ extends §_-2J§ implements §catch§, §_-Is§, §_-BH§
   {
      private static var lastId:int;
      
      private static const RAY_OFFSET:Number = 5;
      
      private static var _v:§_-bj§ = new §_-bj§();
      
      public var gameKernel:§_-AG§;
      
      public var body:§_-BV§;
      
      public var §_-Ei§:§_-nL§;
      
      public var §_-iA§:§_-nL§;
      
      public var maxSpeed:Number = 0;
      
      private var §_-fL§:ValueSmoother = new ValueSmoother(100,1000,0,0);
      
      public var maxTurnSpeed:Number = 0;
      
      private var §_-dr§:ValueSmoother = new ValueSmoother(0.3,10,0,0);
      
      private var §_-mt§:Number = 0;
      
      private var §_-JJ§:Number = 0;
      
      private var §_-Tb§:Boolean;
      
      private var §_-mq§:Boolean;
      
      private var §_-DC§:Vector.<§_-Nh§>;
      
      public var §_-i1§:Vector.<§_-Nh§>;
      
      public var §_-4Y§:Vector.<§_-Nh§>;
      
      public var §_-bi§:§_-bj§ = new §_-bj§();
      
      public var §_-UQ§:§_-Ok§ = new §_-Ok§();
      
      public var §_-YH§:Matrix4 = new Matrix4();
      
      public var §_-CF§:§_-8C§ = new §_-8C§();
      
      public var moveDirection:int;
      
      public var turnDirection:int;
      
      private var hull:§_-dT§;
      
      private var §_-Rg§:§_-YY§;
      
      private var §_-z§:§_-M2§;
      
      private var §case §:Boolean;
      
      private var turret:§_-3e§;
      
      private var §_-CG§:Vector.<§_-bj§>;
      
      private var mass:Number = 1;
      
      private var power:Number = 0;
      
      private var reverseBackTurn:Boolean;
      
      public function §_-cx§(hull:§_-dT§, mass:Number, power:Number)
      {
         super();
         this.mass = mass;
         this.power = power;
         this.§_-CG§ = new Vector.<§_-bj§>();
         this.body = new §_-BV§(1,Matrix3.IDENTITY);
         this.body.id = lastId++;
         this.§_-DC§ = new Vector.<§_-Nh§>();
         this.§_-4Y§ = new Vector.<§_-Nh§>();
         this.§_-i1§ = new Vector.<§_-Nh§>();
         this.§_-Rg§ = new §_-YY§(this.body,this.§_-i1§,this.§_-4Y§);
         this.§_-Uj§(hull);
      }
      
      public function §_-P0§() : Vector.<§_-bj§>
      {
         return this.§_-CG§;
      }
      
      public function getBody() : §_-BV§
      {
         return this.body;
      }
      
      public function §_-Ln§(wheelName:String) : Number
      {
         var lastHitLength:Number = this.§_-Ei§.§_-fG§(wheelName,this.§_-CF§.rayLength);
         if(lastHitLength < 0)
         {
            lastHitLength = this.§_-iA§.§_-fG§(wheelName,this.§_-CF§.rayLength);
         }
         if(lastHitLength < 0)
         {
            return 0;
         }
         return this.§_-CF§.§_-Fw§ - lastHitLength;
      }
      
      public function §_-Ra§() : Number
      {
         return this.§_-Ei§.§_-gt§;
      }
      
      public function §_-8p§() : Number
      {
         return this.§_-iA§.§_-gt§;
      }
      
      public function §_-Uj§(hull:§_-dT§) : void
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
         this.§_-21§(hull.§_-AE§,this.§_-DC§,§_-HM§.TANK,§_-HM§.TANK | §_-HM§.STATIC);
         this.§_-21§(hull.§_-KR§,this.§_-i1§,§_-HM§.TANK,§_-HM§.TANK);
         if(this.turret != null)
         {
            this.turret.setTurretMountPoint(hull.§_-Rj§);
         }
         this.§_-I3§();
         this.§_-Y2§();
         var rayZ:Number = this.§_-EQ§();
         this.setSuspensionCollisionMask(§_-HM§.TANK | §_-HM§.STATIC);
         this.§_-CF§.rayLength = 75;
         this.§_-CF§.§_-Fw§ = rayZ - hull.§_-Sh§.z;
         this.§_-CF§.§_-WZ§ = 1000;
         this.body.material.§_-J1§ = 0.1;
         this.setChassisControls(this.moveDirection,this.turnDirection,true);
         var bb:§_-FW§ = new §_-FW§();
         this.calculateBoundBox(bb);
         this.§_-JA§(bb);
      }
      
      public function §_-Gu§(value:Number, immediate:Boolean) : void
      {
         if(immediate)
         {
            this.maxTurnSpeed = value;
            this.§_-dr§.reset(value);
         }
         else
         {
            this.§_-dr§.targetValue = value;
         }
      }
      
      public function §_-la§(value:Number, immediate:Boolean) : void
      {
         if(immediate)
         {
            this.maxSpeed = value;
            this.§_-fL§.reset(value);
         }
         else
         {
            this.§_-fL§.targetValue = value;
         }
      }
      
      private function §_-EQ§() : Number
      {
         var matrix:Matrix4 = new Matrix4();
         matrix.§_-Vi§(this.hull.§_-Sh§);
         this.§_-Ei§ = new §_-nL§(this.body,matrix,this.hull.§_-EY§);
         this.§_-iA§ = new §_-nL§(this.body,matrix,this.hull.§_-M4§);
         return this.§_-Ei§.rays[0].getRelativeZ();
      }
      
      private function §_-Y2§() : void
      {
         var dimensions:§_-bj§ = null;
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
            dimensions = this.hull.§_-eh§.hs.clone();
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
      
      private function calculateBoundBox(boundBox:§_-FW§) : void
      {
         var collisionPrimitive:§_-Nh§ = null;
         var primitiveTransform:Matrix4 = null;
         boundBox.§_-GT§();
         for each(collisionPrimitive in this.§_-DC§)
         {
            primitiveTransform = collisionPrimitive.transform;
            collisionPrimitive.transform = collisionPrimitive.localTransform || Matrix4.IDENTITY;
            boundBox.§_-EH§(collisionPrimitive.calculateAABB());
            collisionPrimitive.transform = primitiveTransform;
         }
      }
      
      private function §_-JA§(boundBox:§_-FW§) : void
      {
         var z:int = (boundBox.maxZ - boundBox.minZ) / 2;
         this.§_-Ud§(0,boundBox.maxX,boundBox.maxY,z);
         this.§_-Ud§(1,boundBox.minX,boundBox.maxY,z);
         this.§_-Ud§(2,boundBox.minX,boundBox.minY,z);
         this.§_-Ud§(3,boundBox.maxX,boundBox.minY,z);
      }
      
      private function §_-Ud§(index:int, x:Number, y:Number, z:Number) : void
      {
         var point:§_-bj§ = null;
         var clientLog:§_-5-§ = null;
         clientLog = §_-5-§(§_-oP§.§_-nQ§().§_-N6§(§_-5-§));
         clientLog.log("tank","LegacyTrackedChassisComponent::setBoundPoint() point %1: %2, %3, %4",index,x.toFixed(2),y.toFixed(2),z.toFixed(2));
         if(index < this.§_-CG§.length)
         {
            point = this.§_-CG§[index];
         }
         if(point == null)
         {
            point = new §_-bj§();
            this.§_-CG§[index] = point;
         }
         point.reset(x,y,z);
      }
      
      public function §_-I3§() : void
      {
         var collisionPrimitive:§_-Nh§ = null;
         var turretPrimitives:Vector.<§_-Nh§> = null;
         if(this.body.collisionPrimitives != null)
         {
            this.body.collisionPrimitives.clear();
         }
         this.§_-y§(this.§_-DC§);
         this.§_-y§(this.§_-i1§);
         this.§_-4Y§.length = 0;
         for each(collisionPrimitive in this.§_-DC§)
         {
            this.§_-4Y§.push(collisionPrimitive);
         }
         if(this.turret != null)
         {
            turretPrimitives = this.turret.getTurretPrimitives();
            this.§_-y§(turretPrimitives);
            for each(collisionPrimitive in turretPrimitives)
            {
               this.§_-4Y§.push(collisionPrimitive);
            }
         }
      }
      
      public function §_-JK§(velocity:§_-bj§) : void
      {
         this.body.§_-8g§(velocity);
      }
      
      public function §_-VU§(velocity:§_-bj§) : void
      {
         this.body.§_-6F§(velocity);
      }
      
      public function §_-LV§(orientation:§_-Ok§) : void
      {
         this.body.§_-LV§(orientation);
      }
      
      public function §_-oa§(x:Number, y:Number, z:Number) : void
      {
         this.body.§_-oa§(x,y,z);
      }
      
      public function §_-83§(w:Number, x:Number, y:Number, z:Number) : void
      {
         this.body.§_-83§(w,x,y,z);
      }
      
      public function §_-C3§(x:Number, y:Number, z:Number) : void
      {
         var w:Number = 1 - x * x - y * y - z * z;
         this.body.§_-83§(w < 0 ? 0 : Number(Math.sqrt(w)),x,y,z);
      }
      
      public function setLinearVelocityXYZ(x:Number, y:Number, z:Number) : void
      {
         this.body.§_-7q§(x,y,z);
      }
      
      public function setAngularVelocityXYZ(x:Number, y:Number, z:Number) : void
      {
         this.body.§_-U4§(x,y,z);
      }
      
      public function §_-Vi§(position:§_-bj§) : void
      {
         this.body.§_-Vi§(position);
      }
      
      public function §_-eS§() : void
      {
         this.body.§use§();
      }
      
      private function §_-Er§(throttleLeft:Number, throttleRight:Number) : void
      {
         this.§_-mt§ = throttleLeft;
         this.§_-JJ§ = throttleRight;
      }
      
      private function § get§(lb:Boolean, rb:Boolean) : void
      {
         this.§_-Tb§ = lb;
         this.§_-mq§ = rb;
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
               this.§ get§(false,false);
               k = 0.8;
               throttleLeft -= turnDirection * throttle * k;
               throttleRight += turnDirection * throttle * k;
            }
            else
            {
               k = 0.4;
               if(moveDirection == 1)
               {
                  this.§ get§(turnDirection == 1,turnDirection == -1);
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
                  this.§ get§(turnDirection == -1,turnDirection == 1);
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
                  this.§ get§(turnDirection == 1,turnDirection == -1);
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
            this.§_-Er§(throttleLeft,throttleRight);
            return true;
         }
         return false;
      }
      
      override public function addToGame(gameKernel:§_-AG§) : void
      {
         this.gameKernel = gameKernel;
      }
      
      override public function removeFromGame(gameKernel:§_-AG§) : void
      {
         this.§_-z§.§_-Ah§.stop();
         this.removeFromScene();
         gameKernel = null;
      }
      
      override public function initComponent() : void
      {
         §_-U-§(entity.getComponentStrict(§_-U-§)).§_-Ea§(this);
         this.§_-I3§();
         this.§_-z§ = new §_-M2§();
         var respawnState:§_-Gg§ = new §_-Gg§(this);
         this.§_-z§.§_-W§(entity,§_-kU§.SET_RESPAWN_STATE,respawnState);
         this.§_-z§.§_-W§(entity,§_-kU§.SET_ACTIVATING_STATE,new §_-1t§(this));
         this.§_-z§.§_-W§(entity,§_-kU§.SET_ACTIVE_STATE,new §_-Wz§(this));
         this.§_-z§.§_-W§(entity,§_-kU§.SET_DEAD_STATE,new §_-0N§(this));
         this.§_-z§.§_-Ah§ = §_-GH§.INSTANCE;
         entity.addEventHandler(§_-Ss§.BATTLE_FINISHED,this.§_-7L§);
      }
      
      public function §_-pB§(point:§_-bj§) : void
      {
         point.copy(this.hull.§_-EN§);
      }
      
      public function §_-Cd§() : Matrix4
      {
         return this.§_-YH§;
      }
      
      public function setTurret(turret:§_-3e§) : void
      {
         this.turret = turret;
         if(turret != null)
         {
            this.§_-I3§();
         }
      }
      
      public function §_-Cj§(point:§_-bj§) : void
      {
         point.copy(this.hull.§_-Rj§);
      }
      
      public function updateBeforeSimulation(physicsStep:int) : void
      {
         var d:Number = NaN;
         var limit:Number = NaN;
         var dt:Number = Number(§_-h2§.timeDeltaSeconds);
         if(this.maxSpeed != this.§_-fL§.targetValue)
         {
            this.maxSpeed = this.§_-fL§.update(dt);
         }
         if(this.maxTurnSpeed != this.§_-dr§.targetValue)
         {
            this.maxTurnSpeed = this.§_-dr§.update(dt);
         }
         var slipTerm:int = this.§_-mt§ > this.§_-JJ§ ? -1 : (this.§_-mt§ < this.§_-JJ§ ? 1 : 0);
         var world:§_-DB§ = this.body.scene;
         var weight:Number = this.mass * world.§_-MX§.length();
         var k:Number = this.§_-mt§ != this.§_-JJ§ && !(this.§_-Tb§ || this.§_-mq§) && this.body.state.rotation.length() > this.maxTurnSpeed ? 0.1 : 1;
         this.§_-Ei§.§_-HQ§(dt,k * this.§_-mt§,this.maxSpeed,slipTerm,weight,this.§_-CF§,this.§_-Tb§);
         this.§_-iA§.§_-HQ§(dt,k * this.§_-JJ§,this.maxSpeed,slipTerm,weight,this.§_-CF§,this.§_-mq§);
         var baseMatrix:Matrix3 = this.body.baseMatrix;
         if(this.§_-iA§.§_-Ca§ >= this.§_-iA§.numRays >> 1 || this.§_-Ei§.§_-Ca§ >= this.§_-Ei§.numRays >> 1)
         {
            d = world.§_-MX§.x * baseMatrix.c + world.§_-MX§.y * baseMatrix.g + world.§_-MX§.z * baseMatrix.k;
            limit = Math.SQRT1_2 * world.§_-MX§.length();
            if(d < -limit || d > limit)
            {
               _v.x = (baseMatrix.c * d - world.§_-MX§.x) * this.mass;
               _v.y = (baseMatrix.g * d - world.§_-MX§.y) * this.mass;
               _v.z = (baseMatrix.k * d - world.§_-MX§.z) * this.mass;
               this.body.§_-Qy§(_v);
            }
         }
      }
      
      public function updateAfterSimulation(physicsStep:int) : void
      {
      }
      
      public function interpolate(interpolationCoeff:Number) : void
      {
         this.body.interpolate(interpolationCoeff,this.§_-bi§,this.§_-UQ§);
         this.§_-UQ§.normalize();
         this.§_-UQ§.toMatrix4(this.§_-YH§);
         this.§_-YH§.§_-Vi§(this.§_-bi§);
      }
      
      public function §_-5l§(mask:int) : void
      {
         for(var i:int = 0; i < this.§_-i1§.length; i++)
         {
            this.§_-i1§[i].collisionMask = mask;
         }
      }
      
      public function setDetailedCollisionGroup(collisionGroup:int) : void
      {
         var collisionPrimitive:§_-Nh§ = null;
         for each(collisionPrimitive in this.§_-DC§)
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
         this.§_-Ei§.collisionMask = collisionMask;
         this.§_-iA§.collisionMask = collisionMask;
      }
      
      public function addToScene() : void
      {
         var physicsSystem:§_-8a§ = null;
         var physicsScene:§_-DB§ = null;
         var collisionDetector:§_-Zm§ = null;
         if(!this.§case §)
         {
            physicsSystem = this.gameKernel.§_-m8§();
            physicsScene = physicsSystem.§_-d-§();
            collisionDetector = §_-Zm§(physicsScene.collisionDetector);
            physicsScene.§_-D8§(this.body);
            collisionDetector.§_-pN§(this.§_-Rg§);
            physicsSystem.addControllerBefore(this);
            this.§case § = true;
         }
      }
      
      public function removeFromScene() : void
      {
         var physicsSystem:§_-8a§ = null;
         var physicsScene:§_-DB§ = null;
         var collisionDetector:§_-Zm§ = null;
         if(this.§case §)
         {
            physicsSystem = this.gameKernel.§_-m8§();
            physicsScene = physicsSystem.§_-d-§();
            collisionDetector = §_-Zm§(physicsScene.collisionDetector);
            physicsScene.§_-2x§(this.body);
            collisionDetector.§_-qP§(this.§_-Rg§);
            physicsSystem.removeControllerBefore(this);
            this.§case § = false;
         }
      }
      
      private function §_-Nr§(value:Number) : void
      {
         if(value <= 0)
         {
            throw new ArgumentError("Mass must have a positive value");
         }
         this.body.invMass = 1 / value;
         if(this.hull != null)
         {
            §_-kG§.§_-Il§(value,this.hull.§_-eh§.hs,this.body.invInertia);
         }
      }
      
      private function §_-21§(geometryData:Vector.<§_-WY§>, primitives:Vector.<§_-Nh§>, collisionGroup:int, collisionMask:int) : void
      {
         var boxData:§_-WY§ = null;
         var primitive:§_-m3§ = null;
         primitives.length = 0;
         for each(boxData in geometryData)
         {
            primitive = new §_-m3§(boxData.hs,collisionGroup,collisionMask);
            primitive.localTransform = boxData.matrix.clone();
            primitive.body = this.body;
            primitives.push(primitive);
         }
      }
      
      private function §_-y§(primitives:Vector.<§_-Nh§>) : void
      {
         var collisionPrimitive:§_-Nh§ = null;
         for each(collisionPrimitive in primitives)
         {
            this.body.§_-jH§(collisionPrimitive,collisionPrimitive.localTransform);
         }
      }
      
      private function §_-7L§(gameType:String, gameData:*) : void
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
