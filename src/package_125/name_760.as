package package_125
{
   import alternativa.engine3d.alternativa3d;
   import package_124.name_749;
   
   use namespace alternativa3d;
   
   public class name_760 extends name_709
   {
      private static var temp:name_778 = new name_778();
      
      alternativa3d var name_783:name_778;
      
      public var property:String;
      
      public function name_760(object:String, property:String)
      {
         super();
         this.property = property;
         this.object = object;
      }
      
      override alternativa3d function get keyFramesList() : name_748
      {
         return this.alternativa3d::name_783;
      }
      
      override alternativa3d function set keyFramesList(value:name_748) : void
      {
         this.alternativa3d::name_783 = name_778(value);
      }
      
      public function method_257(time:Number, value:Number = 0) : name_748
      {
         var key:name_778 = new name_778();
         key.alternativa3d::var_420 = time;
         key.value = value;
         alternativa3d::method_849(key);
         return key;
      }
      
      override alternativa3d function blend(time:Number, weight:Number, state:name_749) : void
      {
         var prev:name_778 = null;
         if(this.property == null)
         {
            return;
         }
         var next:name_778 = this.alternativa3d::name_783;
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
               state.method_919(this.property,temp.alternativa3d::name_781,weight);
            }
            else
            {
               state.method_919(this.property,prev.alternativa3d::name_781,weight);
            }
         }
         else if(next != null)
         {
            state.method_919(this.property,next.alternativa3d::name_781,weight);
         }
      }
      
      override alternativa3d function createKeyFrame() : name_748
      {
         return new name_778();
      }
      
      override alternativa3d function interpolateKeyFrame(dest:name_748, a:name_748, b:name_748, value:Number) : void
      {
         name_778(dest).interpolate(name_778(a),name_778(b),value);
      }
      
      override public function slice(start:Number, end:Number = 1.7976931348623157e+308) : name_709
      {
         var track:name_760 = new name_760(object,this.property);
         alternativa3d::method_851(track,start,end);
         return track;
      }
   }
}

