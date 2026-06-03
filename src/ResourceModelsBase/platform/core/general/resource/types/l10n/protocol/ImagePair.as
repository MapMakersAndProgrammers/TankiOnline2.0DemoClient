package platform.core.general.resource.types.l10n.protocol
{
   public class ImagePair
   {
      
      private var _key:String;
      
      private var _value:Vector.<int>;
      
      public function ImagePair(param1:String, param2:Vector.<int>)
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
      
      public function get value() : Vector.<int>
      {
         return this._value;
      }
      
      public function set value(param1:Vector.<int>) : void
      {
         this._value = param1;
      }
      
      public function toString() : String
      {
         var _loc1_:String = "ImagePair [";
         _loc1_ += "key = " + this.key + " ";
         _loc1_ += "value = " + this.value + " ";
         return _loc1_ + "]";
      }
   }
}

