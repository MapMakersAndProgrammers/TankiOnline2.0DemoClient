package alternativa.tanks.game.weapons
{
   import package_46.name_194;
   import package_92.name_271;
   
   public class WeaponHit
   {
      public var distance:Number;
      
      public var body:name_271;
      
      public var position:name_194 = new name_194();
      
      public var direction:name_194 = new name_194();
      
      public var normal:name_194 = new name_194();
      
      public function WeaponHit()
      {
         super();
      }
      
      public function toString() : String
      {
         return "[WeaponHit distance=" + this.distance + ", body=" + this.body + ", position=" + this.position + ", direction=" + this.direction + ", normal=" + this.normal + "]";
      }
   }
}

