package alternativa.tanks.game.camera
{
   import alternativa.tanks.game.subsystems.rendersystem.GameCamera;
   import flash.display.Shape;
   
   public class AxisIndicator extends Shape
   {
      private var var_32:int;
      
      private var axis:Vector.<Number> = Vector.<Number>([0,0,0,0,0,0]);
      
      public function AxisIndicator(size:int)
      {
         super();
         this.var_32 = size;
      }
      
      public function update(camera:GameCamera) : void
      {
         var kx:Number = NaN;
         var ky:Number = NaN;
         graphics.clear();
         this.axis[0] = camera.xAxis.x;
         this.axis[1] = camera.yAxis.x;
         this.axis[2] = camera.xAxis.y;
         this.axis[3] = camera.yAxis.y;
         this.axis[4] = camera.xAxis.z;
         this.axis[5] = camera.yAxis.z;
         var halfSize:int = this.var_32 / 2;
         for(var i:int = 0,var bitOffset:int = 16; i < 6; i += 2,bitOffset -= 8)
         {
            kx = this.axis[i] + 1;
            ky = this.axis[int(i + 1)] + 1;
            graphics.lineStyle(0,255 << bitOffset);
            graphics.moveTo(halfSize,halfSize);
            graphics.lineTo(halfSize * kx,halfSize * ky);
         }
      }
      
      public function get size() : int
      {
         return this.var_32;
      }
   }
}

