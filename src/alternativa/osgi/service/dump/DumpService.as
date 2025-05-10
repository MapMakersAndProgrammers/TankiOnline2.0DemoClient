package alternativa.osgi.service.dump
{
   import alternativa.osgi.OSGi;
   import alternativa.osgi.service.console.IConsole;
   import flash.utils.Dictionary;
   
   public class DumpService implements IDumpService
   {
      private var osgi:OSGi;
      
      private var name_gQ:Dictionary;
      
      private var name_G8:Vector.<IDumper>;
      
      public function DumpService(osgi:OSGi)
      {
         super();
         this.osgi = osgi;
         var console:IConsole = IConsole(osgi.getService(IConsole));
         console.setCommandHandler("dump",this.hadleConsoleCommand);
         this.name_gQ = new Dictionary(false);
         this.name_G8 = new Vector.<IDumper>();
      }
      
      public function registerDumper(dumper:IDumper) : void
      {
         if(this.name_gQ[dumper.dumperName] != null)
         {
            throw new Error("Dumper is already registered");
         }
         this.name_gQ[dumper.dumperName] = dumper;
         this.name_G8.push(dumper);
      }
      
      public function unregisterDumper(dumperName:String) : void
      {
         var dumper:IDumper = this.name_gQ[dumperName];
         if(dumper != null)
         {
            this.name_G8.splice(this.name_G8.indexOf(dumper),1);
            delete this.name_gQ[dumperName];
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
            if(index < this.name_G8.length)
            {
               dumper = this.name_G8[index];
            }
         }
         else
         {
            dumper = this.name_gQ[dumperName];
         }
         if(dumper == null)
         {
            return "Dumper " + dumperName + " not found. Available dumpers: \n" + this.getDumperList();
         }
         return dumper.dump(params);
      }
      
      public function get dumpersByName() : Dictionary
      {
         return this.name_gQ;
      }
      
      public function get dumpersList() : Vector.<IDumper>
      {
         return this.name_G8;
      }
      
      private function getDumperList() : String
      {
         var s:String = "";
         for(var i:int = 0; i < this.name_G8.length; i++)
         {
            s += i.toString() + " " + this.name_G8[i].dumperName + "\n";
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

