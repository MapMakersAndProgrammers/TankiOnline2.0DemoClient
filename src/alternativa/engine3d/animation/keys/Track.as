package alternativa.engine3d.animation.keys
{
   import alternativa.engine3d.alternativa3d;
   import alternativa.engine3d.animation.AnimationState;
   
   use namespace alternativa3d;
   
   public class Track
   {
      public var object:String;
      
      alternativa3d var name_YC:Number = 0;
      
      public function Track()
      {
         super();
      }
      
      public function get length() : Number
      {
         return this.name_YC;
      }
      
      alternativa3d function get keyFramesList() : Keyframe
      {
         return null;
      }
      
      alternativa3d function set keyFramesList(value:Keyframe) : void
      {
      }
      
      alternativa3d function addKeyToList(key:Keyframe) : void
      {
         var _loc3_:Keyframe = null;
         var time:Number = key.name_qC;
         if(this.alternativa3d::keyFramesList == null)
         {
            this.alternativa3d::keyFramesList = key;
            this.name_YC = time <= 0 ? 0 : time;
            return;
         }
         if(this.alternativa3d::keyFramesList.name_qC > time)
         {
            key.alternativa3d::nextKeyFrame = this.alternativa3d::keyFramesList;
            this.alternativa3d::keyFramesList = key;
            return;
         }
         _loc3_ = this.alternativa3d::keyFramesList;
         while(_loc3_.alternativa3d::nextKeyFrame != null && _loc3_.alternativa3d::nextKeyFrame.name_qC <= time)
         {
            _loc3_ = _loc3_.alternativa3d::nextKeyFrame;
         }
         if(_loc3_.alternativa3d::nextKeyFrame == null)
         {
            _loc3_.alternativa3d::nextKeyFrame = key;
            this.name_YC = time <= 0 ? 0 : time;
         }
         else
         {
            key.alternativa3d::nextKeyFrame = _loc3_.alternativa3d::nextKeyFrame;
            _loc3_.alternativa3d::nextKeyFrame = key;
         }
      }
      
      public function removeKey(key:Keyframe) : Keyframe
      {
         var k:Keyframe = null;
         if(this.alternativa3d::keyFramesList != null)
         {
            if(this.alternativa3d::keyFramesList == key)
            {
               this.alternativa3d::keyFramesList = this.alternativa3d::keyFramesList.alternativa3d::nextKeyFrame;
               if(this.alternativa3d::keyFramesList == null)
               {
                  this.name_YC = 0;
               }
               return key;
            }
            k = this.alternativa3d::keyFramesList;
            while(k.alternativa3d::nextKeyFrame != null && k.alternativa3d::nextKeyFrame != key)
            {
               k = k.alternativa3d::nextKeyFrame;
            }
            if(k.alternativa3d::nextKeyFrame == key)
            {
               if(key.alternativa3d::nextKeyFrame == null)
               {
                  this.name_YC = k.name_qC <= 0 ? 0 : k.name_qC;
               }
               k.alternativa3d::nextKeyFrame = key.alternativa3d::nextKeyFrame;
               return key;
            }
         }
         throw new Error("Key not found");
      }
      
      public function get keys() : Vector.<Keyframe>
      {
         var result:Vector.<Keyframe> = new Vector.<Keyframe>();
         var i:int = 0;
         for(var key:Keyframe = this.alternativa3d::keyFramesList; key != null; key = key.alternativa3d::nextKeyFrame)
         {
            result[i] = key;
            i++;
         }
         return result;
      }
      
      alternativa3d function blend(time:Number, weight:Number, state:AnimationState) : void
      {
      }
      
      public function slice(start:Number, end:Number = 1.7976931348623157e+308) : Track
      {
         return null;
      }
      
      alternativa3d function createKeyFrame() : Keyframe
      {
         return null;
      }
      
      alternativa3d function interpolateKeyFrame(dest:Keyframe, a:Keyframe, b:Keyframe, value:Number) : void
      {
      }
      
      alternativa3d function sliceImplementation(dest:Track, start:Number, end:Number) : void
      {
         var prev:Keyframe = null;
         var nextKey:Keyframe = null;
         var shiftTime:Number = start > 0 ? start : 0;
         var next:Keyframe = this.alternativa3d::keyFramesList;
         var key:Keyframe = this.alternativa3d::createKeyFrame();
         while(next != null && next.name_qC <= start)
         {
            prev = next;
            next = next.alternativa3d::nextKeyFrame;
         }
         if(prev != null)
         {
            if(next != null)
            {
               this.alternativa3d::interpolateKeyFrame(key,prev,next,(start - prev.name_qC) / (next.name_qC - prev.name_qC));
               key.name_qC = start - shiftTime;
            }
            else
            {
               this.alternativa3d::interpolateKeyFrame(key,key,prev,1);
            }
         }
         else
         {
            if(next == null)
            {
               return;
            }
            this.alternativa3d::interpolateKeyFrame(key,key,next,1);
            key.name_qC = next.name_qC - shiftTime;
            prev = next;
            next = next.alternativa3d::nextKeyFrame;
         }
         dest.alternativa3d::keyFramesList = key;
         if(next == null || end <= start)
         {
            dest.name_YC = key.name_qC <= 0 ? 0 : key.name_qC;
            return;
         }
         while(next != null && next.name_qC <= end)
         {
            nextKey = this.alternativa3d::createKeyFrame();
            this.alternativa3d::interpolateKeyFrame(nextKey,nextKey,next,1);
            nextKey.name_qC = next.name_qC - shiftTime;
            key.alternativa3d::nextKeyFrame = nextKey;
            key = nextKey;
            prev = next;
            next = next.alternativa3d::nextKeyFrame;
         }
         if(next != null)
         {
            nextKey = this.alternativa3d::createKeyFrame();
            this.alternativa3d::interpolateKeyFrame(nextKey,prev,next,(end - prev.name_qC) / (next.name_qC - prev.name_qC));
            nextKey.name_qC = end - shiftTime;
            key.alternativa3d::nextKeyFrame = nextKey;
         }
         if(nextKey != null)
         {
            dest.name_YC = nextKey.name_qC <= 0 ? 0 : nextKey.name_qC;
         }
      }
   }
}

