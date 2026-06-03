package platform.core.general.resource.types.l10n.protocol
{
   public class StringPair
   {
      
      private var _key:String;
      
      private var _value:String;
      
      public function StringPair(param1:String, param2:String)
      {
         super();
         this._key = param1;
         this._value = param2;
      }
      
      public function get key() : String
      {
         return this._key;
      }
      
      public function set key(param1:String) : void
      {
         this._key = param1;
      }
      
      public function get value() : String
      {
         return this._value;
      }
      
      public function set value(param1:String) : void
      {
         this._value = param1;
      }
      
      public function toString() : String
      {
         var _loc1_:String = "StringPair [";
         _loc1_ += "key = " + this.key + " ";
         _loc1_ += "value = " + this.value + " ";
         return _loc1_ + "]";
      }
   }
}

