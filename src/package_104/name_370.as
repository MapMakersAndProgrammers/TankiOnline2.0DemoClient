package package_104
{
   import flash.display.BitmapData;
   import flash.utils.Dictionary;
   
   public class name_370 implements name_358
   {
      private var strings:Object = {};
      
      private var images:Object = {};
      
      private var var_550:Object = {};
      
      private var numbers:Object = {};
      
      private var var_549:Object = {};
      
      private var var_552:String;
      
      private var var_551:String;
      
      public function name_370(language:String, defaultLanguage:String)
      {
         super();
         this.var_552 = language;
         this.var_551 = defaultLanguage;
         this.strings = new Dictionary();
         this.images = new Dictionary();
      }
      
      public function method_599(id:String, text:String) : void
      {
         this.strings[id] = text;
      }
      
      public function method_601(id:String, image:BitmapData) : void
      {
         this.images[id] = image;
      }
      
      public function method_595(id:String, value:Boolean) : void
      {
         this.var_550[id] = value;
      }
      
      public function method_600(id:String, value:Number) : void
      {
         this.numbers[id] = value;
      }
      
      public function method_598(id:String, value:int) : void
      {
         this.var_549[id] = value;
      }
      
      public function method_597(id:String, ... vars) : String
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
      
      public function method_604(id:String) : BitmapData
      {
         return this.images[id];
      }
      
      public function method_602(id:String) : Boolean
      {
         return this.var_550[id];
      }
      
      public function method_596(id:String) : Number
      {
         return this.numbers[id];
      }
      
      public function method_603(id:String) : int
      {
         return this.var_549[id];
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

