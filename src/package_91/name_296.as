package package_91
{
   import alternativa.tanks.game.EntityComponent;
   import alternativa.tanks.game.Entity;
   import package_74.class_23;
   import package_74.name_233;
   import package_74.name_327;
   import package_74.name_496;
   
   public class name_296 extends EntityComponent implements class_23
   {
      private static var poolSize:int;
      
      private static var pool:Vector.<Entity> = new Vector.<Entity>();
      
      private var roundData:name_498;
      
      private var callback:name_499;
      
      private var effectsFactory:name_349;
      
      public function name_296(radius:Number, roundSpeed:Number, maxRicochets:uint, impactForce:Number, weakening:name_327, effectsFactory:name_349, callback:name_499)
      {
         super();
         this.roundData = new name_498(radius,roundSpeed,maxRicochets,impactForce,weakening);
         this.effectsFactory = effectsFactory;
         this.callback = callback;
      }
      
      public static function method_382(entity:Entity) : void
      {
         var _loc2_:* = poolSize++;
         pool[_loc2_] = entity;
      }
      
      public function getRound(shotType:name_496, maxRange:Number) : name_233
      {
         var roundEntity:Entity = null;
         if(poolSize == 0)
         {
            roundEntity = this.method_381();
         }
         else
         {
            roundEntity = pool[--poolSize];
            pool[poolSize] = null;
         }
         var plasmaRoundComponent:name_497 = name_497(roundEntity.getComponentStrict(name_497));
         plasmaRoundComponent.init(shotType,this.roundData,maxRange,this.effectsFactory,this.callback);
         return plasmaRoundComponent;
      }
      
      private function method_381() : Entity
      {
         var entity:Entity = new Entity(Entity.name_74());
         var energyRoundComponent:name_497 = new name_497();
         entity.name_60(energyRoundComponent);
         entity.name_64();
         return entity;
      }
      
      public function method_383(callback:name_499) : void
      {
         this.callback = callback;
      }
   }
}

