package package_98
{
   import alternativa.utils.TextUtils;
   import alternativa.tanks.game.subsystems.rendersystem.RenderSystem;
   import package_21.name_116;
   import package_24.OmniLight;
   import alternativa.osgi.service.console.IConsole;
   
   public class name_560 extends name_557
   {
      public function name_560(param1:RenderSystem)
      {
         super(param1);
      }
      
      override protected function lightToString(param1:name_116) : String
      {
         var _loc2_:OmniLight = OmniLight(param1);
         return TextUtils.name_719("OmniLight color: 0x%1, attenuationBegin: %2, attenuationEnd: %3, x: %4, y: %5, z: %6",_loc2_.color.toString(16),_loc2_.attenuationBegin.toFixed(2),_loc2_.attenuationEnd.toFixed(2),_loc2_.x.toFixed(2),_loc2_.y.toFixed(2),_loc2_.z.toFixed(2));
      }
      
      override protected function modify(param1:IConsole, param2:String, param3:Array) : name_116
      {
         var _loc4_:OmniLight = this.method_762(param2);
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
               _loc4_.attenuationBegin = method_761(param3[0]);
               _loc4_.attenuationEnd = method_761(param3[1]);
               break;
            default:
               param1.method_145(Vector.<String>(["Available commands:","color value","pos x y z","att attenuationBegin attenuationEnd"]));
               return null;
         }
         return _loc4_;
      }
      
      override protected function create(param1:IConsole, param2:Array, param3:int) : name_116
      {
         if(param2.length == 0)
         {
            param1.name_145("parameters: color attenuationBegin attenuationEnd x y z");
            return null;
         }
         var _loc4_:uint = uint(param2[0]);
         var _loc5_:Number = method_761(param2[1]);
         var _loc6_:Number = method_761(param2[2]);
         var _loc7_:OmniLight = new OmniLight(_loc4_,_loc5_,_loc6_);
         _loc7_.name = "Omni_" + param3;
         _loc7_.x = method_761(param2[3]);
         _loc7_.y = method_761(param2[4]);
         _loc7_.z = method_761(param2[5]);
         renderSystem.lights.omniLigths.add(_loc7_);
         return _loc7_;
      }
      
      override protected function getLigts() : Vector.<name_116>
      {
         return Vector.<name_116>(renderSystem.lights.omniLigths.lights);
      }
      
      override protected function del(param1:IConsole, param2:String) : name_116
      {
         var _loc3_:OmniLight = this.method_762(param2);
         if(_loc3_ != null)
         {
            renderSystem.lights.omniLigths.remove(OmniLight(_loc3_));
         }
         return _loc3_;
      }
      
      private function method_762(param1:String) : OmniLight
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

