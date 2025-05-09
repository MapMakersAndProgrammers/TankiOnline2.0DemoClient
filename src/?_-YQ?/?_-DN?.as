package §_-YQ§
{
   import §_-Ex§.§_-5P§;
   import §_-I0§.§_-Jv§;
   import §_-O5§.§_-Hk§;
   import §_-RG§.A3DMapComponent;
   import §_-az§.§_-AG§;
   import §_-az§.§_-gw§;
   import §_-az§.§_-ps§;
   import §_-cv§.§_-YU§;
   import §_-cv§.§_-cP§;
   import §_-cv§.§_-dD§;
   import §_-e6§.§_-1I§;
   import flash.display.DisplayObjectContainer;
   
   public class §_-DN§ extends §_-ps§
   {
      private var gameKernel:§_-AG§;
      
      private var config:§_-YU§;
      
      private var container:DisplayObjectContainer;
      
      private var preloader:Preloader;
      
      public function §_-DN§(param1:§_-AG§, param2:§_-YU§, param3:DisplayObjectContainer, param4:Preloader)
      {
         super(§_-AG§.EVENT_SYSTEM_PRIORITY + 1);
         this.gameKernel = param1;
         this.config = param2;
         this.preloader = param4;
         this.container = param3;
      }
      
      override public function run() : void
      {
         var _loc1_:§_-1I§ = this.gameKernel.§_-DZ§();
         var _loc2_:§_-Jv§ = new §_-Jv§(_loc1_.§_-GW§(),this.gameKernel.§_-Ku§());
         _loc1_.§_-N8§(_loc2_);
         _loc2_.§_-oa§(0,0,1000);
         _loc2_.§_-38§(0,2000,0);
         this.container.addChild(_loc1_.§_-0D§());
         var _loc3_:§_-gw§ = this.§_-pL§();
         this.gameKernel.§_-oR§(_loc3_);
         this.preloader.§_-QU§(0.75);
         §_-Uw§.addTask(new §_-A3§(§_-AG§.INPUT_SYSTEM_PRIORITY + 1,this.config,this.gameKernel,_loc2_,this.preloader));
         §_-Uw§.killTask(this);
      }
      
      private function §_-pL§() : §_-gw§
      {
         var _loc2_:§_-Hk§ = null;
         var _loc6_:§_-dD§ = null;
         var _loc7_:String = null;
         var _loc3_:§_-cP§ = this.config.§_-WG§.§_-hJ§("skybox");
         if(_loc3_ != null)
         {
            _loc2_ = new §_-Hk§();
            _loc6_ = _loc3_.§_-EZ§(this.config.§_-f§());
            for each(_loc7_ in [§_-5P§.BACK,§_-5P§.BOTTOM,§_-5P§.FRONT,§_-5P§.LEFT,§_-5P§.RIGHT,§_-5P§.TOP])
            {
               _loc2_.§_-9v§(_loc7_,_loc6_.§_-Vf§(_loc7_));
            }
         }
         var _loc4_:§_-gw§ = new §_-gw§(§_-gw§.§_-9o§());
         var _loc5_:A3DMapComponent = new A3DMapComponent(this.config.mapData,_loc2_,1000000,new MapListener(this.gameKernel.§_-Ev§()));
         _loc4_.§_-2d§(_loc5_);
         _loc4_.§_-m7§();
         return _loc4_;
      }
   }
}

import §_-RG§.§_-7J§;
import §_-az§.§_-Ss§;
import §_-j-§.§_-B7§;

class MapListener implements §_-7J§
{
   private var eventSystem:§_-B7§;
   
   public function MapListener(param1:§_-B7§)
   {
      super();
      this.eventSystem = param1;
   }
   
   public function onA3DMapComplete() : void
   {
      this.eventSystem.dispatchEvent(§_-Ss§.MAP_COMPLETE,null);
   }
}
