package alternativa.tanks.game.weapons.ammunition.energy
{
   import alternativa.tanks.game.Entity;
   import alternativa.tanks.game.EntityComponent;
   import alternativa.tanks.game.weapons.EnergyShotType;
   import alternativa.tanks.game.weapons.IEnergyAmmunition;
   import alternativa.tanks.game.weapons.IGenericRound;
   import alternativa.tanks.game.weapons.IWeaponDistanceWeakening;
   
   public class EnergyAmmunitionComponent extends EntityComponent implements IEnergyAmmunition
   {
      private static var poolSize:int;
      
      private static var pool:Vector.<Entity> = new Vector.<Entity>();
      
      private var roundData:EnergyRoundData;
      
      private var callback:IEnergyRoundCallback;
      
      private var effectsFactory:IEnergyRoundEffectsFactory;
      
      public function EnergyAmmunitionComponent(radius:Number, roundSpeed:Number, maxRicochets:uint, impactForce:Number, weakening:IWeaponDistanceWeakening, effectsFactory:IEnergyRoundEffectsFactory, callback:IEnergyRoundCallback)
      {
         super();
         this.roundData = new EnergyRoundData(radius,roundSpeed,maxRicochets,impactForce,weakening);
         this.effectsFactory = effectsFactory;
         this.callback = callback;
      }
      
      public static function destroyRound(entity:Entity) : void
      {
         var _loc2_:* = poolSize++;
         pool[_loc2_] = entity;
      }
      
      public function getRound(shotType:EnergyShotType, maxRange:Number) : IGenericRound
      {
         var roundEntity:Entity = null;
         if(poolSize == 0)
         {
            roundEntity = this.createRound();
         }
         else
         {
            roundEntity = pool[--poolSize];
            pool[poolSize] = null;
         }
         var plasmaRoundComponent:EnergyRoundComponent = EnergyRoundComponent(roundEntity.getComponentStrict(EnergyRoundComponent));
         plasmaRoundComponent.init(shotType,this.roundData,maxRange,this.effectsFactory,this.callback);
         return plasmaRoundComponent;
      }
      
      private function createRound() : Entity
      {
         var entity:Entity = new Entity(Entity.generateId());
         var energyRoundComponent:EnergyRoundComponent = new EnergyRoundComponent();
         entity.addComponent(energyRoundComponent);
         entity.initComponents();
         return entity;
      }
      
      public function setCallback(callback:IEnergyRoundCallback) : void
      {
         this.callback = callback;
      }
   }
}

