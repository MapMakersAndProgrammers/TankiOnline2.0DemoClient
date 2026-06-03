package platform.core.general.resource.types.swf
{
   public class ResourceSWFParams
   {
      
      private var _keys:Vector.<String>;
      
      private var _values:Vector.<String>;
      
      public function ResourceSWFParams(param1:Vector.<String>, param2:Vector.<String>)
      {
         super();
         this._keys = param1;
         this._values = param2;
      }
      
      public function get keys() : Vector.<String>
      {
         return this._keys;
      }
      
      public function set keys(param1:Vector.<String>) : void
      {
         this._keys = param1;
      }
      
      public function get values() : Vector.<String>
      {
         return this._values;
      }
      
      public function set values(param1:Vector.<String>) : void
      {
         this._values = param1;
      }
      
      public function toString() : String
      {
         var _loc1_:String = "ResourceSWFParams [";
         _loc1_ += "keys = " + this.keys + " ";
         _loc1_ += "values = " + this.values + " ";
         return _loc1_ + "]";
      }
   }
}

