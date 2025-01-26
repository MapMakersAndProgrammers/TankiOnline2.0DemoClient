package package_125
{
   import alternativa.engine3d.alternativa3d;
   import flash.geom.Matrix3D;
   import flash.geom.Orientation3D;
   import flash.geom.Vector3D;
   
   use namespace alternativa3d;
   
   public class name_787 extends name_748
   {
      alternativa3d var x:Number = 0;
      
      alternativa3d var y:Number = 0;
      
      alternativa3d var z:Number = 0;
      
      alternativa3d var rotation:Vector3D = new Vector3D(0,0,0,1);
      
      alternativa3d var scaleX:Number = 1;
      
      alternativa3d var scaleY:Number = 1;
      
      alternativa3d var scaleZ:Number = 1;
      
      alternativa3d var next:name_787;
      
      public function name_787()
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
      
      public function interpolate(a:name_787, b:name_787, c:Number) : void
      {
         var c2:Number = 1 - c;
         this.alternativa3d::x = c2 * a.alternativa3d::x + c * b.alternativa3d::x;
         this.alternativa3d::y = c2 * a.alternativa3d::y + c * b.alternativa3d::y;
         this.alternativa3d::z = c2 * a.alternativa3d::z + c * b.alternativa3d::z;
         this.name_602(a.alternativa3d::rotation,b.alternativa3d::rotation,c,this.alternativa3d::rotation);
         this.alternativa3d::scaleX = c2 * a.alternativa3d::scaleX + c * b.alternativa3d::scaleX;
         this.alternativa3d::scaleY = c2 * a.alternativa3d::scaleY + c * b.alternativa3d::scaleY;
         this.alternativa3d::scaleZ = c2 * a.alternativa3d::scaleZ + c * b.alternativa3d::scaleZ;
      }
      
      private function name_602(a:Vector3D, b:Vector3D, t:Number, result:Vector3D) : void
      {
         var k1:Number = NaN;
         var k2:Number = NaN;
         var d:Number = NaN;
         var theta:Number = NaN;
         var sine:Number = NaN;
         var beta:Number = NaN;
         var alpha:Number = NaN;
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
            theta = Number(Math.acos(cosine));
            sine = Number(Math.sin(theta));
            beta = Math.sin((1 - t) * theta) / sine;
            alpha = Math.sin(t * theta) / sine * flip;
            result.w = a.w * beta + b.w * alpha;
            result.x = a.x * beta + b.x * alpha;
            result.y = a.y * beta + b.y * alpha;
            result.z = a.z * beta + b.z * alpha;
         }
      }
      
      override alternativa3d function get nextKeyFrame() : name_748
      {
         return this.alternativa3d::next;
      }
      
      override alternativa3d function set nextKeyFrame(value:name_748) : void
      {
         this.alternativa3d::next = name_787(value);
      }
   }
}

