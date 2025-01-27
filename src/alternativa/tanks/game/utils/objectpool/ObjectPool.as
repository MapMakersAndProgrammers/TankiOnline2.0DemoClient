package alternativa.tanks.game.utils.objectpool
{
   public class ObjectPool
   {
      private var objectClass:Class;
      
      private var objects:Vector.<Object> = new Vector.<Object>();
      
      private var numObjects:int;
      
      public function ObjectPool(objectClass:Class)
      {
         super();
         this.objectClass = objectClass;
      }
      
      public function name_110() : Object
      {
         if(this.numObjects == 0)
         {
            return new this.objectClass(this);
         }
         var object:Object = this.objects[--this.numObjects];
         this.objects[this.numObjects] = null;
         return object;
      }
      
      public function clear() : void
      {
         this.objects.length = 0;
         this.numObjects = 0;
      }
      
      internal function name_425(object:Object) : void
      {
         var _loc2_:* = this.numObjects++;
         this.objects[_loc2_] = object;
      }
   }
}

