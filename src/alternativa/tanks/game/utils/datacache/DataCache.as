package alternativa.tanks.game.utils.datacache
{
   import flash.utils.Dictionary;
   
   public class DataCache
   {
      private var map:Dictionary;
      
      public function DataCache()
      {
         super();
         this.map = new Dictionary();
      }
      
      public function getData(key:Object, factory:IDataFactory = null) : Object
      {
         var data:Object = this.map[key];
         if(data == null && factory != null)
         {
            data = factory.createData(key);
            this.map[key] = data;
         }
         return data;
      }
      
      public function getKeys() : Vector.<Object>
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

