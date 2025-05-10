package alternativa.tanks.game.entities.tank
{
   import alternativa.engine3d.objects.Mesh;
   import alternativa.engine3d.objects.Skin;
   import alternativa.math.Vector3;
   import alternativa.tanks.game.physics.BoxData;
   
   public class TankHull extends TankPart
   {
      public var name_Sh:Vector3 = new Vector3();
      
      public var name_Rj:Vector3 = new Vector3();
      
      public var name_EN:Vector3 = new Vector3();
      
      public var name_eh:BoxData;
      
      public var name_AE:Vector.<BoxData> = new Vector.<BoxData>();
      
      public var name_KR:Vector.<BoxData> = new Vector.<BoxData>();
      
      public var name_j9:Vector.<Vector3> = new Vector.<Vector3>();
      
      public var name_Hd:Vector.<Vector3> = new Vector.<Vector3>();
      
      public var name_DH:Number = 1;
      
      public var name_EY:Vector.<TankWheel> = new Vector.<TankWheel>();
      
      public var name_M4:Vector.<TankWheel> = new Vector.<TankWheel>();
      
      public var name_Ei:Skin;
      
      public var name_iA:Skin;
      
      public var shadow:Mesh;
      
      public function TankHull()
      {
         super();
      }
   }
}

