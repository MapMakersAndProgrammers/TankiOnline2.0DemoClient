package alternativa.tanks.config.loaders.tankparts
{
   import alternativa.tanks.game.entities.tank.TankPart;
   
   public class TankHullLoaderFactory implements ITankPartLoaderFactory
   {
      public function TankHullLoaderFactory()
      {
         super();
      }
      
      public function createLoader(param1:String, param2:XML, param3:Vector.<TankPart>) : TankPartLoader
      {
         return new TankHullLoader(param1,param2,param3);
      }
   }
}

