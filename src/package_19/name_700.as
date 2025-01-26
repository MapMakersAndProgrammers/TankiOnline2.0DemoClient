package package_19
{
   import alternativa.engine3d.alternativa3d;
   import package_21.name_139;
   import package_21.name_78;
   
   use namespace alternativa3d;
   
   public class name_700 extends name_78
   {
      alternativa3d var name_704:name_139 = new name_139();
      
      alternativa3d var bindPoseTransform:name_139 = new name_139();
      
      private var var_689:name_139 = new name_139();
      
      public function name_700()
      {
         super();
      }
      
      alternativa3d function name_701(matrix:Vector.<Number>) : void
      {
         this.alternativa3d::bindPoseTransform.method_294(matrix);
      }
      
      alternativa3d function name_703() : void
      {
         if(this.alternativa3d::bindPoseTransform != null)
         {
            this.alternativa3d::name_704.combine(alternativa3d::localToGlobalTransform,this.alternativa3d::bindPoseTransform);
         }
      }
      
      override public function clone() : name_78
      {
         var res:name_700 = new name_700();
         res.clonePropertiesFrom(this);
         return res;
      }
      
      override protected function clonePropertiesFrom(source:name_78) : void
      {
         var sourceJoint:name_700 = null;
         super.clonePropertiesFrom(source);
         sourceJoint = source as name_700;
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

