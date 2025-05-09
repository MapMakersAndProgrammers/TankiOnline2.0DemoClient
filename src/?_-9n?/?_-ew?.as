package §_-9n§
{
   import §_-OZ§.§_-SK§;
   import alternativa.engine3d.alternativa3d;
   import flash.geom.Matrix3D;
   import flash.geom.Orientation3D;
   import flash.geom.Vector3D;
   
   use namespace alternativa3d;
   
   public class §_-ew§ extends §_-Np§
   {
      private static var tempQuat:Vector3D = new Vector3D();
      
      private static var temp:§_-44§ = new §_-44§();
      
      private var §_-ku§:§_-44§;
      
      public function §_-ew§(object:String)
      {
         super();
         this.object = object;
      }
      
      override alternativa3d function get keyFramesList() : §_-NS§
      {
         return this.§_-ku§;
      }
      
      override alternativa3d function set keyFramesList(value:§_-NS§) : void
      {
         this.§_-ku§ = §_-44§(value);
      }
      
      public function §_-Le§(time:Number, matrix:Matrix3D) : §_-44§
      {
         var key:§_-44§ = null;
         key = new §_-44§();
         key.alternativa3d::_-qC = time;
         var components:Vector.<Vector3D> = matrix.decompose(Orientation3D.QUATERNION);
         key.alternativa3d::x = components[0].x;
         key.alternativa3d::y = components[0].y;
         key.alternativa3d::z = components[0].z;
         key.alternativa3d::rotation = components[1];
         key.alternativa3d::scaleX = components[2].x;
         key.alternativa3d::scaleY = components[2].y;
         key.alternativa3d::scaleZ = components[2].z;
         alternativa3d::_-K1(key);
         return key;
      }
      
      public function §_-mr§(time:Number, x:Number = 0, y:Number = 0, z:Number = 0, rotationX:Number = 0, rotationY:Number = 0, rotationZ:Number = 0, scaleX:Number = 1, scaleY:Number = 1, scaleZ:Number = 1) : §_-44§
      {
         var key:§_-44§ = new §_-44§();
         key.alternativa3d::_-qC = time;
         key.alternativa3d::x = x;
         key.alternativa3d::y = y;
         key.alternativa3d::z = z;
         key.alternativa3d::rotation = this.§_-JN§(rotationX,rotationY,rotationZ);
         key.alternativa3d::scaleX = scaleX;
         key.alternativa3d::scaleY = scaleY;
         key.alternativa3d::scaleZ = scaleZ;
         alternativa3d::_-K1(key);
         return key;
      }
      
      private function §_-Qn§(quat:Vector3D, additive:Vector3D) : void
      {
         var ww:Number = additive.w * quat.w - additive.x * quat.x - additive.y * quat.y - additive.z * quat.z;
         var xx:Number = additive.w * quat.x + additive.x * quat.w + additive.y * quat.z - additive.z * quat.y;
         var yy:Number = additive.w * quat.y + additive.y * quat.w + additive.z * quat.x - additive.x * quat.z;
         var zz:Number = additive.w * quat.z + additive.z * quat.w + additive.x * quat.y - additive.y * quat.x;
         quat.w = ww;
         quat.x = xx;
         quat.y = yy;
         quat.z = zz;
      }
      
      private function §_-OW§(quat:Vector3D) : void
      {
         var d:Number = quat.w * quat.w + quat.x * quat.x + quat.y * quat.y + quat.z * quat.z;
         if(d == 0)
         {
            quat.w = 1;
         }
         else
         {
            d = 1 / Math.sqrt(d);
            quat.w *= d;
            quat.x *= d;
            quat.y *= d;
            quat.z *= d;
         }
      }
      
      private function §_-3K§(quat:Vector3D, x:Number, y:Number, z:Number, angle:Number) : void
      {
         quat.w = Math.cos(0.5 * angle);
         var k:Number = Math.sin(0.5 * angle) / Math.sqrt(x * x + y * y + z * z);
         quat.x = x * k;
         quat.y = y * k;
         quat.z = z * k;
      }
      
      private function §_-JN§(x:Number, y:Number, z:Number) : Vector3D
      {
         var result:Vector3D = new Vector3D();
         this.§_-3K§(result,1,0,0,x);
         this.§_-3K§(tempQuat,0,1,0,y);
         this.§_-Qn§(result,tempQuat);
         this.§_-OW§(result);
         this.§_-3K§(tempQuat,0,0,1,z);
         this.§_-Qn§(result,tempQuat);
         this.§_-OW§(result);
         return result;
      }
      
      override alternativa3d function blend(time:Number, weight:Number, state:§_-SK§) : void
      {
         var prev:§_-44§ = null;
         var next:§_-44§ = this.§_-ku§;
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
               state.§_-nV§(temp,weight);
            }
            else
            {
               state.§_-nV§(prev,weight);
            }
         }
         else if(next != null)
         {
            state.§_-nV§(next,weight);
         }
      }
      
      override alternativa3d function createKeyFrame() : §_-NS§
      {
         return new §_-44§();
      }
      
      override alternativa3d function interpolateKeyFrame(dest:§_-NS§, a:§_-NS§, b:§_-NS§, value:Number) : void
      {
         §_-44§(dest).interpolate(§_-44§(a),§_-44§(b),value);
      }
      
      override public function slice(start:Number, end:Number = 1.7976931348623157e+308) : §_-Np§
      {
         var track:§_-ew§ = new §_-ew§(object);
         alternativa3d::_-2Y(track,start,end);
         return track;
      }
   }
}

