package alternativa.tanks.game.entities.tank.physics.chassis.tracked.legacy
{
   import alternativa.math.Matrix3;
   import alternativa.math.Matrix4;
   import alternativa.math.Quaternion;
   import alternativa.math.Vector3;
   import alternativa.osgi.OSGi;
   import alternativa.osgi.service.clientlog.IClientLog;
   import alternativa.physics.Body;
   import alternativa.physics.PhysicsScene;
   import alternativa.physics.PhysicsUtils;
   import alternativa.physics.collision.CollisionPrimitive;
   import alternativa.physics.collision.primitives.CollisionBox;
   import alternativa.physics.collision.types.BoundBox;
   import alternativa.tanks.game.EntityComponent;
   import alternativa.tanks.game.GameEvents;
   import alternativa.tanks.game.GameKernel;
   import alternativa.tanks.game.entities.EmptyState;
   import alternativa.tanks.game.entities.EventStates;
   import alternativa.tanks.game.entities.tank.IControllableTrackedChassisComponent;
   import alternativa.tanks.game.entities.tank.TankEvents;
   import alternativa.tanks.game.entities.tank.TankHull;
   import alternativa.tanks.game.entities.tank.physics.IChassisPhysicsComponent;
   import alternativa.tanks.game.entities.tank.physics.ITurretPhysicsComponent;
   import alternativa.tanks.game.entities.tank.physics.InterpolationComponent;
   import alternativa.tanks.game.physics.BodyCollisionData;
   import alternativa.tanks.game.physics.BoxData;
   import alternativa.tanks.game.physics.CollisionGroup;
   import alternativa.tanks.game.physics.ITanksCollisionDetector;
   import alternativa.tanks.game.subsystems.physicssystem.IPhysicsController;
   import alternativa.tanks.game.subsystems.physicssystem.PhysicsSystem;
   import alternativa.tanks.game.subsystems.timesystem.TimeSystem;
   
   public class LegacyTrackedChassisComponent extends EntityComponent implements IPhysicsController, IChassisPhysicsComponent, IControllableTrackedChassisComponent
   {
      private static var lastId:int;
      
      private static const RAY_OFFSET:Number = 5;
      
      private static var _v:Vector3 = new Vector3();
      
      public var gameKernel:GameKernel;
      
      public var body:Body;
      
      public var name_Ei:LegacyTrack;
      
      public var name_iA:LegacyTrack;
      
      public var maxSpeed:Number = 0;
      
      private var name_fL:ValueSmoother = new ValueSmoother(100,1000,0,0);
      
      public var maxTurnSpeed:Number = 0;
      
      private var name_dr:ValueSmoother = new ValueSmoother(0.3,10,0,0);
      
      private var name_mt:Number = 0;
      
      private var name_JJ:Number = 0;
      
      private var name_Tb:Boolean;
      
      private var name_mq:Boolean;
      
      private var name_DC:Vector.<CollisionPrimitive>;
      
      public var name_i1:Vector.<CollisionPrimitive>;
      
      public var name_4Y:Vector.<CollisionPrimitive>;
      
      public var name_bi:Vector3 = new Vector3();
      
      public var name_UQ:Quaternion = new Quaternion();
      
      public var name_YH:Matrix4 = new Matrix4();
      
      public var name_CF:SuspensionData = new SuspensionData();
      
      public var moveDirection:int;
      
      public var turnDirection:int;
      
      private var hull:TankHull;
      
      private var name_Rg:BodyCollisionData;
      
      private var name_z:EventStates;
      
      private var name_case:Boolean;
      
      private var turret:ITurretPhysicsComponent;
      
      private var name_CG:Vector.<Vector3>;
      
      private var mass:Number = 1;
      
      private var power:Number = 0;
      
      private var reverseBackTurn:Boolean;
      
      public function LegacyTrackedChassisComponent(hull:TankHull, mass:Number, power:Number)
      {
         super();
         this.mass = mass;
         this.power = power;
         this.name_CG = new Vector.<Vector3>();
         this.body = new Body(1,Matrix3.IDENTITY);
         this.body.id = lastId++;
         this.name_DC = new Vector.<CollisionPrimitive>();
         this.name_4Y = new Vector.<CollisionPrimitive>();
         this.name_i1 = new Vector.<CollisionPrimitive>();
         this.name_Rg = new BodyCollisionData(this.body,this.name_i1,this.name_4Y);
         this.setHull(hull);
      }
      
      public function getBoundPoints() : Vector.<Vector3>
      {
         return this.name_CG;
      }
      
      public function getBody() : Body
      {
         return this.body;
      }
      
      public function getWheelDeltaZ(wheelName:String) : Number
      {
         var lastHitLength:Number = this.name_Ei.getRayLastHitLength(wheelName,this.name_CF.rayLength);
         if(lastHitLength < 0)
         {
            lastHitLength = this.name_iA.getRayLastHitLength(wheelName,this.name_CF.rayLength);
         }
         if(lastHitLength < 0)
         {
            return 0;
         }
         return this.name_CF.name_Fw - lastHitLength;
      }
      
      public function getLeftTrackSpeed() : Number
      {
         return this.name_Ei.name_gt;
      }
      
      public function getRightTrackSpeed() : Number
      {
         return this.name_iA.name_gt;
      }
      
      public function setHull(hull:TankHull) : void
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
         this.createPrimitives(hull.name_AE,this.name_DC,CollisionGroup.TANK,CollisionGroup.TANK | CollisionGroup.STATIC);
         this.createPrimitives(hull.name_KR,this.name_i1,CollisionGroup.TANK,CollisionGroup.TANK);
         if(this.turret != null)
         {
            this.turret.setTurretMountPoint(hull.name_Rj);
         }
         this.resetCollisionPrimitives();
         this.setBodyInertia();
         var rayZ:Number = this.createTracks();
         this.setSuspensionCollisionMask(CollisionGroup.TANK | CollisionGroup.STATIC);
         this.name_CF.rayLength = 75;
         this.name_CF.name_Fw = rayZ - hull.name_Sh.z;
         this.name_CF.name_WZ = 1000;
         this.body.material.name_J1 = 0.1;
         this.setChassisControls(this.moveDirection,this.turnDirection,true);
         var bb:BoundBox = new BoundBox();
         this.calculateBoundBox(bb);
         this.calculateBoundPoints(bb);
      }
      
      public function setMaxTurnSpeed(value:Number, immediate:Boolean) : void
      {
         if(immediate)
         {
            this.maxTurnSpeed = value;
            this.name_dr.reset(value);
         }
         else
         {
            this.name_dr.targetValue = value;
         }
      }
      
      public function setMaxSpeed(value:Number, immediate:Boolean) : void
      {
         if(immediate)
         {
            this.maxSpeed = value;
            this.name_fL.reset(value);
         }
         else
         {
            this.name_fL.targetValue = value;
         }
      }
      
      private function createTracks() : Number
      {
         var matrix:Matrix4 = new Matrix4();
         matrix.setPosition(this.hull.name_Sh);
         this.name_Ei = new LegacyTrack(this.body,matrix,this.hull.name_EY);
         this.name_iA = new LegacyTrack(this.body,matrix,this.hull.name_M4);
         return this.name_Ei.rays[0].getRelativeZ();
      }
      
      private function setBodyInertia() : void
      {
         var _loc1_:Vector3 = null;
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         if(this.mass == Infinity)
         {
            this.body.invMass = 0;
            this.body.invInertia.copy(Matrix3.ZERO);
         }
         else
         {
            _loc1_ = this.hull.name_eh.hs.clone();
            _loc1_.scale(2);
            this.body.invMass = 1 / this.mass;
            _loc2_ = _loc1_.x * _loc1_.x;
            _loc3_ = _loc1_.y * _loc1_.y;
            _loc4_ = _loc1_.z * _loc1_.z;
            this.body.invInertia.a = 12 * this.body.invMass / (_loc3_ + _loc4_);
            this.body.invInertia.f = 12 * this.body.invMass / (_loc4_ + _loc2_);
            this.body.invInertia.k = 12 * this.body.invMass / (_loc2_ + _loc3_);
         }
      }
      
      private function calculateBoundBox(boundBox:BoundBox) : void
      {
         var collisionPrimitive:CollisionPrimitive = null;
         var primitiveTransform:Matrix4 = null;
         boundBox.infinity();
         for each(collisionPrimitive in this.name_DC)
         {
            primitiveTransform = collisionPrimitive.transform;
            collisionPrimitive.transform = collisionPrimitive.localTransform || Matrix4.IDENTITY;
            boundBox.addBoundBox(collisionPrimitive.calculateAABB());
            collisionPrimitive.transform = primitiveTransform;
         }
      }
      
      private function calculateBoundPoints(boundBox:BoundBox) : void
      {
         var z:int = (boundBox.maxZ - boundBox.minZ) / 2;
         this.setBoundPoint(0,boundBox.maxX,boundBox.maxY,z);
         this.setBoundPoint(1,boundBox.minX,boundBox.maxY,z);
         this.setBoundPoint(2,boundBox.minX,boundBox.minY,z);
         this.setBoundPoint(3,boundBox.maxX,boundBox.minY,z);
      }
      
      private function setBoundPoint(index:int, x:Number, y:Number, z:Number) : void
      {
         var point:Vector3 = null;
         var clientLog:IClientLog = null;
         clientLog = IClientLog(OSGi.getInstance().getService(IClientLog));
         clientLog.log("tank","LegacyTrackedChassisComponent::setBoundPoint() point %1: %2, %3, %4",index,x.toFixed(2),y.toFixed(2),z.toFixed(2));
         if(index < this.name_CG.length)
         {
            point = this.name_CG[index];
         }
         if(point == null)
         {
            point = new Vector3();
            this.name_CG[index] = point;
         }
         point.reset(x,y,z);
      }
      
      public function resetCollisionPrimitives() : void
      {
         var collisionPrimitive:CollisionPrimitive = null;
         var turretPrimitives:Vector.<CollisionPrimitive> = null;
         if(this.body.collisionPrimitives != null)
         {
            this.body.collisionPrimitives.clear();
         }
         this.addPrimitivesToBody(this.name_DC);
         this.addPrimitivesToBody(this.name_i1);
         this.name_4Y.length = 0;
         for each(collisionPrimitive in this.name_DC)
         {
            this.name_4Y.push(collisionPrimitive);
         }
         if(this.turret != null)
         {
            turretPrimitives = this.turret.getTurretPrimitives();
            this.addPrimitivesToBody(turretPrimitives);
            for each(collisionPrimitive in turretPrimitives)
            {
               this.name_4Y.push(collisionPrimitive);
            }
         }
      }
      
      public function setLinearVelocity(velocity:Vector3) : void
      {
         this.body.setVelocity(velocity);
      }
      
      public function setAngularVelocity(velocity:Vector3) : void
      {
         this.body.setRotation(velocity);
      }
      
      public function setOrientation(orientation:Quaternion) : void
      {
         this.body.setOrientation(orientation);
      }
      
      public function setPositionXYZ(x:Number, y:Number, z:Number) : void
      {
         this.body.setPositionXYZ(x,y,z);
      }
      
      public function setOrientationWXYZ(w:Number, x:Number, y:Number, z:Number) : void
      {
         this.body.setOrientationWXYZ(w,x,y,z);
      }
      
      public function setOrientationXYZ(x:Number, y:Number, z:Number) : void
      {
         var w:Number = 1 - x * x - y * y - z * z;
         this.body.setOrientationWXYZ(w < 0 ? 0 : Number(Math.sqrt(w)),x,y,z);
      }
      
      public function setLinearVelocityXYZ(x:Number, y:Number, z:Number) : void
      {
         this.body.setVelocityXYZ(x,y,z);
      }
      
      public function setAngularVelocityXYZ(x:Number, y:Number, z:Number) : void
      {
         this.body.setRotationXYZ(x,y,z);
      }
      
      public function setPosition(position:Vector3) : void
      {
         this.body.setPosition(position);
      }
      
      public function resetPhysicsState() : void
      {
         this.body.saveState();
      }
      
      private function setThrottle(throttleLeft:Number, throttleRight:Number) : void
      {
         this.name_mt = throttleLeft;
         this.name_JJ = throttleRight;
      }
      
      private function setBrakes(lb:Boolean, rb:Boolean) : void
      {
         this.name_Tb = lb;
         this.name_mq = rb;
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
               this.setBrakes(false,false);
               k = 0.8;
               throttleLeft -= turnDirection * throttle * k;
               throttleRight += turnDirection * throttle * k;
            }
            else
            {
               k = 0.4;
               if(moveDirection == 1)
               {
                  this.setBrakes(turnDirection == 1,turnDirection == -1);
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
                  this.setBrakes(turnDirection == -1,turnDirection == 1);
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
                  this.setBrakes(turnDirection == 1,turnDirection == -1);
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
            this.setThrottle(throttleLeft,throttleRight);
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
         this.name_z.name_Ah.stop();
         this.removeFromScene();
         gameKernel = null;
      }
      
      override public function initComponent() : void
      {
         InterpolationComponent(entity.getComponentStrict(InterpolationComponent)).setChassisController(this);
         this.resetCollisionPrimitives();
         this.name_z = new EventStates();
         var respawnState:LegacyRespawnState = new LegacyRespawnState(this);
         this.name_z.setEventState(entity,TankEvents.SET_RESPAWN_STATE,respawnState);
         this.name_z.setEventState(entity,TankEvents.SET_ACTIVATING_STATE,new LegacyActivatingState(this));
         this.name_z.setEventState(entity,TankEvents.SET_ACTIVE_STATE,new LegacyActiveState(this));
         this.name_z.setEventState(entity,TankEvents.SET_DEAD_STATE,new LegacyDeadState(this));
         this.name_z.name_Ah = EmptyState.INSTANCE;
         entity.addEventHandler(GameEvents.BATTLE_FINISHED,this.onBattleFinished);
      }
      
      public function getTurretSkinMountPoint(point:Vector3) : void
      {
         point.copy(this.hull.name_EN);
      }
      
      public function getInterpolatedMatrix() : Matrix4
      {
         return this.name_YH;
      }
      
      public function setTurret(turret:ITurretPhysicsComponent) : void
      {
         this.turret = turret;
         if(turret != null)
         {
            this.resetCollisionPrimitives();
         }
      }
      
      public function getTurretMountPoint(point:Vector3) : void
      {
         point.copy(this.hull.name_Rj);
      }
      
      public function updateBeforeSimulation(physicsStep:int) : void
      {
         var d:Number = NaN;
         var limit:Number = NaN;
         var dt:Number = TimeSystem.timeDeltaSeconds;
         if(this.maxSpeed != this.name_fL.targetValue)
         {
            this.maxSpeed = this.name_fL.update(dt);
         }
         if(this.maxTurnSpeed != this.name_dr.targetValue)
         {
            this.maxTurnSpeed = this.name_dr.update(dt);
         }
         var slipTerm:int = this.name_mt > this.name_JJ ? -1 : (this.name_mt < this.name_JJ ? 1 : 0);
         var world:PhysicsScene = this.body.scene;
         var weight:Number = this.mass * world.name_MX.length();
         var k:Number = this.name_mt != this.name_JJ && !(this.name_Tb || this.name_mq) && this.body.state.rotation.length() > this.maxTurnSpeed ? 0.1 : 1;
         this.name_Ei.addForces(dt,k * this.name_mt,this.maxSpeed,slipTerm,weight,this.name_CF,this.name_Tb);
         this.name_iA.addForces(dt,k * this.name_JJ,this.maxSpeed,slipTerm,weight,this.name_CF,this.name_mq);
         var baseMatrix:Matrix3 = this.body.baseMatrix;
         if(this.name_iA.name_Ca >= this.name_iA.numRays >> 1 || this.name_Ei.name_Ca >= this.name_Ei.numRays >> 1)
         {
            d = world.name_MX.x * baseMatrix.c + world.name_MX.y * baseMatrix.g + world.name_MX.z * baseMatrix.k;
            limit = Math.SQRT1_2 * world.name_MX.length();
            if(d < -limit || d > limit)
            {
               _v.x = (baseMatrix.c * d - world.name_MX.x) * this.mass;
               _v.y = (baseMatrix.g * d - world.name_MX.y) * this.mass;
               _v.z = (baseMatrix.k * d - world.name_MX.z) * this.mass;
               this.body.addForce(_v);
            }
         }
      }
      
      public function updateAfterSimulation(physicsStep:int) : void
      {
      }
      
      public function interpolate(interpolationCoeff:Number) : void
      {
         this.body.interpolate(interpolationCoeff,this.name_bi,this.name_UQ);
         this.name_UQ.normalize();
         this.name_UQ.toMatrix4(this.name_YH);
         this.name_YH.setPosition(this.name_bi);
      }
      
      public function setSimpleCollisionMask(mask:int) : void
      {
         for(var i:int = 0; i < this.name_i1.length; i++)
         {
            this.name_i1[i].collisionMask = mask;
         }
      }
      
      public function setDetailedCollisionGroup(collisionGroup:int) : void
      {
         var collisionPrimitive:CollisionPrimitive = null;
         for each(collisionPrimitive in this.name_DC)
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
         this.name_Ei.collisionMask = collisionMask;
         this.name_iA.collisionMask = collisionMask;
      }
      
      public function addToScene() : void
      {
         var physicsSystem:PhysicsSystem = null;
         var physicsScene:PhysicsScene = null;
         var collisionDetector:ITanksCollisionDetector = null;
         if(!this.name_case)
         {
            physicsSystem = this.gameKernel.getPhysicsSystem();
            physicsScene = physicsSystem.getPhysicsScene();
            collisionDetector = ITanksCollisionDetector(physicsScene.collisionDetector);
            physicsScene.addBody(this.body);
            collisionDetector.addBodyCollisionData(this.name_Rg);
            physicsSystem.addControllerBefore(this);
            this.name_case = true;
         }
      }
      
      public function removeFromScene() : void
      {
         var physicsSystem:PhysicsSystem = null;
         var physicsScene:PhysicsScene = null;
         var collisionDetector:ITanksCollisionDetector = null;
         if(this.name_case)
         {
            physicsSystem = this.gameKernel.getPhysicsSystem();
            physicsScene = physicsSystem.getPhysicsScene();
            collisionDetector = ITanksCollisionDetector(physicsScene.collisionDetector);
            physicsScene.removeBody(this.body);
            collisionDetector.removeBodyCollisionData(this.name_Rg);
            physicsSystem.removeControllerBefore(this);
            this.name_case = false;
         }
      }
      
      private function setMass(value:Number) : void
      {
         if(value <= 0)
         {
            throw new ArgumentError("Mass must have a positive value");
         }
         this.body.invMass = 1 / value;
         if(this.hull != null)
         {
            PhysicsUtils.getBoxInvInertia(value,this.hull.name_eh.hs,this.body.invInertia);
         }
      }
      
      private function createPrimitives(geometryData:Vector.<BoxData>, primitives:Vector.<CollisionPrimitive>, collisionGroup:int, collisionMask:int) : void
      {
         var boxData:BoxData = null;
         var primitive:CollisionBox = null;
         primitives.length = 0;
         for each(boxData in geometryData)
         {
            primitive = new CollisionBox(boxData.hs,collisionGroup,collisionMask);
            primitive.localTransform = boxData.matrix.clone();
            primitive.body = this.body;
            primitives.push(primitive);
         }
      }
      
      private function addPrimitivesToBody(primitives:Vector.<CollisionPrimitive>) : void
      {
         var collisionPrimitive:CollisionPrimitive = null;
         for each(collisionPrimitive in primitives)
         {
            this.body.addCollisionPrimitive(collisionPrimitive,collisionPrimitive.localTransform);
         }
      }
      
      private function onBattleFinished(gameType:String, gameData:*) : void
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
