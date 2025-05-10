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
      
      private var name_9P:IGenericTargetEvaluator;
      
      private var name_bW:IRailgunTargetEvaluator;
      
      private var name_ci:IGenericTargetEvaluator;
      
      private var name_L1:Dictionary;
      
      private var name_ee:Dictionary;
      
      public function TextureResourceService(param1:GameKernel)
      {
         super();
         this.gameKernel = param1;
         this.name_L1 = new Dictionary();
         this.name_ee = new Dictionary();
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
         var _loc3_:ATFTextureResource = this.name_L1[param1];
         if(_loc3_ == null && param2)
         {
            _loc3_ = new ATFTextureResource(param1);
            this.name_L1[param1] = _loc3_;
         }
         return _loc3_;
      }
      
      private function getBitmapResourceSafe(param1:BitmapData, param2:Boolean) : BitmapTextureResource
      {
         var _loc3_:BitmapTextureResource = this.name_ee[param1];
         if(_loc3_ == null && param2)
         {
            _loc3_ = new BitmapTextureResource(param1);
            this.name_ee[param1] = _loc3_;
         }
         return _loc3_;
      }
      
      public function clear() : void
      {
         this.gameKernel = null;
         this.name_9P = null;
         this.name_bW = null;
         this.name_ci = null;
      }
      
      public function getGenericTargetEvaluator() : IGenericTargetEvaluator
      {
         if(this.name_9P == null)
         {
            throw new Error("Generic target evaluator is not set");
         }
         return this.name_9P;
      }
      
      public function setGenericTargetEvaluator(param1:IGenericTargetEvaluator) : void
      {
         this.name_9P = param1;
      }
      
      public function getRailgunTargetEvaluator() : IRailgunTargetEvaluator
      {
         if(this.name_bW == null)
         {
            throw new Error("Railgun target evaluator is not set");
         }
         return this.name_bW;
      }
      
      public function setRailgunTargetEvaluator(param1:IRailgunTargetEvaluator) : void
      {
         this.name_bW = param1;
      }
      
      public function getFlamethrowerTargetEvaluator() : IGenericTargetEvaluator
      {
         if(this.name_ci == null)
         {
            throw new Error("Flame/freeze target evaluator is not set");
         }
         return this.name_ci;
      }
      
      public function setFlamethrowerTargetEvaluator(param1:IGenericTargetEvaluator) : void
      {
         this.name_ci = param1;
      }
   }
}

