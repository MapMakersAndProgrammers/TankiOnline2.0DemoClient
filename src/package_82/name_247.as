package package_82
{
   import flash.geom.Vector3D;
   import alternativa.tanks.game.EntityComponent;
   import alternativa.tanks.game.GameKernel;
   import package_115.class_26;
   import package_25.name_250;
   import package_28.name_129;
   import package_46.name_194;
   import package_75.class_15;
   import package_83.name_594;
   
   public class name_247 extends EntityComponent implements class_26
   {
      private static var smokyShotAtlas:name_250;
      
      private var gameKernel:GameKernel;
      
      private var turretPhysicsComponent:class_15;
      
      private var textureResource:name_129;
      
      private var var_487:Vector3D = new Vector3D();
      
      public function name_247(textureResource:name_129)
      {
         super();
         this.textureResource = textureResource;
      }
      
      public static function init(diffuse:name_129, opacity:name_129) : void
      {
         smokyShotAtlas = new name_250(diffuse,opacity,8,8,58,1,30,true);
      }
      
      override public function initComponent() : void
      {
         this.turretPhysicsComponent = class_15(entity.getComponentStrict(class_15));
      }
      
      override public function addToGame(gameKernel:GameKernel) : void
      {
         this.gameKernel = gameKernel;
         gameKernel.name_5().method_29(this.textureResource);
      }
      
      override public function removeFromGame(gameKernel:GameKernel) : void
      {
         gameKernel.name_5().method_28(this.textureResource);
      }
      
      public function method_411(barrelIndex:int, barrelOrigin:name_194, muzzlePosition:name_194, gunDirection:name_194, gunElevationAxis:name_194) : void
      {
         var eff:name_594 = new name_594(smokyShotAtlas);
         this.var_487.x = muzzlePosition.x;
         this.var_487.y = muzzlePosition.y;
         this.var_487.z = muzzlePosition.z + 20;
         eff.position = this.var_487;
         this.var_487.x = gunDirection.x;
         this.var_487.y = gunDirection.y;
         this.var_487.z = gunDirection.z;
         eff.direction = this.var_487;
         eff.scale = 3;
         this.gameKernel.name_5().method_48(eff);
      }
   }
}

