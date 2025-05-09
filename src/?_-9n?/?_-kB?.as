package §_-9n§
{
   import §_-OZ§.§_-SK§;
   import alternativa.engine3d.alternativa3d;
   
   use namespace alternativa3d;
   
   public class §_-kB§ extends §_-Np§
   {
      private static var temp:§_-j3§ = new §_-j3§();
      
      alternativa3d var §_-ku§:§_-j3§;
      
      public var property:String;
      
      public function §_-kB§(object:String, property:String)
      {
         super();
         this.property = property;
         this.object = object;
      }
      
      override alternativa3d function get keyFramesList() : §_-NS§
      {
         return this.alternativa3d::_-ku;
      }
      
      override alternativa3d function set keyFramesList(value:§_-NS§) : void
      {
         this.alternativa3d::_-ku = §_-j3§(value);
      }
      
      public function §_-Le§(time:Number, value:Number = 0) : §_-NS§
      {
         var key:§_-j3§ = new §_-j3§();
         key.alternativa3d::_-qC = time;
         key.value = value;
         alternativa3d::_-K1(key);
         return key;
      }
      
      override alternativa3d function blend(time:Number, weight:Number, state:§_-SK§) : void
      {
         var prev:§_-j3§ = null;
         if(this.property == null)
         {
            return;
         }
         var next:§_-j3§ = this.alternativa3d::_-ku;
         while(next != null && next.alternativa3d::_-qC < time)
         {
            prev = next;
            next = next.alternativa3d::next;
         }
         if(prev != null)
         {
            if(next != null)
            {
               temp.interpolate(prev,next,(time - prev.alternativa3d::_-qC) / (next.alternativa3d::_-qC - prev.alternativa3d::_-qC));
               state.§_-B§(this.property,temp.alternativa3d::_-4O,weight);
            }
            else
            {
               state.§_-B§(this.property,prev.alternativa3d::_-4O,weight);
            }
         }
         else if(next != null)
         {
            state.§_-B§(this.property,next.alternativa3d::_-4O,weight);
         }
      }
      
      override alternativa3d function createKeyFrame() : §_-NS§
      {
         return new §_-j3§();
      }
      
      override alternativa3d function interpolateKeyFrame(dest:§_-NS§, a:§_-NS§, b:§_-NS§, value:Number) : void
      {
         §_-j3§(dest).interpolate(§_-j3§(a),§_-j3§(b),value);
      }
      
      override public function slice(start:Number, end:Number = 1.7976931348623157e+308) : §_-Np§
      {
         var track:§_-kB§ = new §_-kB§(object,this.property);
         alternativa3d::_-2Y(track,start,end);
         return track;
      }
   }
}

