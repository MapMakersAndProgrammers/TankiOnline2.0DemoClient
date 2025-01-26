package package_20
{
   public class name_476
   {
      private static var pool:name_476;
      
      public var eventType:String;
      
      public var eventData:*;
      
      public var next:name_476;
      
      public function name_476(eventType:String, eventData:*)
      {
         super();
         this.eventType = eventType;
         this.eventData = eventData;
      }
      
      public static function create(eventType:String, eventData:*) : name_476
      {
         if(pool == null)
         {
            return new name_476(eventType,eventData);
         }
         var item:name_476 = pool;
         pool = item.next;
         item.next = null;
         item.eventType = eventType;
         item.eventData = eventData;
         return item;
      }
      
      public function destroy() : void
      {
         this.eventType = null;
         this.eventData = null;
         this.next = pool;
         pool = this;
      }
   }
}

