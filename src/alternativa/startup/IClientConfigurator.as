package alternativa.startup
{
   import flash.display.DisplayObjectContainer;
   import alternativa.utils.Properties;
   
   public interface IClientConfigurator
   {
      function start(param1:DisplayObjectContainer, param2:Properties, param3:Vector.<LibraryInfo>, param4:ConnectionParameters, param5:Vector.<String>) : void;
   }
}

