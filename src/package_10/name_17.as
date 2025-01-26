package package_10
{
   import flash.display.Stage;
   import package_18.name_44;
   import package_20.name_179;
   import package_20.name_56;
   import package_22.name_181;
   import package_22.name_87;
   import package_26.name_100;
   import package_27.name_180;
   import package_42.name_177;
   import package_42.name_184;
   import package_43.name_183;
   import package_43.name_190;
   import package_44.name_178;
   import package_45.name_182;
   
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
      
      public const const_1:name_180 = new name_180(20);
      
      private var var_43:Stage;
      
      private var var_36:Object;
      
      private var var_41:class_8 = new DummyLogger();
      
      private var var_4:name_52;
      
      private var var_44:name_182;
      
      private var inputSystem:name_181;
      
      private var eventSystem:name_179;
      
      private var logicSystem1:name_177;
      
      private var logicSystem2:name_177;
      
      private var physicsSystem:name_178;
      
      private var renderSystem:name_44;
      
      private var var_42:name_183;
      
      private var var_39:Vector.<name_54>;
      
      private var var_38:int;
      
      private var var_40:name_100;
      
      public function name_17(stage:Stage, options:Object)
      {
         super();
         this.var_43 = stage;
         this.var_36 = options || {};
         this.var_39 = new Vector.<name_54>();
         this.var_40 = new name_100();
         this.var_4 = new name_52();
         this.var_44 = new name_182(TIME_SYSTEM_PRIORITY);
         this.var_4.addTask(this.var_44);
         this.inputSystem = new name_181(INPUT_SYSTEM_PRIORITY,stage);
         this.var_4.addTask(this.inputSystem);
         this.eventSystem = new name_179(EVENT_SYSTEM_PRIORITY);
         this.var_4.addTask(this.eventSystem);
         this.logicSystem1 = new name_177(LOGIC_SYSTEM_1_PRIORITY,this);
         this.var_4.addTask(this.logicSystem1);
         this.logicSystem2 = new name_177(LOGIC_SYSTEM_2_PRIORITY,this);
         this.var_4.addTask(this.logicSystem2);
         this.physicsSystem = new name_178(PHYSICS_SYSTEM_PRIORITY,this.var_40);
         this.var_4.addTask(this.physicsSystem);
         this.renderSystem = new name_44(RENDER_SYSTEM_PRIORITY,stage);
         this.var_4.addTask(this.renderSystem);
         this.var_42 = new name_183(CLEANUP_SYSTEM_PRIORITY);
         this.var_4.addTask(this.var_42);
      }
      
      public function get logger() : class_8
      {
         return this.var_41;
      }
      
      public function set logger(value:class_8) : void
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
      
      public function method_111(command:name_190) : void
      {
         this.var_42.name_187(command);
      }
      
      public function method_108() : name_100
      {
         return this.var_40;
      }
      
      public function addTask(gameTask:class_1) : void
      {
         this.var_4.addTask(gameTask);
      }
      
      public function name_73(entity:name_54) : void
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
      
      public function method_109(entity:name_54) : void
      {
         var index:int = int(entity.index);
         if(index < 0)
         {
            throw new Error("Entity " + entity + " is not in game");
         }
         var lastEntity:name_54 = this.var_39[--this.var_38];
         lastEntity.index = index;
         this.var_39[index] = lastEntity;
         this.var_39[this.var_38] = null;
         entity.index = -1;
         entity.removeFromGame(this);
      }
      
      public function name_66() : name_87
      {
         return this.inputSystem;
      }
      
      public function name_61() : name_56
      {
         return this.eventSystem;
      }
      
      public function getLogicSystem1() : name_184
      {
         return this.logicSystem1;
      }
      
      public function getLogicSystem2() : name_184
      {
         return this.logicSystem2;
      }
      
      public function method_112() : name_178
      {
         return this.physicsSystem;
      }
      
      public function name_5() : name_44
      {
         return this.renderSystem;
      }
      
      public function name_51() : void
      {
         this.const_1.name_188();
         this.var_4.name_185();
         this.const_1.name_186();
      }
      
      public function method_110() : void
      {
         this.var_4.name_189();
         this.var_4.name_185();
      }
   }
}

class DummyLogger implements class_8
{
   public function DummyLogger()
   {
      super();
   }
   
   public function log(channel:String, text:String) : void
   {
   }
}
