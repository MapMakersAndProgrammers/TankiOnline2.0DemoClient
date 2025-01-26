package package_73
{
   import flash.utils.Dictionary;
   
   public class name_293
   {
      private var map:Dictionary;
      
      public function name_293()
      {
         super();
         this.map = new Dictionary();
      }
      
      public function method_84(key:Object, factory:class_13 = null) : Object
      {
         var data:Object = this.map[key];
         if(data == null && factory != null)
         {
            data = factory.createData(key);
            this.map[key] = data;
         }
         return data;
      }
      
      public function method_374() : Vector.<Object>
      {
         var key:* = undefined;
         var keys:Vector.<Object> = new Vector.<Object>();
         for(key in this.map)
         {
            keys.push(key);
         }
         return keys;
      }
      
      public function clear() : void
      {
         this.map = new Dictionary();
      }
   }
}

