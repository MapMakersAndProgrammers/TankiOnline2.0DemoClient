package alternativa.tanks.lightsmanager
{
   import alternativa.engine3d.core.Light3D;
   import alternativa.engine3d.lights.SpotLight;
   import alternativa.osgi.service.console.IConsole;
   import alternativa.tanks.game.subsystems.rendersystem.RenderSystem;
   import alternativa.utils.TextUtils;
   
   public class SpotLightRegistry extends LightsRegistry
   {
      public function SpotLightRegistry(param1:RenderSystem)
      {
         super(param1);
      }
      
      override protected function lightToString(param1:Light3D) : String
      {
         var _loc2_:SpotLight = SpotLight(param1);
         return TextUtils.replaceVars("SpotLight color: 0x%1, attenuationBegin: %2, attenuationEnd: %3, hotspot: %4, falloff: %5, x: %6, y: %7, z: %8",_loc2_.color.toString(16),_loc2_.attenuationBegin.toFixed(2),_loc2_.attenuationEnd.toFixed(2),_loc2_.hotspot.toFixed(2),_loc2_.falloff.toFixed(2),_loc2_.x.toFixed(2),_loc2_.y.toFixed(2),_loc2_.z.toFixed(2));
      }
      
      override protected function modify(param1:IConsole, param2:String, param3:Array) : Light3D
      {
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc4_:SpotLight = this.getLight(param2);
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
            case "cone":
               _loc4_.hotspot = parseNumber(param3[0],0);
               _loc4_.falloff = parseNumber(param3[1],0);
               break;
            case "lookAt":
               _loc6_ = parseNumber(param3[0],0);
               _loc7_ = parseNumber(param3[1],0);
               _loc8_ = parseNumber(param3[2],0);
               _loc4_.lookAt(_loc6_,_loc7_,_loc8_);
               param1.addText("Looking at " + _loc6_ + ", " + _loc7_ + ", " + _loc8_);
               break;
            case "att":
               _loc4_.attenuationBegin = parseNumber(param3[0]);
               _loc4_.attenuationEnd = parseNumber(param3[1]);
               break;
            default:
               param1.addLines(Vector.<String>(["Available commands:","color value","att attenuationBegin attenuationEnd","cone hotspot falloff","pos x y z","lookAt x y z"]));
               return null;
         }
         return _loc4_;
      }
      
      override protected function create(param1:IConsole, param2:Array, param3:int) : Light3D
      {
         if(param2.length == 0)
         {
            param1.addText("parameters: color attenuationBegin attenuationEnd hotspot falloff x y z lookX lookY lookZ");
            return null;
         }
         var _loc4_:int = int(param2[0]);
         var _loc5_:Number = parseNumber(param2[1]);
         var _loc6_:Number = parseNumber(param2[2]);
         var _loc7_:Number = parseNumber(param2[3]);
         var _loc8_:Number = parseNumber(param2[4]);
         var _loc9_:Number = parseNumber(param2[5]);
         var _loc10_:Number = parseNumber(param2[6]);
         var _loc11_:Number = parseNumber(param2[7]);
         var _loc12_:Number = parseNumber(param2[8]);
         var _loc13_:Number = parseNumber(param2[9]);
         var _loc14_:Number = parseNumber(param2[10]);
         var _loc15_:SpotLight = new SpotLight(_loc4_,_loc5_,_loc6_,_loc7_,_loc8_);
         _loc15_.name = "Spot_" + param3;
         _loc15_.x = _loc9_;
         _loc15_.y = _loc10_;
         _loc15_.z = _loc11_;
         _loc15_.lookAt(_loc12_,_loc13_,_loc14_);
         renderSystem.lights.spotLights.add(_loc15_);
         return _loc15_;
      }
      
      override protected function getLigts() : Vector.<Light3D>
      {
         return Vector.<Light3D>(renderSystem.lights.spotLights.lights);
      }
      
      override protected function del(param1:IConsole, param2:String) : Light3D
      {
         var _loc3_:SpotLight = this.getLight(param2);
         if(_loc3_ != null)
         {
            renderSystem.lights.spotLights.remove(SpotLight(_loc3_));
         }
         return _loc3_;
      }
      
      private function getLight(param1:String) : SpotLight
      {
         var _loc3_:SpotLight = null;
         var _loc2_:Vector.<SpotLight> = renderSystem.lights.spotLights.lights;
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

