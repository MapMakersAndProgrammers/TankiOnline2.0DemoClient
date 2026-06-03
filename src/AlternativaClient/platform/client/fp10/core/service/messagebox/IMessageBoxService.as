package platform.client.fp10.core.service.messagebox
{
   public interface IMessageBoxService
   {
      
      function showMessage(param1:int, param2:String, param3:String, param4:int, param5:IMessageBoxListener = null, param6:Object = null) : int;
      
      function hideMessage(param1:int) : void;
   }
}

