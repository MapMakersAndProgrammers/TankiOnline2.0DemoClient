package alternativa.tanks
{
   import flash.display.BitmapData;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   import package_10.name_17;
   import package_117.name_542;
   import package_28.name_241;
   import package_28.name_93;
   import package_79.name_326;
   
   public class TextureResourceService implements ITextureResourceService
   {
      public var gameKernel:name_17;
      
      private var var_455:name_326;
      
      private var var_453:name_542;
      
      private var var_454:name_326;
      
      private var var_457:Dictionary;
      
      private var var_456:Dictionary;
      
      public function TextureResourceService(param1:name_17)
      {
         super();
         this.gameKernel = param1;
         this.var_457 = new Dictionary();
         this.var_456 = new Dictionary();
      }
      
      public function name_254(param1:ByteArray) : name_241
      {
         var _loc2_:name_241 = this.getCompressedResourceSafe(param1,true);
         if(!_loc2_.isUploaded)
         {
            this.gameKernel.name_5().method_29(_loc2_);
         }
         return _loc2_;
      }
      
      public function method_435(param1:ByteArray) : void
      {
         var _loc2_:name_241 = this.getCompressedResourceSafe(param1,false);
         if(_loc2_ != null)
         {
            this.gameKernel.name_5().method_28(_loc2_);
         }
      }
      
      public function name_320(param1:BitmapData) : name_93
      {
         var _loc2_:name_93 = this.getBitmapResourceSafe(param1,true);
         this.gameKernel.name_5().method_29(_loc2_);
         return _loc2_;
      }
      
      public function method_434(param1:BitmapData) : void
      {
         var _loc2_:name_93 = this.getBitmapResourceSafe(param1,false);
         if(_loc2_ != null)
         {
            this.gameKernel.name_5().method_28(_loc2_);
         }
      }
      
      private function getCompressedResourceSafe(param1:ByteArray, param2:Boolean) : name_241
      {
         var _loc3_:name_241 = this.var_457[param1];
         if(_loc3_ == null && param2)
         {
            _loc3_ = new name_241(param1);
            this.var_457[param1] = _loc3_;
         }
         return _loc3_;
      }
      
      private function getBitmapResourceSafe(param1:BitmapData, param2:Boolean) : name_93
      {
         var _loc3_:name_93 = this.var_456[param1];
         if(_loc3_ == null && param2)
         {
            _loc3_ = new name_93(param1);
            this.var_456[param1] = _loc3_;
         }
         return _loc3_;
      }
      
      public function clear() : void
      {
         this.gameKernel = null;
         this.var_455 = null;
         this.var_453 = null;
         this.var_454 = null;
      }
      
      public function method_440() : name_326
      {
         if(this.var_455 == null)
         {
            throw new Error("Generic target evaluator is not set");
         }
         return this.var_455;
      }
      
      public function method_439(param1:name_326) : void
      {
         this.var_455 = param1;
      }
      
      public function method_443() : name_542
      {
         if(this.var_453 == null)
         {
            throw new Error("Railgun target evaluator is not set");
         }
         return this.var_453;
      }
      
      public function method_438(param1:name_542) : void
      {
         this.var_453 = param1;
      }
      
      public function method_441() : name_326
      {
         if(this.var_454 == null)
         {
            throw new Error("Flame/freeze target evaluator is not set");
         }
         return this.var_454;
      }
      
      public function method_442(param1:name_326) : void
      {
         this.var_454 = param1;
      }
   }
}

