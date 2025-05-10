package alternativa.tanks.game.utils
{
   import flash.utils.getTimer;
   
   public class TimeStat
   {
      public var §_-IZ§:Number = 0;
      
      public var §_-6u§:Number = 0;
      
      private var maxTicks:int;
      
      private var §_-Et§:int;
      
      private var §_-Jl§:int;
      
      private var §_-45§:int;
      
      public function TimeStat(maxTicks:int)
      {
         super();
         this.maxTicks = maxTicks;
      }
      
      public function startTick() : void
      {
         this.§_-Jl§ = getTimer();
      }
      
      public function stopTick() : void
      {
         this.§_-45§ += getTimer() - this.§_-Jl§;
         ++this.§_-Et§;
         if(this.§_-Et§ >= this.maxTicks)
         {
            this.§_-IZ§ = this.§_-45§ / this.§_-Et§;
            this.§_-6u§ = this.§_-Et§ * 1000 / this.§_-45§;
            this.§_-Et§ = 0;
            this.§_-45§ = 0;
         }
      }
   }
}

