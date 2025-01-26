package package_121
{
   import package_109.name_767;
   import package_46.name_194;
   import package_76.name_235;
   import package_76.name_665;
   import package_92.name_630;
   import package_92.name_674;
   
   public class name_732 implements name_665
   {
      private var p1:name_194 = new name_194();
      
      private var p2:name_194 = new name_194();
      
      public function name_732()
      {
         super();
      }
      
      public function getContact(prim1:name_235, prim2:name_235, contact:name_630) : Boolean
      {
         var s1:name_767 = null;
         var s2:name_767 = null;
         var dz:Number = NaN;
         if(prim1.body != null)
         {
            s1 = prim1 as name_767;
            s2 = prim2 as name_767;
         }
         else
         {
            s1 = prim2 as name_767;
            s2 = prim1 as name_767;
         }
         s1.transform.getAxis(3,this.p1);
         s2.transform.getAxis(3,this.p2);
         var dx:Number = this.p1.x - this.p2.x;
         var dy:Number = this.p1.y - this.p2.y;
         dz = this.p1.z - this.p2.z;
         var len:Number = dx * dx + dy * dy + dz * dz;
         var sum:Number = s1.r + s2.r;
         if(len > sum * sum)
         {
            return false;
         }
         len = Number(Math.sqrt(len));
         dx /= len;
         dy /= len;
         dz /= len;
         contact.body1 = s1.body;
         contact.body2 = s2.body;
         contact.normal.x = dx;
         contact.normal.y = dy;
         contact.normal.z = dz;
         contact.name_679 = 1;
         var cp:name_674 = contact.points[0];
         cp.penetration = sum - len;
         cp.pos.x = this.p1.x - dx * s1.r;
         cp.pos.y = this.p1.y - dy * s1.r;
         cp.pos.z = this.p1.z - dz * s1.r;
         cp.r1.method_366(cp.pos,this.p1);
         cp.r2.method_366(cp.pos,this.p2);
         return true;
      }
      
      public function haveCollision(prim1:name_235, prim2:name_235) : Boolean
      {
         return false;
      }
   }
}

