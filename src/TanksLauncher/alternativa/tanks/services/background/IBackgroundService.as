package alternativa.tanks.services.background
{
   import flash.display.DisplayObjectContainer;
   import flash.geom.Rectangle;
   
   public interface IBackgroundService
   {
      
      function showBg() : void;
      
      function hideBg() : void;
      
      function drawBattleBg(param1:Rectangle = null) : void;
      
      function setBgLayer(param1:DisplayObjectContainer) : void;
   }
}

