package §_-az§
{
   import §_-Fc§.§_-8a§;
   import §_-RQ§.§_-Q9§;
   import §_-V-§.§_-mw§;
   import §_-aM§.§_-Lm§;
   import §_-aM§.§_-Yf§;
   import §_-e6§.§_-1I§;
   import §_-j-§.§_-B7§;
   import §_-j-§.§_-Wd§;
   import §_-lS§.§_-h2§;
   import §_-nO§.§_-5B§;
   import §_-nO§.§_-Yk§;
   import flash.display.Stage;
   import §in §.§_-N9§;
   import §in §.§_-eF§;
   
   public class §_-AG§
   {
      public static const TIME_SYSTEM_PRIORITY:int = 0;
      
      public static const INPUT_SYSTEM_PRIORITY:int = 1000;
      
      public static const EVENT_SYSTEM_PRIORITY:int = 2000;
      
      public static const LOGIC_SYSTEM_1_PRIORITY:int = 3000;
      
      public static const LOGIC_SYSTEM_2_PRIORITY:int = 3001;
      
      public static const PHYSICS_SYSTEM_PRIORITY:int = 4000;
      
      public static const RENDER_SYSTEM_PRIORITY:int = 5000;
      
      public static const CLEANUP_SYSTEM_PRIORITY:int = 6000;
      
      public const §_-PI§:§_-mw§ = new §_-mw§(20);
      
      private var §_-We§:Stage;
      
      private var §_-D9§:Object;
      
      private var §_-IC§:§_-kM§ = new DummyLogger();
      
      private var §_-Uw§:§_-1H§;
      
      private var §_-f2§:§_-h2§;
      
      private var inputSystem:§_-Yf§;
      
      private var eventSystem:§_-Wd§;
      
      private var logicSystem1:§_-Yk§;
      
      private var logicSystem2:§_-Yk§;
      
      private var physicsSystem:§_-8a§;
      
      private var renderSystem:§_-1I§;
      
      private var §_-0s§:§_-N9§;
      
      private var §_-jZ§:Vector.<§_-gw§>;
      
      private var §_-TA§:int;
      
      private var §_-XC§:§_-Q9§;
      
      public function §_-AG§(stage:Stage, options:Object)
      {
         super();
         this.§_-We§ = stage;
         this.§_-D9§ = options || {};
         this.§_-jZ§ = new Vector.<§_-gw§>();
         this.§_-XC§ = new §_-Q9§();
         this.§_-Uw§ = new §_-1H§();
         this.§_-f2§ = new §_-h2§(TIME_SYSTEM_PRIORITY);
         this.§_-Uw§.addTask(this.§_-f2§);
         this.inputSystem = new §_-Yf§(INPUT_SYSTEM_PRIORITY,stage);
         this.§_-Uw§.addTask(this.inputSystem);
         this.eventSystem = new §_-Wd§(EVENT_SYSTEM_PRIORITY);
         this.§_-Uw§.addTask(this.eventSystem);
         this.logicSystem1 = new §_-Yk§(LOGIC_SYSTEM_1_PRIORITY,this);
         this.§_-Uw§.addTask(this.logicSystem1);
         this.logicSystem2 = new §_-Yk§(LOGIC_SYSTEM_2_PRIORITY,this);
         this.§_-Uw§.addTask(this.logicSystem2);
         this.physicsSystem = new §_-8a§(PHYSICS_SYSTEM_PRIORITY,this.§_-XC§);
         this.§_-Uw§.addTask(this.physicsSystem);
         this.renderSystem = new §_-1I§(RENDER_SYSTEM_PRIORITY,stage);
         this.§_-Uw§.addTask(this.renderSystem);
         this.§_-0s§ = new §_-N9§(CLEANUP_SYSTEM_PRIORITY);
         this.§_-Uw§.addTask(this.§_-0s§);
      }
      
      public function get logger() : §_-kM§
      {
         return this.§_-IC§;
      }
      
      public function set logger(value:§_-kM§) : void
      {
         if(value == null)
         {
            throw new ArgumentError("Logger is null");
         }
         this.§_-IC§ = value;
      }
      
      public function get stage() : Stage
      {
         return this.§_-We§;
      }
      
      public function get options() : Object
      {
         return this.§_-D9§;
      }
      
      public function §_-L§(command:§_-eF§) : void
      {
         this.§_-0s§.§_-Si§(command);
      }
      
      public function §_-11§() : §_-Q9§
      {
         return this.§_-XC§;
      }
      
      public function addTask(gameTask:§_-ps§) : void
      {
         this.§_-Uw§.addTask(gameTask);
      }
      
      public function §_-oR§(entity:§_-gw§) : void
      {
         if(entity.index < 0)
         {
            entity.index = this.§_-TA§;
            var _loc2_:* = this.§_-TA§++;
            this.§_-jZ§[_loc2_] = entity;
            entity.addToGame(this);
            return;
         }
         throw new Error("Entity " + entity + " is already in game");
      }
      
      public function §_-13§(entity:§_-gw§) : void
      {
         var index:int = int(entity.index);
         if(index < 0)
         {
            throw new Error("Entity " + entity + " is not in game");
         }
         var lastEntity:§_-gw§ = this.§_-jZ§[--this.§_-TA§];
         lastEntity.index = index;
         this.§_-jZ§[index] = lastEntity;
         this.§_-jZ§[this.§_-TA§] = null;
         entity.index = -1;
         entity.removeFromGame(this);
      }
      
      public function §_-Ku§() : §_-Lm§
      {
         return this.inputSystem;
      }
      
      public function §_-Ev§() : §_-B7§
      {
         return this.eventSystem;
      }
      
      public function getLogicSystem1() : §_-5B§
      {
         return this.logicSystem1;
      }
      
      public function getLogicSystem2() : §_-5B§
      {
         return this.logicSystem2;
      }
      
      public function §_-m8§() : §_-8a§
      {
         return this.physicsSystem;
      }
      
      public function §_-DZ§() : §_-1I§
      {
         return this.renderSystem;
      }
      
      public function §_-Kf§() : void
      {
         this.§_-PI§.§_-Ay§();
         this.§_-Uw§.§_-h3§();
         this.§_-PI§.§_-BM§();
      }
      
      public function §_-EC§() : void
      {
         this.§_-Uw§.§_-Ap§();
         this.§_-Uw§.§_-h3§();
      }
   }
}

class DummyLogger implements §_-kM§
{
   public function DummyLogger()
   {
      super();
   }
   
   public function log(channel:String, text:String) : void
   {
   }
}
