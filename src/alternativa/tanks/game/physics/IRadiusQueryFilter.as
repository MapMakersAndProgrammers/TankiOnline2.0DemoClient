package alternativa.tanks.game.physics
{
   import alternativa.math.Vector3;
   import alternativa.physics.Body;
   
   public interface IRadiusQueryFilter
   {
      function acceptBody(param1:Vector3, param2:Body) : Boolean;
   }
}

