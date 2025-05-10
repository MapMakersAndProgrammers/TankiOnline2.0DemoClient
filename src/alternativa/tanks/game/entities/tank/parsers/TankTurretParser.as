package alternativa.tanks.game.entities.tank.parsers
{
   import alternativa.engine3d.objects.Mesh;
   import alternativa.math.Vector3;
   import alternativa.tanks.game.entities.tank.TankPart;
   import alternativa.tanks.game.entities.tank.TankTurret;
   
   public class TankTurretParser extends TankPartParser
   {
      public function TankTurretParser()
      {
         super();
      }
      
      override protected function createTankPart() : TankPart
      {
         return new TankTurret();
      }
      
      override protected function getParsingFunctions() : Object
      {
         return {
            "turret":this.parseSkin,
            "fmnt":this.parseFlagMountPoint,
            "box":this.parseTurretBox,
            "muzzle":this.parseMuzzle
         };
      }
      
      private function parseSkin(mesh:Mesh, tankTurret:TankTurret) : void
      {
         tankTurret.geometry = mesh.geometry;
      }
      
      private function parseFlagMountPoint(mesh:Mesh, tankTurret:TankTurret) : void
      {
         tankTurret.§_-G3§.reset(mesh.x,mesh.y,mesh.z);
      }
      
      private function parseTurretBox(mesh:Mesh, tankTurret:TankTurret) : void
      {
         tankTurret.§_-Of§.push(TankPartParsingUtils.parseCollisionBoxData(mesh));
      }
      
      private function parseMuzzle(mesh:Mesh, tankTurret:TankTurret) : void
      {
         tankTurret.§_-O3§.push(new Vector3(mesh.x,mesh.y,mesh.z));
      }
   }
}

