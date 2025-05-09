package package_101
{
   import alternativa.engine3d.alternativa3d;
   import flash.geom.Matrix3D;
   import flash.geom.Orientation3D;
   import flash.geom.Vector3D;
   import package_102.name_584;
   
   use namespace alternativa3d;
   
   public class name_590 extends name_552
   {
      private static var tempQuat:Vector3D = new Vector3D();
      
      private static var temp:name_604 = new name_604();
      
      private var name_599:name_604;
      
      public function name_590(object:String)
      {
         super();
         this.object = object;
      }
      
      override alternativa3d function get keyFramesList() : name_583
      {
         return this.name_599;
      }
      
      override alternativa3d function set keyFramesList(value:name_583) : void
      {
         this.name_599 = name_604(value);
      }
      
      public function method_126(time:Number, matrix:Matrix3D) : name_604
      {
         var key:name_604 = null;
         key = new name_604();
         key.alternativa3d::var_420 = time;
         var components:Vector.<Vector3D> = matrix.decompose(Orientation3D.QUATERNION);
         key.alternativa3d::x = components[0].x;
         key.alternativa3d::y = components[0].y;
         key.alternativa3d::z = components[0].z;
         key.alternativa3d::rotation = components[1];
         key.alternativa3d::scaleX = components[2].x;
         key.alternativa3d::scaleY = components[2].y;
         key.alternativa3d::scaleZ = components[2].z;
         alternativa3d::method_350(key);
         return key;
      }
      
      public function method_372(time:Number, x:Number = 0, y:Number = 0, z:Number = 0, rotationX:Number = 0, rotationY:Number = 0, rotationZ:Number = 0, scaleX:Number = 1, scaleY:Number = 1, scaleZ:Number = 1) : name_604
      {
         var key:name_604 = new name_604();
         key.alternativa3d::var_420 = time;
         key.alternativa3d::x = x;
         key.alternativa3d::y = y;
         key.alternativa3d::z = z;
         key.alternativa3d::rotation = this.method_371(rotationX,rotationY,rotationZ);
         key.alternativa3d::scaleX = scaleX;
         key.alternativa3d::scaleY = scaleY;
         key.alternativa3d::scaleZ = scaleZ;
         alternativa3d::method_350(key);
         return key;
      }
      
      private function method_369(quat:Vector3D, additive:Vector3D) : void
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
      
      private function method_370(quat:Vector3D) : void
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
      
      private function method_368(quat:Vector3D, x:Number, y:Number, z:Number, angle:Number) : void
      {
         quat.w = Math.cos(0.5 * angle);
         var k:Number = Math.sin(0.5 * angle) / Math.sqrt(x * x + y * y + z * z);
         quat.x = x * k;
         quat.y = y * k;
         quat.z = z * k;
      }
      
      private function method_371(x:Number, y:Number, z:Number) : Vector3D
      {
         var result:Vector3D = new Vector3D();
         this.method_368(result,1,0,0,x);
         this.method_368(tempQuat,0,1,0,y);
         this.method_369(result,tempQuat);
         this.method_370(result);
         this.method_368(tempQuat,0,0,1,z);
         this.method_369(result,tempQuat);
         this.method_370(result);
         return result;
      }
      
      override alternativa3d function blend(time:Number, weight:Number, state:name_584) : void
      {
         var prev:name_604 = null;
         var next:name_604 = this.name_599;
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
               state.name_605(temp,weight);
            }
            else
            {
               state.name_605(prev,weight);
            }
         }
         else if(next != null)
         {
            state.name_605(next,weight);
         }
      }
      
      override alternativa3d function createKeyFrame() : name_583
      {
         return new name_604();
      }
      
      override alternativa3d function interpolateKeyFrame(dest:name_583, a:name_583, b:name_583, value:Number) : void
      {
         name_604(dest).interpolate(name_604(a),name_604(b),value);
      }
      
      override public function slice(start:Number, end:Number = 1.7976931348623157e+308) : name_552
      {
         var track:name_590 = new name_590(object);
         alternativa3d::method_352(track,start,end);
         return track;
      }
   }
}

