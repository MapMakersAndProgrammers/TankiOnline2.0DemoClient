package alternativa.engine3d.animation.keys
{
   import alternativa.engine3d.alternativa3d;
   import alternativa.engine3d.animation.AnimationState;
   
   use namespace alternativa3d;
   
   public class NumberTrack extends Track
   {
      private static var temp:NumberKey = new NumberKey();
      
      alternativa3d var name_ku:NumberKey;
      
      public var property:String;
      
      public function NumberTrack(object:String, property:String)
      {
         super();
         this.property = property;
         this.object = object;
      }
      
      override alternativa3d function get keyFramesList() : Keyframe
      {
         return this.name_ku;
      }
      
      override alternativa3d function set keyFramesList(value:Keyframe) : void
      {
         this.name_ku = NumberKey(value);
      }
      
      public function addKey(time:Number, value:Number = 0) : Keyframe
      {
         var key:NumberKey = new NumberKey();
         key.name_qC = time;
         key.value = value;
         alternativa3d::addKeyToList(key);
         return key;
      }
      
      override alternativa3d function blend(time:Number, weight:Number, state:AnimationState) : void
      {
         var prev:NumberKey = null;
         if(this.property == null)
         {
            return;
         }
         var next:NumberKey = this.name_ku;
         while(next != null && next.name_qC < time)
         {
            prev = next;
            next = next.alternativa3d::next;
         }
         if(prev != null)
         {
            if(next != null)
            {
               temp.interpolate(prev,next,(time - prev.name_qC) / (next.name_qC - prev.name_qC));
               state.addWeightedNumber(this.property,temp.name_4O,weight);
            }
            else
            {
               state.addWeightedNumber(this.property,prev.name_4O,weight);
            }
         }
         else if(next != null)
         {
            state.addWeightedNumber(this.property,next.name_4O,weight);
         }
      }
      
      override alternativa3d function createKeyFrame() : Keyframe
      {
         return new NumberKey();
      }
      
      override alternativa3d function interpolateKeyFrame(dest:Keyframe, a:Keyframe, b:Keyframe, value:Number) : void
      {
         NumberKey(dest).interpolate(NumberKey(a),NumberKey(b),value);
      }
      
      override public function slice(start:Number, end:Number = 1.7976931348623157e+308) : Track
      {
         var track:NumberTrack = new NumberTrack(object,this.property);
         alternativa3d::sliceImplementation(track,start,end);
         return track;
      }
   }
}

