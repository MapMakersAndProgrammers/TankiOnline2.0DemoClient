package §_-9n§
{
   import §_-OZ§.§_-SK§;
   import alternativa.engine3d.alternativa3d;
   
   use namespace alternativa3d;
   
   public class §_-Np§
   {
      public var object:String;
      
      alternativa3d var §_-YC§:Number = 0;
      
      public function §_-Np§()
      {
         super();
      }
      
      public function get length() : Number
      {
         return this.alternativa3d::_-YC;
      }
      
      alternativa3d function get keyFramesList() : §_-NS§
      {
         return null;
      }
      
      alternativa3d function set keyFramesList(value:§_-NS§) : void
      {
      }
      
      alternativa3d function §_-K1§(key:§_-NS§) : void
      {
         var k:§_-NS§ = null;
         var time:Number = Number(key.alternativa3d::_-qC);
         if(this.alternativa3d::keyFramesList == null)
         {
            this.alternativa3d::keyFramesList = key;
            this.alternativa3d::_-YC = time <= 0 ? 0 : time;
            return;
         }
         if(this.alternativa3d::keyFramesList.alternativa3d::_-qC > time)
         {
            key.alternativa3d::nextKeyFrame = this.alternativa3d::keyFramesList;
            this.alternativa3d::keyFramesList = key;
            return;
         }
         k = this.alternativa3d::keyFramesList;
         while(k.alternativa3d::nextKeyFrame != null && k.alternativa3d::nextKeyFrame.alternativa3d::_-qC <= time)
         {
            k = k.alternativa3d::nextKeyFrame;
         }
         if(k.alternativa3d::nextKeyFrame == null)
         {
            k.alternativa3d::nextKeyFrame = key;
            this.alternativa3d::_-YC = time <= 0 ? 0 : time;
         }
         else
         {
            key.alternativa3d::nextKeyFrame = k.alternativa3d::nextKeyFrame;
            k.alternativa3d::nextKeyFrame = key;
         }
      }
      
      public function §_-dg§(key:§_-NS§) : §_-NS§
      {
         var k:§_-NS§ = null;
         if(this.alternativa3d::keyFramesList != null)
         {
            if(this.alternativa3d::keyFramesList == key)
            {
               this.alternativa3d::keyFramesList = this.alternativa3d::keyFramesList.alternativa3d::nextKeyFrame;
               if(this.alternativa3d::keyFramesList == null)
               {
                  this.alternativa3d::_-YC = 0;
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
                  this.alternativa3d::_-YC = k.alternativa3d::_-qC <= 0 ? 0 : Number(k.alternativa3d::_-qC);
               }
               k.alternativa3d::nextKeyFrame = key.alternativa3d::nextKeyFrame;
               return key;
            }
         }
         throw new Error("Key not found");
      }
      
      public function get keys() : Vector.<§_-NS§>
      {
         var result:Vector.<§_-NS§> = new Vector.<§_-NS§>();
         var i:int = 0;
         for(var key:§_-NS§ = this.alternativa3d::keyFramesList; key != null; key = key.alternativa3d::nextKeyFrame)
         {
            result[i] = key;
            i++;
         }
         return result;
      }
      
      alternativa3d function blend(time:Number, weight:Number, state:§_-SK§) : void
      {
      }
      
      public function slice(start:Number, end:Number = 1.7976931348623157e+308) : §_-Np§
      {
         return null;
      }
      
      alternativa3d function createKeyFrame() : §_-NS§
      {
         return null;
      }
      
      alternativa3d function interpolateKeyFrame(dest:§_-NS§, a:§_-NS§, b:§_-NS§, value:Number) : void
      {
      }
      
      alternativa3d function §_-2Y§(dest:§_-Np§, start:Number, end:Number) : void
      {
         var prev:§_-NS§ = null;
         var nextKey:§_-NS§ = null;
         var shiftTime:Number = start > 0 ? start : 0;
         var next:§_-NS§ = this.alternativa3d::keyFramesList;
         var key:§_-NS§ = this.alternativa3d::createKeyFrame();
         while(next != null && next.alternativa3d::_-qC <= start)
         {
            prev = next;
            next = next.alternativa3d::nextKeyFrame;
         }
         if(prev != null)
         {
            if(next != null)
            {
               this.alternativa3d::interpolateKeyFrame(key,prev,next,(start - prev.alternativa3d::_-qC) / (next.alternativa3d::_-qC - prev.alternativa3d::_-qC));
               key.alternativa3d::_-qC = start - shiftTime;
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
            key.alternativa3d::_-qC = next.alternativa3d::_-qC - shiftTime;
            prev = next;
            next = next.alternativa3d::nextKeyFrame;
         }
         dest.alternativa3d::keyFramesList = key;
         if(next == null || end <= start)
         {
            dest.alternativa3d::_-YC = key.alternativa3d::_-qC <= 0 ? 0 : Number(key.alternativa3d::_-qC);
            return;
         }
         while(next != null && next.alternativa3d::_-qC <= end)
         {
            nextKey = this.alternativa3d::createKeyFrame();
            this.alternativa3d::interpolateKeyFrame(nextKey,nextKey,next,1);
            nextKey.alternativa3d::_-qC = next.alternativa3d::_-qC - shiftTime;
            key.alternativa3d::nextKeyFrame = nextKey;
            key = nextKey;
            prev = next;
            next = next.alternativa3d::nextKeyFrame;
         }
         if(next != null)
         {
            nextKey = this.alternativa3d::createKeyFrame();
            this.alternativa3d::interpolateKeyFrame(nextKey,prev,next,(end - prev.alternativa3d::_-qC) / (next.alternativa3d::_-qC - prev.alternativa3d::_-qC));
            nextKey.alternativa3d::_-qC = end - shiftTime;
            key.alternativa3d::nextKeyFrame = nextKey;
         }
         if(nextKey != null)
         {
            dest.alternativa3d::_-YC = nextKey.alternativa3d::_-qC <= 0 ? 0 : Number(nextKey.alternativa3d::_-qC);
         }
      }
   }
}

