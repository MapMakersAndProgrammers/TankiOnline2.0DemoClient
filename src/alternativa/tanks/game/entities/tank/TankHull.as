package alternativa.tanks.game.entities.tank
{
   import alternativa.engine3d.objects.Mesh;
   import alternativa.engine3d.objects.Skin;
   import alternativa.math.Vector3;
   import alternativa.tanks.game.physics.BoxData;
   
   public class TankHull extends TankPart
   {
      public var §_-Sh§:Vector3 = new Vector3();
      
      public var §_-Rj§:Vector3 = new Vector3();
      
      public var §_-EN§:Vector3 = new Vector3();
      
      public var §_-eh§:BoxData;
      
      public var §_-AE§:Vector.<BoxData> = new Vector.<BoxData>();
      
      public var §_-KR§:Vector.<BoxData> = new Vector.<BoxData>();
      
      public var §_-j9§:Vector.<Vector3> = new Vector.<Vector3>();
      
      public var §_-Hd§:Vector.<Vector3> = new Vector.<Vector3>();
      
      public var §_-DH§:Number = 1;
      
      public var §_-EY§:Vector.<TankWheel> = new Vector.<TankWheel>();
      
      public var §_-M4§:Vector.<TankWheel> = new Vector.<TankWheel>();
      
      public var §_-Ei§:Skin;
      
      public var §_-iA§:Skin;
      
      public var shadow:Mesh;
      
      public function TankHull()
      {
         super();
      }
   }
}

