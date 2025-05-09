package alternativa.tanks.lightsmanager
{
   import alternativa.engine3d.core.Light3D;
   import alternativa.engine3d.lights.OmniLight;
   import alternativa.osgi.service.console.IConsole;
   import alternativa.tanks.game.subsystems.rendersystem.RenderSystem;
   import alternativa.utils.TextUtils;
   
   public class OmniLightRegistry extends LightsRegistry
   {
      public function OmniLightRegistry(param1:RenderSystem)
      {
         super(param1);
      }
      
      override protected function lightToString(param1:Light3D) : String
      {
         var _loc2_:OmniLight = OmniLight(param1);
         return TextUtils.replaceVars("OmniLight color: 0x%1, attenuationBegin: %2, attenuationEnd: %3, x: %4, y: %5, z: %6",_loc2_.color.toString(16),_loc2_.attenuationBegin.toFixed(2),_loc2_.attenuationEnd.toFixed(2),_loc2_.x.toFixed(2),_loc2_.y.toFixed(2),_loc2_.z.toFixed(2));
      }
      
      override protected function modify(param1:IConsole, param2:String, param3:Array) : Light3D
      {
         var _loc4_:OmniLight = this.getLight(param2);
         if(_loc4_ == null)
         {
            return null;
         }
         var _loc5_:String = param3.shift();
         switch(_loc5_)
         {
            case "pos":
               _loc4_.x = param3[0];
               _loc4_.y = param3[1];
               _loc4_.z = param3[2];
               break;
            case "color":
               _loc4_.color = param3[0];
               break;
            case "att":
               _loc4_.attenuationBegin = parseNumber(param3[0]);
               _loc4_.attenuationEnd = parseNumber(param3[1]);
               break;
            default:
               param1.addLines(Vector.<String>(["Available commands:","color value","pos x y z","att attenuationBegin attenuationEnd"]));
               return null;
         }
         return _loc4_;
      }
      
      override protected function create(param1:IConsole, param2:Array, param3:int) : Light3D
      {
         if(param2.length == 0)
         {
            param1.addText("parameters: color attenuationBegin attenuationEnd x y z");
            return null;
         }
         var _loc4_:uint = uint(param2[0]);
         var _loc5_:Number = parseNumber(param2[1]);
         var _loc6_:Number = parseNumber(param2[2]);
         var _loc7_:OmniLight = new OmniLight(_loc4_,_loc5_,_loc6_);
         _loc7_.name = "Omni_" + param3;
         _loc7_.x = parseNumber(param2[3]);
         _loc7_.y = parseNumber(param2[4]);
         _loc7_.z = parseNumber(param2[5]);
         renderSystem.lights.omniLigths.add(_loc7_);
         return _loc7_;
      }
      
      override protected function getLigts() : Vector.<Light3D>
      {
         return Vector.<Light3D>(renderSystem.lights.omniLigths.lights);
      }
      
      override protected function del(param1:IConsole, param2:String) : Light3D
      {
         var _loc3_:OmniLight = this.getLight(param2);
         if(_loc3_ != null)
         {
            renderSystem.lights.omniLigths.remove(OmniLight(_loc3_));
         }
         return _loc3_;
      }
      
      private function getLight(param1:String) : OmniLight
      {
         var _loc3_:OmniLight = null;
         var _loc2_:Vector.<OmniLight> = renderSystem.lights.omniLigths.lights;
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

