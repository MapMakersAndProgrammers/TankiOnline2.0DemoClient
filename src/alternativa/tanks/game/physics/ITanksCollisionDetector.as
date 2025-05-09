package alternativa.tanks.game.physics
{
   import alternativa.math.Vector3;
   import alternativa.physics.collision.ICollisionDetector;
   
   public interface ITanksCollisionDetector extends ICollisionDetector
   {
      function getObjectsInRadius(param1:Vector3, param2:Number, param3:IRadiusQueryFilter) : Vector.<BodyDistance>;
      
      function addBodyCollisionData(param1:BodyCollisionData) : void;
      
      function removeBodyCollisionData(param1:BodyCollisionData) : void;
      
      function prepareForRaycasts() : void;
   }
}

