package alternativa.tanks.lightsmanager
{
   import alternativa.engine3d.core.Light3D;
   import alternativa.engine3d.lights.AmbientLight;
   import alternativa.osgi.service.console.IConsole;
   import alternativa.tanks.game.subsystems.rendersystem.RenderSystem;
   
   public class AmbientLightRegistry extends LightsRegistry
   {
      public function AmbientLightRegistry(param1:RenderSystem)
      {
         super(param1);
      }
      
      override protected function lightToString(param1:Light3D) : String
      {
         return "AmbientLight color: 0x" + AmbientLight(param1).color.toString(16);
      }
      
      override protected function create(param1:IConsole, param2:Array, param3:int) : Light3D
      {
         var _loc4_:uint = 0;
         var _loc5_:AmbientLight = null;
         if(param2.length == 0)
         {
            param1.addText("Color is expected");
            return null;
         }
         _loc4_ = uint(param2[0]);
         _loc5_ = new AmbientLight(_loc4_);
         _loc5_.name = "Ambient_" + param3;
         renderSystem.lights.ambientLight = _loc5_;
         return _loc5_;
      }
      
      override protected function modify(param1:IConsole, param2:String, param3:Array) : Light3D
      {
         var _loc4_:AmbientLight = renderSystem.lights.ambientLight;
         if(_loc4_ != null)
         {
            if(param3[0] != "color")
            {
               param1.addText("Available commands:");
               param1.addText("color color_value");
            }
            else
            {
               _loc4_.color = param3[1];
            }
         }
         return _loc4_;
      }
      
      override protected function getLigts() : Vector.<Light3D>
      {
         return Vector.<Light3D>([renderSystem.lights.ambientLight]);
      }
      
      override protected function del(param1:IConsole, param2:String) : Light3D
      {
         var _loc3_:AmbientLight = renderSystem.lights.ambientLight;
         renderSystem.lights.ambientLight = null;
         return _loc3_;
      }
   }
}

