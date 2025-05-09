package alternativa.tanks.game.entities.tank.physics.turret
{
   import alternativa.math.Matrix4;
   import alternativa.math.Vector3;
   import alternativa.physics.collision.CollisionPrimitive;
   import alternativa.tanks.game.EntityComponent;
   import alternativa.tanks.game.GameEvents;
   import alternativa.tanks.game.GameKernel;
   import alternativa.tanks.game.entities.EmptyState;
   import alternativa.tanks.game.entities.EventStates;
   import alternativa.tanks.game.entities.tank.TankEvents;
   import alternativa.tanks.game.entities.tank.TankTurret;
   import alternativa.tanks.game.entities.tank.physics.IChassisPhysicsComponent;
   import alternativa.tanks.game.entities.tank.physics.ITurretPhysicsComponent;
   import alternativa.tanks.game.entities.tank.physics.InterpolationComponent;
   import alternativa.tanks.game.physics.BoxData;
   import alternativa.tanks.game.physics.CollisionGroup;
   import alternativa.tanks.game.physics.TurretCollisioinBox;
   import alternativa.tanks.game.subsystems.physicssystem.IPhysicsController;
   import alternativa.tanks.game.utils.GameMathUtils;
   
   public class TurretPhysicsComponent extends EntityComponent implements ITurretPhysicsComponent, IPhysicsController
   {
      public var var_430:Number;
      
      private var turnDirection:int;
      
      private var direction:Number = 0;
      
      private var var_433:Number = 0;
      
      private var maxRotationSpeed:Number = 0;
      
      private var rotationAcceleration:Number = 0;
      
      private var var_432:Number = 0;
      
      private var var_434:Boolean;
      
      private var chassisComponent:IChassisPhysicsComponent;
      
      private var gameKernel:GameKernel;
      
      private var turret:TankTurret;
      
      private var primitives:Vector.<CollisionPrimitive>;
      
      private var var_431:Vector3;
      
      private var var_426:Boolean;
      
      private var var_424:EventStates;
      
      private var var_429:Matrix4 = new Matrix4();
      
      public function TurretPhysicsComponent(turret:TankTurret, maxRotationSpeed:Number, rotationAcceleration:Number)
      {
         super();
         this.maxRotationSpeed = maxRotationSpeed;
         this.rotationAcceleration = rotationAcceleration;
         this.primitives = new Vector.<CollisionPrimitive>();
         this.var_431 = new Vector3();
         this.setTurret(turret);
      }
      
      override public function addToGame(gameKernel:GameKernel) : void
      {
         this.gameKernel = gameKernel;
      }
      
      override public function initComponent() : void
      {
         this.chassisComponent = IChassisPhysicsComponent(entity.getComponentStrict(IChassisPhysicsComponent));
         this.chassisComponent.getTurretMountPoint(this.var_431);
         this.chassisComponent.setTurret(this);
         this.updatePrimitves();
         InterpolationComponent(entity.getComponentStrict(InterpolationComponent)).setTurretController(this);
         this.var_424 = new EventStates();
         this.var_424.setEventState(entity,TankEvents.SET_RESPAWN_STATE,new RespawnState(this));
         var activeState:ActiveState = new ActiveState(this);
         this.var_424.setEventState(entity,TankEvents.SET_ACTIVATING_STATE,activeState);
         this.var_424.setEventState(entity,TankEvents.SET_ACTIVE_STATE,activeState);
         this.var_424.setEventState(entity,TankEvents.SET_DEAD_STATE,new DeadState(this));
         this.var_424.name_371 = EmptyState.INSTANCE;
         entity.addEventHandler(GameEvents.BATTLE_FINISHED,this.onBattleFinished);
      }
      
      public function getBarrelCount() : int
      {
         return this.turret.var_422.length;
      }
      
      public function getGunData(barrelIndex:int, barrelOrigin:Vector3, gunDirection:Vector3, gunElevationAxis:Vector3) : void
      {
         var muzzlePoint:Vector3 = this.getLocalMuzzlePoint(barrelIndex);
         barrelOrigin.reset(muzzlePoint.x,0,muzzlePoint.z);
         barrelOrigin.transform4(this.var_429);
         this.var_429.getAxis(0,gunElevationAxis);
         this.var_429.getAxis(1,gunDirection);
      }
      
      public function getGunMuzzleData(barrelIndex:int, muzzlePosition:Vector3, gunDirection:Vector3) : void
      {
         var localMuzzlePoint:Vector3 = this.getLocalMuzzlePoint(barrelIndex);
         this.var_429.transformPoint(localMuzzlePoint,muzzlePosition);
         this.var_429.getAxis(1,gunDirection);
      }
      
      public function getGunMuzzleData2(barrelIndex:int, barrelOrigin:Vector3, muzzlePosition:Vector3) : void
      {
         var localMuzzlePoint:Vector3 = this.getLocalMuzzlePoint(barrelIndex);
         barrelOrigin.reset(localMuzzlePoint.x,0,localMuzzlePoint.z);
         barrelOrigin.transform4(this.var_429);
         this.var_429.transformPoint(localMuzzlePoint,muzzlePosition);
      }
      
      public function getBarrelLength(barrelIndex:int) : Number
      {
         return this.turret.var_422[barrelIndex].y;
      }
      
      public function getInterpolatedTurretDirection() : Number
      {
         return this.var_430;
      }
      
      public function getChassisMatrix() : Matrix4
      {
         return this.chassisComponent.getInterpolatedMatrix();
      }
      
      public function getSkinMountPoint(vector:Vector3) : void
      {
         this.chassisComponent.getTurretSkinMountPoint(vector);
      }
      
      public function setTurret(turret:TankTurret) : void
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
         this.createTurretPrimitives(CollisionGroup.TANK,CollisionGroup.TANK | CollisionGroup.STATIC);
         if(this.chassisComponent != null)
         {
            this.chassisComponent.setTurret(this);
            this.updatePrimitves();
         }
      }
      
      public function setTurretMountPoint(point:Vector3) : void
      {
         this.var_431.copy(point);
         this.updatePrimitves();
      }
      
      public function getTurretDirection() : Number
      {
         return this.direction;
      }
      
      public function setTurretDirection(value:Number) : void
      {
         this.direction = GameMathUtils.clampAngle(value);
         this.updatePrimitves();
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
      
      public function getTurretPrimitives() : Vector.<CollisionPrimitive>
      {
         return this.primitives;
      }
      
      public function updateBeforeSimulation(physicsStep:int) : void
      {
         var _loc2_:Number = NaN;
         this.var_433 = this.direction;
         if(!this.var_434 && this.turnDirection == 0)
         {
            this.var_432 = 0;
         }
         else
         {
            _loc2_ = 0.001 * physicsStep;
            this.var_432 += this.rotationAcceleration * _loc2_;
            if(this.var_432 > this.maxRotationSpeed)
            {
               this.var_432 = this.maxRotationSpeed;
            }
            if(this.var_434)
            {
               this.direction = GameMathUtils.advanceValueTowards(this.direction,0,this.var_432 * _loc2_);
               if(this.direction == 0)
               {
                  this.var_434 = false;
               }
               this.updatePrimitves();
            }
            else
            {
               this.setTurretDirection(this.direction + this.turnDirection * this.var_432 * _loc2_);
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
         this.var_429.toIdentity();
         this.var_429.setRotationMatrix(0,0,this.var_430);
         this.var_429.setPosition(this.var_431);
         this.var_429.append(this.chassisComponent.getInterpolatedMatrix());
      }
      
      internal function addToScene() : void
      {
         if(!this.var_426)
         {
            this.gameKernel.getPhysicsSystem().addControllerBefore(this);
            this.var_426 = true;
         }
      }
      
      internal function removeFromScene() : void
      {
         if(this.var_426)
         {
            this.gameKernel.getPhysicsSystem().removeControllerBefore(this);
            this.var_426 = false;
         }
      }
      
      private function getLocalMuzzlePoint(barrelIndex:int) : Vector3
      {
         return this.turret.var_422[barrelIndex];
      }
      
      private function createTurretPrimitives(collisionGroup:int, collisionMask:int) : void
      {
         var boxData:BoxData = null;
         var collisioinBox:TurretCollisioinBox = null;
         this.primitives.length = 0;
         for each(boxData in this.turret.var_423)
         {
            collisioinBox = new TurretCollisioinBox(boxData.hs,boxData.matrix,collisionGroup,collisionMask);
            collisioinBox.localTransform = new Matrix4();
            this.primitives.push(collisioinBox);
         }
      }
      
      private function updatePrimitves() : void
      {
         var collisionPrimitive:TurretCollisioinBox = null;
         var m:Matrix4 = null;
         var actualDirection:Number = -this.direction;
         var cos:Number = Number(Math.cos(actualDirection));
         var sin:Number = Number(Math.sin(actualDirection));
         var numPrimitives:uint = uint(this.primitives.length);
         for(var i:int = 0; i < numPrimitives; i++)
         {
            collisionPrimitive = TurretCollisioinBox(this.primitives[i]);
            m = collisionPrimitive.localTransform;
            m.toIdentity();
            m.a = cos;
            m.b = sin;
            m.e = -sin;
            m.f = cos;
            m.d = this.var_431.x;
            m.h = this.var_431.y;
            m.l = this.var_431.z;
            m.prepend(collisionPrimitive.m);
         }
      }
      
      private function onBattleFinished(gameType:String, gameData:*) : void
      {
         this.setTurretControls(0);
      }
   }
}

