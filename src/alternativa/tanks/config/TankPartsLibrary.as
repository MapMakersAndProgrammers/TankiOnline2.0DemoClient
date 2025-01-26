package alternativa.tanks.config
{
   import flash.display.BitmapData;
   import flash.events.Event;
   import package_112.name_463;
   import package_112.name_464;
   import package_40.name_169;
   import package_41.name_461;
   import package_41.name_462;
   import package_71.name_234;
   import package_71.name_249;
   import package_71.name_333;
   
   public class TankPartsLibrary extends ResourceLoader
   {
      private var var_196:Vector.<name_333>;
      
      private var var_197:Vector.<name_333>;
      
      private var var_198:Vector.<BitmapData>;
      
      private var var_194:name_461;
      
      private var var_195:name_462;
      
      public function TankPartsLibrary(param1:Config)
      {
         super("Tank parts library",param1);
      }
      
      public function get name_300() : int
      {
         return this.var_196.length;
      }
      
      public function name_351(param1:int) : name_249
      {
         return name_249(this.var_196[param1]);
      }
      
      public function name_353(param1:String) : name_249
      {
         return this.findPartByID(param1,this.var_196) as name_249;
      }
      
      public function name_350(param1:String) : int
      {
         return this.getPartIndex(param1,this.var_196);
      }
      
      public function get name_302() : int
      {
         return this.var_197.length;
      }
      
      public function name_336(param1:int) : name_234
      {
         return name_234(this.var_197[param1]);
      }
      
      public function name_331(param1:String) : name_234
      {
         return this.findPartByID(param1,this.var_197) as name_234;
      }
      
      public function name_338(param1:String) : int
      {
         return this.getPartIndex(param1,this.var_197);
      }
      
      public function get method_325() : int
      {
         return this.var_198.length;
      }
      
      public function name_347(param1:int) : BitmapData
      {
         return this.var_198[param1];
      }
      
      override public function run() : void
      {
         this.loadHulls();
      }
      
      private function findPartByID(param1:String, param2:Vector.<name_333>) : name_333
      {
         var _loc3_:name_333 = null;
         for each(_loc3_ in param2)
         {
            if(_loc3_.id == param1)
            {
               return _loc3_;
            }
         }
         return null;
      }
      
      private function getPartIndex(param1:String, param2:Vector.<name_333>) : int
      {
         var _loc4_:name_333 = null;
         var _loc3_:int = 0;
         while(_loc3_ < param2.length)
         {
            _loc4_ = param2[_loc3_];
            if(_loc4_.id == param1)
            {
               return _loc3_;
            }
            _loc3_++;
         }
         return -1;
      }
      
      private function loadHulls() : void
      {
         this.var_194 = new name_461();
         this.var_194.addEventListener(Event.COMPLETE,this.onHullsLoadingComplete);
         this.var_194.load(this.getBaseUrl(),config.xml.tankParts.hull,new name_463());
      }
      
      private function onHullsLoadingComplete(param1:Event) : void
      {
         dispatchEvent(new name_169(name_169.TASK_PROGRESS,1,3));
         this.var_194.removeEventListener(Event.COMPLETE,this.onHullsLoadingComplete);
         this.var_196 = this.var_194.parts;
         this.loadTurrets();
      }
      
      private function loadTurrets() : void
      {
         this.var_194.addEventListener(Event.COMPLETE,this.onTurretsLoadingComplete);
         this.var_194.load(this.getBaseUrl(),config.xml.tankParts.turret,new name_464());
      }
      
      private function onTurretsLoadingComplete(param1:Event) : void
      {
         dispatchEvent(new name_169(name_169.TASK_PROGRESS,1,3));
         this.var_194.removeEventListener(Event.COMPLETE,this.onTurretsLoadingComplete);
         this.var_197 = this.var_194.parts;
         this.var_194 = null;
         this.loadColormaps();
      }
      
      private function loadColormaps() : void
      {
         this.var_195 = new name_462();
         this.var_195.addEventListener(Event.COMPLETE,this.onColormapsLoadingComplete);
         this.var_195.load(StringUtils.name_460(config.xml.colorings.@baseUrl),config.xml.colorings.image);
      }
      
      private function onColormapsLoadingComplete(param1:Event) : void
      {
         dispatchEvent(new name_169(name_169.TASK_PROGRESS,1,3));
         this.var_198 = this.var_195.images;
         this.var_195.removeEventListener(Event.COMPLETE,this.onColormapsLoadingComplete);
         this.var_195 = null;
         method_102();
      }
      
      private function getBaseUrl() : String
      {
         return StringUtils.name_460(config.xml.tankParts.@baseUrl);
      }
   }
}

