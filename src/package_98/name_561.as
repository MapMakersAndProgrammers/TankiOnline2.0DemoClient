package package_98
{
   import package_15.name_718;
   import package_18.name_44;
   import package_21.name_116;
   import package_24.SpotLight;
   import alternativa.osgi.service.console.IConsole;
   
   public class name_561 extends name_557
   {
      public function name_561(param1:name_44)
      {
         super(param1);
      }
      
      override protected function lightToString(param1:name_116) : String
      {
         var _loc2_:SpotLight = SpotLight(param1);
         return name_718.name_719("SpotLight color: 0x%1, attenuationBegin: %2, attenuationEnd: %3, hotspot: %4, falloff: %5, x: %6, y: %7, z: %8",_loc2_.color.toString(16),_loc2_.attenuationBegin.toFixed(2),_loc2_.attenuationEnd.toFixed(2),_loc2_.hotspot.toFixed(2),_loc2_.falloff.toFixed(2),_loc2_.x.toFixed(2),_loc2_.y.toFixed(2),_loc2_.z.toFixed(2));
      }
      
      override protected function modify(param1:IConsole, param2:String, param3:Array) : name_116
      {
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc4_:SpotLight = this.method_762(param2);
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
               _loc4_.hotspot = method_761(param3[0],0);
               _loc4_.falloff = method_761(param3[1],0);
               break;
            case "lookAt":
               _loc6_ = method_761(param3[0],0);
               _loc7_ = method_761(param3[1],0);
               _loc8_ = method_761(param3[2],0);
               _loc4_.lookAt(_loc6_,_loc7_,_loc8_);
               param1.name_145("Looking at " + _loc6_ + ", " + _loc7_ + ", " + _loc8_);
               break;
            case "att":
               _loc4_.attenuationBegin = method_761(param3[0]);
               _loc4_.attenuationEnd = method_761(param3[1]);
               break;
            default:
               param1.method_145(Vector.<String>(["Available commands:","color value","att attenuationBegin attenuationEnd","cone hotspot falloff","pos x y z","lookAt x y z"]));
               return null;
         }
         return _loc4_;
      }
      
      override protected function create(param1:IConsole, param2:Array, param3:int) : name_116
      {
         if(param2.length == 0)
         {
            param1.name_145("parameters: color attenuationBegin attenuationEnd hotspot falloff x y z lookX lookY lookZ");
            return null;
         }
         var _loc4_:int = int(param2[0]);
         var _loc5_:Number = method_761(param2[1]);
         var _loc6_:Number = method_761(param2[2]);
         var _loc7_:Number = method_761(param2[3]);
         var _loc8_:Number = method_761(param2[4]);
         var _loc9_:Number = method_761(param2[5]);
         var _loc10_:Number = method_761(param2[6]);
         var _loc11_:Number = method_761(param2[7]);
         var _loc12_:Number = method_761(param2[8]);
         var _loc13_:Number = method_761(param2[9]);
         var _loc14_:Number = method_761(param2[10]);
         var _loc15_:SpotLight = new SpotLight(_loc4_,_loc5_,_loc6_,_loc7_,_loc8_);
         _loc15_.name = "Spot_" + param3;
         _loc15_.x = _loc9_;
         _loc15_.y = _loc10_;
         _loc15_.z = _loc11_;
         _loc15_.lookAt(_loc12_,_loc13_,_loc14_);
         renderSystem.lights.spotLights.add(_loc15_);
         return _loc15_;
      }
      
      override protected function getLigts() : Vector.<name_116>
      {
         return Vector.<name_116>(renderSystem.lights.spotLights.lights);
      }
      
      override protected function del(param1:IConsole, param2:String) : name_116
      {
         var _loc3_:SpotLight = this.method_762(param2);
         if(_loc3_ != null)
         {
            renderSystem.lights.spotLights.remove(SpotLight(_loc3_));
         }
         return _loc3_;
      }
      
      private function method_762(param1:String) : SpotLight
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

