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
      private var name_z:EventStates;
      
      private var components:Vector.<ITankGraphicsComponent>;
      
      private var name_case:Boolean;
      
      private var name_DV:Boolean;
      
      private var alpha:Number = 1;
      
      private var gameKernel:GameKernel;
      
      public function GraphicsControlComponent()
      {
         super();
         this.components = new Vector.<ITankGraphicsComponent>();
      }
      
      override public function initComponent() : void
      {
         this.name_z = new EventStates();
         this.name_z.setEventState(entity,TankEvents.SET_ACTIVATING_STATE,new ActivatingState(this));
         this.name_z.setEventState(entity,TankEvents.SET_ACTIVE_STATE,new ActiveState(this));
         this.name_z.setEventState(entity,TankEvents.SET_DEAD_STATE,new DeadState(this));
         var respawnState:RespawnState = new RespawnState(this);
         this.name_z.setEventState(entity,TankEvents.SET_RESPAWN_STATE,respawnState);
         this.name_z.name_Ah = EmptyState.INSTANCE;
      }
      
      override public function addToGame(gameKernel:GameKernel) : void
      {
         this.gameKernel = gameKernel;
      }
      
      public function addToScene() : void
      {
         var tankGraphicsComponent:ITankGraphicsComponent = null;
         var renderSystem:RenderSystem = null;
         if(!this.name_case)
         {
            for each(tankGraphicsComponent in this.components)
            {
               tankGraphicsComponent.addToScene();
            }
            renderSystem = this.gameKernel.getRenderSystem();
            renderSystem.addRenderer(this);
            this.name_case = true;
         }
         this.name_DV = false;
         this.alpha = 1;
      }
      
      public function removeFromScene() : void
      {
         if(this.name_case)
         {
            this.name_DV = true;
         }
      }
      
      public function doRemoveFromScene() : void
      {
         var tankGraphicsComponent:ITankGraphicsComponent = null;
         this.name_DV = false;
         this.name_case = false;
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
         if(this.name_DV)
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

