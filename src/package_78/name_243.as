package package_78
{
   import alternativa.utils.ByteArrayMap;
   import package_19.name_380;
   import package_19.name_528;
   import package_21.name_78;
   import package_46.Matrix4;
   import package_46.name_194;
   import package_71.name_249;
   import package_71.name_318;
   import package_71.name_333;
   import package_86.name_484;
   
   public class name_243 extends name_258
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
      
      public function name_243()
      {
         super();
      }
      
      override protected function doParse(objects:Vector.<name_78>, tankPart:name_333, files:ByteArrayMap) : void
      {
         super.doParse(objects,tankPart,files);
         this.method_423(tankPart,files);
      }
      
      private function method_423(tankPart:name_333, files:ByteArrayMap) : void
      {
         tankPart.textureData.name_59(KEY_TRACKS_NORMAL,files.name_248(TRACKS_NORMALMAP_ATF));
         tankPart.textureData.name_59(KEY_TRACKS_DIFFUSE,files.name_248(TRACKS_DIFFUSEMAP_ATF));
         tankPart.textureData.name_59(KEY_TRACKS_OPACITY,files.name_248(TRACKS_OPACITYMAP_ATF));
         if(files.name_248(SHADOW_ATF) != null)
         {
            tankPart.textureData.name_59(KEY_SHADOW,files.name_248(SHADOW_ATF));
         }
      }
      
      override protected function createTankPart() : name_333
      {
         return new name_249();
      }
      
      override protected function getParsingFunctions() : Object
      {
         return {
            "hull":this.method_429,
            "mount":this.method_422,
            "body":this.method_425,
            "box":this.method_421,
            "simp":this.method_426,
            "sp":this.method_427,
            "wh":this.method_428,
            "track":this.method_424,
            "shadow":this.method_430
         };
      }
      
      override protected function beginParsing(tankPart:name_333) : void
      {
         leftSprings = [];
         rightSprings = [];
      }
      
      override protected function endParsing(tankPart:name_333) : void
      {
         this.method_420(name_249(tankPart));
      }
      
      private function method_429(mesh:name_380, tankHull:name_249) : void
      {
         tankHull.geometry = mesh.geometry;
      }
      
      private function method_422(mesh:name_380, tankHull:name_249) : void
      {
         tankHull.name_533.reset(mesh.x,mesh.y,mesh.z);
         tankHull.name_536.copy(tankHull.name_533);
      }
      
      private function method_425(mesh:name_380, tankHull:name_249) : void
      {
         tankHull.name_517 = name_531.name_532(mesh);
      }
      
      private function method_421(mesh:name_380, tankHull:name_249) : void
      {
         var boxData:name_484 = name_531.name_532(mesh);
         tankHull.name_534.push(boxData);
      }
      
      private function method_426(mesh:name_380, tankHull:name_249) : void
      {
         var boxData:name_484 = name_531.name_532(mesh);
         tankHull.name_535.push(boxData);
      }
      
      private function method_427(mesh:name_380, tankHull:name_249) : void
      {
         var name:String = mesh.name.toLowerCase();
         var type:String = name.substr(2,1);
         var index:int = int(int(name.substr(3,1)));
         var array:Array = type == "r" ? rightSprings : leftSprings;
         array[index] = new name_194(mesh.x,mesh.y,mesh.z);
      }
      
      private function method_428(mesh:name_380, tankHull:name_249) : void
      {
         var tankWheel:name_318 = new name_318(mesh.name,mesh.geometry,new name_194(mesh.x,mesh.y,mesh.z));
         if(mesh.name.charAt(2) == "l")
         {
            tankHull.name_325.push(tankWheel);
         }
         else
         {
            tankHull.name_323.push(tankWheel);
         }
      }
      
      private function method_430(mesh:name_380, tankHull:name_249) : void
      {
         tankHull.shadow = mesh;
      }
      
      private function method_424(skin:name_528, tankHull:name_249) : void
      {
         var child:name_78 = null;
         for(var i:int = 0; i < skin.numChildren; i++)
         {
            child = skin.getChildAt(i);
            child.name = child.name.toLowerCase();
         }
         if(skin.name.toLowerCase().charAt(0) == "l")
         {
            tankHull.name_337 = skin;
         }
         else
         {
            tankHull.name_340 = skin;
         }
      }
      
      private function method_420(tankHull:name_249) : void
      {
         var skinMatrix:Matrix4 = tankHull.name_517.matrix.clone();
         skinMatrix.invert();
         skinMatrix.getAxis(3,tankHull.name_538);
         tankHull.name_533.transform4(skinMatrix);
         this.method_418(tankHull.name_534,skinMatrix);
         this.method_418(tankHull.name_535,skinMatrix);
         tankHull.name_539 = this.method_419(leftSprings,skinMatrix);
         tankHull.name_537 = this.method_419(rightSprings,skinMatrix);
         leftSprings = null;
         rightSprings = null;
      }
      
      private function method_418(geometry:Vector.<name_484>, m:Matrix4) : void
      {
         var cbData:name_484 = null;
         for each(cbData in geometry)
         {
            cbData.matrix.append(m);
         }
      }
      
      private function method_419(points:Array, matrix:Matrix4) : Vector.<name_194>
      {
         var v:name_194 = null;
         for each(v in points)
         {
            v.transform4(matrix);
         }
         return Vector.<name_194>(points);
      }
   }
}

