package platform.client.fp10.core.service.messagebox.impl
{
   import alternativa.osgi.OSGi;
   import alternativa.osgi.service.display.IDisplay;
   import platform.client.fp10.core.service.messagebox.IMessageBoxListener;
   import platform.client.fp10.core.service.messagebox.IMessageBoxService;
   
   public class MessageBoxService implements IMessageBoxService
   {
      
      private var osgi:OSGi;
      
      private var window:MessageWindow = new MessageWindow();
      
      public function MessageBoxService(param1:OSGi)
      {
         super();
         this.osgi = param1;
      }
      
      public function showMessage(param1:int, param2:String, param3:String, param4:int, param5:IMessageBoxListener = null, param6:Object = null) : int
      {
         var _loc7_:IDisplay = IDisplay(this.osgi.getService(IDisplay));
         this.window.text = param3;
         _loc7_.stage.addChild(this.window);
         return 0;
      }
      
      public function hideMessage(param1:int) : void
      {
         this.window.hide();
      }
   }
}

