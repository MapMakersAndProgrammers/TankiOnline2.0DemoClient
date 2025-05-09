package alternativa.physics.collision
{
   public interface IPrimitiveCollisionFilter
   {
      function acceptPrimitivesCollision(param1:CollisionPrimitive, param2:CollisionPrimitive) : Boolean;
   }
}

