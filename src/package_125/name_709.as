package package_125
{
   import alternativa.engine3d.alternativa3d;
   import package_124.name_749;
   
   use namespace alternativa3d;
   
   public class name_709
   {
      public var object:String;
      
      alternativa3d var var_693:Number = 0;
      
      public function name_709()
      {
         super();
      }
      
      public function get length() : Number
      {
         return this.alternativa3d::var_693;
      }
      
      alternativa3d function get keyFramesList() : name_748
      {
         return null;
      }
      
      alternativa3d function set keyFramesList(value:name_748) : void
      {
      }
      
      alternativa3d function method_849(key:name_748) : void
      {
         var k:name_748 = null;
         var time:Number = Number(key.alternativa3d::var_420);
         if(this.alternativa3d::keyFramesList == null)
         {
            this.alternativa3d::keyFramesList = key;
            this.alternativa3d::var_693 = time <= 0 ? 0 : time;
            return;
         }
         if(this.alternativa3d::keyFramesList.alternativa3d::var_420 > time)
         {
            key.alternativa3d::nextKeyFrame = this.alternativa3d::keyFramesList;
            this.alternativa3d::keyFramesList = key;
            return;
         }
         k = this.alternativa3d::keyFramesList;
         while(k.alternativa3d::nextKeyFrame != null && k.alternativa3d::nextKeyFrame.alternativa3d::var_420 <= time)
         {
            k = k.alternativa3d::nextKeyFrame;
         }
         if(k.alternativa3d::nextKeyFrame == null)
         {
            k.alternativa3d::nextKeyFrame = key;
            this.alternativa3d::var_693 = time <= 0 ? 0 : time;
         }
         else
         {
            key.alternativa3d::nextKeyFrame = k.alternativa3d::nextKeyFrame;
            k.alternativa3d::nextKeyFrame = key;
         }
      }
      
      public function method_850(key:name_748) : name_748
      {
         var k:name_748 = null;
         if(this.alternativa3d::keyFramesList != null)
         {
            if(this.alternativa3d::keyFramesList == key)
            {
               this.alternativa3d::keyFramesList = this.alternativa3d::keyFramesList.alternativa3d::nextKeyFrame;
               if(this.alternativa3d::keyFramesList == null)
               {
                  this.alternativa3d::var_693 = 0;
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
                  this.alternativa3d::var_693 = k.alternativa3d::var_420 <= 0 ? 0 : Number(k.alternativa3d::var_420);
               }
               k.alternativa3d::nextKeyFrame = key.alternativa3d::nextKeyFrame;
               return key;
            }
         }
         throw new Error("Key not found");
      }
      
      public function get keys() : Vector.<name_748>
      {
         var result:Vector.<name_748> = new Vector.<name_748>();
         var i:int = 0;
         for(var key:name_748 = this.alternativa3d::keyFramesList; key != null; key = key.alternativa3d::nextKeyFrame)
         {
            result[i] = key;
            i++;
         }
         return result;
      }
      
      alternativa3d function blend(time:Number, weight:Number, state:name_749) : void
      {
      }
      
      public function slice(start:Number, end:Number = 1.7976931348623157e+308) : name_709
      {
         return null;
      }
      
      alternativa3d function createKeyFrame() : name_748
      {
         return null;
      }
      
      alternativa3d function interpolateKeyFrame(dest:name_748, a:name_748, b:name_748, value:Number) : void
      {
      }
      
      alternativa3d function method_851(dest:name_709, start:Number, end:Number) : void
      {
         var prev:name_748 = null;
         var nextKey:name_748 = null;
         var shiftTime:Number = start > 0 ? start : 0;
         var next:name_748 = this.alternativa3d::keyFramesList;
         var key:name_748 = this.alternativa3d::createKeyFrame();
         while(next != null && next.alternativa3d::var_420 <= start)
         {
            prev = next;
            next = next.alternativa3d::nextKeyFrame;
         }
         if(prev != null)
         {
            if(next != null)
            {
               this.alternativa3d::interpolateKeyFrame(key,prev,next,(start - prev.alternativa3d::var_420) / (next.alternativa3d::var_420 - prev.alternativa3d::var_420));
               key.alternativa3d::var_420 = start - shiftTime;
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
            key.alternativa3d::var_420 = next.alternativa3d::var_420 - shiftTime;
            prev = next;
            next = next.alternativa3d::nextKeyFrame;
         }
         dest.alternativa3d::keyFramesList = key;
         if(next == null || end <= start)
         {
            dest.alternativa3d::var_693 = key.alternativa3d::var_420 <= 0 ? 0 : Number(key.alternativa3d::var_420);
            return;
         }
         while(next != null && next.alternativa3d::var_420 <= end)
         {
            nextKey = this.alternativa3d::createKeyFrame();
            this.alternativa3d::interpolateKeyFrame(nextKey,nextKey,next,1);
            nextKey.alternativa3d::var_420 = next.alternativa3d::var_420 - shiftTime;
            key.alternativa3d::nextKeyFrame = nextKey;
            key = nextKey;
            prev = next;
            next = next.alternativa3d::nextKeyFrame;
         }
         if(next != null)
         {
            nextKey = this.alternativa3d::createKeyFrame();
            this.alternativa3d::interpolateKeyFrame(nextKey,prev,next,(end - prev.alternativa3d::var_420) / (next.alternativa3d::var_420 - prev.alternativa3d::var_420));
            nextKey.alternativa3d::var_420 = end - shiftTime;
            key.alternativa3d::nextKeyFrame = nextKey;
         }
         if(nextKey != null)
         {
            dest.alternativa3d::var_693 = nextKey.alternativa3d::var_420 <= 0 ? 0 : Number(nextKey.alternativa3d::var_420);
         }
      }
   }
}

