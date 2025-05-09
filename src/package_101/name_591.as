package package_101
{
   import alternativa.engine3d.alternativa3d;
   import package_102.name_584;
   
   use namespace alternativa3d;
   
   public class name_591 extends name_552
   {
      private static var temp:name_602 = new name_602();
      
      alternativa3d var name_599:name_602;
      
      public var property:String;
      
      public function name_591(object:String, property:String)
      {
         super();
         this.property = property;
         this.object = object;
      }
      
      override alternativa3d function get keyFramesList() : name_583
      {
         return this.alternativa3d::name_599;
      }
      
      override alternativa3d function set keyFramesList(value:name_583) : void
      {
         this.alternativa3d::name_599 = name_602(value);
      }
      
      public function method_126(time:Number, value:Number = 0) : name_583
      {
         var key:name_602 = new name_602();
         key.alternativa3d::var_420 = time;
         key.value = value;
         alternativa3d::method_350(key);
         return key;
      }
      
      override alternativa3d function blend(time:Number, weight:Number, state:name_584) : void
      {
         var prev:name_602 = null;
         if(this.property == null)
         {
            return;
         }
         var next:name_602 = this.alternativa3d::name_599;
         while(next != null && next.alternativa3d::var_420 < time)
         {
            prev = next;
            next = next.alternativa3d::next;
         }
         if(prev != null)
         {
            if(next != null)
            {
               temp.interpolate(prev,next,(time - prev.alternativa3d::var_420) / (next.alternativa3d::var_420 - prev.alternativa3d::var_420));
               state.name_603(this.property,temp.alternativa3d::name_598,weight);
            }
            else
            {
               state.name_603(this.property,prev.alternativa3d::name_598,weight);
            }
         }
         else if(next != null)
         {
            state.name_603(this.property,next.alternativa3d::name_598,weight);
         }
      }
      
      override alternativa3d function createKeyFrame() : name_583
      {
         return new name_602();
      }
      
      override alternativa3d function interpolateKeyFrame(dest:name_583, a:name_583, b:name_583, value:Number) : void
      {
         name_602(dest).interpolate(name_602(a),name_602(b),value);
      }
      
      override public function slice(start:Number, end:Number = 1.7976931348623157e+308) : name_552
      {
         var track:name_591 = new name_591(object,this.property);
         alternativa3d::method_352(track,start,end);
         return track;
      }
   }
}

