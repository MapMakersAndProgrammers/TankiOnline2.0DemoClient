package alternativa.physics.collision.colliders
{
   import alternativa.math.Vector3;
   import alternativa.physics.Contact;
   import alternativa.physics.ContactPoint;
   import alternativa.physics.collision.CollisionPrimitive;
   import alternativa.physics.collision.ICollider;
   import alternativa.physics.collision.primitives.CollisionSphere;
   import alternativa.physics.collision.primitives.name_311;
   
   public class BoxSphereCollider implements ICollider
   {
      private var center:Vector3 = new Vector3();
      
      private var var_713:Vector3 = new Vector3();
      
      private var bPos:Vector3 = new Vector3();
      
      private var var_714:Vector3 = new Vector3();
      
      public function BoxSphereCollider()
      {
         super();
      }
      
      public function getContact(prim1:CollisionPrimitive, prim2:CollisionPrimitive, contact:Contact) : Boolean
      {
         var box:name_311 = null;
         var sphere:CollisionSphere = prim1 as CollisionSphere;
         if(sphere == null)
         {
            sphere = prim2 as CollisionSphere;
            box = prim1 as name_311;
         }
         else
         {
            box = prim2 as name_311;
         }
         sphere.transform.getAxis(3,this.var_714);
         box.transform.getAxis(3,this.bPos);
         box.transform.transformPointTransposed(this.var_714,this.center);
         var hs:Vector3 = box.hs;
         var sx:Number = hs.x + sphere.r;
         var sy:Number = hs.y + sphere.r;
         var sz:Number = hs.z + sphere.r;
         if(this.center.x > sx || this.center.x < -sx || this.center.y > sy || this.center.y < -sy || this.center.z > sz || this.center.z < -sz)
         {
            return false;
         }
         if(this.center.x > hs.x)
         {
            this.var_713.x = hs.x;
         }
         else if(this.center.x < -hs.x)
         {
            this.var_713.x = -hs.x;
         }
         else
         {
            this.var_713.x = this.center.x;
         }
         if(this.center.y > hs.y)
         {
            this.var_713.y = hs.y;
         }
         else if(this.center.y < -hs.y)
         {
            this.var_713.y = -hs.y;
         }
         else
         {
            this.var_713.y = this.center.y;
         }
         if(this.center.z > hs.z)
         {
            this.var_713.z = hs.z;
         }
         else if(this.center.z < -hs.z)
         {
            this.var_713.z = -hs.z;
         }
         else
         {
            this.var_713.z = this.center.z;
         }
         var distSqr:Number = this.center.subtract(this.var_713).lengthSqr();
         if(distSqr > sphere.r * sphere.r)
         {
            return false;
         }
         contact.body1 = sphere.body;
         contact.body2 = box.body;
         contact.normal.copy(this.var_713).transform4(box.transform).subtract(this.var_714).normalize().reverse();
         contact.name_506 = 1;
         var cp:ContactPoint = contact.points[0];
         cp.penetration = sphere.r - Math.sqrt(distSqr);
         cp.pos.copy(contact.normal).scale(-sphere.r).add(this.var_714);
         cp.r1.diff(cp.pos,this.var_714);
         cp.r2.diff(cp.pos,this.bPos);
         return true;
      }
      
      public function haveCollision(prim1:CollisionPrimitive, prim2:CollisionPrimitive) : Boolean
      {
         var box:name_311 = null;
         var sphere:CollisionSphere = prim1 as CollisionSphere;
         if(sphere == null)
         {
            sphere = prim2 as CollisionSphere;
            box = prim1 as name_311;
         }
         else
         {
            box = prim2 as name_311;
         }
         sphere.transform.getAxis(3,this.var_714);
         box.transform.getAxis(3,this.bPos);
         box.transform.transformPointTransposed(this.var_714,this.center);
         var hs:Vector3 = box.hs;
         var sx:Number = hs.x + sphere.r;
         var sy:Number = hs.y + sphere.r;
         var sz:Number = hs.z + sphere.r;
         if(this.center.x > sx || this.center.x < -sx || this.center.y > sy || this.center.y < -sy || this.center.z > sz || this.center.z < -sz)
         {
            return false;
         }
         if(this.center.x > hs.x)
         {
            this.var_713.x = hs.x;
         }
         else if(this.center.x < -hs.x)
         {
            this.var_713.x = -hs.x;
         }
         else
         {
            this.var_713.x = this.center.x;
         }
         if(this.center.y > hs.y)
         {
            this.var_713.y = hs.y;
         }
         else if(this.center.y < -hs.y)
         {
            this.var_713.y = -hs.y;
         }
         else
         {
            this.var_713.y = this.center.y;
         }
         if(this.center.z > hs.z)
         {
            this.var_713.z = hs.z;
         }
         else if(this.center.z < -hs.z)
         {
            this.var_713.z = -hs.z;
         }
         else
         {
            this.var_713.z = this.center.z;
         }
         var distSqr:Number = this.center.subtract(this.var_713).lengthSqr();
         return distSqr <= sphere.r * sphere.r;
      }
   }
}

