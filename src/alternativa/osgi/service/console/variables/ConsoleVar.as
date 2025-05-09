package alternativa.osgi.service.console.variables
{
   import alternativa.osgi.OSGi;
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
         var console:IConsole = IConsole(OSGi.getInstance().getService(IConsole));
         if(console != null)
         {
            console.addVariable(this);
         }
      }
      
      public function getName() : String
      {
         return this.varName;
      }
      
      public function destroy() : void
      {
         var console:IConsole = IConsole(OSGi.getInstance().getService(IConsole));
         if(console != null)
         {
            console.removeVariable(this.varName);
         }
         this.inputListener = null;
      }
      
      public function processConsoleInput(console:IConsole, params:Array) : void
      {
         var _loc3_:String = null;
         var _loc4_:String = null;
         if(params.length == 0)
         {
            console.addText(this.varName + " = " + this.toString());
         }
         else
         {
            _loc3_ = this.toString();
            _loc4_ = this.acceptInput(params[0]);
            if(_loc4_ == null)
            {
               console.addText(this.varName + " is set to " + this.toString() + " (was " + _loc3_ + ")");
               if(this.inputListener != null)
               {
                  this.inputListener.call(null,this);
               }
            }
            else
            {
               console.addText(_loc4_);
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

