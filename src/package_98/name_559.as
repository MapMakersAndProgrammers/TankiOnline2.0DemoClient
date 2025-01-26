package package_98
{
   import package_18.name_44;
   import package_21.name_116;
   import package_24.DirectionalLight;
   import alternativa.osgi.service.console.IConsole;
   
   public class name_559 extends name_557
   {
      public function name_559(param1:name_44)
      {
         super(param1);
      }
      
      override protected function getLigts() : Vector.<name_116>
      {
         return Vector.<name_116>(renderSystem.lights.directionalLigths.lights);
      }
      
      override protected function del(param1:IConsole, param2:String) : name_116
      {
         var _loc3_:DirectionalLight = this.method_762(param2);
         if(_loc3_ != null)
         {
            renderSystem.lights.directionalLigths.remove(_loc3_);
         }
         return _loc3_;
      }
      
      private function method_762(param1:String) : DirectionalLight
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

