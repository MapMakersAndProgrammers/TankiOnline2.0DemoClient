package alternativa.tanks.game.usertitle
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   
   public class §_-4R§
   {
      private static var hpGreenEmptyCls:Class = ProgressBarSkin_hpGreenEmptyCls;
      
      private static var hpGreenEmpty:BitmapData = Bitmap(new hpGreenEmptyCls()).bitmapData;
      
      private static var hpGreenFullCls:Class = ProgressBarSkin_hpGreenFullCls;
      
      private static var hpGreenFull:BitmapData = Bitmap(new hpGreenFullCls()).bitmapData;
      
      private static var hpRedEmptyCls:Class = ProgressBarSkin_hpRedEmptyCls;
      
      private static var hpRedEmpty:BitmapData = Bitmap(new hpRedEmptyCls()).bitmapData;
      
      private static var hpRedFullCls:Class = ProgressBarSkin_hpRedFullCls;
      
      private static var hpRedFull:BitmapData = Bitmap(new hpRedFullCls()).bitmapData;
      
      private static var hpBlueEmptyCls:Class = ProgressBarSkin_hpBlueEmptyCls;
      
      private static var hpBlueEmpty:BitmapData = Bitmap(new hpBlueEmptyCls()).bitmapData;
      
      private static var hpBlueFullCls:Class = ProgressBarSkin_hpBlueFullCls;
      
      private static var hpBlueFull:BitmapData = Bitmap(new hpBlueFullCls()).bitmapData;
      
      private static var weaponEmptyCls:Class = ProgressBarSkin_weaponEmptyCls;
      
      private static var weaponEmpty:BitmapData = Bitmap(new weaponEmptyCls()).bitmapData;
      
      private static var weaponFullCls:Class = ProgressBarSkin_weaponFullCls;
      
      private static var weaponFull:BitmapData = Bitmap(new weaponFullCls()).bitmapData;
      
      private static const COLOR_DM:uint = 4964125;
      
      private static const COLOR_TEAM_BLUE:uint = 4691967;
      
      private static const COLOR_TEAM_RED:uint = 15741974;
      
      public static const HEALTHBAR_DM:§_-4R§ = new §_-4R§(COLOR_DM,hpGreenEmpty,hpGreenFull,4);
      
      public static const HEALTHBAR_BLUE:§_-4R§ = new §_-4R§(COLOR_TEAM_BLUE,hpBlueEmpty,hpBlueFull,4);
      
      public static const HEALTHBAR_RED:§_-4R§ = new §_-4R§(COLOR_TEAM_RED,hpRedEmpty,hpRedFull,4);
      
      public static const WEAPONBAR:§_-4R§ = new §_-4R§(0,weaponEmpty,weaponFull,4);
      
      public var §_-XU§:BitmapData;
      
      public var §_-9Y§:BitmapData;
      
      public var §_-GY§:BitmapData;
      
      public var §_-j2§:BitmapData;
      
      public var §_-py§:BitmapData;
      
      public var §_-oU§:BitmapData;
      
      public var color:uint;
      
      public function §_-4R§(color:uint, emptyBitmap:BitmapData, fullBitmap:BitmapData, tipWidth:int)
      {
         super();
         this.color = color;
         var parts:§_-ml§ = new §_-ml§(emptyBitmap,tipWidth);
         this.§_-XU§ = parts.left;
         this.§_-GY§ = parts.right;
         this.§_-py§ = parts.center;
         parts = new §_-ml§(fullBitmap,tipWidth);
         this.§_-9Y§ = parts.left;
         this.§_-j2§ = parts.right;
         this.§_-oU§ = parts.center;
      }
   }
}

