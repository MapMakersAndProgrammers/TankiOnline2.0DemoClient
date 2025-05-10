package alternativa.osgi.service.display
{
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.display.Stage;
   
   public class Display implements IDisplay
   {
      private var name_We:Stage;
      
      private var name_j:DisplayObjectContainer;
      
      private var name_finally:DisplayObjectContainer;
      
      private var name_TJ:DisplayObjectContainer;
      
      private var name_6o:DisplayObjectContainer;
      
      private var name_Xl:DisplayObjectContainer;
      
      private var name_Ha:DisplayObjectContainer;
      
      private var name_5X:DisplayObjectContainer;
      
      private var name_Qq:DisplayObjectContainer;
      
      private var name_Ow:DisplayObjectContainer;
      
      public function Display(rootContainer:DisplayObjectContainer)
      {
         super();
         this.name_We = rootContainer.stage;
         this.name_j = rootContainer;
         this.name_finally = this.addLayerSprite();
         this.name_TJ = this.addLayerSprite();
         this.name_6o = this.addLayerSprite();
         this.name_Xl = this.addLayerSprite();
         this.name_Ha = this.addLayerSprite();
         this.name_5X = this.addLayerSprite();
         this.name_Qq = this.addLayerSprite();
         this.name_Ow = this.addLayerSprite();
      }
      
      private function addLayerSprite() : Sprite
      {
         var sprite:Sprite = new Sprite();
         sprite.mouseEnabled = false;
         sprite.tabEnabled = false;
         this.name_j.addChild(sprite);
         return sprite;
      }
      
      public function get stage() : Stage
      {
         return this.name_We;
      }
      
      public function get mainContainer() : DisplayObjectContainer
      {
         return this.name_j;
      }
      
      public function get backgroundLayer() : DisplayObjectContainer
      {
         return this.name_finally;
      }
      
      public function get contentLayer() : DisplayObjectContainer
      {
         return this.name_TJ;
      }
      
      public function get contentUILayer() : DisplayObjectContainer
      {
         return this.name_6o;
      }
      
      public function get systemLayer() : DisplayObjectContainer
      {
         return this.name_Xl;
      }
      
      public function get systemUILayer() : DisplayObjectContainer
      {
         return this.name_Ha;
      }
      
      public function get dialogsLayer() : DisplayObjectContainer
      {
         return this.name_5X;
      }
      
      public function get noticesLayer() : DisplayObjectContainer
      {
         return this.name_Qq;
      }
      
      public function get cursorLayer() : DisplayObjectContainer
      {
         return this.name_Ow;
      }
   }
}

