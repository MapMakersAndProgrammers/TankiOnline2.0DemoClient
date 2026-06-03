package platform.client.fp10.core.model
{
   import platform.client.fp10.core.model.impl.Model;
   import platform.client.fp10.core.type.IGameObject;
   
   public class IObjectLoadListenerEvents implements IObjectLoadListener
   {
      
      private var object:IGameObject;
      
      private var impl:Vector.<IObjectLoadListener>;
      
      public function IObjectLoadListenerEvents(param1:IGameObject, param2:Vector.<IModel>)
      {
         super();
         this.object = param1;
         this.impl = new Vector.<IObjectLoadListener>();
         var _loc3_:int = 0;
         while(_loc3_ < param2.length)
         {
            this.impl.push(param2[_loc3_]);
            _loc3_++;
         }
      }
      
      public function objectLoaded() : void
      {
         Model.object = this.object;
         var _loc1_:int = 0;
         while(_loc1_ < this.impl.length)
         {
            this.impl[_loc1_].objectLoaded();
            _loc1_++;
         }
         Model.popObject();
      }
      
      public function objectLoadedPost() : void
      {
         Model.object = this.object;
         var _loc1_:int = 0;
         while(_loc1_ < this.impl.length)
         {
            this.impl[_loc1_].objectLoadedPost();
            _loc1_++;
         }
         Model.popObject();
      }
      
      public function objectUnloaded() : void
      {
         Model.object = this.object;
         var _loc1_:int = 0;
         while(_loc1_ < this.impl.length)
         {
            this.impl[_loc1_].objectUnloaded();
            _loc1_++;
         }
         Model.popObject();
      }
      
      public function objectUnloadedPost() : void
      {
         Model.object = this.object;
         var _loc1_:int = 0;
         while(_loc1_ < this.impl.length)
         {
            this.impl[_loc1_].objectUnloadedPost();
            _loc1_++;
         }
         Model.popObject();
      }
   }
}

