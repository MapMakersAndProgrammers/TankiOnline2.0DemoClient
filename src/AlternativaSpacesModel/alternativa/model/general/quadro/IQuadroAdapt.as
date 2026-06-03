package alternativa.model.general.quadro
{
   import platform.client.fp10.core.model.impl.Model;
   import platform.client.fp10.core.type.IGameObject;
   
   public class IQuadroAdapt implements IQuadro
   {
      
      private var object:IGameObject;
      
      private var impl:IQuadro;
      
      public function IQuadroAdapt(param1:IGameObject, param2:IQuadro)
      {
         super();
         this.object = param1;
         this.impl = param2;
      }
      
      public function calc(param1:int, param2:int) : int
      {
         Model.object = this.object;
         var _loc3_:int = this.impl.calc(param1,param2);
         Model.popObject();
         return _loc3_;
      }
      
      public function load() : void
      {
         Model.object = this.object;
         this.impl.load();
         Model.popObject();
      }
   }
}

