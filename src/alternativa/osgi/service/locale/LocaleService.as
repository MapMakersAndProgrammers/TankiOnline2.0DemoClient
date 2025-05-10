package alternativa.osgi.service.locale
{
   import flash.display.BitmapData;
   import flash.utils.Dictionary;
   
   public class LocaleService implements ILocaleService
   {
      private var strings:Object = {};
      
      private var images:Object = {};
      
      private var §_-bK§:Object = {};
      
      private var numbers:Object = {};
      
      private var §_-op§:Object = {};
      
      private var §_-VI§:String;
      
      private var §_-4p§:String;
      
      public function LocaleService(language:String, defaultLanguage:String)
      {
         super();
         this.§_-VI§ = language;
         this.§_-4p§ = defaultLanguage;
         this.strings = new Dictionary();
         this.images = new Dictionary();
      }
      
      public function setText(id:String, text:String) : void
      {
         this.strings[id] = text;
      }
      
      public function setImage(id:String, image:BitmapData) : void
      {
         this.images[id] = image;
      }
      
      public function setBoolean(id:String, value:Boolean) : void
      {
         this.§_-bK§[id] = value;
      }
      
      public function setNumber(id:String, value:Number) : void
      {
         this.numbers[id] = value;
      }
      
      public function setInt(id:String, value:int) : void
      {
         this.§_-op§[id] = value;
      }
      
      public function getText(id:String, ... vars) : String
      {
         var text:String = this.strings[id];
         if(text == null)
         {
            return id;
         }
         for(var i:int = 0; i < vars.length; )
         {
            text = text.replace("%" + (i + 1),vars[i]);
            i++;
         }
         return text;
      }
      
      public function getImage(id:String) : BitmapData
      {
         return this.images[id];
      }
      
      public function getBoolean(id:String) : Boolean
      {
         return this.§_-bK§[id];
      }
      
      public function getNumber(id:String) : Number
      {
         return this.numbers[id];
      }
      
      public function getInt(id:String) : int
      {
         return this.§_-op§[id];
      }
      
      public function get language() : String
      {
         return this.§_-VI§;
      }
      
      public function get defaultLanguage() : String
      {
         return this.§_-4p§;
      }
   }
}

