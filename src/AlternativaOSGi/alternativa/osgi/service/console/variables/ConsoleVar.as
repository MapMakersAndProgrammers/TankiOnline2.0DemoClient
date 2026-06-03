package alternativa.osgi.service.console.variables
{
   import alternativa.osgi.OSGi;
   import alternativa.osgi.service.console.IConsole;
   
   public class ConsoleVar
   {
      
      protected var varName:String;
      
      protected var inputListener:Function;
      
      public function ConsoleVar(param1:String, param2:Function = null)
      {
         super();
         this.varName = param1;
         this.inputListener = param2;
         var _loc3_:IConsole = IConsole(OSGi.getInstance().getService(IConsole));
         if(_loc3_ != null)
         {
            _loc3_.addVariable(this);
         }
      }
      
      public function getName() : String
      {
         return this.varName;
      }
      
      public function destroy() : void
      {
         var _loc1_:IConsole = IConsole(OSGi.getInstance().getService(IConsole));
         if(_loc1_ != null)
         {
            _loc1_.removeVariable(this.varName);
         }
         this.inputListener = null;
      }
      
      public function processConsoleInput(param1:IConsole, param2:Array) : void
      {
         var _loc3_:String = null;
         var _loc4_:String = null;
         if(param2.length == 0)
         {
            param1.addText(this.varName + " = " + this.toString());
         }
         else
         {
            _loc3_ = this.toString();
            _loc4_ = this.acceptInput(param2[0]);
            if(_loc4_ == null)
            {
               param1.addText(this.varName + " is set to " + this.toString() + " (was " + _loc3_ + ")");
               if(this.inputListener != null)
               {
                  this.inputListener.call(null,this);
               }
            }
            else
            {
               param1.addText(_loc4_);
            }
         }
      }
      
      protected function acceptInput(param1:String) : String
      {
         return "Not implemented";
      }
      
      public function toString() : String
      {
         return "Not implemented";
      }
   }
}

