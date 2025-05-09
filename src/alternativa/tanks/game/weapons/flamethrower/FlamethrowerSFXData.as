package alternativa.tanks.game.weapons.flamethrower
{
   import alternativa.engine3d.materials.Material;
   import alternativa.tanks.game.effects.ColorTransformEntry;
   
   public class FlamethrowerSFXData
   {
      public var frames:Vector.<Material>;
      
      public var colorTransformPoints:Vector.<ColorTransformEntry>;
      
      public function FlamethrowerSFXData(frames:Vector.<Material>, colorTransformPoints:Vector.<ColorTransformEntry>)
      {
         super();
         this.frames = frames;
         this.colorTransformPoints = colorTransformPoints;
      }
   }
}

