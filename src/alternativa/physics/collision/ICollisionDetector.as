package alternativa.physics.collision
{
   import alternativa.math.Vector3;
   import alternativa.physics.Contact;
   import alternativa.physics.collision.types.RayHit;
   
   public interface ICollisionDetector
   {
      function getAllContacts(param1:Contact) : Contact;
      
      function raycast(param1:Vector3, param2:Vector3, param3:int, param4:Number, param5:IRaycastFilter, param6:RayHit) : Boolean;
      
      function raycastStatic(param1:Vector3, param2:Vector3, param3:int, param4:Number, param5:IRaycastFilter, param6:RayHit) : Boolean;
      
      function getContact(param1:CollisionPrimitive, param2:CollisionPrimitive, param3:Contact) : Boolean;
      
      function testCollision(param1:CollisionPrimitive, param2:CollisionPrimitive) : Boolean;
   }
}

