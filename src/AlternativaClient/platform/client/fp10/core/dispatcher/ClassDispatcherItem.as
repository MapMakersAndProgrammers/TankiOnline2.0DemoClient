package platform.client.fp10.core.dispatcher
{
   import alternativa.protocol.ProtocolBuffer;
   import alternativa.types.Long;
   
   public class ClassDispatcherItem extends DispatcherItem
   {
      
      public var classId:Long;
      
      public var parentId:Long;
      
      public var modelIds:Vector.<Long>;
      
      public var buffer:ProtocolBuffer;
      
      public var optionalMapPosition:int;
      
      public function ClassDispatcherItem(param1:Long, param2:Long, param3:Vector.<Long>, param4:ProtocolBuffer, param5:int)
      {
         super(DispatcherItem.CLASS);
         this.classId = param1;
         this.parentId = param2;
         this.modelIds = param3;
         this.buffer = param4;
         this.optionalMapPosition = param5;
      }
      
      override public function toString() : String
      {
         return "[Class id=" + this.classId + "]";
      }
   }
}

