package alternativa.osgi.service.display
{
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.display.Stage;
   
   public class Display implements IDisplay
   {
      private var var_43:Stage;
      
      private var var_557:DisplayObjectContainer;
      
      private var var_565:DisplayObjectContainer;
      
      private var var_563:DisplayObjectContainer;
      
      private var var_559:DisplayObjectContainer;
      
      private var var_564:DisplayObjectContainer;
      
      private var var_560:DisplayObjectContainer;
      
      private var var_558:DisplayObjectContainer;
      
      private var var_562:DisplayObjectContainer;
      
      private var var_561:DisplayObjectContainer;
      
      public function Display(rootContainer:DisplayObjectContainer)
      {
         super();
         this.var_43 = rootContainer.stage;
         this.var_557 = rootContainer;
         this.var_565 = this.addLayerSprite();
         this.var_563 = this.addLayerSprite();
         this.var_559 = this.addLayerSprite();
         this.var_564 = this.addLayerSprite();
         this.var_560 = this.addLayerSprite();
         this.var_558 = this.addLayerSprite();
         this.var_562 = this.addLayerSprite();
         this.var_561 = this.addLayerSprite();
      }
      
      private function addLayerSprite() : Sprite
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
      
      public function get mainContainer() : DisplayObjectContainer
      {
         return this.var_557;
      }
      
      public function get backgroundLayer() : DisplayObjectContainer
      {
         return this.var_565;
      }
      
      public function get contentLayer() : DisplayObjectContainer
      {
         return this.var_563;
      }
      
      public function get contentUILayer() : DisplayObjectContainer
      {
         return this.var_559;
      }
      
      public function get systemLayer() : DisplayObjectContainer
      {
         return this.var_564;
      }
      
      public function get systemUILayer() : DisplayObjectContainer
      {
         return this.var_560;
      }
      
      public function get dialogsLayer() : DisplayObjectContainer
      {
         return this.var_558;
      }
      
      public function get noticesLayer() : DisplayObjectContainer
      {
         return this.var_562;
      }
      
      public function get cursorLayer() : DisplayObjectContainer
      {
         return this.var_561;
      }
   }
}

