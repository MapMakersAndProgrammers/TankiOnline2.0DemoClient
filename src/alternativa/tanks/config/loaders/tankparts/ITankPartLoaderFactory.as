package alternativa.tanks.config.loaders.tankparts
{
   import alternativa.tanks.game.entities.tank.TankPart;
   
   public interface ITankPartLoaderFactory
   {
      function createLoader(param1:String, param2:XML, param3:Vector.<TankPart>) : TankPartLoader;
   }
}

