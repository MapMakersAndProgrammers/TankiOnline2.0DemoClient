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
      
      private var var_737:Number;
      
      private var var_738:int;
      
      private var var_736:int;
      
      public function Blinker(initialInterval:int, minInterval:int, intervalDecrement:int, minValue:Number, maxValue:Number, speedCoeff:Number)
      {
         super();
         this.initialInterval = initialInterval;
         this.minInterval = minInterval;
         this.intervalDecrement = intervalDecrement;
         this.minValue = minValue;
         this.maxValue = maxValue;
         this.speedCoeff = speedCoeff;
         this.var_737 = maxValue - minValue;
      }
      
      public function init(now:int) : void
      {
         this.value = this.maxValue;
         this.var_736 = this.initialInterval;
         this.speed = this.getSpeed(-1);
         this.var_738 = now + this.var_736;
      }
      
      public function setMaxValue(value:Number) : void
      {
         if(value < this.minValue)
         {
            return;
         }
         this.maxValue = value;
         this.var_737 = this.maxValue - this.minValue;
      }
      
      public function setMinValue(value:Number) : void
      {
         if(value > this.maxValue)
         {
            return;
         }
         this.minValue = value;
         this.var_737 = this.maxValue - this.minValue;
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
         if(now >= this.var_738)
         {
            if(this.var_736 > this.minInterval)
            {
               this.var_736 -= this.intervalDecrement;
               if(this.var_736 < this.minInterval)
               {
                  this.var_736 = this.minInterval;
               }
            }
            this.var_738 = now + this.var_736;
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
         return direction * this.speedCoeff * this.var_737 / this.var_736;
      }
   }
}

