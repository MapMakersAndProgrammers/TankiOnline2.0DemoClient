package platform.client.fp10.core.model
{
   import platform.client.fp10.core.model.impl.Model;
   import platform.client.fp10.core.type.IGameObject;
   
   public class IObjectLoadListenerAdapt implements IObjectLoadListener
   {
      
      private var object:IGameObject;
      
      private var impl:IObjectLoadListener;
      
      public function IObjectLoadListenerAdapt(param1:IGameObject, param2:IObjectLoadListener)
      {
         super();
         this.object = param1;
         this.impl = param2;
      }
      
      public function objectLoaded() : void
      {
         Model.object = this.object;
         this.impl.objectLoaded();
         Model.popObject();
      }
      
      public function objectLoadedPost() : void
      {
         Model.object = this.object;
         this.impl.objectLoadedPost();
         Model.popObject();
      }
      
      public function objectUnloaded() : void
      {
         Model.object = this.object;
         this.impl.objectUnloaded();
         Model.popObject();
      }
      
      public function objectUnloadedPost() : void
      {
         Model.object = this.object;
         this.impl.objectUnloadedPost();
         Model.popObject();
      }
   }
}

