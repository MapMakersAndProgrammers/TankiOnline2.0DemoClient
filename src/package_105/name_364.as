package package_105
{
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.display.Stage;
   
   public class name_364 implements name_363
   {
      private var var_43:Stage;
      
      private var var_557:DisplayObjectContainer;
      
      private var var_565:DisplayObjectContainer;
      
      private var var_559:DisplayObjectContainer;
      
      private var var_558:DisplayObjectContainer;
      
      private var var_561:DisplayObjectContainer;
      
      private var var_564:DisplayObjectContainer;
      
      private var var_560:DisplayObjectContainer;
      
      private var var_563:DisplayObjectContainer;
      
      private var var_562:DisplayObjectContainer;
      
      public function name_364(rootContainer:DisplayObjectContainer)
      {
         super();
         this.var_43 = rootContainer.stage;
         this.var_557 = rootContainer;
         this.var_565 = this.method_619();
         this.var_559 = this.method_619();
         this.var_558 = this.method_619();
         this.var_561 = this.method_619();
         this.var_564 = this.method_619();
         this.var_560 = this.method_619();
         this.var_563 = this.method_619();
         this.var_562 = this.method_619();
      }
      
      private function method_619() : Sprite
      {
         var sprite:Sprite = new Sprite();
         sprite.mouseEnabled = false;
         sprite.tabEnabled = false;
         this.var_557.addChild(sprite);
         return sprite;
      }
      
      public function get stage() : Stage
      {
         return this.var_43;
      }
      
      public function get method_610() : DisplayObjectContainer
      {
         return this.var_557;
      }
      
      public function get method_611() : DisplayObjectContainer
      {
         return this.var_565;
      }
      
      public function get method_614() : DisplayObjectContainer
      {
         return this.var_559;
      }
      
      public function get method_617() : DisplayObjectContainer
      {
         return this.var_558;
      }
      
      public function get method_613() : DisplayObjectContainer
      {
         return this.var_561;
      }
      
      public function get method_616() : DisplayObjectContainer
      {
         return this.var_564;
      }
      
      public function get method_612() : DisplayObjectContainer
      {
         return this.var_560;
      }
      
      public function get method_618() : DisplayObjectContainer
      {
         return this.var_563;
      }
      
      public function get method_615() : DisplayObjectContainer
      {
         return this.var_562;
      }
   }
}

