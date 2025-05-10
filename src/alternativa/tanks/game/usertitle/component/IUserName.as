package alternativa.tanks.game.usertitle.component
{
   import flash.display.IBitmapDrawable;
   
   public interface IUserName
   {
      function set text(param1:String) : void;
      
      function get textWidth() : int;
      
      function get textHeight() : int;
      
      function set textColor(param1:uint) : void;
      
      function getLabel() : IBitmapDrawable;
   }
}

