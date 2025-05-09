package alternativa.tanks.game.entities.tank.physics
{
   import alternativa.math.Matrix4;
   import alternativa.math.Vector3;
   import alternativa.physics.collision.CollisionPrimitive;
   import alternativa.tanks.game.entities.tank.TankTurret;
   
   public interface ITurretPhysicsComponent
   {
      function setTurret(param1:TankTurret) : void;
      
      function getTurretDirection() : Number;
      
      function setTurretDirection(param1:Number) : void;
      
      function setTurretControls(param1:int) : Boolean;
      
      function centerTurret(param1:Boolean) : void;
      
      function setTurretMountPoint(param1:Vector3) : void;
      
      function getTurretPrimitives() : Vector.<CollisionPrimitive>;
      
      function getChassisMatrix() : Matrix4;
      
      function getInterpolatedTurretDirection() : Number;
      
      function getSkinMountPoint(param1:Vector3) : void;
      
      function getGunData(param1:int, param2:Vector3, param3:Vector3, param4:Vector3) : void;
      
      function getGunMuzzleData(param1:int, param2:Vector3, param3:Vector3) : void;
      
      function getGunMuzzleData2(param1:int, param2:Vector3, param3:Vector3) : void;
      
      function getBarrelLength(param1:int) : Number;
      
      function getBarrelCount() : int;
   }
}

