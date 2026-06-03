package platform.client.core.general.spaces.models.dispatcher
{
   import alternativa.types.Long;
   
   public interface IDispatcherModelBase
   {
      
      function loadObjects(param1:Vector.<LoadObjectStruct>) : void;
      
      function unloadObjects(param1:Vector.<Long>) : void;
   }
}

