package alternativa.tanks.game.effects
{
   import flash.geom.ColorTransform;
   
   public class ColorTransformEntry extends ColorTransform
   {
      public var t:Number;
      
      public function ColorTransformEntry(t:Number, redMultiplier:Number = 1, greenMultiplier:Number = 1, blueMultiplier:Number = 1, alphaMultiplier:Number = 1, redOffset:Number = 0, greenOffset:Number = 0, blueOffset:Number = 0, alphaOffset:Number = 0)
      {
         super();
         this.t = t;
         this.redMultiplier = redMultiplier;
         this.greenMultiplier = greenMultiplier;
         this.blueMultiplier = blueMultiplier;
         this.alphaMultiplier = alphaMultiplier;
         this.redOffset = redOffset;
         this.greenOffset = greenOffset;
         this.blueOffset = blueOffset;
         this.alphaOffset = alphaOffset;
      }
   }
}

