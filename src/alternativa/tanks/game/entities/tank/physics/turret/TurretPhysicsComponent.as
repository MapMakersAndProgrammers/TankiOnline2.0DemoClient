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
      public var §_-JR§:Number;
      
      private var turnDirection:int;
      
      private var direction:Number = 0;
      
      private var §_-De§:Number = 0;
      
      private var maxRotationSpeed:Number = 0;
      
      private var rotationAcceleration:Number = 0;
      
      private var §_-nr§:Number = 0;
      
      private var §_-fV§:Boolean;
      
      private var chassisComponent:IChassisPhysicsComponent;
      
      private var gameKernel:GameKernel;
      
      private var turret:TankTurret;
      
      private var primitives:Vector.<CollisionPrimitive>;
      
      private var §_-CH§:Vector3;
      
      private var §case §:Boolean;
      
      private var §_-z§:EventStates;
      
      private var §_-pP§:Matrix4 = new Matrix4();
      
      public function TurretPhysicsComponent(turret:TankTurret, maxRotationSpeed:Number, rotationAcceleration:Number)
      {
         super();
         this.maxRotationSpeed = maxRotationSpeed;
         this.rotationAcceleration = rotationAcceleration;
         this.primitives = new Vector.<CollisionPrimitive>();
         this.§_-CH§ = new Vector3();
         this.setTurret(turret);
      }
      
      override public function addToGame(gameKernel:GameKernel) : void
      {
         this.gameKernel = gameKernel;
      }
      
      override public function initComponent() : void
      {
         this.chassisComponent = IChassisPhysicsComponent(entity.getComponentStrict(IChassisPhysicsComponent));
         this.chassisComponent.getTurretMountPoint(this.§_-CH§);
         this.chassisComponent.setTurret(this);
         this.updatePrimitves();
         InterpolationComponent(entity.getComponentStrict(InterpolationComponent)).setTurretController(this);
         this.§_-z§ = new EventStates();
         this.§_-z§.setEventState(entity,TankEvents.SET_RESPAWN_STATE,new RespawnState(this));
         var activeState:ActiveState = new ActiveState(this);
         this.§_-z§.setEventState(entity,TankEvents.SET_ACTIVATING_STATE,activeState);
         this.§_-z§.setEventState(entity,TankEvents.SET_ACTIVE_STATE,activeState);
         this.§_-z§.setEventState(entity,TankEvents.SET_DEAD_STATE,new DeadState(this));
         this.§_-z§.§_-Ah§ = EmptyState.INSTANCE;
         entity.addEventHandler(GameEvents.BATTLE_FINISHED,this.onBattleFinished);
      }
      
      public function getBarrelCount() : int
      {
         return this.turret.§_-O3§.length;
      }
      
      public function getGunData(barrelIndex:int, barrelOrigin:Vector3, gunDirection:Vector3, gunElevationAxis:Vector3) : void
      {
         var muzzlePoint:Vector3 = this.getLocalMuzzlePoint(barrelIndex);
         barrelOrigin.reset(muzzlePoint.x,0,muzzlePoint.z);
         barrelOrigin.transform4(this.§_-pP§);
         this.§_-pP§.getAxis(0,gunElevationAxis);
         this.§_-pP§.getAxis(1,gunDirection);
      }
      
      public function getGunMuzzleData(barrelIndex:int, muzzlePosition:Vector3, gunDirection:Vector3) : void
      {
         var localMuzzlePoint:Vector3 = this.getLocalMuzzlePoint(barrelIndex);
         this.§_-pP§.transformPoint(localMuzzlePoint,muzzlePosition);
         this.§_-pP§.getAxis(1,gunDirection);
      }
      
      public function getGunMuzzleData2(barrelIndex:int, barrelOrigin:Vector3, muzzlePosition:Vector3) : void
      {
         var localMuzzlePoint:Vector3 = this.getLocalMuzzlePoint(barrelIndex);
         barrelOrigin.reset(localMuzzlePoint.x,0,localMuzzlePoint.z);
         barrelOrigin.transform4(this.§_-pP§);
         this.§_-pP§.transformPoint(localMuzzlePoint,muzzlePosition);
      }
      
      public function getBarrelLength(barrelIndex:int) : Number
      {
         return this.turret.§_-O3§[barrelIndex].y;
      }
      
      public function getInterpolatedTurretDirection() : Number
      {
         return this.§_-JR§;
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
         this.§_-CH§.copy(point);
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
         this.§_-fV§ = false;
         return true;
      }
      
      public function centerTurret(value:Boolean) : void
      {
         this.§_-fV§ = value;
      }
      
      public function getTurretPrimitives() : Vector.<CollisionPrimitive>
      {
         return this.primitives;
      }
      
      public function updateBeforeSimulation(physicsStep:int) : void
      {
         var _loc2_:Number = NaN;
         this.§_-De§ = this.direction;
         if(!this.§_-fV§ && this.turnDirection == 0)
         {
            this.§_-nr§ = 0;
         }
         else
         {
            _loc2_ = 0.001 * physicsStep;
            this.§_-nr§ += this.rotationAcceleration * _loc2_;
            if(this.§_-nr§ > this.maxRotationSpeed)
            {
               this.§_-nr§ = this.maxRotationSpeed;
            }
            if(this.§_-fV§)
            {
               this.direction = GameMathUtils.advanceValueTowards(this.direction,0,this.§_-nr§ * _loc2_);
               if(this.direction == 0)
               {
                  this.§_-fV§ = false;
               }
               this.updatePrimitves();
            }
            else
            {
               this.setTurretDirection(this.direction + this.turnDirection * this.§_-nr§ * _loc2_);
            }
         }
      }
      
      public function updateAfterSimulation(physicsStep:int) : void
      {
      }
      
      public function interpolate(interpolationCoeff:Number) : void
      {
         var angleDiff:Number = this.direction - this.§_-De§;
         if(angleDiff > Math.PI)
         {
            angleDiff = 2 * Math.PI - angleDiff;
            this.§_-JR§ = this.§_-De§ - angleDiff * interpolationCoeff;
            if(this.§_-JR§ < -Math.PI)
            {
               this.§_-JR§ += 2 * Math.PI;
            }
         }
         else if(angleDiff < -Math.PI)
         {
            angleDiff += 2 * Math.PI;
            this.§_-JR§ = this.§_-De§ + angleDiff * interpolationCoeff;
            if(this.§_-JR§ > Math.PI)
            {
               this.§_-JR§ -= 2 * Math.PI;
            }
         }
         else
         {
            this.§_-JR§ = this.§_-De§ * (1 - interpolationCoeff) + this.direction * interpolationCoeff;
         }
         this.§_-pP§.toIdentity();
         this.§_-pP§.setRotationMatrix(0,0,this.§_-JR§);
         this.§_-pP§.setPosition(this.§_-CH§);
         this.§_-pP§.append(this.chassisComponent.getInterpolatedMatrix());
      }
      
      internal function addToScene() : void
      {
         if(!this.§case §)
         {
            this.gameKernel.getPhysicsSystem().addControllerBefore(this);
            this.§case § = true;
         }
      }
      
      internal function removeFromScene() : void
      {
         if(this.§case §)
         {
            this.gameKernel.getPhysicsSystem().removeControllerBefore(this);
            this.§case § = false;
         }
      }
      
      private function getLocalMuzzlePoint(barrelIndex:int) : Vector3
      {
         return this.turret.§_-O3§[barrelIndex];
      }
      
      private function createTurretPrimitives(collisionGroup:int, collisionMask:int) : void
      {
         var boxData:BoxData = null;
         var collisioinBox:TurretCollisioinBox = null;
         this.primitives.length = 0;
         for each(boxData in this.turret.§_-Of§)
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
            m.d = this.§_-CH§.x;
            m.h = this.§_-CH§.y;
            m.l = this.§_-CH§.z;
            m.prepend(collisionPrimitive.m);
         }
      }
      
      private function onBattleFinished(gameType:String, gameData:*) : void
      {
         this.setTurretControls(0);
      }
   }
}

