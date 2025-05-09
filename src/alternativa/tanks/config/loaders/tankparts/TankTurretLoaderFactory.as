package alternativa.tanks.config.loaders.tankparts
{
   import alternativa.tanks.game.entities.tank.TankPart;
   
   public class TankTurretLoaderFactory implements ITankPartLoaderFactory
   {
      public function TankTurretLoaderFactory()
      {
         super();
      }
      
      public function createLoader(param1:String, param2:XML, param3:Vector.<TankPart>) : TankPartLoader
      {
         return new TankTurretLoader(param1,param2,param3);
      }
   }
}

