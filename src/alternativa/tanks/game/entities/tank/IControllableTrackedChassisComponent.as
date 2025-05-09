package alternativa.tanks.game.entities.tank
{
   import alternativa.math.Quaternion;
   import alternativa.math.Vector3;
   
   public interface IControllableTrackedChassisComponent
   {
      function setChassisControls(param1:int, param2:int, param3:Boolean, param4:Boolean = false) : Boolean;
      
      function setPosition(param1:Vector3) : void;
      
      function setPositionXYZ(param1:Number, param2:Number, param3:Number) : void;
      
      function setLinearVelocity(param1:Vector3) : void;
      
      function setLinearVelocityXYZ(param1:Number, param2:Number, param3:Number) : void;
      
      function setAngularVelocity(param1:Vector3) : void;
      
      function setAngularVelocityXYZ(param1:Number, param2:Number, param3:Number) : void;
      
      function setOrientation(param1:Quaternion) : void;
      
      function setOrientationXYZ(param1:Number, param2:Number, param3:Number) : void;
   }
}

