package alternativa.engine3d.animation.keys
{
   import alternativa.engine3d.alternativa3d;
   import flash.geom.Matrix3D;
   import flash.geom.Orientation3D;
   import flash.geom.Vector3D;
   
   use namespace alternativa3d;
   
   public class TransformKey extends Keyframe
   {
      alternativa3d var x:Number = 0;
      
      alternativa3d var y:Number = 0;
      
      alternativa3d var z:Number = 0;
      
      alternativa3d var rotation:Vector3D = new Vector3D(0,0,0,1);
      
      alternativa3d var scaleX:Number = 1;
      
      alternativa3d var scaleY:Number = 1;
      
      alternativa3d var scaleZ:Number = 1;
      
      alternativa3d var next:TransformKey;
      
      public function TransformKey()
      {
         super();
      }
      
      override public function get value() : Object
      {
         var m:Matrix3D = new Matrix3D();
         m.recompose(Vector.<Vector3D>([new Vector3D(this.alternativa3d::x,this.alternativa3d::y,this.alternativa3d::z),this.alternativa3d::rotation,new Vector3D(this.alternativa3d::scaleX,this.alternativa3d::scaleY,this.alternativa3d::scaleZ)]),Orientation3D.QUATERNION);
         return m;
      }
      
      override public function set value(v:Object) : void
      {
         var m:Matrix3D = Matrix3D(v);
         var components:Vector.<Vector3D> = m.decompose(Orientation3D.QUATERNION);
         this.alternativa3d::x = components[0].x;
         this.alternativa3d::y = components[0].y;
         this.alternativa3d::z = components[0].z;
         this.alternativa3d::rotation = components[1];
         this.alternativa3d::scaleX = components[2].x;
         this.alternativa3d::scaleY = components[2].y;
         this.alternativa3d::scaleZ = components[2].z;
      }
      
      public function interpolate(a:TransformKey, b:TransformKey, c:Number) : void
      {
         var c2:Number = 1 - c;
         this.alternativa3d::x = c2 * a.alternativa3d::x + c * b.alternativa3d::x;
         this.alternativa3d::y = c2 * a.alternativa3d::y + c * b.alternativa3d::y;
         this.alternativa3d::z = c2 * a.alternativa3d::z + c * b.alternativa3d::z;
         this.slerp(a.alternativa3d::rotation,b.alternativa3d::rotation,c,this.alternativa3d::rotation);
         this.alternativa3d::scaleX = c2 * a.alternativa3d::scaleX + c * b.alternativa3d::scaleX;
         this.alternativa3d::scaleY = c2 * a.alternativa3d::scaleY + c * b.alternativa3d::scaleY;
         this.alternativa3d::scaleZ = c2 * a.alternativa3d::scaleZ + c * b.alternativa3d::scaleZ;
      }
      
      private function slerp(a:Vector3D, b:Vector3D, t:Number, result:Vector3D) : void
      {
         var k1:Number = NaN;
         var k2:Number = NaN;
         var d:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc13_:Number = NaN;
         var flip:Number = 1;
         var cosine:Number = a.w * b.w + a.x * b.x + a.y * b.y + a.z * b.z;
         if(cosine < 0)
         {
            cosine = -cosine;
            flip = -1;
         }
         if(1 - cosine < 0.001)
         {
            k1 = 1 - t;
            k2 = t * flip;
            result.w = a.w * k1 + b.w * k2;
            result.x = a.x * k1 + b.x * k2;
            result.y = a.y * k1 + b.y * k2;
            result.z = a.z * k1 + b.z * k2;
            d = result.w * result.w + result.x * result.x + result.y * result.y + result.z * result.z;
            if(d == 0)
            {
               result.w = 1;
            }
            else
            {
               result.scaleBy(1 / Math.sqrt(d));
            }
         }
         else
         {
            _loc10_ = Number(Math.acos(cosine));
            _loc11_ = Number(Math.sin(_loc10_));
            _loc12_ = Math.sin((1 - t) * _loc10_) / _loc11_;
            _loc13_ = Math.sin(t * _loc10_) / _loc11_ * flip;
            result.w = a.w * _loc12_ + b.w * _loc13_;
            result.x = a.x * _loc12_ + b.x * _loc13_;
            result.y = a.y * _loc12_ + b.y * _loc13_;
            result.z = a.z * _loc12_ + b.z * _loc13_;
         }
      }
      
      override alternativa3d function get nextKeyFrame() : Keyframe
      {
         return this.alternativa3d::next;
      }
      
      override alternativa3d function set nextKeyFrame(value:Keyframe) : void
      {
         this.alternativa3d::next = TransformKey(value);
      }
   }
}

