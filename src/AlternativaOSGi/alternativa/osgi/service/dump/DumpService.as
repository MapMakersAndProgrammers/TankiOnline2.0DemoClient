package alternativa.osgi.service.dump
{
   import alternativa.osgi.OSGi;
   import alternativa.osgi.service.console.IConsole;
   import flash.utils.Dictionary;
   
   public class DumpService implements IDumpService
   {
      
      private var osgi:OSGi;
      
      private var _dumperByName:Dictionary;
      
      private var _dumperByIndex:Vector.<IDumper>;
      
      public function DumpService(param1:OSGi)
      {
         super();
         this.osgi = param1;
         var _loc2_:IConsole = IConsole(param1.getService(IConsole));
         _loc2_.setCommandHandler("dump",this.hadleConsoleCommand);
         this._dumperByName = new Dictionary(false);
         this._dumperByIndex = new Vector.<IDumper>();
      }
      
      public function registerDumper(param1:IDumper) : void
      {
         if(this._dumperByName[param1.dumperName] != null)
         {
            throw new Error("Dumper is already registered");
         }
         this._dumperByName[param1.dumperName] = param1;
         this._dumperByIndex.push(param1);
      }
      
      public function unregisterDumper(param1:String) : void
      {
         var _loc2_:IDumper = this._dumperByName[param1];
         if(_loc2_ != null)
         {
            this._dumperByIndex.splice(this._dumperByIndex.indexOf(_loc2_),1);
            delete this._dumperByName[param1];
         }
      }
      
      public function dump(param1:String, param2:Array) : String
      {
         var _loc3_:IDumper = null;
         var _loc4_:int = 0;
         if(param1 == null)
         {
            return this.getDumperList();
         }
         if(param1.match(/^\d+$/) != null)
         {
            _loc4_ = int(param1);
            if(_loc4_ < this._dumperByIndex.length)
            {
               _loc3_ = this._dumperByIndex[_loc4_];
            }
         }
         else
         {
            _loc3_ = this._dumperByName[param1];
         }
         if(_loc3_ == null)
         {
            return "Dumper " + param1 + " not found. Available dumpers: \n" + this.getDumperList();
         }
         return _loc3_.dump(param2);
      }
      
      public function get dumpersByName() : Dictionary
      {
         return this._dumperByName;
      }
      
      public function get dumpersList() : Vector.<IDumper>
      {
         return this._dumperByIndex;
      }
      
      private function getDumperList() : String
      {
         var _loc1_:String = "";
         var _loc2_:int = 0;
         while(_loc2_ < this._dumperByIndex.length)
         {
            _loc1_ += _loc2_.toString() + " " + this._dumperByIndex[_loc2_].dumperName + "\n";
            _loc2_++;
         }
         return _loc1_;
      }
      
      private function hadleConsoleCommand(param1:IConsole, param2:Array) : void
      {
         var _loc3_:String = param2.shift();
         param1.addText(this.dump(_loc3_,param2));
      }
   }
}

