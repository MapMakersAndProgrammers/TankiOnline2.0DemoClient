package platform.client.core.general.spaces.models.dispatcher
{
   import alternativa.types.Long;
   
   public class LoadObjectStruct
   {
      
      private var _data:Vector.<ModelData>;
      
      private var _id:Long;
      
      private var _parent:Long;
      
      public function LoadObjectStruct(param1:Vector.<ModelData>, param2:Long, param3:Long)
      {
         super();
         this._data = param1;
         this._id = param2;
         this._parent = param3;
      }
      
      public function get data() : Vector.<ModelData>
      {
         return this._data;
      }
      
      public function set data(param1:Vector.<ModelData>) : void
      {
         this._data = param1;
      }
      
      public function get id() : Long
      {
         return this._id;
      }
      
      public function set id(param1:Long) : void
      {
         this._id = param1;
      }
      
      public function get parent() : Long
      {
         return this._parent;
      }
      
      public function set parent(param1:Long) : void
      {
         this._parent = param1;
      }
      
      public function toString() : String
      {
         var _loc1_:String = "LoadObjectStruct [";
         _loc1_ += "data = " + this.data + " ";
         _loc1_ += "id = " + this.id + " ";
         _loc1_ += "parent = " + this.parent + " ";
         return _loc1_ + "]";
      }
   }
}

