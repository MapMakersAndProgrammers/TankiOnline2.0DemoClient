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
      
      private var name_Jr:Number;
      
      private var name_KH:int;
      
      private var name_EE:int;
      
      public function Blinker(initialInterval:int, minInterval:int, intervalDecrement:int, minValue:Number, maxValue:Number, speedCoeff:Number)
      {
         super();
         this.initialInterval = initialInterval;
         this.minInterval = minInterval;
         this.intervalDecrement = intervalDecrement;
         this.minValue = minValue;
         this.maxValue = maxValue;
         this.speedCoeff = speedCoeff;
         this.name_Jr = maxValue - minValue;
      }
      
      public function init(now:int) : void
      {
         this.value = this.maxValue;
         this.name_EE = this.initialInterval;
         this.speed = this.getSpeed(-1);
         this.name_KH = now + this.name_EE;
      }
      
      public function setMaxValue(value:Number) : void
      {
         if(value < this.minValue)
         {
            return;
         }
         this.maxValue = value;
         this.name_Jr = this.maxValue - this.minValue;
      }
      
      public function setMinValue(value:Number) : void
      {
         if(value > this.maxValue)
         {
            return;
         }
         this.minValue = value;
         this.name_Jr = this.maxValue - this.minValue;
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
         if(now >= this.name_KH)
         {
            if(this.name_EE > this.minInterval)
            {
               this.name_EE -= this.intervalDecrement;
               if(this.name_EE < this.minInterval)
               {
                  this.name_EE = this.minInterval;
               }
            }
            this.name_KH = now + this.name_EE;
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
         return direction * this.speedCoeff * this.name_Jr / this.name_EE;
      }
   }
}

