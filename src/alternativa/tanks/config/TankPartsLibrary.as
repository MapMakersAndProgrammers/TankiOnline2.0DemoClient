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
      private var name_SB:Vector.<TankPart>;
      
      private var name_dl:Vector.<TankPart>;
      
      private var name_cy:Vector.<BitmapData>;
      
      private var name_Ic:TankPartsBatchLoader;
      
      private var name_1D:ImageSequenceLoader;
      
      public function TankPartsLibrary(param1:Config)
      {
         super("Tank parts library",param1);
      }
      
      public function get numHulls() : int
      {
         return this.name_SB.length;
      }
      
      public function getHull(param1:int) : TankHull
      {
         return TankHull(this.name_SB[param1]);
      }
      
      public function getHullByID(param1:String) : TankHull
      {
         return this.findPartByID(param1,this.name_SB) as TankHull;
      }
      
      public function getHullIndex(param1:String) : int
      {
         return this.getPartIndex(param1,this.name_SB);
      }
      
      public function get numTurrets() : int
      {
         return this.name_dl.length;
      }
      
      public function getTurret(param1:int) : TankTurret
      {
         return TankTurret(this.name_dl[param1]);
      }
      
      public function getTurretByID(param1:String) : TankTurret
      {
         return this.findPartByID(param1,this.name_dl) as TankTurret;
      }
      
      public function getTurretIndex(param1:String) : int
      {
         return this.getPartIndex(param1,this.name_dl);
      }
      
      public function get numColormaps() : int
      {
         return this.name_cy.length;
      }
      
      public function getColormap(param1:int) : BitmapData
      {
         return this.name_cy[param1];
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
         this.name_Ic = new TankPartsBatchLoader();
         this.name_Ic.addEventListener(Event.COMPLETE,this.onHullsLoadingComplete);
         this.name_Ic.load(this.getBaseUrl(),config.xml.tankParts.hull,new TankHullLoaderFactory());
      }
      
      private function onHullsLoadingComplete(param1:Event) : void
      {
         dispatchEvent(new TaskEvent(TaskEvent.TASK_PROGRESS,1,3));
         this.name_Ic.removeEventListener(Event.COMPLETE,this.onHullsLoadingComplete);
         this.name_SB = this.name_Ic.parts;
         this.loadTurrets();
      }
      
      private function loadTurrets() : void
      {
         this.name_Ic.addEventListener(Event.COMPLETE,this.onTurretsLoadingComplete);
         this.name_Ic.load(this.getBaseUrl(),config.xml.tankParts.turret,new TankTurretLoaderFactory());
      }
      
      private function onTurretsLoadingComplete(param1:Event) : void
      {
         dispatchEvent(new TaskEvent(TaskEvent.TASK_PROGRESS,1,3));
         this.name_Ic.removeEventListener(Event.COMPLETE,this.onTurretsLoadingComplete);
         this.name_dl = this.name_Ic.parts;
         this.name_Ic = null;
         this.loadColormaps();
      }
      
      private function loadColormaps() : void
      {
         this.name_1D = new ImageSequenceLoader();
         this.name_1D.addEventListener(Event.COMPLETE,this.onColormapsLoadingComplete);
         this.name_1D.load(StringUtils.makeCorrectBaseUrl(config.xml.colorings.@baseUrl),config.xml.colorings.image);
      }
      
      private function onColormapsLoadingComplete(param1:Event) : void
      {
         dispatchEvent(new TaskEvent(TaskEvent.TASK_PROGRESS,1,3));
         this.name_cy = this.name_1D.images;
         this.name_1D.removeEventListener(Event.COMPLETE,this.onColormapsLoadingComplete);
         this.name_1D = null;
         completeTask();
      }
      
      private function getBaseUrl() : String
      {
         return StringUtils.makeCorrectBaseUrl(config.xml.tankParts.@baseUrl);
      }
   }
}

