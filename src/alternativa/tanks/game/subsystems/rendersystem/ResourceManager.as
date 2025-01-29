package alternativa.tanks.game.subsystems.rendersystem
{
   import flash.display3D.Context3D;
   import flash.utils.Dictionary;
   import package_21.name_77;
   
   public class ResourceManager implements IResourceManager
   {
      private var context:Context3D;
      
      private var var_106:Dictionary;
      
      private var var_105:Vector.<name_77>;
      
      public function ResourceManager()
      {
         super();
         this.var_106 = new Dictionary();
      }
      
      public function method_29(resource:name_77) : void
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
      
      public function method_32(resources:Vector.<name_77>) : void
      {
         var resource:name_77 = null;
         for each(resource in resources)
         {
            this.method_29(resource);
         }
      }
      
      public function method_28(resource:name_77) : void
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
      
      public function method_31(resources:Vector.<name_77>) : void
      {
         var resource:name_77 = null;
         for each(resource in resources)
         {
            this.method_28(resource);
         }
      }
      
      public function method_30(resource:name_77) : void
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
      
      public function name_105(context:Context3D) : void
      {
         var resource:name_77 = null;
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
               name_77(resource).dispose();
            }
         }
         this.var_105 = null;
         this.var_106 = new Dictionary();
      }
      
      private function doRelease(resource:name_77) : void
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
      
      private function getQueuedIndex(resource:name_77) : int
      {
         if(this.var_105 == null)
         {
            return -1;
         }
         return this.var_105.indexOf(resource);
      }
      
      private function queue(resource:name_77) : void
      {
         if(this.var_105 == null)
         {
            this.var_105 = new Vector.<name_77>();
         }
         this.var_105.push(resource);
      }
   }
}

