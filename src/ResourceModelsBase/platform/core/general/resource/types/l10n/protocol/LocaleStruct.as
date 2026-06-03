package platform.core.general.resource.types.l10n.protocol
{
   public class LocaleStruct
   {
      
      private var _booleans:Vector.<BooleanPair>;
      
      private var _doubles:Vector.<DoublePair>;
      
      private var _images:Vector.<ImagePair>;
      
      private var _ints:Vector.<IntPair>;
      
      private var _prefix:String;
      
      private var _strings:Vector.<StringPair>;
      
      public function LocaleStruct(param1:Vector.<BooleanPair>, param2:Vector.<DoublePair>, param3:Vector.<ImagePair>, param4:Vector.<IntPair>, param5:String, param6:Vector.<StringPair>)
      {
         super();
         this._booleans = param1;
         this._doubles = param2;
         this._images = param3;
         this._ints = param4;
         this._prefix = param5;
         this._strings = param6;
      }
      
      public function get booleans() : Vector.<BooleanPair>
      {
         return this._booleans;
      }
      
      public function set booleans(param1:Vector.<BooleanPair>) : void
      {
         this._booleans = param1;
      }
      
      public function get doubles() : Vector.<DoublePair>
      {
         return this._doubles;
      }
      
      public function set doubles(param1:Vector.<DoublePair>) : void
      {
         this._doubles = param1;
      }
      
      public function get images() : Vector.<ImagePair>
      {
         return this._images;
      }
      
      public function set images(param1:Vector.<ImagePair>) : void
      {
         this._images = param1;
      }
      
      public function get ints() : Vector.<IntPair>
      {
         return this._ints;
      }
      
      public function set ints(param1:Vector.<IntPair>) : void
      {
         this._ints = param1;
      }
      
      public function get prefix() : String
      {
         return this._prefix;
      }
      
      public function set prefix(param1:String) : void
      {
         this._prefix = param1;
      }
      
      public function get strings() : Vector.<StringPair>
      {
         return this._strings;
      }
      
      public function set strings(param1:Vector.<StringPair>) : void
      {
         this._strings = param1;
      }
      
      public function toString() : String
      {
         var _loc1_:String = "LocaleStruct [";
         _loc1_ += "booleans = " + this.booleans + " ";
         _loc1_ += "doubles = " + this.doubles + " ";
         _loc1_ += "images = " + this.images + " ";
         _loc1_ += "ints = " + this.ints + " ";
         _loc1_ += "prefix = " + this.prefix + " ";
         _loc1_ += "strings = " + this.strings + " ";
         return _loc1_ + "]";
      }
   }
}

