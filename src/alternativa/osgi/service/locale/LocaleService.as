package alternativa.osgi.service.locale
{
   import flash.display.BitmapData;
   import flash.utils.Dictionary;
   
   public class LocaleService implements ILocaleService
   {
      private var strings:Object = {};
      
      private var images:Object = {};
      
      private var var_549:Object = {};
      
      private var numbers:Object = {};
      
      private var var_550:Object = {};
      
      private var var_552:String;
      
      private var var_551:String;
      
      public function LocaleService(language:String, defaultLanguage:String)
      {
         super();
         this.var_552 = language;
         this.var_551 = defaultLanguage;
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
         this.var_549[id] = value;
      }
      
      public function setNumber(id:String, value:Number) : void
      {
         this.numbers[id] = value;
      }
      
      public function setInt(id:String, value:int) : void
      {
         this.var_550[id] = value;
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
         return this.var_549[id];
      }
      
      public function getNumber(id:String) : Number
      {
         return this.numbers[id];
      }
      
      public function getInt(id:String) : int
      {
         return this.var_550[id];
      }
      
      public function get language() : String
      {
         return this.var_552;
      }
      
      public function get defaultLanguage() : String
      {
         return this.var_551;
      }
   }
}

