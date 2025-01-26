package package_27
{
   import flash.utils.getTimer;
   
   public class name_180
   {
      public var var_211:Number = 0;
      
      public var var_212:Number = 0;
      
      private var maxTicks:int;
      
      private var var_208:int;
      
      private var var_210:int;
      
      private var var_209:int;
      
      public function name_180(maxTicks:int)
      {
         super();
         this.maxTicks = maxTicks;
      }
      
      public function name_188() : void
      {
         this.var_210 = getTimer();
      }
      
      public function name_186() : void
      {
         this.var_209 += getTimer() - this.var_210;
         ++this.var_208;
         if(this.var_208 >= this.maxTicks)
         {
            this.var_211 = this.var_209 / this.var_208;
            this.var_212 = this.var_208 * 1000 / this.var_209;
            this.var_208 = 0;
            this.var_209 = 0;
         }
      }
   }
}

