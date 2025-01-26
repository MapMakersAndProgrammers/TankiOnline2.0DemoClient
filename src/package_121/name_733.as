package package_121
{
   import package_109.name_377;
   import package_109.name_767;
   import package_46.name_194;
   import package_76.name_235;
   import package_76.name_665;
   import package_92.name_630;
   import package_92.name_674;
   
   public class name_733 implements name_665
   {
      private var center:name_194 = new name_194();
      
      private var var_714:name_194 = new name_194();
      
      private var bPos:name_194 = new name_194();
      
      private var var_715:name_194 = new name_194();
      
      public function name_733()
      {
         super();
      }
      
      public function getContact(prim1:name_235, prim2:name_235, contact:name_630) : Boolean
      {
         var box:name_377 = null;
         var sphere:name_767 = prim1 as name_767;
         if(sphere == null)
         {
            sphere = prim2 as name_767;
            box = prim1 as name_377;
         }
         else
         {
            box = prim2 as name_377;
         }
         sphere.transform.getAxis(3,this.var_715);
         box.transform.getAxis(3,this.bPos);
         box.transform.transformPointTransposed(this.var_715,this.center);
         var hs:name_194 = box.hs;
         var sx:Number = hs.x + sphere.r;
         var sy:Number = hs.y + sphere.r;
         var sz:Number = hs.z + sphere.r;
         if(this.center.x > sx || this.center.x < -sx || this.center.y > sy || this.center.y < -sy || this.center.z > sz || this.center.z < -sz)
         {
            return false;
         }
         if(this.center.x > hs.x)
         {
            this.var_714.x = hs.x;
         }
         else if(this.center.x < -hs.x)
         {
            this.var_714.x = -hs.x;
         }
         else
         {
            this.var_714.x = this.center.x;
         }
         if(this.center.y > hs.y)
         {
            this.var_714.y = hs.y;
         }
         else if(this.center.y < -hs.y)
         {
            this.var_714.y = -hs.y;
         }
         else
         {
            this.var_714.y = this.center.y;
         }
         if(this.center.z > hs.z)
         {
            this.var_714.z = hs.z;
         }
         else if(this.center.z < -hs.z)
         {
            this.var_714.z = -hs.z;
         }
         else
         {
            this.var_714.z = this.center.z;
         }
         var distSqr:Number = this.center.subtract(this.var_714).method_365();
         if(distSqr > sphere.r * sphere.r)
         {
            return false;
         }
         contact.body1 = sphere.body;
         contact.body2 = box.body;
         contact.normal.copy(this.var_714).transform4(box.transform).subtract(this.var_715).normalize().reverse();
         contact.name_679 = 1;
         var cp:name_674 = contact.points[0];
         cp.penetration = sphere.r - Math.sqrt(distSqr);
         cp.pos.copy(contact.normal).scale(-sphere.r).add(this.var_715);
         cp.r1.method_366(cp.pos,this.var_715);
         cp.r2.method_366(cp.pos,this.bPos);
         return true;
      }
      
      public function haveCollision(prim1:name_235, prim2:name_235) : Boolean
      {
         var box:name_377 = null;
         var sphere:name_767 = prim1 as name_767;
         if(sphere == null)
         {
            sphere = prim2 as name_767;
            box = prim1 as name_377;
         }
         else
         {
            box = prim2 as name_377;
         }
         sphere.transform.getAxis(3,this.var_715);
         box.transform.getAxis(3,this.bPos);
         box.transform.transformPointTransposed(this.var_715,this.center);
         var hs:name_194 = box.hs;
         var sx:Number = hs.x + sphere.r;
         var sy:Number = hs.y + sphere.r;
         var sz:Number = hs.z + sphere.r;
         if(this.center.x > sx || this.center.x < -sx || this.center.y > sy || this.center.y < -sy || this.center.z > sz || this.center.z < -sz)
         {
            return false;
         }
         if(this.center.x > hs.x)
         {
            this.var_714.x = hs.x;
         }
         else if(this.center.x < -hs.x)
         {
            this.var_714.x = -hs.x;
         }
         else
         {
            this.var_714.x = this.center.x;
         }
         if(this.center.y > hs.y)
         {
            this.var_714.y = hs.y;
         }
         else if(this.center.y < -hs.y)
         {
            this.var_714.y = -hs.y;
         }
         else
         {
            this.var_714.y = this.center.y;
         }
         if(this.center.z > hs.z)
         {
            this.var_714.z = hs.z;
         }
         else if(this.center.z < -hs.z)
         {
            this.var_714.z = -hs.z;
         }
         else
         {
            this.var_714.z = this.center.z;
         }
         var distSqr:Number = this.center.subtract(this.var_714).method_365();
         return distSqr <= sphere.r * sphere.r;
      }
   }
}

