package alternativa.tanks.game.physics
{
   import alternativa.math.Matrix4;
   import alternativa.math.Vector3;
   import alternativa.physics.collision.primitives.name_311;
   
   public class TurretCollisioinBox extends name_311
   {
      public var m:Matrix4;
      
      public function TurretCollisioinBox(hs:Vector3, localMatrix:Matrix4, collisionGroup:int, collisionMask:int)
      {
         super(hs,collisionGroup,collisionMask);
         this.m = localMatrix.clone();
      }
   }
}

