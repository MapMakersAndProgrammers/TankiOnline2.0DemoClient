package platform.client.core.general.spaces.models.quadrosimple
{
   import platform.client.core.general.spaces.models.quadro.Test;
   
   public interface IQuadroSimpleModelBase
   {
      
      function change(param1:int, param2:int) : void;
      
      function click(param1:int, param2:int) : void;
      
      function setTest(param1:Test) : void;
   }
}

