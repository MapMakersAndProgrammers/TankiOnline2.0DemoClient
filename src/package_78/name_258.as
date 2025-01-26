package package_78
{
   import package_116.name_529;
   import package_116.name_530;
   import package_15.name_55;
   import package_19.name_528;
   import package_21.name_78;
   import package_71.name_333;
   
   public class name_258
   {
      public static const KEY_DIFFUSE_MAP:String = "diffuseMap";
      
      public static const KEY_NORMAL_MAP:String = "normalMap";
      
      public static const KEY_SURFACE_MAP:String = "surfaceMap";
      
      public function name_258()
      {
         super();
      }
      
      public function method_314(byteArrayMap:name_55, mainFile:String) : name_333
      {
         var objects:Vector.<name_78> = null;
         var parserA3D:name_529 = null;
         var parserCollada:name_530 = null;
         var tankPart:name_333 = this.createTankPart();
         if(mainFile == "main.a3d")
         {
            parserA3D = new name_529();
            parserA3D.method_314(byteArrayMap.name_248(mainFile));
            objects = parserA3D.objects;
         }
         else
         {
            if(mainFile != "main.dae")
            {
               throw new Error("Unsupported type: " + mainFile);
            }
            parserCollada = new name_530();
            parserCollada.method_314(XML(byteArrayMap.name_248(mainFile).toString()));
            objects = parserCollada.objects;
         }
         this.method_417(objects);
         this.beginParsing(tankPart);
         this.doParse(objects,tankPart,byteArrayMap);
         this.endParsing(tankPart);
         tankPart.textureData.name_59(KEY_DIFFUSE_MAP,byteArrayMap.name_248("diffuse.atf"));
         tankPart.textureData.name_59(KEY_NORMAL_MAP,byteArrayMap.name_248("normalmap.atf"));
         tankPart.textureData.name_59(KEY_SURFACE_MAP,byteArrayMap.name_248("surface.atf"));
         return tankPart;
      }
      
      private function method_417(objects:Vector.<name_78>) : void
      {
         var object3D:name_78 = null;
         var skin:name_528 = null;
         var i:int = 0;
         var childAt:name_78 = null;
         for each(object3D in objects)
         {
            if(object3D is name_528)
            {
               skin = name_528(object3D);
               for(i = 0; i < skin.numChildren; i++)
               {
                  childAt = skin.getChildAt(i);
               }
            }
         }
      }
      
      protected function createTankPart() : name_333
      {
         throw new Error("Not implemented");
      }
      
      protected function beginParsing(tankPart:name_333) : void
      {
      }
      
      protected function endParsing(tankPart:name_333) : void
      {
      }
      
      protected function getParsingFunctions() : Object
      {
         return {};
      }
      
      protected function doParse(objects:Vector.<name_78>, tankPart:name_333, byteArrayMap:name_55) : void
      {
         var object:name_78 = null;
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

