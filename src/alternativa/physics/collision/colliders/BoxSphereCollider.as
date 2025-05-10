package alternativa.physics.collision.colliders
{
   import alternativa.math.Vector3;
   import alternativa.physics.Contact;
   import alternativa.physics.ContactPoint;
   import alternativa.physics.collision.CollisionPrimitive;
   import alternativa.physics.collision.ICollider;
   import alternativa.physics.collision.primitives.CollisionSphere;
   import alternativa.physics.collision.primitives.CollisionBox;
   
   public class BoxSphereCollider implements ICollider
   {
      private var center:Vector3 = new Vector3();
      
      private var §_-ZR§:Vector3 = new Vector3();
      
      private var bPos:Vector3 = new Vector3();
      
      private var §_-dt§:Vector3 = new Vector3();
      
      public function BoxSphereCollider()
      {
         super();
      }
      
      public function getContact(prim1:CollisionPrimitive, prim2:CollisionPrimitive, contact:Contact) : Boolean
      {
         var box:CollisionBox = null;
         var sphere:CollisionSphere = prim1 as CollisionSphere;
         if(sphere == null)
         {
            sphere = prim2 as CollisionSphere;
            box = prim1 as CollisionBox;
         }
         else
         {
            box = prim2 as CollisionBox;
         }
         sphere.transform.getAxis(3,this.§_-dt§);
         box.transform.getAxis(3,this.bPos);
         box.transform.transformPointTransposed(this.§_-dt§,this.center);
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
            this.§_-ZR§.x = hs.x;
         }
         else if(this.center.x < -hs.x)
         {
            this.§_-ZR§.x = -hs.x;
         }
         else
         {
            this.§_-ZR§.x = this.center.x;
         }
         if(this.center.y > hs.y)
         {
            this.§_-ZR§.y = hs.y;
         }
         else if(this.center.y < -hs.y)
         {
            this.§_-ZR§.y = -hs.y;
         }
         else
         {
            this.§_-ZR§.y = this.center.y;
         }
         if(this.center.z > hs.z)
         {
            this.§_-ZR§.z = hs.z;
         }
         else if(this.center.z < -hs.z)
         {
            this.§_-ZR§.z = -hs.z;
         }
         else
         {
            this.§_-ZR§.z = this.center.z;
         }
         var distSqr:Number = this.center.subtract(this.§_-ZR§).lengthSqr();
         if(distSqr > sphere.r * sphere.r)
         {
            return false;
         }
         contact.body1 = sphere.body;
         contact.body2 = box.body;
         contact.normal.copy(this.§_-ZR§).transform4(box.transform).subtract(this.§_-dt§).normalize().reverse();
         contact.§_-P3§ = 1;
         var cp:ContactPoint = contact.points[0];
         cp.penetration = sphere.r - Math.sqrt(distSqr);
         cp.pos.copy(contact.normal).scale(-sphere.r).add(this.§_-dt§);
         cp.r1.diff(cp.pos,this.§_-dt§);
         cp.r2.diff(cp.pos,this.bPos);
         return true;
      }
      
      public function haveCollision(prim1:CollisionPrimitive, prim2:CollisionPrimitive) : Boolean
      {
         var box:CollisionBox = null;
         var sphere:CollisionSphere = prim1 as CollisionSphere;
         if(sphere == null)
         {
            sphere = prim2 as CollisionSphere;
            box = prim1 as CollisionBox;
         }
         else
         {
            box = prim2 as CollisionBox;
         }
         sphere.transform.getAxis(3,this.§_-dt§);
         box.transform.getAxis(3,this.bPos);
         box.transform.transformPointTransposed(this.§_-dt§,this.center);
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
            this.§_-ZR§.x = hs.x;
         }
         else if(this.center.x < -hs.x)
         {
            this.§_-ZR§.x = -hs.x;
         }
         else
         {
            this.§_-ZR§.x = this.center.x;
         }
         if(this.center.y > hs.y)
         {
            this.§_-ZR§.y = hs.y;
         }
         else if(this.center.y < -hs.y)
         {
            this.§_-ZR§.y = -hs.y;
         }
         else
         {
            this.§_-ZR§.y = this.center.y;
         }
         if(this.center.z > hs.z)
         {
            this.§_-ZR§.z = hs.z;
         }
         else if(this.center.z < -hs.z)
         {
            this.§_-ZR§.z = -hs.z;
         }
         else
         {
            this.§_-ZR§.z = this.center.z;
         }
         var distSqr:Number = this.center.subtract(this.§_-ZR§).lengthSqr();
         return distSqr <= sphere.r * sphere.r;
      }
   }
}

