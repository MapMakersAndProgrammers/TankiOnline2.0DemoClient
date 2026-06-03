package platform.client.core.general.spaces.models.quadrosimple
{
   import platform.client.fp10.core.resource.types.ImageResource;
   
   public class QuadroSimpleModelCC
   {
      
      private var _imageType:ImageResource;
      
      private var _listString:Vector.<String>;
      
      private var _name:String;
      
      public function QuadroSimpleModelCC(param1:ImageResource, param2:Vector.<String>, param3:String)
      {
         super();
         this._imageType = param1;
         this._listString = param2;
         this._name = param3;
      }
      
      public function get imageType() : ImageResource
      {
         return this._imageType;
      }
      
      public function set imageType(param1:ImageResource) : void
      {
         this._imageType = param1;
      }
      
      public function get listString() : Vector.<String>
      {
         return this._listString;
      }
      
      public function set listString(param1:Vector.<String>) : void
      {
         this._listString = param1;
      }
      
      public function get name() : String
      {
         return this._name;
      }
      
      public function set name(param1:String) : void
      {
         this._name = param1;
      }
      
      public function toString() : String
      {
         var _loc1_:String = "QuadroSimpleModelCC [";
         _loc1_ += "imageType = " + this.imageType + " ";
         _loc1_ += "listString = " + this.listString + " ";
         _loc1_ += "name = " + this.name + " ";
         return _loc1_ + "]";
      }
   }
}

