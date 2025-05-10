package alternativa.tanks.game.utils
{
   import flash.utils.getTimer;
   
   public class TimeStat
   {
      public var name_IZ:Number = 0;
      
      public var name_6u:Number = 0;
      
      private var maxTicks:int;
      
      private var name_Et:int;
      
      private var name_Jl:int;
      
      private var name_45:int;
      
      public function TimeStat(maxTicks:int)
      {
         super();
         this.maxTicks = maxTicks;
      }
      
      public function startTick() : void
      {
         this.name_Jl = getTimer();
      }
      
      public function stopTick() : void
      {
         this.name_45 += getTimer() - this.name_Jl;
         ++this.name_Et;
         if(this.name_Et >= this.maxTicks)
         {
            this.name_IZ = this.name_45 / this.name_Et;
            this.name_6u = this.name_Et * 1000 / this.name_45;
            this.name_Et = 0;
            this.name_45 = 0;
         }
      }
   }
}

