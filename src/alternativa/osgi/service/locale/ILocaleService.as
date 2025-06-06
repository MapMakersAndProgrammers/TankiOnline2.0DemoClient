package alternativa.osgi.service.locale
{
   import flash.display.BitmapData;
   
   public interface ILocaleService
   {
      function setText(param1:String, param2:String) : void;
      
      function setImage(param1:String, param2:BitmapData) : void;
      
      function setBoolean(param1:String, param2:Boolean) : void;
      
      function setNumber(param1:String, param2:Number) : void;
      
      function setInt(param1:String, param2:int) : void;
      
      function getText(param1:String, ... rest) : String;
      
      function getImage(param1:String) : BitmapData;
      
      function getBoolean(param1:String) : Boolean;
      
      function getNumber(param1:String) : Number;
      
      function getInt(param1:String) : int;
      
      function get language() : String;
      
      function get defaultLanguage() : String;
   }
}

