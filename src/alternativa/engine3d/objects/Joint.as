package alternativa.engine3d.objects
{
   import alternativa.engine3d.alternativa3d;
   import alternativa.engine3d.core.Object3D;
   import alternativa.engine3d.core.Transform3D;
   
   use namespace alternativa3d;
   
   public class Joint extends Object3D
   {
      alternativa3d var §_-Dy§:Transform3D = new Transform3D();
      
      alternativa3d var bindPoseTransform:Transform3D = new Transform3D();
      
      private var §_-ar§:Transform3D = new Transform3D();
      
      public function Joint()
      {
         super();
      }
      
      alternativa3d function setBindPoseMatrix(matrix:Vector.<Number>) : void
      {
         this.alternativa3d::bindPoseTransform.initFromVector(matrix);
      }
      
      alternativa3d function calculateTransform() : void
      {
         if(this.alternativa3d::bindPoseTransform != null)
         {
            this.alternativa3d::_-Dy.combine(alternativa3d::localToGlobalTransform,this.alternativa3d::bindPoseTransform);
         }
      }
      
      override public function clone() : Object3D
      {
         var res:Joint = new Joint();
         res.clonePropertiesFrom(this);
         return res;
      }
      
      override protected function clonePropertiesFrom(source:Object3D) : void
      {
         var sourceJoint:Joint = null;
         super.clonePropertiesFrom(source);
         sourceJoint = source as Joint;
         this.alternativa3d::bindPoseTransform.a = sourceJoint.alternativa3d::bindPoseTransform.a;
         this.alternativa3d::bindPoseTransform.b = sourceJoint.alternativa3d::bindPoseTransform.b;
         this.alternativa3d::bindPoseTransform.c = sourceJoint.alternativa3d::bindPoseTransform.c;
         this.alternativa3d::bindPoseTransform.d = sourceJoint.alternativa3d::bindPoseTransform.d;
         this.alternativa3d::bindPoseTransform.e = sourceJoint.alternativa3d::bindPoseTransform.e;
         this.alternativa3d::bindPoseTransform.f = sourceJoint.alternativa3d::bindPoseTransform.f;
         this.alternativa3d::bindPoseTransform.g = sourceJoint.alternativa3d::bindPoseTransform.g;
         this.alternativa3d::bindPoseTransform.h = sourceJoint.alternativa3d::bindPoseTransform.h;
         this.alternativa3d::bindPoseTransform.i = sourceJoint.alternativa3d::bindPoseTransform.i;
         this.alternativa3d::bindPoseTransform.j = sourceJoint.alternativa3d::bindPoseTransform.j;
         this.alternativa3d::bindPoseTransform.k = sourceJoint.alternativa3d::bindPoseTransform.k;
         this.alternativa3d::bindPoseTransform.l = sourceJoint.alternativa3d::bindPoseTransform.l;
      }
   }
}

