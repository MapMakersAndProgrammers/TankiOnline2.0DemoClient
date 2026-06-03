package platform.client.core.general.spaces.models.quadro
{
   public class Test
   {
      
      private var _listString:Vector.<String>;
      
      private var _value:int;
      
      private var _valueNull:int;
      
      public function Test(param1:Vector.<String>, param2:int, param3:int)
      {
         super();
         this._listString = param1;
         this._value = param2;
         this._valueNull = param3;
      }
      
      public function get listString() : Vector.<String>
      {
         return this._listString;
      }
      
      public function set listString(param1:Vector.<String>) : void
      {
         this._listString = param1;
      }
      
      public function get value() : int
      {
         return this._value;
      }
      
      public function set value(param1:int) : void
      {
         this._value = param1;
      }
      
      public function get valueNull() : int
      {
         return this._valueNull;
      }
      
      public function set valueNull(param1:int) : void
      {
         this._valueNull = param1;
      }
      
      public function toString() : String
      {
         var _loc1_:String = "Test [";
         _loc1_ += "listString = " + this.listString + " ";
         _loc1_ += "value = " + this.value + " ";
         _loc1_ += "valueNull = " + this.valueNull + " ";
         return _loc1_ + "]";
      }
   }
}

