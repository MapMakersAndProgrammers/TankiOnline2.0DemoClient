package platform.client.core.general.spaces.models.tests.selfunload
{
   import alternativa.types.Long;
   
   public class SelfUnloadModelCC
   {
      
      private var _ind:Long;
      
      private var _str:String;
      
      public function SelfUnloadModelCC(param1:Long, param2:String)
      {
         super();
         this._ind = param1;
         this._str = param2;
      }
      
      public function get ind() : Long
      {
         return this._ind;
      }
      
      public function set ind(param1:Long) : void
      {
         this._ind = param1;
      }
      
      public function get str() : String
      {
         return this._str;
      }
      
      public function set str(param1:String) : void
      {
         this._str = param1;
      }
      
      public function toString() : String
      {
         var _loc1_:String = "SelfUnloadModelCC [";
         _loc1_ += "ind = " + this.ind + " ";
         _loc1_ += "str = " + this.str + " ";
         return _loc1_ + "]";
      }
   }
}

