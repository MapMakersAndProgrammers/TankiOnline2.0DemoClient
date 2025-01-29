package alternativa.tanks
{
   import flash.display.DisplayObjectContainer;
   import alternativa.tanks.game.GameTask;
   import alternativa.tanks.game.GameKernel;
   import alternativa.tanks.game.Entity;
   import alternativa.tanks.config.Config;
   import alternativa.tanks.config.BlobGroup;
   import alternativa.tanks.config.BlobCategory;
   import alternativa.utils.ByteArrayMap;
   import package_18.name_44;
   import package_19.name_53;
   import alternativa.tanks.game.entities.map.A3DMapComponent;
   import alternativa.tanks.game.camera.FreeCameraController;
   
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
         var _loc1_:name_44 = this.gameKernel.name_5();
         var _loc2_:FreeCameraController = new FreeCameraController(_loc1_.name_27(),this.gameKernel.name_66());
         _loc1_.name_63(_loc2_);
         _loc2_.name_75(0,0,1000);
         _loc2_.name_76(0,2000,0);
         this.container.addChild(_loc1_.name_71());
         var _loc3_:Entity = this.createMapEntity();
         this.gameKernel.name_73(_loc3_);
         this.preloader.name_69(0.75);
         var_4.addTask(new TankTestTask(GameKernel.INPUT_SYSTEM_PRIORITY + 1,this.config,this.gameKernel,_loc2_,this.preloader));
         var_4.killTask(this);
      }
      
      private function createMapEntity() : Entity
      {
         var _loc2_:ByteArrayMap = null;
         var _loc6_:BlobGroup = null;
         var _loc7_:String = null;
         var _loc3_:BlobCategory = this.config.name_68.name_72("skybox");
         if(_loc3_ != null)
         {
            _loc2_ = new ByteArrayMap();
            _loc6_ = _loc3_.name_62(this.config.name_67());
            for each(_loc7_ in [name_53.BACK,name_53.BOTTOM,name_53.FRONT,name_53.LEFT,name_53.RIGHT,name_53.TOP])
            {
               _loc2_.name_59(_loc7_,_loc6_.name_65(_loc7_));
            }
         }
         var _loc4_:Entity = new Entity(Entity.name_74());
         var _loc5_:A3DMapComponent = new A3DMapComponent(this.config.mapData,_loc2_,1000000,new MapListener(this.gameKernel.name_61()));
         _loc4_.name_60(_loc5_);
         _loc4_.name_64();
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
