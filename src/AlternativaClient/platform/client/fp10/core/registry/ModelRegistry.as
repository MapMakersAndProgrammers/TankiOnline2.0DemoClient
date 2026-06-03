package platform.client.fp10.core.registry
{
   import alternativa.protocol.ICodec;
   import alternativa.protocol.ProtocolBuffer;
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.type.IGameObject;
   
   public interface ModelRegistry
   {
      
      function register(param1:Long, param2:Long) : void;
      
      function add(param1:IModel, param2:Vector.<Class>) : void;
      
      function remove(param1:Long) : void;
      
      function registerModelConstructorCodec(param1:Long, param2:ICodec) : void;
      
      function getModelConstructorCodec(param1:Long) : ICodec;
      
      function invoke(param1:IGameObject, param2:Long, param3:ProtocolBuffer) : void;
      
      function getModel(param1:Long) : IModel;
      
      function registerAdapt(param1:Class, param2:Class) : void;
      
      function registerEvents(param1:Class, param2:Class) : void;
      
      function getAdaptClass(param1:Class) : Class;
      
      function getEventsClass(param1:Class) : Class;
      
      function getModelsByInterface(param1:Class) : Vector.<IModel>;
      
      function getModelForObject(param1:IGameObject, param2:Class) : IModel;
      
      function getModelsForObject(param1:IGameObject, param2:Class) : Vector.<IModel>;
      
      function getInterfacesForModel(param1:Long) : Vector.<Class>;
      
      function get models() : Vector.<IModel>;
   }
}

