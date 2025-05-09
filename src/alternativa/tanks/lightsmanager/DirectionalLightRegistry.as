package alternativa.tanks.lightsmanager
{
   import alternativa.engine3d.core.Light3D;
   import alternativa.engine3d.lights.DirectionalLight;
   import alternativa.osgi.service.console.IConsole;
   import alternativa.tanks.game.subsystems.rendersystem.RenderSystem;
   
   public class DirectionalLightRegistry extends LightsRegistry
   {
      public function DirectionalLightRegistry(param1:RenderSystem)
      {
         super(param1);
      }
      
      override protected function getLigts() : Vector.<Light3D>
      {
         return Vector.<Light3D>(renderSystem.lights.directionalLigths.lights);
      }
      
      override protected function del(param1:IConsole, param2:String) : Light3D
      {
         var _loc3_:DirectionalLight = this.getLight(param2);
         if(_loc3_ != null)
         {
            renderSystem.lights.directionalLigths.remove(_loc3_);
         }
         return _loc3_;
      }
      
      private function getLight(param1:String) : DirectionalLight
      {
         var _loc3_:DirectionalLight = null;
         var _loc2_:Vector.<DirectionalLight> = renderSystem.lights.directionalLigths.lights;
         if(_loc2_ != null)
         {
            for each(_loc3_ in _loc2_)
            {
               if(_loc3_.name == param1)
               {
                  return _loc3_;
               }
            }
         }
         return null;
      }
   }
}

