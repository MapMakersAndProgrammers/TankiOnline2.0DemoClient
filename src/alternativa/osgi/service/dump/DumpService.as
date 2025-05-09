package alternativa.osgi.service.dump
{
   import alternativa.osgi.OSGi;
   import alternativa.osgi.service.console.IConsole;
   import flash.utils.Dictionary;
   
   public class DumpService implements IDumpService
   {
      private var osgi:OSGi;
      
      private var §_-gQ§:Dictionary;
      
      private var §_-G8§:Vector.<IDumper>;
      
      public function DumpService(osgi:OSGi)
      {
         super();
         this.osgi = osgi;
         var console:IConsole = IConsole(osgi.getService(IConsole));
         console.setCommandHandler("dump",this.hadleConsoleCommand);
         this.§_-gQ§ = new Dictionary(false);
         this.§_-G8§ = new Vector.<IDumper>();
      }
      
      public function registerDumper(dumper:IDumper) : void
      {
         if(this.§_-gQ§[dumper.dumperName] != null)
         {
            throw new Error("Dumper is already registered");
         }
         this.§_-gQ§[dumper.dumperName] = dumper;
         this.§_-G8§.push(dumper);
      }
      
      public function unregisterDumper(dumperName:String) : void
      {
         var dumper:IDumper = this.§_-gQ§[dumperName];
         if(dumper != null)
         {
            this.§_-G8§.splice(this.§_-G8§.indexOf(dumper),1);
            delete this.§_-gQ§[dumperName];
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
            if(index < this.§_-G8§.length)
            {
               dumper = this.§_-G8§[index];
            }
         }
         else
         {
            dumper = this.§_-gQ§[dumperName];
         }
         if(dumper == null)
         {
            return "Dumper " + dumperName + " not found. Available dumpers: \n" + this.getDumperList();
         }
         return dumper.dump(params);
      }
      
      public function get dumpersByName() : Dictionary
      {
         return this.§_-gQ§;
      }
      
      public function get dumpersList() : Vector.<IDumper>
      {
         return this.§_-G8§;
      }
      
      private function getDumperList() : String
      {
         var s:String = "";
         for(var i:int = 0; i < this.§_-G8§.length; i++)
         {
            s += i.toString() + " " + this.§_-G8§[i].dumperName + "\n";
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

