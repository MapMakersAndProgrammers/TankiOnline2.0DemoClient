package alternativa.tanks
{
   import package_40.name_564;
   
   public class TankParams
   {
      public static const defaultTankParams:TankParams = getDefaultTankParams();
      
      public var x:Number = 0;
      
      public var y:Number = 0;
      
      public var z:Number = 0;
      
      public var rotationX:Number = 0;
      
      public var rotationY:Number = 0;
      
      public var rotationZ:Number = 0;
      
      public var hull:String = "";
      
      public var turret:String = "";
      
      public var coloring:int = 0;
      
      public var isUser:Boolean = false;
      
      public function TankParams()
      {
         super();
      }
      
      private static function getDefaultTankParams() : TankParams
      {
         var _loc1_:TankParams = new TankParams();
         _loc1_.y = 1000;
         _loc1_.z = 1000;
         _loc1_.isUser = true;
         _loc1_.hull = "Wasp M1";
         _loc1_.turret = "Smoky M1";
         return _loc1_;
      }
      
      public static function name_317(param1:XML, param2:Boolean = false) : TankParams
      {
         var _loc3_:TankParams = new TankParams();
         _loc3_.isUser = param2;
         var _loc4_:Array = name_564.name_565(XMLList(param1.xyz)[0]);
         if(_loc4_.length == 3)
         {
            _loc3_.x = Number(_loc4_[0]);
            _loc3_.y = Number(_loc4_[1]);
            _loc3_.z = Number(_loc4_[2]);
         }
         _loc4_ = name_564.name_565(XMLList(param1.rotation)[0]);
         if(_loc4_.length == 3)
         {
            _loc3_.rotationX = Number(_loc4_[0]);
            _loc3_.rotationY = Number(_loc4_[1]);
            _loc3_.rotationZ = Number(_loc4_[2]);
         }
         _loc3_.hull = param1.hull;
         _loc3_.turret = param1.turret;
         _loc3_.coloring = int(param1.coloring);
         return _loc3_;
      }
      
      public static function name_322(param1:Array) : TankParams
      {
         return new TankParams();
      }
   }
}

