package alternativa.physics.collision
{
   import alternativa.physics.Body;
   
   public interface IBodyCollisionFilter
   {
      function acceptBodiesCollision(param1:Body, param2:Body) : Boolean;
   }
}

