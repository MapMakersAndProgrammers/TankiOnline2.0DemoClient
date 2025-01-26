package package_98
{
   import package_18.name_44;
   import package_21.name_116;
   import package_24.name_376;
   import package_6.name_4;
   
   public class name_558 extends name_557
   {
      public function name_558(param1:name_44)
      {
         super(param1);
      }
      
      override protected function lightToString(param1:name_116) : String
      {
         return "AmbientLight color: 0x" + name_376(param1).color.toString(16);
      }
      
      override protected function create(param1:name_4, param2:Array, param3:int) : name_116
      {
         var _loc4_:uint = 0;
         var _loc5_:name_376 = null;
         if(param2.length == 0)
         {
            param1.name_145("Color is expected");
            return null;
         }
         _loc4_ = uint(param2[0]);
         _loc5_ = new name_376(_loc4_);
         _loc5_.name = "Ambient_" + param3;
         renderSystem.lights.ambientLight = _loc5_;
         return _loc5_;
      }
      
      override protected function modify(param1:name_4, param2:String, param3:Array) : name_116
      {
         var _loc4_:name_376 = renderSystem.lights.ambientLight;
         if(_loc4_ != null)
         {
            if(param3[0] != "color")
            {
               param1.name_145("Available commands:");
               param1.name_145("color color_value");
            }
            else
            {
               _loc4_.color = param3[1];
            }
         }
         return _loc4_;
      }
      
      override protected function getLigts() : Vector.<name_116>
      {
         return Vector.<name_116>([renderSystem.lights.ambientLight]);
      }
      
      override protected function del(param1:name_4, param2:String) : name_116
      {
         var _loc3_:name_376 = renderSystem.lights.ambientLight;
         renderSystem.lights.ambientLight = null;
         return _loc3_;
      }
   }
}

