package package_15
{
   import flash.display.Stage;
   import package_18.name_51;
   import package_20.name_55;
   import package_20.name_99;
   import package_24.name_105;
   import package_24.name_96;
   import package_25.name_97;
   import package_26.name_104;
   import package_26.name_111;
   import package_27.name_98;
   import package_28.name_101;
   import package_28.name_112;
   import package_29.name_100;
   import package_30.name_103;
   
   public class name_17
   {
      public static const TIME_SYSTEM_PRIORITY:int = 0;
      
      public static const INPUT_SYSTEM_PRIORITY:int = 1000;
      
      public static const EVENT_SYSTEM_PRIORITY:int = 2000;
      
      public static const LOGIC_SYSTEM_1_PRIORITY:int = 3000;
      
      public static const LOGIC_SYSTEM_2_PRIORITY:int = 3001;
      
      public static const PHYSICS_SYSTEM_PRIORITY:int = 4000;
      
      public static const RENDER_SYSTEM_PRIORITY:int = 5000;
      
      public static const CLEANUP_SYSTEM_PRIORITY:int = 6000;
      
      public const const_1:name_100 = new name_100(20);
      
      private var var_43:Stage;
      
      private var var_36:Object;
      
      private var var_41:class_4 = new DummyLogger();
      
      private var var_4:name_102;
      
      private var var_44:name_103;
      
      private var inputSystem:name_101;
      
      private var eventSystem:name_99;
      
      private var logicSystem1:name_96;
      
      private var logicSystem2:name_96;
      
      private var physicsSystem:name_98;
      
      private var renderSystem:name_51;
      
      private var var_42:name_104;
      
      private var var_39:Vector.<name_53>;
      
      private var var_38:int;
      
      private var var_40:name_97;
      
      public function name_17(stage:Stage, options:Object)
      {
         super();
         this.var_43 = stage;
         this.var_36 = options || {};
         this.var_39 = new Vector.<name_53>();
         this.var_40 = new name_97();
         this.var_4 = new name_102();
         this.var_44 = new name_103(TIME_SYSTEM_PRIORITY);
         this.var_4.addTask(this.var_44);
         this.inputSystem = new name_101(INPUT_SYSTEM_PRIORITY,stage);
         this.var_4.addTask(this.inputSystem);
         this.eventSystem = new name_99(EVENT_SYSTEM_PRIORITY);
         this.var_4.addTask(this.eventSystem);
         this.logicSystem1 = new name_96(LOGIC_SYSTEM_1_PRIORITY,this);
         this.var_4.addTask(this.logicSystem1);
         this.logicSystem2 = new name_96(LOGIC_SYSTEM_2_PRIORITY,this);
         this.var_4.addTask(this.logicSystem2);
         this.physicsSystem = new name_98(PHYSICS_SYSTEM_PRIORITY,this.var_40);
         this.var_4.addTask(this.physicsSystem);
         this.renderSystem = new name_51(RENDER_SYSTEM_PRIORITY,stage);
         this.var_4.addTask(this.renderSystem);
         this.var_42 = new name_104(CLEANUP_SYSTEM_PRIORITY);
         this.var_4.addTask(this.var_42);
      }
      
      public function get logger() : class_4
      {
         return this.var_41;
      }
      
      public function set logger(value:class_4) : void
      {
         if(value == null)
         {
            throw new ArgumentError("Logger is null");
         }
         this.var_41 = value;
      }
      
      public function get stage() : Stage
      {
         return this.var_43;
      }
      
      public function get options() : Object
      {
         return this.var_36;
      }
      
      public function method_36(command:name_111) : void
      {
         this.var_42.name_108(command);
      }
      
      public function method_33() : name_97
      {
         return this.var_40;
      }
      
      public function addTask(gameTask:class_1) : void
      {
         this.var_4.addTask(gameTask);
      }
      
      public function name_72(entity:name_53) : void
      {
         if(entity.index < 0)
         {
            entity.index = this.var_38;
            var _loc2_:* = this.var_38++;
            this.var_39[_loc2_] = entity;
            entity.addToGame(this);
            return;
         }
         throw new Error("Entity " + entity + " is already in game");
      }
      
      public function method_34(entity:name_53) : void
      {
         var index:int = int(entity.index);
         if(index < 0)
         {
            throw new Error("Entity " + entity + " is not in game");
         }
         var lastEntity:name_53 = this.var_39[--this.var_38];
         lastEntity.index = index;
         this.var_39[index] = lastEntity;
         this.var_39[this.var_38] = null;
         entity.index = -1;
         entity.removeFromGame(this);
      }
      
      public function name_65() : name_112
      {
         return this.inputSystem;
      }
      
      public function name_60() : name_55
      {
         return this.eventSystem;
      }
      
      public function getLogicSystem1() : name_105
      {
         return this.logicSystem1;
      }
      
      public function getLogicSystem2() : name_105
      {
         return this.logicSystem2;
      }
      
      public function method_37() : name_98
      {
         return this.physicsSystem;
      }
      
      public function name_5() : name_51
      {
         return this.renderSystem;
      }
      
      public function name_45() : void
      {
         this.const_1.name_109();
         this.var_4.name_106();
         this.const_1.name_107();
      }
      
      public function method_35() : void
      {
         this.var_4.name_110();
         this.var_4.name_106();
      }
   }
}

class DummyLogger implements class_4
{
   public function DummyLogger()
   {
      super();
   }
   
   public function log(channel:String, text:String) : void
   {
   }
}
