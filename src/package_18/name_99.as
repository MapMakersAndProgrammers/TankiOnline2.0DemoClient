package package_18
{
   import flash.display.BitmapData;
   import flash.display.Stage3D;
   
   public class name_99 implements name_88
   {
      private var fogBitmap:BitmapData;
      
      private var renderSystem:name_44;
      
      public function name_99(fogBitmap:BitmapData, renderSystem:name_44)
      {
         super();
         this.fogBitmap = fogBitmap;
         this.renderSystem = renderSystem;
      }
      
      public function execute(stage3d:Stage3D) : void
      {
         this.renderSystem.method_33(this.fogBitmap);
      }
   }
}

