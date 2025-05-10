package alternativa.tanks.game.subsystems.rendersystem
{
   import alternativa.engine3d.core.Resource;
   import flash.display3D.Context3D;
   import flash.utils.Dictionary;
   
   public class ResourceManager implements IResourceManager
   {
      private var context:Context3D;
      
      private var name_hg:Dictionary;
      
      private var name_Wf:Vector.<Resource>;
      
      public function ResourceManager()
      {
         super();
         this.name_hg = new Dictionary();
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
         var refCount:int = int(this.name_hg[resource]);
         this.name_hg[resource] = refCount + 1;
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
         var refCount:int = int(this.name_hg[resource]);
         if(refCount > 0)
         {
            if(refCount == 1)
            {
               this.doRelease(resource);
            }
            else
            {
               this.name_hg[resource] = refCount - 1;
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
         if(this.name_Wf != null)
         {
            for each(resource in this.name_Wf)
            {
               resource.upload(context);
            }
            this.name_Wf = null;
         }
      }
      
      public function clear() : void
      {
         var resource:* = undefined;
         if(this.context != null)
         {
            for(resource in this.name_hg)
            {
               Resource(resource).dispose();
            }
         }
         this.name_Wf = null;
         this.name_hg = new Dictionary();
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
               num = int(this.name_Wf.length);
               if(num == 1)
               {
                  this.name_Wf = null;
               }
               else
               {
                  this.name_Wf[index] = this.name_Wf[--num];
                  this.name_Wf.length = num;
               }
            }
         }
         else
         {
            resource.dispose();
            delete this.name_hg[resource];
         }
      }
      
      private function getQueuedIndex(resource:Resource) : int
      {
         if(this.name_Wf == null)
         {
            return -1;
         }
         return this.name_Wf.indexOf(resource);
      }
      
      private function queue(resource:Resource) : void
      {
         if(this.name_Wf == null)
         {
            this.name_Wf = new Vector.<Resource>();
         }
         this.name_Wf.push(resource);
      }
   }
}

