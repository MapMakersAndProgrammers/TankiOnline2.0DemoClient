package alternativa.model.general.quadro
{
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;
   import platform.client.fp10.core.type.IGameObject;
   
   public class IQuadroEvents implements IQuadro
   {
      
      private var object:IGameObject;
      
      private var impl:Vector.<IQuadro>;
      
      public function IQuadroEvents(param1:IGameObject, param2:Vector.<IModel>)
      {
         super();
         this.object = param1;
         this.impl = new Vector.<IQuadro>();
         var _loc3_:int = 0;
         while(_loc3_ < param2.length)
         {
            this.impl.push(param2[_loc3_]);
            _loc3_++;
         }
      }
      
      public function calc(param1:int, param2:int) : int
      {
         var _loc4_:int = 0;
         Model.object = this.object;
         var _loc3_:int = 0;
         while(_loc3_ < this.impl.length)
         {
            _loc4_ = this.impl[_loc3_].calc(param1,param2);
            _loc3_++;
         }
         Model.popObject();
         return _loc4_;
      }
      
      public function load() : void
      {
         Model.object = this.object;
         var _loc1_:int = 0;
         while(_loc1_ < this.impl.length)
         {
            this.impl[_loc1_].load();
            _loc1_++;
         }
         Model.popObject();
      }
   }
}

