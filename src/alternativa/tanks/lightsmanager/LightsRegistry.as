package alternativa.tanks.lightsmanager
{
   import alternativa.engine3d.core.Light3D;
   import alternativa.osgi.service.console.IConsole;
   import alternativa.tanks.game.subsystems.rendersystem.RenderSystem;
   
   public class LightsRegistry
   {
      protected var lastId:int;
      
      protected var renderSystem:RenderSystem;
      
      public function LightsRegistry(param1:RenderSystem)
      {
         super();
         this.renderSystem = param1;
      }
      
      final public function handleCommand(param1:IConsole, param2:Array) : void
      {
         var _loc4_:int = 0;
         var _loc5_:Light3D = null;
         var _loc6_:String = null;
         if(param2.length == 0)
         {
            param1.addText("Parameters are expected:");
            param1.addText("ls -- list lights");
            param1.addText("add <params> -- add light");
            param1.addText("del <light_id> -- delete light");
            param1.addText("clear -- delete all lights");
            param1.addText("<light_id> <property> <value> -- set property of the light");
            return;
         }
         var _loc3_:String = param2.shift();
         switch(_loc3_)
         {
            case "ls":
               this.list(param1);
               break;
            case "add":
               _loc4_ = ++this.lastId;
               _loc5_ = this.create(param1,param2,_loc4_);
               if(_loc5_ != null)
               {
                  param1.addText("Light has been created: " + _loc5_.name);
                  param1.addText(this.lightToString(_loc5_));
               }
               break;
            case "del":
               _loc6_ = param2[0];
               this.del(param1,_loc6_);
               break;
            case "clear":
               this.clear(param1);
               break;
            default:
               _loc5_ = this.modify(param1,_loc3_,param2);
               if(_loc5_ != null)
               {
                  param1.addText("Light has been changed: " + _loc5_.name);
                  param1.addText(this.lightToString(_loc5_));
                  break;
               }
               param1.addText("Light has not been changed or found");
               break;
         }
      }
      
      private function clear(param1:IConsole) : void
      {
         var _loc3_:Vector.<String> = null;
         var _loc4_:Light3D = null;
         var _loc5_:String = null;
         var _loc2_:Vector.<Light3D> = this.getLigts();
         if(_loc2_ != null)
         {
            _loc3_ = new Vector.<String>();
            for each(_loc4_ in _loc2_)
            {
               _loc3_.push(_loc4_.name);
            }
            for each(_loc5_ in _loc3_)
            {
               this.del(param1,_loc5_);
            }
         }
      }
      
      private function list(param1:IConsole) : void
      {
         var _loc3_:Light3D = null;
         var _loc2_:Vector.<Light3D> = this.getLigts();
         for each(_loc3_ in _loc2_)
         {
            param1.addText(_loc3_.name + " " + this.lightToString(_loc3_));
         }
      }
      
      protected function getLigts() : Vector.<Light3D>
      {
         throw new Error("Not imlemented");
      }
      
      protected function lightToString(param1:Light3D) : String
      {
         return "[None]";
      }
      
      protected function modify(param1:IConsole, param2:String, param3:Array) : Light3D
      {
         throw new Error("Not implemented");
      }
      
      protected function create(param1:IConsole, param2:Array, param3:int) : Light3D
      {
         throw new Error("Not implemented");
      }
      
      protected function del(param1:IConsole, param2:String) : Light3D
      {
         throw new Error("Not implemented");
      }
      
      final protected function parseNumber(param1:String, param2:Number = 0) : Number
      {
         var _loc3_:Number = Number(Number(param1));
         return !!isNaN(_loc3_) ? param2 : _loc3_;
      }
   }
}

