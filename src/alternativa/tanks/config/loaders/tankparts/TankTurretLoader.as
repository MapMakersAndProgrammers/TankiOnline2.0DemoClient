package alternativa.tanks.config.loaders.tankparts
{
   import alternativa.tanks.game.entities.tank.TankPart;
   import alternativa.tanks.game.entities.tank.parsers.TankTurretParser;
   import alternativa.utils.ByteArrayMap;
   
   public class TankTurretLoader extends TankPartLoader
   {
      public function TankTurretLoader(param1:String, param2:XML, param3:Vector.<TankPart>)
      {
         super(param1,param2,param3);
      }
      
      override public function parseModelData(param1:ByteArrayMap) : TankPart
      {
         var _loc2_:TankTurretParser = new TankTurretParser();
         return _loc2_.parse(param1,name_P9);
      }
   }
}

