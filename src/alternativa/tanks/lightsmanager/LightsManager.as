package alternativa.tanks.lightsmanager
{
   import alternativa.osgi.OSGi;
   import alternativa.osgi.service.console.IConsole;
   import alternativa.tanks.game.subsystems.rendersystem.RenderSystem;
   
   public class LightsManager
   {
      private static const LIGHT_TYPE_AMBIENT:String = "a";
      
      private static const LIGHT_TYPE_DIRECTIONAL:String = "d";
      
      private static const LIGHT_TYPE_OMNI:String = "o";
      
      private static const LIGHT_TYPE_SPOT:String = "s";
      
      private var renderSystem:RenderSystem;
      
      private var §_-02§:Object = {};
      
      public function LightsManager(param1:RenderSystem)
      {
         super();
         this.renderSystem = param1;
         var _loc2_:IConsole = IConsole(OSGi.getInstance().getService(IConsole));
         _loc2_.setCommandHandler("light",this.lightCommandHandler);
         this.§_-02§[LIGHT_TYPE_AMBIENT] = new AmbientLightRegistry(param1);
         this.§_-02§[LIGHT_TYPE_DIRECTIONAL] = new DirectionalLightRegistry(param1);
         this.§_-02§[LIGHT_TYPE_OMNI] = new OmniLightRegistry(param1);
         this.§_-02§[LIGHT_TYPE_SPOT] = new SpotLightRegistry(param1);
      }
      
      private function lightCommandHandler(param1:IConsole, param2:Array) : void
      {
         var _loc3_:String = null;
         var _loc4_:LightsRegistry = null;
         if(param2.length != 0)
         {
            _loc3_ = param2.shift();
            _loc4_ = this.§_-02§[_loc3_];
            if(_loc4_ == null)
            {
               param1.addText("Unknown light type");
            }
            else
            {
               _loc4_.handleCommand(param1,param2);
            }
         }
      }
   }
}

