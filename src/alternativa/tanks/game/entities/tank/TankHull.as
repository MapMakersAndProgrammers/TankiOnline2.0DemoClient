package alternativa.tanks.game.entities.tank
{
   import alternativa.engine3d.objects.Mesh;
   import alternativa.engine3d.objects.Skin;
   import alternativa.math.Vector3;
   import alternativa.tanks.game.physics.BoxData;
   
   public class TankHull extends TankPart
   {
      public var name_400:Vector3 = new Vector3();
      
      public var name_395:Vector3 = new Vector3();
      
      public var name_398:Vector3 = new Vector3();
      
      public var name_388:BoxData;
      
      public var name_396:Vector.<BoxData> = new Vector.<BoxData>();
      
      public var name_397:Vector.<BoxData> = new Vector.<BoxData>();
      
      public var name_401:Vector.<Vector3> = new Vector.<Vector3>();
      
      public var name_399:Vector.<Vector3> = new Vector.<Vector3>();
      
      public var name_437:Number = 1;
      
      public var name_247:Vector.<TankWheel> = new Vector.<TankWheel>();
      
      public var name_245:Vector.<TankWheel> = new Vector.<TankWheel>();
      
      public var name_261:Skin;
      
      public var name_266:Skin;
      
      public var shadow:Mesh;
      
      public function TankHull()
      {
         super();
      }
   }
}

