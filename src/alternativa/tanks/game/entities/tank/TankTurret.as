package alternativa.tanks.game.entities.tank
{
   import alternativa.math.Vector3;
   import alternativa.tanks.game.physics.BoxData;
   
   public class TankTurret extends TankPart
   {
      public var name_Of:Vector.<BoxData> = new Vector.<BoxData>();
      
      public var name_O3:Vector.<Vector3> = new Vector.<Vector3>();
      
      public var name_G3:Vector3 = new Vector3();
      
      public function TankTurret()
      {
         super();
      }
   }
}

