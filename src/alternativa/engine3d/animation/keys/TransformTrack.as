package alternativa.engine3d.animation.keys
{
   import alternativa.engine3d.alternativa3d;
   import alternativa.engine3d.animation.AnimationState;
   import flash.geom.Matrix3D;
   import flash.geom.Orientation3D;
   import flash.geom.Vector3D;
   
   use namespace alternativa3d;
   
   public class TransformTrack extends Track
   {
      private static var tempQuat:Vector3D = new Vector3D();
      
      private static var temp:TransformKey = new TransformKey();
      
      private var §_-ku§:TransformKey;
      
      public function TransformTrack(object:String)
      {
         super();
         this.object = object;
      }
      
      override alternativa3d function get keyFramesList() : Keyframe
      {
         return this.§_-ku§;
      }
      
      override alternativa3d function set keyFramesList(value:Keyframe) : void
      {
         this.§_-ku§ = TransformKey(value);
      }
      
      public function addKey(time:Number, matrix:Matrix3D) : TransformKey
      {
         var key:TransformKey = null;
         key = new TransformKey();
         key.alternativa3d::_-qC = time;
         var components:Vector.<Vector3D> = matrix.decompose(Orientation3D.QUATERNION);
         key.alternativa3d::x = components[0].x;
         key.alternativa3d::y = components[0].y;
         key.alternativa3d::z = components[0].z;
         key.alternativa3d::rotation = components[1];
         key.alternativa3d::scaleX = components[2].x;
         key.alternativa3d::scaleY = components[2].y;
         key.alternativa3d::scaleZ = components[2].z;
         alternativa3d::addKeyToList(key);
         return key;
      }
      
      public function addKeyComponents(time:Number, x:Number = 0, y:Number = 0, z:Number = 0, rotationX:Number = 0, rotationY:Number = 0, rotationZ:Number = 0, scaleX:Number = 1, scaleY:Number = 1, scaleZ:Number = 1) : TransformKey
      {
         var key:TransformKey = new TransformKey();
         key.alternativa3d::_-qC = time;
         key.alternativa3d::x = x;
         key.alternativa3d::y = y;
         key.alternativa3d::z = z;
         key.alternativa3d::rotation = this.createQuatFromEuler(rotationX,rotationY,rotationZ);
         key.alternativa3d::scaleX = scaleX;
         key.alternativa3d::scaleY = scaleY;
         key.alternativa3d::scaleZ = scaleZ;
         alternativa3d::addKeyToList(key);
         return key;
      }
      
      private function appendQuat(quat:Vector3D, additive:Vector3D) : void
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
      
      private function normalizeQuat(quat:Vector3D) : void
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
      
      private function setQuatFromAxisAngle(quat:Vector3D, x:Number, y:Number, z:Number, angle:Number) : void
      {
         quat.w = Math.cos(0.5 * angle);
         var k:Number = Math.sin(0.5 * angle) / Math.sqrt(x * x + y * y + z * z);
         quat.x = x * k;
         quat.y = y * k;
         quat.z = z * k;
      }
      
      private function createQuatFromEuler(x:Number, y:Number, z:Number) : Vector3D
      {
         var result:Vector3D = new Vector3D();
         this.setQuatFromAxisAngle(result,1,0,0,x);
         this.setQuatFromAxisAngle(tempQuat,0,1,0,y);
         this.appendQuat(result,tempQuat);
         this.normalizeQuat(result);
         this.setQuatFromAxisAngle(tempQuat,0,0,1,z);
         this.appendQuat(result,tempQuat);
         this.normalizeQuat(result);
         return result;
      }
      
      override alternativa3d function blend(time:Number, weight:Number, state:AnimationState) : void
      {
         var prev:TransformKey = null;
         var next:TransformKey = this.§_-ku§;
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
               state.addWeightedTransform(temp,weight);
            }
            else
            {
               state.addWeightedTransform(prev,weight);
            }
         }
         else if(next != null)
         {
            state.addWeightedTransform(next,weight);
         }
      }
      
      override alternativa3d function createKeyFrame() : Keyframe
      {
         return new TransformKey();
      }
      
      override alternativa3d function interpolateKeyFrame(dest:Keyframe, a:Keyframe, b:Keyframe, value:Number) : void
      {
         TransformKey(dest).interpolate(TransformKey(a),TransformKey(b),value);
      }
      
      override public function slice(start:Number, end:Number = 1.7976931348623157e+308) : Track
      {
         var track:TransformTrack = new TransformTrack(object);
         alternativa3d::sliceImplementation(track,start,end);
         return track;
      }
   }
}

