package alternativa.osgi.service.display
{
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.display.Stage;
   
   public class Display implements IDisplay
   {
      private var §_-We§:Stage;
      
      private var §_-j§:DisplayObjectContainer;
      
      private var §finally§:DisplayObjectContainer;
      
      private var §_-TJ§:DisplayObjectContainer;
      
      private var §_-6o§:DisplayObjectContainer;
      
      private var §_-Xl§:DisplayObjectContainer;
      
      private var §_-Ha§:DisplayObjectContainer;
      
      private var §_-5X§:DisplayObjectContainer;
      
      private var §_-Qq§:DisplayObjectContainer;
      
      private var §_-Ow§:DisplayObjectContainer;
      
      public function Display(rootContainer:DisplayObjectContainer)
      {
         super();
         this.§_-We§ = rootContainer.stage;
         this.§_-j§ = rootContainer;
         this.§finally§ = this.addLayerSprite();
         this.§_-TJ§ = this.addLayerSprite();
         this.§_-6o§ = this.addLayerSprite();
         this.§_-Xl§ = this.addLayerSprite();
         this.§_-Ha§ = this.addLayerSprite();
         this.§_-5X§ = this.addLayerSprite();
         this.§_-Qq§ = this.addLayerSprite();
         this.§_-Ow§ = this.addLayerSprite();
      }
      
      private function addLayerSprite() : Sprite
      {
         var sprite:Sprite = new Sprite();
         sprite.mouseEnabled = false;
         sprite.tabEnabled = false;
         this.§_-j§.addChild(sprite);
         return sprite;
      }
      
      public function get stage() : Stage
      {
         return this.§_-We§;
      }
      
      public function get mainContainer() : DisplayObjectContainer
      {
         return this.§_-j§;
      }
      
      public function get backgroundLayer() : DisplayObjectContainer
      {
         return this.§finally§;
      }
      
      public function get contentLayer() : DisplayObjectContainer
      {
         return this.§_-TJ§;
      }
      
      public function get contentUILayer() : DisplayObjectContainer
      {
         return this.§_-6o§;
      }
      
      public function get systemLayer() : DisplayObjectContainer
      {
         return this.§_-Xl§;
      }
      
      public function get systemUILayer() : DisplayObjectContainer
      {
         return this.§_-Ha§;
      }
      
      public function get dialogsLayer() : DisplayObjectContainer
      {
         return this.§_-5X§;
      }
      
      public function get noticesLayer() : DisplayObjectContainer
      {
         return this.§_-Qq§;
      }
      
      public function get cursorLayer() : DisplayObjectContainer
      {
         return this.§_-Ow§;
      }
   }
}

