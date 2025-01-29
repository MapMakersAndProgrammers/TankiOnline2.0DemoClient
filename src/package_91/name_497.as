package package_91
{
   import alternativa.tanks.game.EntityComponent;
   import alternativa.tanks.game.GameKernel;
   import package_27.name_501;
   import package_44.name_178;
   import package_44.name_465;
   import package_45.name_182;
   import package_46.Matrix3;
   import package_46.name_194;
   import alternativa.tanks.game.weapons.IGenericRound;
   import alternativa.tanks.game.weapons.EnergyShotType;
   import package_76.name_235;
   import package_76.name_256;
   import package_76.name_631;
   import package_86.name_257;
   import package_90.name_273;
   import package_92.name_271;
   
   public class name_497 extends EntityComponent implements name_465, IGenericRound, name_631
   {
      private static const NUM_PERIPHERAL_RAYS:int = 8;
      
      private static const RADIAL_ANGLE_STEP:Number = 2 * Math.PI / NUM_PERIPHERAL_RAYS;
      
      private static var rayHit:name_273 = new name_273();
      
      private static var _rotationMatrix:Matrix3 = new Matrix3();
      
      private static var _vector:name_194 = new name_194();
      
      private static var _normal:name_194 = new name_194();
      
      private var gameKernel:GameKernel;
      
      private var var_623:name_194 = new name_194();
      
      private var var_620:name_194 = new name_194();
      
      private var direction:name_194 = new name_194();
      
      private var var_621:Number;
      
      private var shotId:int;
      
      private var shooter:name_271;
      
      private var collisionDetector:name_256;
      
      private var callback:name_499;
      
      private var roundData:name_498;
      
      private var maxRange:Number;
      
      private var effect:name_522;
      
      private var shotType:EnergyShotType;
      
      private var ricochetCount:int;
      
      private var var_622:Vector.<name_194>;
      
      private var effectsFactory:name_349;
      
      public function name_497()
      {
         super();
         this.var_622 = new Vector.<name_194>(NUM_PERIPHERAL_RAYS);
         for(var i:int = 0; i < NUM_PERIPHERAL_RAYS; i++)
         {
            this.var_622[i] = new name_194();
         }
      }
      
      public function init(shotType:EnergyShotType, roundData:name_498, maxRange:Number, effectsFactory:name_349, callback:name_499) : void
      {
         this.shotType = shotType;
         this.roundData = roundData;
         this.maxRange = maxRange;
         this.callback = callback;
         this.effectsFactory = effectsFactory;
         this.ricochetCount = 0;
      }
      
      override public function initComponent() : void
      {
      }
      
      override public function addToGame(gameKernel:GameKernel) : void
      {
         this.gameKernel = gameKernel;
         var physicsSystem:name_178 = gameKernel.method_112();
         this.collisionDetector = physicsSystem.name_246().collisionDetector;
         physicsSystem.addControllerBefore(this);
         if(this.shotType == EnergyShotType.NORMAL_SHOT)
         {
            physicsSystem.method_330(this);
            this.effect = this.effectsFactory.method_414();
         }
      }
      
      override public function removeFromGame(gameKernel:GameKernel) : void
      {
         var physicsSystem:name_178 = gameKernel.method_112();
         physicsSystem.removeControllerBefore(this);
         this.gameKernel = null;
         this.roundData = null;
         this.effectsFactory = null;
         this.shooter = null;
         this.collisionDetector = null;
         if(this.effect != null)
         {
            physicsSystem.method_332(this);
            this.effect.method_255();
            this.effect = null;
         }
         name_296.method_382(entity);
      }
      
      public function name_664(primitive:name_235) : Boolean
      {
         return primitive.body != this.shooter;
      }
      
      public function updateBeforeSimulation(physicsStep:int) : void
      {
         var i:int = 0;
         var raycastResult:int = 0;
         var filter:name_631 = null;
         var hitTime:Number = NaN;
         var body:name_271 = null;
         var origin:name_194 = null;
         var impactForce:Number = NaN;
         var deltaDistance:Number = this.roundData.speed * name_182.timeDeltaSeconds;
         for(var frameDistance:Number = 0; deltaDistance > name_501.EPSILON; )
         {
            raycastResult = 0;
            filter = this.ricochetCount == 0 ? this : null;
            hitTime = deltaDistance + 1;
            body = null;
            if(this.collisionDetector.raycast(this.var_620,this.direction,name_257.WEAPON | name_257.STATIC,deltaDistance,filter,rayHit))
            {
               raycastResult = 1;
               hitTime = rayHit.t;
               body = rayHit.primitive.body;
               _normal.copy(rayHit.normal);
            }
            for(i = 0; i < NUM_PERIPHERAL_RAYS; )
            {
               origin = this.var_622[i];
               if(this.collisionDetector.raycast(origin,this.direction,name_257.WEAPON,deltaDistance,filter,rayHit))
               {
                  if(rayHit.t < hitTime)
                  {
                     raycastResult = 2;
                     hitTime = rayHit.t;
                     body = rayHit.primitive.body;
                     _normal.copy(rayHit.normal);
                  }
               }
               i++;
            }
            if(raycastResult <= 0)
            {
               this.var_621 += deltaDistance;
               if(this.var_621 > this.maxRange)
               {
                  this.gameKernel.method_109(entity);
               }
               else
               {
                  this.var_623.copy(this.var_620);
                  _vector.copy(this.direction).scale(deltaDistance);
                  this.var_620.add(_vector);
                  for(i = 0; i < NUM_PERIPHERAL_RAYS; i++)
                  {
                     name_194(this.var_622[i]).add(_vector);
                  }
               }
               return;
            }
            this.var_621 += hitTime;
            if(this.var_621 >= this.maxRange)
            {
               this.gameKernel.method_109(entity);
               return;
            }
            if(!(raycastResult == 1 && this.ricochetCount < this.roundData.maxRicochets && body == null))
            {
               this.effectsFactory.method_413(rayHit.position);
               if(body != null)
               {
                  impactForce = this.roundData.weakening.name_554(this.var_621) * this.roundData.impactForce;
                  body.name_556(rayHit.position,this.direction,impactForce);
                  if(this.callback != null)
                  {
                     this.callback.name_691(this.shotId,rayHit.position,this.var_621,body);
                  }
               }
               this.gameKernel.method_109(entity);
               return;
            }
            ++this.ricochetCount;
            frameDistance += hitTime;
            this.var_621 += hitTime;
            deltaDistance -= hitTime;
            _vector.copy(this.var_620).method_362(hitTime,this.direction);
            this.effectsFactory.method_412(_vector,_normal,this.direction);
            this.var_620.method_362(hitTime,this.direction).method_362(0.01,_normal);
            this.direction.method_362(-2 * this.direction.dot(_normal),_normal);
            this.var_623.copy(this.var_620).method_362(-frameDistance,this.direction);
            this.method_705(this.var_620,this.direction,this.roundData.radius);
         }
      }
      
      public function updateAfterSimulation(physicsStep:int) : void
      {
      }
      
      public function interpolate(interpolationCoeff:Number) : void
      {
         _vector.method_366(this.var_620,this.var_623).scale(interpolationCoeff).add(this.var_623);
         this.effect.name_201(_vector);
      }
      
      public function method_372(gameKernel:GameKernel, shotId:int, shooter:name_271, barrelOrigin:name_194, barrelLength:Number, shotDirection:name_194, muzzlePosition:name_194) : void
      {
         this.shotId = shotId;
         this.shooter = shooter;
         this.direction.copy(shotDirection);
         this.var_621 = 0;
         switch(this.shotType)
         {
            case EnergyShotType.CLOSE_SHOT:
               this.var_620.copy(barrelOrigin);
               break;
            case EnergyShotType.NORMAL_SHOT:
               this.var_620.copy(muzzlePosition);
         }
         this.method_705(this.var_620,shotDirection,this.roundData.radius);
         gameKernel.name_73(entity);
      }
      
      private function method_705(centerPoint:name_194, shotDirection:name_194, radius:Number) : void
      {
         var axis:int = 0;
         var min:Number = 10;
         var d:Number = shotDirection.x < 0 ? -shotDirection.x : shotDirection.x;
         if(d < min)
         {
            min = d;
            axis = 0;
         }
         d = shotDirection.y < 0 ? -shotDirection.y : shotDirection.y;
         if(d < min)
         {
            min = d;
            axis = 1;
         }
         d = shotDirection.z < 0 ? -shotDirection.z : shotDirection.z;
         if(d < min)
         {
            axis = 2;
         }
         var v:name_194 = new name_194();
         switch(axis)
         {
            case 0:
               v.x = 0;
               v.y = shotDirection.z;
               v.z = -shotDirection.y;
               break;
            case 1:
               v.x = -shotDirection.z;
               v.y = 0;
               v.z = shotDirection.x;
               break;
            case 2:
               v.x = shotDirection.y;
               v.y = -shotDirection.x;
               v.z = 0;
         }
         v.normalize().scale(radius);
         _rotationMatrix.method_344(shotDirection,RADIAL_ANGLE_STEP);
         name_194(this.var_622[0]).copy(centerPoint).add(v);
         for(var i:int = 1; i < NUM_PERIPHERAL_RAYS; i++)
         {
            v.transform3(_rotationMatrix);
            name_194(this.var_622[i]).copy(centerPoint).add(v);
         }
      }
   }
}

