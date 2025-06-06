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
      public var name_JR:Number;
      
      private var turnDirection:int;
      
      private var direction:Number = 0;
      
      private var name_De:Number = 0;
      
      private var maxRotationSpeed:Number = 0;
      
      private var rotationAcceleration:Number = 0;
      
      private var name_nr:Number = 0;
      
      private var name_fV:Boolean;
      
      private var chassisComponent:IChassisPhysicsComponent;
      
      private var gameKernel:GameKernel;
      
      private var turret:TankTurret;
      
      private var primitives:Vector.<CollisionPrimitive>;
      
      private var name_CH:Vector3;
      
      private var name_case:Boolean;
      
      private var name_z:EventStates;
      
      private var name_pP:Matrix4 = new Matrix4();
      
      public function TurretPhysicsComponent(turret:TankTurret, maxRotationSpeed:Number, rotationAcceleration:Number)
      {
         super();
         this.maxRotationSpeed = maxRotationSpeed;
         this.rotationAcceleration = rotationAcceleration;
         this.primitives = new Vector.<CollisionPrimitive>();
         this.name_CH = new Vector3();
         this.setTurret(turret);
      }
      
      override public function addToGame(gameKernel:GameKernel) : void
      {
         this.gameKernel = gameKernel;
      }
      
      override public function initComponent() : void
      {
         this.chassisComponent = IChassisPhysicsComponent(entity.getComponentStrict(IChassisPhysicsComponent));
         this.chassisComponent.getTurretMountPoint(this.name_CH);
         this.chassisComponent.setTurret(this);
         this.updatePrimitves();
         InterpolationComponent(entity.getComponentStrict(InterpolationComponent)).setTurretController(this);
         this.name_z = new EventStates();
         this.name_z.setEventState(entity,TankEvents.SET_RESPAWN_STATE,new RespawnState(this));
         var activeState:ActiveState = new ActiveState(this);
         this.name_z.setEventState(entity,TankEvents.SET_ACTIVATING_STATE,activeState);
         this.name_z.setEventState(entity,TankEvents.SET_ACTIVE_STATE,activeState);
         this.name_z.setEventState(entity,TankEvents.SET_DEAD_STATE,new DeadState(this));
         this.name_z.name_Ah = EmptyState.INSTANCE;
         entity.addEventHandler(GameEvents.BATTLE_FINISHED,this.onBattleFinished);
      }
      
      public function getBarrelCount() : int
      {
         return this.turret.name_O3.length;
      }
      
      public function getGunData(barrelIndex:int, barrelOrigin:Vector3, gunDirection:Vector3, gunElevationAxis:Vector3) : void
      {
         var muzzlePoint:Vector3 = this.getLocalMuzzlePoint(barrelIndex);
         barrelOrigin.reset(muzzlePoint.x,0,muzzlePoint.z);
         barrelOrigin.transform4(this.name_pP);
         this.name_pP.getAxis(0,gunElevationAxis);
         this.name_pP.getAxis(1,gunDirection);
      }
      
      public function getGunMuzzleData(barrelIndex:int, muzzlePosition:Vector3, gunDirection:Vector3) : void
      {
         var localMuzzlePoint:Vector3 = this.getLocalMuzzlePoint(barrelIndex);
         this.name_pP.transformPoint(localMuzzlePoint,muzzlePosition);
         this.name_pP.getAxis(1,gunDirection);
      }
      
      public function getGunMuzzleData2(barrelIndex:int, barrelOrigin:Vector3, muzzlePosition:Vector3) : void
      {
         var localMuzzlePoint:Vector3 = this.getLocalMuzzlePoint(barrelIndex);
         barrelOrigin.reset(localMuzzlePoint.x,0,localMuzzlePoint.z);
         barrelOrigin.transform4(this.name_pP);
         this.name_pP.transformPoint(localMuzzlePoint,muzzlePosition);
      }
      
      public function getBarrelLength(barrelIndex:int) : Number
      {
         return this.turret.name_O3[barrelIndex].y;
      }
      
      public function getInterpolatedTurretDirection() : Number
      {
         return this.name_JR;
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
         this.name_CH.copy(point);
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
         this.name_fV = false;
         return true;
      }
      
      public function centerTurret(value:Boolean) : void
      {
         this.name_fV = value;
      }
      
      public function getTurretPrimitives() : Vector.<CollisionPrimitive>
      {
         return this.primitives;
      }
      
      public function updateBeforeSimulation(physicsStep:int) : void
      {
         var _loc2_:Number = NaN;
         this.name_De = this.direction;
         if(!this.name_fV && this.turnDirection == 0)
         {
            this.name_nr = 0;
         }
         else
         {
            _loc2_ = 0.001 * physicsStep;
            this.name_nr += this.rotationAcceleration * _loc2_;
            if(this.name_nr > this.maxRotationSpeed)
            {
               this.name_nr = this.maxRotationSpeed;
            }
            if(this.name_fV)
            {
               this.direction = GameMathUtils.advanceValueTowards(this.direction,0,this.name_nr * _loc2_);
               if(this.direction == 0)
               {
                  this.name_fV = false;
               }
               this.updatePrimitves();
            }
            else
            {
               this.setTurretDirection(this.direction + this.turnDirection * this.name_nr * _loc2_);
            }
         }
      }
      
      public function updateAfterSimulation(physicsStep:int) : void
      {
      }
      
      public function interpolate(interpolationCoeff:Number) : void
      {
         var angleDiff:Number = this.direction - this.name_De;
         if(angleDiff > Math.PI)
         {
            angleDiff = 2 * Math.PI - angleDiff;
            this.name_JR = this.name_De - angleDiff * interpolationCoeff;
            if(this.name_JR < -Math.PI)
            {
               this.name_JR += 2 * Math.PI;
            }
         }
         else if(angleDiff < -Math.PI)
         {
            angleDiff += 2 * Math.PI;
            this.name_JR = this.name_De + angleDiff * interpolationCoeff;
            if(this.name_JR > Math.PI)
            {
               this.name_JR -= 2 * Math.PI;
            }
         }
         else
         {
            this.name_JR = this.name_De * (1 - interpolationCoeff) + this.direction * interpolationCoeff;
         }
         this.name_pP.toIdentity();
         this.name_pP.setRotationMatrix(0,0,this.name_JR);
         this.name_pP.setPosition(this.name_CH);
         this.name_pP.append(this.chassisComponent.getInterpolatedMatrix());
      }
      
      internal function addToScene() : void
      {
         if(!this.name_case)
         {
            this.gameKernel.getPhysicsSystem().addControllerBefore(this);
            this.name_case = true;
         }
      }
      
      internal function removeFromScene() : void
      {
         if(this.name_case)
         {
            this.gameKernel.getPhysicsSystem().removeControllerBefore(this);
            this.name_case = false;
         }
      }
      
      private function getLocalMuzzlePoint(barrelIndex:int) : Vector3
      {
         return this.turret.name_O3[barrelIndex];
      }
      
      private function createTurretPrimitives(collisionGroup:int, collisionMask:int) : void
      {
         var boxData:BoxData = null;
         var collisioinBox:TurretCollisioinBox = null;
         this.primitives.length = 0;
         for each(boxData in this.turret.name_Of)
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
            m.d = this.name_CH.x;
            m.h = this.name_CH.y;
            m.l = this.name_CH.z;
            m.prepend(collisionPrimitive.m);
         }
      }
      
      private function onBattleFinished(gameType:String, gameData:*) : void
      {
         this.setTurretControls(0);
      }
   }
}

