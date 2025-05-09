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
      private var §_-SB§:Vector.<TankPart>;
      
      private var §_-dl§:Vector.<TankPart>;
      
      private var §_-cy§:Vector.<BitmapData>;
      
      private var §_-Ic§:TankPartsBatchLoader;
      
      private var §_-1D§:ImageSequenceLoader;
      
      public function TankPartsLibrary(param1:Config)
      {
         super("Tank parts library",param1);
      }
      
      public function get numHulls() : int
      {
         return this.§_-SB§.length;
      }
      
      public function getHull(param1:int) : TankHull
      {
         return TankHull(this.§_-SB§[param1]);
      }
      
      public function getHullByID(param1:String) : TankHull
      {
         return this.findPartByID(param1,this.§_-SB§) as TankHull;
      }
      
      public function getHullIndex(param1:String) : int
      {
         return this.getPartIndex(param1,this.§_-SB§);
      }
      
      public function get numTurrets() : int
      {
         return this.§_-dl§.length;
      }
      
      public function getTurret(param1:int) : TankTurret
      {
         return TankTurret(this.§_-dl§[param1]);
      }
      
      public function getTurretByID(param1:String) : TankTurret
      {
         return this.findPartByID(param1,this.§_-dl§) as TankTurret;
      }
      
      public function getTurretIndex(param1:String) : int
      {
         return this.getPartIndex(param1,this.§_-dl§);
      }
      
      public function get numColormaps() : int
      {
         return this.§_-cy§.length;
      }
      
      public function getColormap(param1:int) : BitmapData
      {
         return this.§_-cy§[param1];
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
         this.§_-Ic§ = new TankPartsBatchLoader();
         this.§_-Ic§.addEventListener(Event.COMPLETE,this.onHullsLoadingComplete);
         this.§_-Ic§.load(this.getBaseUrl(),config.xml.tankParts.hull,new TankHullLoaderFactory());
      }
      
      private function onHullsLoadingComplete(param1:Event) : void
      {
         dispatchEvent(new TaskEvent(TaskEvent.TASK_PROGRESS,1,3));
         this.§_-Ic§.removeEventListener(Event.COMPLETE,this.onHullsLoadingComplete);
         this.§_-SB§ = this.§_-Ic§.parts;
         this.loadTurrets();
      }
      
      private function loadTurrets() : void
      {
         this.§_-Ic§.addEventListener(Event.COMPLETE,this.onTurretsLoadingComplete);
         this.§_-Ic§.load(this.getBaseUrl(),config.xml.tankParts.turret,new TankTurretLoaderFactory());
      }
      
      private function onTurretsLoadingComplete(param1:Event) : void
      {
         dispatchEvent(new TaskEvent(TaskEvent.TASK_PROGRESS,1,3));
         this.§_-Ic§.removeEventListener(Event.COMPLETE,this.onTurretsLoadingComplete);
         this.§_-dl§ = this.§_-Ic§.parts;
         this.§_-Ic§ = null;
         this.loadColormaps();
      }
      
      private function loadColormaps() : void
      {
         this.§_-1D§ = new ImageSequenceLoader();
         this.§_-1D§.addEventListener(Event.COMPLETE,this.onColormapsLoadingComplete);
         this.§_-1D§.load(StringUtils.makeCorrectBaseUrl(config.xml.colorings.@baseUrl),config.xml.colorings.image);
      }
      
      private function onColormapsLoadingComplete(param1:Event) : void
      {
         dispatchEvent(new TaskEvent(TaskEvent.TASK_PROGRESS,1,3));
         this.§_-cy§ = this.§_-1D§.images;
         this.§_-1D§.removeEventListener(Event.COMPLETE,this.onColormapsLoadingComplete);
         this.§_-1D§ = null;
         completeTask();
      }
      
      private function getBaseUrl() : String
      {
         return StringUtils.makeCorrectBaseUrl(config.xml.tankParts.@baseUrl);
      }
   }
}

