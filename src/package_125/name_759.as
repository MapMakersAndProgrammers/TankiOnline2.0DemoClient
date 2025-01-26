package package_125
{
   import alternativa.engine3d.alternativa3d;
   import flash.geom.Matrix3D;
   import flash.geom.Orientation3D;
   import flash.geom.Vector3D;
   import package_124.name_749;
   
   use namespace alternativa3d;
   
   public class name_759 extends name_709
   {
      private static var tempQuat:Vector3D = new Vector3D();
      
      private static var temp:name_787 = new name_787();
      
      private var name_783:name_787;
      
      public function name_759(object:String)
      {
         super();
         this.object = object;
      }
      
      override alternativa3d function get keyFramesList() : name_748
      {
         return this.name_783;
      }
      
      override alternativa3d function set keyFramesList(value:name_748) : void
      {
         this.name_783 = name_787(value);
      }
      
      public function method_257(time:Number, matrix:Matrix3D) : name_787
      {
         var key:name_787 = null;
         key = new name_787();
         key.alternativa3d::var_420 = time;
         var components:Vector.<Vector3D> = matrix.decompose(Orientation3D.QUATERNION);
         key.alternativa3d::x = components[0].x;
         key.alternativa3d::y = components[0].y;
         key.alternativa3d::z = components[0].z;
         key.alternativa3d::rotation = components[1];
         key.alternativa3d::scaleX = components[2].x;
         key.alternativa3d::scaleY = components[2].y;
         key.alternativa3d::scaleZ = components[2].z;
         alternativa3d::method_849(key);
         return key;
      }
      
      public function method_929(time:Number, x:Number = 0, y:Number = 0, z:Number = 0, rotationX:Number = 0, rotationY:Number = 0, rotationZ:Number = 0, scaleX:Number = 1, scaleY:Number = 1, scaleZ:Number = 1) : name_787
      {
         var key:name_787 = new name_787();
         key.alternativa3d::var_420 = time;
         key.alternativa3d::x = x;
         key.alternativa3d::y = y;
         key.alternativa3d::z = z;
         key.alternativa3d::rotation = this.method_928(rotationX,rotationY,rotationZ);
         key.alternativa3d::scaleX = scaleX;
         key.alternativa3d::scaleY = scaleY;
         key.alternativa3d::scaleZ = scaleZ;
         alternativa3d::method_849(key);
         return key;
      }
      
      private function method_926(quat:Vector3D, additive:Vector3D) : void
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
      
      private function method_927(quat:Vector3D) : void
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
      
      private function method_925(quat:Vector3D, x:Number, y:Number, z:Number, angle:Number) : void
      {
         quat.w = Math.cos(0.5 * angle);
         var k:Number = Math.sin(0.5 * angle) / Math.sqrt(x * x + y * y + z * z);
         quat.x = x * k;
         quat.y = y * k;
         quat.z = z * k;
      }
      
      private function method_928(x:Number, y:Number, z:Number) : Vector3D
      {
         var result:Vector3D = new Vector3D();
         this.method_925(result,1,0,0,x);
         this.method_925(tempQuat,0,1,0,y);
         this.method_926(result,tempQuat);
         this.method_927(result);
         this.method_925(tempQuat,0,0,1,z);
         this.method_926(result,tempQuat);
         this.method_927(result);
         return result;
      }
      
      override alternativa3d function blend(time:Number, weight:Number, state:name_749) : void
      {
         var prev:name_787 = null;
         var next:name_787 = this.name_783;
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
               state.method_920(temp,weight);
            }
            else
            {
               state.method_920(prev,weight);
            }
         }
         else if(next != null)
         {
            state.method_920(next,weight);
         }
      }
      
      override alternativa3d function createKeyFrame() : name_748
      {
         return new name_787();
      }
      
      override alternativa3d function interpolateKeyFrame(dest:name_748, a:name_748, b:name_748, value:Number) : void
      {
         name_787(dest).interpolate(name_787(a),name_787(b),value);
      }
      
      override public function slice(start:Number, end:Number = 1.7976931348623157e+308) : name_709
      {
         var track:name_759 = new name_759(object);
         alternativa3d::method_851(track,start,end);
         return track;
      }
   }
}

