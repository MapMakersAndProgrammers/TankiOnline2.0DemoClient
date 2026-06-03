package platform.client.fp10.core.network
{
   public class ConnectionCloseStatus
   {
      
      public static const CLOSED_BY_SERVER:ConnectionCloseStatus = new ConnectionCloseStatus("CLOSED_BY_SERVER");
      
      public static const CONNECTION_ERROR:ConnectionCloseStatus = new ConnectionCloseStatus("CONNECTION_ERROR");
      
      public static const DATA_PROCESSING_ERROR:ConnectionCloseStatus = new ConnectionCloseStatus("DATA_PROCESSING_ERROR");
      
      public static const SPACE_CLOSED:ConnectionCloseStatus = new ConnectionCloseStatus("SPACE_CLOSED");
      
      private var _value:String;
      
      public function ConnectionCloseStatus(param1:String)
      {
         super();
         this._value = param1;
      }
      
      public function toString() : String
      {
         return this._value;
      }
   }
}

