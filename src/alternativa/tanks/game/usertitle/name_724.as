package alternativa.tanks.game.usertitle
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   
   public class name_724
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
      
      public static const HEALTHBAR_DM:name_724 = new name_724(COLOR_DM,hpGreenEmpty,hpGreenFull,4);
      
      public static const HEALTHBAR_BLUE:name_724 = new name_724(COLOR_TEAM_BLUE,hpBlueEmpty,hpBlueFull,4);
      
      public static const HEALTHBAR_RED:name_724 = new name_724(COLOR_TEAM_RED,hpRedEmpty,hpRedFull,4);
      
      public static const WEAPONBAR:name_724 = new name_724(0,weaponEmpty,weaponFull,4);
      
      public var var_704:BitmapData;
      
      public var var_703:BitmapData;
      
      public var var_701:BitmapData;
      
      public var var_705:BitmapData;
      
      public var var_700:BitmapData;
      
      public var var_702:BitmapData;
      
      public var color:uint;
      
      public function name_724(color:uint, emptyBitmap:BitmapData, fullBitmap:BitmapData, tipWidth:int)
      {
         super();
         this.color = color;
         var parts:name_763 = new name_763(emptyBitmap,tipWidth);
         this.var_704 = parts.left;
         this.var_701 = parts.right;
         this.var_700 = parts.center;
         parts = new name_763(fullBitmap,tipWidth);
         this.var_703 = parts.left;
         this.var_705 = parts.right;
         this.var_702 = parts.center;
      }
   }
}

