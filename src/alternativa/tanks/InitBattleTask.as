package alternativa.tanks
{
   import alternativa.engine3d.objects.SkyBox;
   import alternativa.tanks.config.BlobCategory;
   import alternativa.tanks.config.BlobGroup;
   import alternativa.tanks.config.Config;
   import alternativa.tanks.game.Entity;
   import alternativa.tanks.game.GameKernel;
   import alternativa.tanks.game.GameTask;
   import alternativa.tanks.game.camera.FreeCameraController;
   import alternativa.tanks.game.entities.map.A3DMapComponent;
   import alternativa.tanks.game.subsystems.rendersystem.RenderSystem;
   import alternativa.utils.ByteArrayMap;
   import flash.display.DisplayObjectContainer;
   
   public class InitBattleTask extends GameTask
   {
      private var gameKernel:GameKernel;
      
      private var config:Config;
      
      private var container:DisplayObjectContainer;
      
      private var preloader:Preloader;
      
      public function InitBattleTask(param1:GameKernel, param2:Config, param3:DisplayObjectContainer, param4:Preloader)
      {
         super(GameKernel.EVENT_SYSTEM_PRIORITY + 1);
         this.gameKernel = param1;
         this.config = param2;
         this.preloader = param4;
         this.container = param3;
      }
      
      override public function run() : void
      {
         var _loc1_:RenderSystem = this.gameKernel.getRenderSystem();
         var _loc2_:FreeCameraController = new FreeCameraController(_loc1_.getCamera(),this.gameKernel.getInputSystem());
         _loc1_.setCameraController(_loc2_);
         _loc2_.setPositionXYZ(0,0,1000);
         _loc2_.lookAtXYZ(0,2000,0);
         this.container.addChild(_loc1_.getView());
         var _loc3_:Entity = this.createMapEntity();
         this.gameKernel.addEntity(_loc3_);
         this.preloader.setProgress(0.75);
         §_-Uw§.addTask(new TankTestTask(GameKernel.INPUT_SYSTEM_PRIORITY + 1,this.config,this.gameKernel,_loc2_,this.preloader));
         §_-Uw§.killTask(this);
      }
      
      private function createMapEntity() : Entity
      {
         var _loc2_:ByteArrayMap = null;
         var _loc6_:BlobGroup = null;
         var _loc7_:String = null;
         var _loc3_:BlobCategory = this.config.§_-WG§.getCategory("skybox");
         if(_loc3_ != null)
         {
            _loc2_ = new ByteArrayMap();
            _loc6_ = _loc3_.getGroup(this.config.getSkyboxId());
            for each(_loc7_ in [SkyBox.BACK,SkyBox.BOTTOM,SkyBox.FRONT,SkyBox.LEFT,SkyBox.RIGHT,SkyBox.TOP])
            {
               _loc2_.putValue(_loc7_,_loc6_.getBlob(_loc7_));
            }
         }
         var _loc4_:Entity = new Entity(Entity.generateId());
         var _loc5_:A3DMapComponent = new A3DMapComponent(this.config.mapData,_loc2_,1000000,new MapListener(this.gameKernel.getEventSystem()));
         _loc4_.addComponent(_loc5_);
         _loc4_.initComponents();
         return _loc4_;
      }
   }
}

import alternativa.tanks.game.GameEvents;
import alternativa.tanks.game.entities.map.IA3DMapComponentListener;
import alternativa.tanks.game.subsystems.eventsystem.IEventSystem;

class MapListener implements IA3DMapComponentListener
{
   private var eventSystem:IEventSystem;
   
   public function MapListener(param1:IEventSystem)
   {
      super();
      this.eventSystem = param1;
   }
   
   public function onA3DMapComplete() : void
   {
      this.eventSystem.dispatchEvent(GameEvents.MAP_COMPLETE,null);
   }
}
