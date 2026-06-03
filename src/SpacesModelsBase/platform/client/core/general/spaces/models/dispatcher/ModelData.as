package platform.client.core.general.spaces.models.dispatcher
{
   import alternativa.types.Long;
   
   public class ModelData
   {
      
      private var _data:Object;
      
      private var _id:Long;
      
      public function ModelData(param1:Object, param2:Long)
      {
         super();
         this._data = param1;
         this._id = param2;
      }
      
      public function get data() : Object
      {
         return this._data;
      }
      
      public function set data(param1:Object) : void
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
      
      public function toString() : String
      {
         var _loc1_:String = "ModelData [";
         _loc1_ += "data = " + this.data + " ";
         _loc1_ += "id = " + this.id + " ";
         return _loc1_ + "]";
      }
   }
}

