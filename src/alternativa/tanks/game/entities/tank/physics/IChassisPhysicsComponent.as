package alternativa.tanks.game.entities.tank.physics
{
   import alternativa.math.Matrix4;
   import alternativa.math.Vector3;
   import alternativa.physics.Body;
   
   public interface IChassisPhysicsComponent
   {
      function setTurret(param1:ITurretPhysicsComponent) : void;
      
      function getTurretMountPoint(param1:Vector3) : void;
      
      function getTurretSkinMountPoint(param1:Vector3) : void;
      
      function getInterpolatedMatrix() : Matrix4;
      
      function getBody() : Body;
      
      function getBoundPoints() : Vector.<Vector3>;
      
      function setDetailedCollisionGroup(param1:int) : void;
      
      function getWheelDeltaZ(param1:String) : Number;
   }
}

