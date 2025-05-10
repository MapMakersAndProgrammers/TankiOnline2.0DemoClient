package alternativa.tanks.game.weapons.ammunition.railgun
{
   import alternativa.physics.collision.CollisionPrimitive;
   import alternativa.physics.collision.IRaycastFilter;
   import flash.utils.Dictionary;
   
   public class MultybodyRaycastFilter implements IRaycastFilter
   {
      public var name_By:Dictionary = new Dictionary();
      
      public function MultybodyRaycastFilter()
      {
         super();
      }
      
      public function acceptRayHit(primitive:CollisionPrimitive) : Boolean
      {
         return this.name_By[primitive.body] == null;
      }
   }
}

