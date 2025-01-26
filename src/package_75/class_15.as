package package_75
{
   import package_46.Matrix4;
   import package_46.name_194;
   import package_71.name_234;
   import package_76.name_235;
   
   public interface class_15
   {
      function setTurret(param1:name_234) : void;
      
      function getTurretDirection() : Number;
      
      function setTurretDirection(param1:Number) : void;
      
      function setTurretControls(param1:int) : Boolean;
      
      function centerTurret(param1:Boolean) : void;
      
      function setTurretMountPoint(param1:name_194) : void;
      
      function getTurretPrimitives() : Vector.<name_235>;
      
      function getChassisMatrix() : Matrix4;
      
      function getInterpolatedTurretDirection() : Number;
      
      function getSkinMountPoint(param1:name_194) : void;
      
      function getGunData(param1:int, param2:name_194, param3:name_194, param4:name_194) : void;
      
      function getGunMuzzleData(param1:int, param2:name_194, param3:name_194) : void;
      
      function getGunMuzzleData2(param1:int, param2:name_194, param3:name_194) : void;
      
      function getBarrelLength(param1:int) : Number;
      
      function getBarrelCount() : int;
   }
}

