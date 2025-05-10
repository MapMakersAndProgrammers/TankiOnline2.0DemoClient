package alternativa.tanks.config.loaders.tankparts
{
   import alternativa.tanks.game.entities.tank.TankPart;
   import alternativa.tanks.game.entities.tank.parsers.TankHullParser;
   import alternativa.utils.ByteArrayMap;
   
   public class TankHullLoader extends TankPartLoader
   {
      public function TankHullLoader(param1:String, param2:XML, param3:Vector.<TankPart>)
      {
         super(param1,param2,param3);
      }
      
      override public function parseModelData(param1:ByteArrayMap) : TankPart
      {
         var _loc2_:TankHullParser = new TankHullParser();
         return _loc2_.parse(param1,name_P9);
      }
   }
}

