package alternativa.tanks.game.entities.tank.parsers
{
   import alternativa.engine3d.core.Object3D;
   import alternativa.engine3d.objects.Mesh;
   import alternativa.engine3d.objects.Skin;
   import alternativa.math.Matrix4;
   import alternativa.math.Vector3;
   import alternativa.tanks.game.entities.tank.TankHull;
   import alternativa.tanks.game.entities.tank.TankPart;
   import alternativa.tanks.game.entities.tank.TankWheel;
   import alternativa.tanks.game.physics.BoxData;
   import alternativa.utils.ByteArrayMap;
   
   public class TankHullParser extends TankPartParser
   {
      private static var leftSprings:Array;
      
      private static var rightSprings:Array;
      
      public static const KEY_TRACKS_DIFFUSE:String = "tracksDiffuseMap";
      
      public static const KEY_TRACKS_NORMAL:String = "tracksNormalMap";
      
      public static const KEY_TRACKS_OPACITY:String = "tracksOpacityMap";
      
      public static const KEY_SHADOW:String = "tracksShadowMap";
      
      public static const TRACKS_NORMALMAP_ATF:String = "tracks_normalmap.atf";
      
      public static const TRACKS_DIFFUSEMAP_ATF:String = "tracks_diffuse.atf";
      
      public static const TRACKS_OPACITYMAP_ATF:String = "tracks_opacity.atf";
      
      public static const SHADOW_ATF:String = "shadow.atf";
      
      public function TankHullParser()
      {
         super();
      }
      
      override protected function doParse(objects:Vector.<Object3D>, tankPart:TankPart, files:ByteArrayMap) : void
      {
         super.doParse(objects,tankPart,files);
         this.parseTextureData(tankPart,files);
      }
      
      private function parseTextureData(tankPart:TankPart, files:ByteArrayMap) : void
      {
         tankPart.textureData.putValue(KEY_TRACKS_NORMAL,files.getValue(TRACKS_NORMALMAP_ATF));
         tankPart.textureData.putValue(KEY_TRACKS_DIFFUSE,files.getValue(TRACKS_DIFFUSEMAP_ATF));
         tankPart.textureData.putValue(KEY_TRACKS_OPACITY,files.getValue(TRACKS_OPACITYMAP_ATF));
         if(files.getValue(SHADOW_ATF) != null)
         {
            tankPart.textureData.putValue(KEY_SHADOW,files.getValue(SHADOW_ATF));
         }
      }
      
      override protected function createTankPart() : TankPart
      {
         return new TankHull();
      }
      
      override protected function getParsingFunctions() : Object
      {
         return {
            "hull":this.parseSkin,
            "mount":this.parseMountPoint,
            "body":this.parseBody,
            "box":this.parseDetailedGeometry,
            "simp":this.parseSimpleGeometry,
            "sp":this.parseSuspensionRay,
            "wh":this.parseWheels,
            "track":this.parseTrack,
            "shadow":this.parseShadow
         };
      }
      
      override protected function beginParsing(tankPart:TankPart) : void
      {
         leftSprings = [];
         rightSprings = [];
      }
      
      override protected function endParsing(tankPart:TankPart) : void
      {
         this.prepareAll(TankHull(tankPart));
      }
      
      private function parseSkin(mesh:Mesh, tankHull:TankHull) : void
      {
         tankHull.geometry = mesh.geometry;
      }
      
      private function parseMountPoint(mesh:Mesh, tankHull:TankHull) : void
      {
         tankHull.name_Rj.reset(mesh.x,mesh.y,mesh.z);
         tankHull.name_EN.copy(tankHull.name_Rj);
      }
      
      private function parseBody(mesh:Mesh, tankHull:TankHull) : void
      {
         tankHull.name_eh = TankPartParsingUtils.parseCollisionBoxData(mesh);
      }
      
      private function parseDetailedGeometry(mesh:Mesh, tankHull:TankHull) : void
      {
         var boxData:BoxData = TankPartParsingUtils.parseCollisionBoxData(mesh);
         tankHull.name_AE.push(boxData);
      }
      
      private function parseSimpleGeometry(mesh:Mesh, tankHull:TankHull) : void
      {
         var boxData:BoxData = TankPartParsingUtils.parseCollisionBoxData(mesh);
         tankHull.name_KR.push(boxData);
      }
      
      private function parseSuspensionRay(mesh:Mesh, tankHull:TankHull) : void
      {
         var name:String = mesh.name.toLowerCase();
         var type:String = name.substr(2,1);
         var index:int = int(int(name.substr(3,1)));
         var array:Array = type == "r" ? rightSprings : leftSprings;
         array[index] = new Vector3(mesh.x,mesh.y,mesh.z);
      }
      
      private function parseWheels(mesh:Mesh, tankHull:TankHull) : void
      {
         var tankWheel:TankWheel = new TankWheel(mesh.name,mesh.geometry,new Vector3(mesh.x,mesh.y,mesh.z));
         if(mesh.name.charAt(2) == "l")
         {
            tankHull.name_EY.push(tankWheel);
         }
         else
         {
            tankHull.name_M4.push(tankWheel);
         }
      }
      
      private function parseShadow(mesh:Mesh, tankHull:TankHull) : void
      {
         tankHull.shadow = mesh;
      }
      
      private function parseTrack(skin:Skin, tankHull:TankHull) : void
      {
         var child:Object3D = null;
         for(var i:int = 0; i < skin.numChildren; i++)
         {
            child = skin.getChildAt(i);
            child.name = child.name.toLowerCase();
         }
         if(skin.name.toLowerCase().charAt(0) == "l")
         {
            tankHull.name_Ei = skin;
         }
         else
         {
            tankHull.name_iA = skin;
         }
      }
      
      private function prepareAll(tankHull:TankHull) : void
      {
         var skinMatrix:Matrix4 = tankHull.name_eh.matrix.clone();
         skinMatrix.invert();
         skinMatrix.getAxis(3,tankHull.name_Sh);
         tankHull.name_Rj.transform4(skinMatrix);
         this.prepareCollisionGeometry(tankHull.name_AE,skinMatrix);
         this.prepareCollisionGeometry(tankHull.name_KR,skinMatrix);
         tankHull.name_j9 = this.prepareSuspensionPoints(leftSprings,skinMatrix);
         tankHull.name_Hd = this.prepareSuspensionPoints(rightSprings,skinMatrix);
         leftSprings = null;
         rightSprings = null;
      }
      
      private function prepareCollisionGeometry(geometry:Vector.<BoxData>, m:Matrix4) : void
      {
         var cbData:BoxData = null;
         for each(cbData in geometry)
         {
            cbData.matrix.append(m);
         }
      }
      
      private function prepareSuspensionPoints(points:Array, matrix:Matrix4) : Vector.<Vector3>
      {
         var v:Vector3 = null;
         for each(v in points)
         {
            v.transform4(matrix);
         }
         return Vector.<Vector3>(points);
      }
   }
}

