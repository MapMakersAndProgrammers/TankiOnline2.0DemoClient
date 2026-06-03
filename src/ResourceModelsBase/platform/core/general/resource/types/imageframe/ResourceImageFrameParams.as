package platform.core.general.resource.types.imageframe
{
   public class ResourceImageFrameParams
   {
      
      private var _alpha:Boolean;
      
      private var _h:int;
      
      private var _w:int;
      
      public function ResourceImageFrameParams(param1:Boolean, param2:int, param3:int)
      {
         super();
         this._alpha = param1;
         this._h = param2;
         this._w = param3;
      }
      
      public function get alpha() : Boolean
      {
         return this._alpha;
      }
      
      public function set alpha(param1:Boolean) : void
      {
         this._alpha = param1;
      }
      
      public function get h() : int
      {
         return this._h;
      }
      
      public function set h(param1:int) : void
      {
         this._h = param1;
      }
      
      public function get w() : int
      {
         return this._w;
      }
      
      public function set w(param1:int) : void
      {
         this._w = param1;
      }
      
      public function toString() : String
      {
         var _loc1_:String = "ResourceImageFrameParams [";
         _loc1_ += "alpha = " + this.alpha + " ";
         _loc1_ += "h = " + this.h + " ";
         _loc1_ += "w = " + this.w + " ";
         return _loc1_ + "]";
      }
   }
}

