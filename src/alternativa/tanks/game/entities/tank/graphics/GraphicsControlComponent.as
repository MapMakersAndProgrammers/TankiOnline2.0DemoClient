package alternativa.tanks.game.entities.tank.graphics
{
   import alternativa.engine3d.alternativa3d;
   import alternativa.tanks.game.EntityComponent;
   import alternativa.tanks.game.GameKernel;
   import alternativa.tanks.game.entities.EmptyState;
   import alternativa.tanks.game.entities.EventStates;
   import alternativa.tanks.game.entities.tank.TankEvents;
   import alternativa.tanks.game.subsystems.rendersystem.IRenderer;
   import alternativa.tanks.game.subsystems.rendersystem.RenderSystem;
   import alternativa.tanks.game.subsystems.timesystem.TimeSystem;
   
   use namespace alternativa3d;
   
   public class GraphicsControlComponent extends EntityComponent implements IRenderer
   {
      private var §_-z§:EventStates;
      
      private var components:Vector.<ITankGraphicsComponent>;
      
      private var §case §:Boolean;
      
      private var §_-DV§:Boolean;
      
      private var alpha:Number = 1;
      
      private var gameKernel:GameKernel;
      
      public function GraphicsControlComponent()
      {
         super();
         this.components = new Vector.<ITankGraphicsComponent>();
      }
      
      override public function initComponent() : void
      {
         this.§_-z§ = new EventStates();
         this.§_-z§.setEventState(entity,TankEvents.SET_ACTIVATING_STATE,new ActivatingState(this));
         this.§_-z§.setEventState(entity,TankEvents.SET_ACTIVE_STATE,new ActiveState(this));
         this.§_-z§.setEventState(entity,TankEvents.SET_DEAD_STATE,new DeadState(this));
         var respawnState:RespawnState = new RespawnState(this);
         this.§_-z§.setEventState(entity,TankEvents.SET_RESPAWN_STATE,respawnState);
         this.§_-z§.§_-Ah§ = EmptyState.INSTANCE;
      }
      
      override public function addToGame(gameKernel:GameKernel) : void
      {
         this.gameKernel = gameKernel;
      }
      
      public function addToScene() : void
      {
         var tankGraphicsComponent:ITankGraphicsComponent = null;
         var renderSystem:RenderSystem = null;
         if(!this.§case §)
         {
            for each(tankGraphicsComponent in this.components)
            {
               tankGraphicsComponent.addToScene();
            }
            renderSystem = this.gameKernel.getRenderSystem();
            renderSystem.addRenderer(this);
            this.§case § = true;
         }
         this.§_-DV§ = false;
         this.alpha = 1;
      }
      
      public function removeFromScene() : void
      {
         if(this.§case §)
         {
            this.§_-DV§ = true;
         }
      }
      
      public function doRemoveFromScene() : void
      {
         var tankGraphicsComponent:ITankGraphicsComponent = null;
         this.§_-DV§ = false;
         this.§case § = false;
         for each(tankGraphicsComponent in this.components)
         {
            tankGraphicsComponent.removeFromScene();
         }
         this.gameKernel.getRenderSystem().removeRenderer(this);
      }
      
      public function setMaterial(materialType:MaterialType) : void
      {
         var tankGraphicsComponent:ITankGraphicsComponent = null;
         for each(tankGraphicsComponent in this.components)
         {
            tankGraphicsComponent.setMaterial(materialType);
         }
      }
      
      public function addComponent(component:ITankGraphicsComponent) : void
      {
         this.components.push(component);
      }
      
      public function render() : void
      {
         var tankGraphicsComponent:ITankGraphicsComponent = null;
         if(this.§_-DV§)
         {
            if(this.alpha == 0)
            {
               this.doRemoveFromScene();
            }
            this.alpha -= TimeSystem.timeDeltaSeconds;
            if(this.alpha < 0)
            {
               this.alpha = 0;
            }
            for each(tankGraphicsComponent in this.components)
            {
               tankGraphicsComponent.setAlpha(this.alpha);
            }
         }
         var numComponents:int = int(this.components.length);
         for(var i:int = 0; i < numComponents; i++)
         {
            tankGraphicsComponent = this.components[i];
            tankGraphicsComponent.render();
         }
      }
   }
}

