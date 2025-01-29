package package_98
{
   import alternativa.tanks.game.subsystems.rendersystem.RenderSystem;
   import alternativa.osgi.OSGi;
   import alternativa.osgi.service.console.IConsole;
   
   public class name_290
   {
      private static const LIGHT_TYPE_AMBIENT:String = "a";
      
      private static const LIGHT_TYPE_DIRECTIONAL:String = "d";
      
      private static const LIGHT_TYPE_OMNI:String = "o";
      
      private static const LIGHT_TYPE_SPOT:String = "s";
      
      private var renderSystem:RenderSystem;
      
      private var var_471:Object = {};
      
      public function name_290(param1:RenderSystem)
      {
         super();
         this.renderSystem = param1;
         var _loc2_:IConsole = IConsole(OSGi.name_8().name_30(IConsole));
         _loc2_.name_45("light",this.method_469);
         this.var_471[LIGHT_TYPE_AMBIENT] = new name_558(param1);
         this.var_471[LIGHT_TYPE_DIRECTIONAL] = new name_559(param1);
         this.var_471[LIGHT_TYPE_OMNI] = new name_560(param1);
         this.var_471[LIGHT_TYPE_SPOT] = new name_561(param1);
      }
      
      private function method_469(param1:IConsole, param2:Array) : void
      {
         var _loc3_:String = null;
         var _loc4_:name_557 = null;
         if(param2.length != 0)
         {
            _loc3_ = param2.shift();
            _loc4_ = this.var_471[_loc3_];
            if(_loc4_ == null)
            {
               param1.name_145("Unknown light type");
            }
            else
            {
               _loc4_.name_562(param1,param2);
            }
         }
      }
   }
}

