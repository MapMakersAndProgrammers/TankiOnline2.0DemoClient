package alternativa.tanks.config
{
   import alternativa.tanks.config.loaders.ImageSequenceLoader;
   import alternativa.tanks.config.loaders.TankPartsBatchLoader;
   import alternativa.tanks.config.loaders.tankparts.TankHullLoaderFactory;
   import alternativa.tanks.config.loaders.tankparts.TankTurretLoaderFactory;
   import alternativa.tanks.game.entities.tank.TankHull;
   import alternativa.tanks.game.entities.tank.TankPart;
   import alternativa.tanks.game.entities.tank.TankTurret;
   import alternativa.tanks.utils.TaskEvent;
   import flash.display.BitmapData;
   import flash.events.Event;
   
   public class TankPartsLibrary extends ResourceLoader
   {
      private var var_196:Vector.<TankPart>;
      
      private var var_197:Vector.<TankPart>;
      
      private var var_198:Vector.<BitmapData>;
      
      private var var_194:TankPartsBatchLoader;
      
      private var var_195:ImageSequenceLoader;
      
      public function TankPartsLibrary(param1:Config)
      {
         super("Tank parts library",param1);
      }
      
      public function get numHulls() : int
      {
         return this.var_196.length;
      }
      
      public function getHull(param1:int) : TankHull
      {
         return TankHull(this.var_196[param1]);
      }
      
      public function getHullByID(param1:String) : TankHull
      {
         return this.findPartByID(param1,this.var_196) as TankHull;
      }
      
      public function getHullIndex(param1:String) : int
      {
         return this.getPartIndex(param1,this.var_196);
      }
      
      public function get numTurrets() : int
      {
         return this.var_197.length;
      }
      
      public function getTurret(param1:int) : TankTurret
      {
         return TankTurret(this.var_197[param1]);
      }
      
      public function getTurretByID(param1:String) : TankTurret
      {
         return this.findPartByID(param1,this.var_197) as TankTurret;
      }
      
      public function getTurretIndex(param1:String) : int
      {
         return this.getPartIndex(param1,this.var_197);
      }
      
      public function get numColormaps() : int
      {
         return this.var_198.length;
      }
      
      public function getColormap(param1:int) : BitmapData
      {
         return this.var_198[param1];
      }
      
      override public function run() : void
      {
         this.loadHulls();
      }
      
      private function findPartByID(param1:String, param2:Vector.<TankPart>) : TankPart
      {
         var _loc3_:TankPart = null;
         for each(_loc3_ in param2)
         {
            if(_loc3_.id == param1)
            {
               return _loc3_;
            }
         }
         return null;
      }
      
      private function getPartIndex(param1:String, param2:Vector.<TankPart>) : int
      {
         var _loc4_:TankPart = null;
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
         this.var_194 = new TankPartsBatchLoader();
         this.var_194.addEventListener(Event.COMPLETE,this.onHullsLoadingComplete);
         this.var_194.load(this.getBaseUrl(),config.xml.tankParts.hull,new TankHullLoaderFactory());
      }
      
      private function onHullsLoadingComplete(param1:Event) : void
      {
         dispatchEvent(new TaskEvent(TaskEvent.TASK_PROGRESS,1,3));
         this.var_194.removeEventListener(Event.COMPLETE,this.onHullsLoadingComplete);
         this.var_196 = this.var_194.parts;
         this.loadTurrets();
      }
      
      private function loadTurrets() : void
      {
         this.var_194.addEventListener(Event.COMPLETE,this.onTurretsLoadingComplete);
         this.var_194.load(this.getBaseUrl(),config.xml.tankParts.turret,new TankTurretLoaderFactory());
      }
      
      private function onTurretsLoadingComplete(param1:Event) : void
      {
         dispatchEvent(new TaskEvent(TaskEvent.TASK_PROGRESS,1,3));
         this.var_194.removeEventListener(Event.COMPLETE,this.onTurretsLoadingComplete);
         this.var_197 = this.var_194.parts;
         this.var_194 = null;
         this.loadColormaps();
      }
      
      private function loadColormaps() : void
      {
         this.var_195 = new ImageSequenceLoader();
         this.var_195.addEventListener(Event.COMPLETE,this.onColormapsLoadingComplete);
         this.var_195.load(StringUtils.makeCorrectBaseUrl(config.xml.colorings.@baseUrl),config.xml.colorings.image);
      }
      
      private function onColormapsLoadingComplete(param1:Event) : void
      {
         dispatchEvent(new TaskEvent(TaskEvent.TASK_PROGRESS,1,3));
         this.var_198 = this.var_195.images;
         this.var_195.removeEventListener(Event.COMPLETE,this.onColormapsLoadingComplete);
         this.var_195 = null;
         completeTask();
      }
      
      private function getBaseUrl() : String
      {
         return StringUtils.makeCorrectBaseUrl(config.xml.tankParts.@baseUrl);
      }
   }
}

