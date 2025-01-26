package package_102
{
   import flash.utils.Dictionary;
   import package_5.name_3;
   import alternativa.osgi.service.console.IConsole;
   
   public class name_359 implements name_355
   {
      private var osgi:name_3;
      
      private var var_548:Dictionary;
      
      private var var_547:Vector.<name_636>;
      
      public function name_359(osgi:name_3)
      {
         super();
         this.osgi = osgi;
         var console:IConsole = IConsole(osgi.name_30(IConsole));
         console.name_45("dump",this.method_594);
         this.var_548 = new Dictionary(false);
         this.var_547 = new Vector.<name_636>();
      }
      
      public function name_360(dumper:name_636) : void
      {
         if(this.var_548[dumper.dumperName] != null)
         {
            throw new Error("Dumper is already registered");
         }
         this.var_548[dumper.dumperName] = dumper;
         this.var_547.push(dumper);
      }
      
      public function method_591(dumperName:String) : void
      {
         var dumper:name_636 = this.var_548[dumperName];
         if(dumper != null)
         {
            this.var_547.splice(this.var_547.indexOf(dumper),1);
            delete this.var_548[dumperName];
         }
      }
      
      public function dump(dumperName:String, params:Array) : String
      {
         var dumper:name_636 = null;
         var index:int = 0;
         if(dumperName == null)
         {
            return this.method_593();
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
            return "Dumper " + dumperName + " not found. Available dumpers: \n" + this.method_593();
         }
         return dumper.dump(params);
      }
      
      public function get method_590() : Dictionary
      {
         return this.var_548;
      }
      
      public function get method_592() : Vector.<name_636>
      {
         return this.var_547;
      }
      
      private function method_593() : String
      {
         var s:String = "";
         for(var i:int = 0; i < this.var_547.length; i++)
         {
            s += i.toString() + " " + this.var_547[i].dumperName + "\n";
         }
         return s;
      }
      
      private function method_594(console:IConsole, params:Array) : void
      {
         var dumperName:String = params.shift();
         console.name_145(this.dump(dumperName,params));
      }
   }
}

