package alternativa.tanks.game.subsystems.rendersystem
{
   import alternativa.engine3d.core.Resource;
   import flash.display3D.Context3D;
   import flash.utils.Dictionary;
   
   public class ResourceManager implements IResourceManager
   {
      private var context:Context3D;
      
      private var var_106:Dictionary;
      
      private var var_105:Vector.<Resource>;
      
      public function ResourceManager()
      {
         super();
         this.var_106 = new Dictionary();
      }
      
      public function useResource(resource:Resource) : void
      {
         if(this.context == null)
         {
            if(this.getQueuedIndex(resource) < 0)
            {
               this.queue(resource);
            }
         }
         else
         {
            resource.upload(this.context);
         }
         var refCount:int = int(this.var_106[resource]);
         this.var_106[resource] = refCount + 1;
      }
      
      public function useResources(resources:Vector.<Resource>) : void
      {
         var resource:Resource = null;
         for each(resource in resources)
         {
            this.useResource(resource);
         }
      }
      
      public function releaseResource(resource:Resource) : void
      {
         var refCount:int = int(this.var_106[resource]);
         if(refCount > 0)
         {
            if(refCount == 1)
            {
               this.doRelease(resource);
            }
            else
            {
               this.var_106[resource] = refCount - 1;
            }
         }
      }
      
      public function releaseResources(resources:Vector.<Resource>) : void
      {
         var resource:Resource = null;
         for each(resource in resources)
         {
            this.releaseResource(resource);
         }
      }
      
      public function uploadResource(resource:Resource) : void
      {
         if(this.context == null)
         {
            this.queue(resource);
         }
         else
         {
            resource.upload(this.context);
         }
      }
      
      public function setContext(context:Context3D) : void
      {
         var resource:Resource = null;
         this.context = context;
         if(this.var_105 != null)
         {
            for each(resource in this.var_105)
            {
               resource.upload(context);
            }
            this.var_105 = null;
         }
      }
      
      public function clear() : void
      {
         var resource:* = undefined;
         if(this.context != null)
         {
            for(resource in this.var_106)
            {
               Resource(resource).dispose();
            }
         }
         this.var_105 = null;
         this.var_106 = new Dictionary();
      }
      
      private function doRelease(resource:Resource) : void
      {
         var index:int = 0;
         var num:int = 0;
         if(this.context == null)
         {
            index = this.getQueuedIndex(resource);
            if(index >= 0)
            {
               num = int(this.var_105.length);
               if(num == 1)
               {
                  this.var_105 = null;
               }
               else
               {
                  this.var_105[index] = this.var_105[--num];
                  this.var_105.length = num;
               }
            }
         }
         else
         {
            resource.dispose();
            delete this.var_106[resource];
         }
      }
      
      private function getQueuedIndex(resource:Resource) : int
      {
         if(this.var_105 == null)
         {
            return -1;
         }
         return this.var_105.indexOf(resource);
      }
      
      private function queue(resource:Resource) : void
      {
         if(this.var_105 == null)
         {
            this.var_105 = new Vector.<Resource>();
         }
         this.var_105.push(resource);
      }
   }
}

