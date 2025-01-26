package alternativa.osgi.service.console.variables
{
   import package_5.name_3;
   import alternativa.osgi.service.console.IConsole;
   
   public class ConsoleVar
   {
      protected var varName:String;
      
      protected var inputListener:Function;
      
      public function ConsoleVar(varName:String, inputListener:Function = null)
      {
         super();
         this.varName = varName;
         this.inputListener = inputListener;
         var console:IConsole = IConsole(name_3.name_8().name_30(IConsole));
         if(console != null)
         {
            console.name_147(this);
         }
      }
      
      public function name_32() : String
      {
         return this.varName;
      }
      
      public function destroy() : void
      {
         var console:IConsole = IConsole(name_3.name_8().name_30(IConsole));
         if(console != null)
         {
            console.name_146(this.varName);
         }
         this.inputListener = null;
      }
      
      public function method_77(console:IConsole, params:Array) : void
      {
         var oldValue:String = null;
         var errorText:String = null;
         if(params.length == 0)
         {
            console.name_145(this.varName + " = " + this.toString());
         }
         else
         {
            oldValue = this.toString();
            errorText = this.acceptInput(params[0]);
            if(errorText == null)
            {
               console.name_145(this.varName + " is set to " + this.toString() + " (was " + oldValue + ")");
               if(this.inputListener != null)
               {
                  this.inputListener.call(null,this);
               }
            }
            else
            {
               console.name_145(errorText);
            }
         }
      }
      
      protected function acceptInput(value:String) : String
      {
         return "Not implemented";
      }
      
      public function toString() : String
      {
         return "Not implemented";
      }
   }
}

