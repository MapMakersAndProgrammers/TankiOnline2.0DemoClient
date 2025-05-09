package alternativa.tanks.game.subsystems.rendersystem
{
   import alternativa.engine3d.core.Resource;
   
   public interface IResourceManager
   {
      function useResource(param1:Resource) : void;
      
      function useResources(param1:Vector.<Resource>) : void;
      
      function releaseResource(param1:Resource) : void;
      
      function releaseResources(param1:Vector.<Resource>) : void;
      
      function uploadResource(param1:Resource) : void;
   }
}

