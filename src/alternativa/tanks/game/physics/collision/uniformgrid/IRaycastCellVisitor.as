package alternativa.tanks.game.physics.collision.uniformgrid
{
   import alternativa.math.Vector3;
   
   public interface IRaycastCellVisitor
   {
      function visitCell(param1:int, param2:int, param3:int, param4:int, param5:Number, param6:Number, param7:int, param8:Vector3, param9:Vector3) : Boolean;
   }
}

