package alternativa.model.general.quadro
{
   import alternativa.osgi.service.clientlog.IClientLog;
   import alternativa.osgi.service.display.IDisplay;
   import alternativa.osgi.service.locale.ILocaleService;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import platform.client.core.general.spaces.models.quadro.IQuadroModelBase;
   import platform.client.core.general.spaces.models.quadro.QuadroModelBase;
   import platform.client.core.general.spaces.models.quadro.Test;
   import platform.client.fp10.core.model.IObjectLoadListener;
   
   [ModelInfo]
   public class QuadroModel extends QuadroModelBase implements IQuadroModelBase, IObjectLoadListener, IQuadro
   {
      
      [Inject]
      public static var display:IDisplay;
      
      [Inject]
      public static var localeService:ILocaleService;
      
      [Inject]
      public static var clientLog:IClientLog;
      
      private var sprite:Sprite;
      
      private var tf:TextField;
      
      public function QuadroModel()
      {
         super();
      }
      
      private function onMouseClick(param1:MouseEvent) : void
      {
         server.click(param1.stageX,param1.stageY);
      }
      
      public function setTest(param1:Test) : void
      {
      }
      
      public function change(param1:int, param2:int) : void
      {
      }
      
      public function click(param1:int, param2:int) : void
      {
      }
      
      public function objectLoaded() : void
      {
      }
      
      private function showLocalizedString(param1:String) : void
      {
         var _loc2_:String = param1 + " " + localeService.getText(param1) + "\n";
         this.tf.appendText(_loc2_);
      }
      
      private function createTextField() : void
      {
         this.tf = new TextField();
         this.tf.defaultTextFormat = new TextFormat("Tahoma",14,16777215);
         this.tf.multiline = true;
         this.tf.autoSize = TextFieldAutoSize.LEFT;
         display.stage.addChild(this.tf);
      }
      
      public function objectLoadedPost() : void
      {
      }
      
      public function objectUnloaded() : void
      {
      }
      
      public function calc(param1:int, param2:int) : int
      {
         return param1 + param2;
      }
      
      public function load() : void
      {
      }
      
      public function objectUnloadedPost() : void
      {
      }
   }
}

