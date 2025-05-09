package alternativa.osgi.service.dump
{
   import alternativa.osgi.OSGi;
   import alternativa.osgi.service.console.IConsole;
   import flash.utils.Dictionary;
   
   public class DumpService implements IDumpService
   {
      private var osgi:OSGi;
      
      private var var_548:Dictionary;
      
      private var var_547:Vector.<IDumper>;
      
      public function DumpService(osgi:OSGi)
      {
         super();
         this.osgi = osgi;
         var console:IConsole = IConsole(osgi.getService(IConsole));
         console.setCommandHandler("dump",this.hadleConsoleCommand);
         this.var_548 = new Dictionary(false);
         this.var_547 = new Vector.<IDumper>();
      }
      
      public function registerDumper(dumper:IDumper) : void
      {
         if(this.var_548[dumper.dumperName] != null)
         {
            throw new Error("Dumper is already registered");
         }
         this.var_548[dumper.dumperName] = dumper;
         this.var_547.push(dumper);
      }
      
      public function unregisterDumper(dumperName:String) : void
      {
         var dumper:IDumper = this.var_548[dumperName];
         if(dumper != null)
         {
            this.var_547.splice(this.var_547.indexOf(dumper),1);
            delete this.var_548[dumperName];
         }
      }
      
      public function dump(dumperName:String, params:Array) : String
      {
         var dumper:IDumper = null;
         var index:int = 0;
         if(dumperName == null)
         {
            return this.getDumperList();
         }
         if(dumperName.match(/^\d+$/) != null)
         {
            index = int(int(dumperName));
            if(index < this.var_547.length)
            {
               dumper = this.var_547[index];
            }
         }
         else
         {
            dumper = this.var_548[dumperName];
         }
         if(dumper == null)
         {
            return "Dumper " + dumperName + " not found. Available dumpers: \n" + this.getDumperList();
         }
         return dumper.dump(params);
      }
      
      public function get dumpersByName() : Dictionary
      {
         return this.var_548;
      }
      
      public function get dumpersList() : Vector.<IDumper>
      {
         return this.var_547;
      }
      
      private function getDumperList() : String
      {
         var s:String = "";
         for(var i:int = 0; i < this.var_547.length; i++)
         {
            s += i.toString() + " " + this.var_547[i].dumperName + "\n";
         }
         return s;
      }
      
      private function hadleConsoleCommand(console:IConsole, params:Array) : void
      {
         var dumperName:String = params.shift();
         console.addText(this.dump(dumperName,params));
      }
   }
}

