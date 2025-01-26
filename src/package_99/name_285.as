package package_99
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import flash.utils.Dictionary;
   
   public class name_285 extends Sprite
   {
      private var values:Dictionary;
      
      private var count:int;
      
      public function name_285()
      {
         super();
         this.values = new Dictionary();
         mouseEnabled = false;
         tabEnabled = false;
         mouseChildren = false;
         tabChildren = false;
      }
      
      public function method_458(param1:String, ... rest) : void
      {
         var _loc3_:TextField = this.values[param1];
         if(_loc3_ == null)
         {
            _loc3_ = this.method_457();
            this.values[param1] = _loc3_;
         }
         _loc3_.text = param1 + ": " + rest.join(" ");
      }
      
      public function method_459(param1:String) : void
      {
         this.method_457().text = param1;
      }
      
      private function method_457() : TextField
      {
         var _loc1_:TextField = new TextField();
         _loc1_.autoSize = TextFieldAutoSize.LEFT;
         addChild(_loc1_);
         _loc1_.defaultTextFormat = new TextFormat("Tahoma",11,16777215);
         _loc1_.y = this.count * 20;
         ++this.count;
         return _loc1_;
      }
   }
}

