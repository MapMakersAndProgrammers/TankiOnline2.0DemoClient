package alternativa.tanks.game.effects
{
   public class Blinker
   {
      private var initialInterval:int;
      
      private var minInterval:int;
      
      private var intervalDecrement:int;
      
      private var maxValue:Number;
      
      private var minValue:Number;
      
      private var speedCoeff:Number;
      
      private var value:Number;
      
      private var speed:Number;
      
      private var §_-Jr§:Number;
      
      private var §_-KH§:int;
      
      private var §_-EE§:int;
      
      public function Blinker(initialInterval:int, minInterval:int, intervalDecrement:int, minValue:Number, maxValue:Number, speedCoeff:Number)
      {
         super();
         this.initialInterval = initialInterval;
         this.minInterval = minInterval;
         this.intervalDecrement = intervalDecrement;
         this.minValue = minValue;
         this.maxValue = maxValue;
         this.speedCoeff = speedCoeff;
         this.§_-Jr§ = maxValue - minValue;
      }
      
      public function init(now:int) : void
      {
         this.value = this.maxValue;
         this.§_-EE§ = this.initialInterval;
         this.speed = this.getSpeed(-1);
         this.§_-KH§ = now + this.§_-EE§;
      }
      
      public function setMaxValue(value:Number) : void
      {
         if(value < this.minValue)
         {
            return;
         }
         this.maxValue = value;
         this.§_-Jr§ = this.maxValue - this.minValue;
      }
      
      public function setMinValue(value:Number) : void
      {
         if(value > this.maxValue)
         {
            return;
         }
         this.minValue = value;
         this.§_-Jr§ = this.maxValue - this.minValue;
      }
      
      public function updateValue(now:int, delta:int) : Number
      {
         this.value += this.speed * delta;
         if(this.value > this.maxValue)
         {
            this.value = this.maxValue;
         }
         if(this.value < this.minValue)
         {
            this.value = this.minValue;
         }
         if(now >= this.§_-KH§)
         {
            if(this.§_-EE§ > this.minInterval)
            {
               this.§_-EE§ -= this.intervalDecrement;
               if(this.§_-EE§ < this.minInterval)
               {
                  this.§_-EE§ = this.minInterval;
               }
            }
            this.§_-KH§ = now + this.§_-EE§;
            if(this.speed < 0)
            {
               this.speed = this.getSpeed(1);
            }
            else
            {
               this.speed = this.getSpeed(-1);
            }
         }
         return this.value;
      }
      
      private function getSpeed(direction:Number) : Number
      {
         return direction * this.speedCoeff * this.§_-Jr§ / this.§_-EE§;
      }
   }
}

