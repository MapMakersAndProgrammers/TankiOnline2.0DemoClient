package platform.client.fp10.core.type
{
   import alternativa.types.Long;
   import flash.utils.Dictionary;
   
   public interface IGameClass
   {
      
      function get id() : Long;
      
      function get parent() : IGameClass;
      
      function get children() : Vector.<IGameClass>;
      
      function get models() : Vector.<Long>;
      
      function get modelsParams() : Dictionary;
   }
}

