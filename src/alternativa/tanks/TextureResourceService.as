package alternativa.tanks
{
   import alternativa.engine3d.resources.ATFTextureResource;
   import alternativa.engine3d.resources.BitmapTextureResource;
   import alternativa.tanks.game.GameKernel;
   import alternativa.tanks.game.weapons.railgun.IRailgunTargetEvaluator;
   import alternativa.tanks.game.weapons.targeting.IGenericTargetEvaluator;
   import flash.display.BitmapData;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   
   public class TextureResourceService implements ITextureResourceService
   {
      public var gameKernel:GameKernel;
      
      private var var_453:IGenericTargetEvaluator;
      
      private var var_454:IRailgunTargetEvaluator;
      
      private var var_455:IGenericTargetEvaluator;
      
      private var var_456:Dictionary;
      
      private var var_457:Dictionary;
      
      public function TextureResourceService(param1:GameKernel)
      {
         super();
         this.gameKernel = param1;
         this.var_456 = new Dictionary();
         this.var_457 = new Dictionary();
      }
      
      public function getCompressedTextureResource(param1:ByteArray) : ATFTextureResource
      {
         var _loc2_:ATFTextureResource = this.getCompressedResourceSafe(param1,true);
         if(!_loc2_.isUploaded)
         {
            this.gameKernel.getRenderSystem().useResource(_loc2_);
         }
         return _loc2_;
      }
      
      public function releaseCompressedTextureResource(param1:ByteArray) : void
      {
         var _loc2_:ATFTextureResource = this.getCompressedResourceSafe(param1,false);
         if(_loc2_ != null)
         {
            this.gameKernel.getRenderSystem().releaseResource(_loc2_);
         }
      }
      
      public function getBitmapTextureResource(param1:BitmapData) : BitmapTextureResource
      {
         var _loc2_:BitmapTextureResource = this.getBitmapResourceSafe(param1,true);
         this.gameKernel.getRenderSystem().useResource(_loc2_);
         return _loc2_;
      }
      
      public function releaseBitmapTextureResource(param1:BitmapData) : void
      {
         var _loc2_:BitmapTextureResource = this.getBitmapResourceSafe(param1,false);
         if(_loc2_ != null)
         {
            this.gameKernel.getRenderSystem().releaseResource(_loc2_);
         }
      }
      
      private function getCompressedResourceSafe(param1:ByteArray, param2:Boolean) : ATFTextureResource
      {
         var _loc3_:ATFTextureResource = this.var_456[param1];
         if(_loc3_ == null && param2)
         {
            _loc3_ = new ATFTextureResource(param1);
            this.var_456[param1] = _loc3_;
         }
         return _loc3_;
      }
      
      private function getBitmapResourceSafe(param1:BitmapData, param2:Boolean) : BitmapTextureResource
      {
         var _loc3_:BitmapTextureResource = this.var_457[param1];
         if(_loc3_ == null && param2)
         {
            _loc3_ = new BitmapTextureResource(param1);
            this.var_457[param1] = _loc3_;
         }
         return _loc3_;
      }
      
      public function clear() : void
      {
         this.gameKernel = null;
         this.var_453 = null;
         this.var_454 = null;
         this.var_455 = null;
      }
      
      public function getGenericTargetEvaluator() : IGenericTargetEvaluator
      {
         if(this.var_453 == null)
         {
            throw new Error("Generic target evaluator is not set");
         }
         return this.var_453;
      }
      
      public function setGenericTargetEvaluator(param1:IGenericTargetEvaluator) : void
      {
         this.var_453 = param1;
      }
      
      public function getRailgunTargetEvaluator() : IRailgunTargetEvaluator
      {
         if(this.var_454 == null)
         {
            throw new Error("Railgun target evaluator is not set");
         }
         return this.var_454;
      }
      
      public function setRailgunTargetEvaluator(param1:IRailgunTargetEvaluator) : void
      {
         this.var_454 = param1;
      }
      
      public function getFlamethrowerTargetEvaluator() : IGenericTargetEvaluator
      {
         if(this.var_455 == null)
         {
            throw new Error("Flame/freeze target evaluator is not set");
         }
         return this.var_455;
      }
      
      public function setFlamethrowerTargetEvaluator(param1:IGenericTargetEvaluator) : void
      {
         this.var_455 = param1;
      }
   }
}

