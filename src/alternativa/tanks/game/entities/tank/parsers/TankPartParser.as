package alternativa.tanks.game.entities.tank.parsers
{
   import alternativa.engine3d.core.Object3D;
   import alternativa.engine3d.loaders.ParserA3D;
   import alternativa.engine3d.loaders.ParserCollada;
   import alternativa.engine3d.objects.Skin;
   import alternativa.tanks.game.entities.tank.TankPart;
   import alternativa.utils.ByteArrayMap;
   
   public class TankPartParser
   {
      public static const KEY_DIFFUSE_MAP:String = "diffuseMap";
      
      public static const KEY_NORMAL_MAP:String = "normalMap";
      
      public static const KEY_SURFACE_MAP:String = "surfaceMap";
      
      public function TankPartParser()
      {
         super();
      }
      
      public function parse(byteArrayMap:ByteArrayMap, mainFile:String) : TankPart
      {
         var objects:Vector.<Object3D> = null;
         var parserA3D:ParserA3D = null;
         var parserCollada:ParserCollada = null;
         var tankPart:TankPart = this.createTankPart();
         if(mainFile == "main.a3d")
         {
            parserA3D = new ParserA3D();
            parserA3D.parse(byteArrayMap.getValue(mainFile));
            objects = parserA3D.objects;
         }
         else
         {
            if(mainFile != "main.dae")
            {
               throw new Error("Unsupported type: " + mainFile);
            }
            parserCollada = new ParserCollada();
            parserCollada.parse(XML(byteArrayMap.getValue(mainFile).toString()));
            objects = parserCollada.objects;
         }
         this.traceSkins(objects);
         this.beginParsing(tankPart);
         this.doParse(objects,tankPart,byteArrayMap);
         this.endParsing(tankPart);
         tankPart.textureData.putValue(KEY_DIFFUSE_MAP,byteArrayMap.getValue("diffuse.atf"));
         tankPart.textureData.putValue(KEY_NORMAL_MAP,byteArrayMap.getValue("normalmap.atf"));
         tankPart.textureData.putValue(KEY_SURFACE_MAP,byteArrayMap.getValue("surface.atf"));
         return tankPart;
      }
      
      private function traceSkins(objects:Vector.<Object3D>) : void
      {
         var object3D:Object3D = null;
         var skin:Skin = null;
         var i:int = 0;
         var childAt:Object3D = null;
         for each(object3D in objects)
         {
            if(object3D is Skin)
            {
               skin = Skin(object3D);
               for(i = 0; i < skin.numChildren; i++)
               {
                  childAt = skin.getChildAt(i);
               }
            }
         }
      }
      
      protected function createTankPart() : TankPart
      {
         throw new Error("Not implemented");
      }
      
      protected function beginParsing(tankPart:TankPart) : void
      {
      }
      
      protected function endParsing(tankPart:TankPart) : void
      {
      }
      
      protected function getParsingFunctions() : Object
      {
         return {};
      }
      
      protected function doParse(objects:Vector.<Object3D>, tankPart:TankPart, byteArrayMap:ByteArrayMap) : void
      {
         var object:Object3D = null;
         var key:String = null;
         var func:Function = null;
         var parsingFunctions:Object = this.getParsingFunctions();
         var len:int = int(objects.length);
         for(var i:int = 0; i < len; )
         {
            object = objects[i];
            if(object.name != null)
            {
               object.name = object.name.toLowerCase();
               for(key in parsingFunctions)
               {
                  if(object.name.indexOf(key) >= 0)
                  {
                     func = parsingFunctions[key];
                     func.call(null,object,tankPart);
                     break;
                  }
               }
            }
            i++;
         }
      }
   }
}

