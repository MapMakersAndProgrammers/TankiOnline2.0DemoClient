package package_72
{
   public class name_764
   {
      private var initialInterval:int;
      
      private var minInterval:int;
      
      private var intervalDecrement:int;
      
      private var maxValue:Number;
      
      private var minValue:Number;
      
      private var speedCoeff:Number;
      
      private var value:Number;
      
      private var speed:Number;
      
      private var var_738:Number;
      
      private var var_739:int;
      
      private var var_737:int;
      
      public function name_764(initialInterval:int, minInterval:int, intervalDecrement:int, minValue:Number, maxValue:Number, speedCoeff:Number)
      {
         super();
         this.initialInterval = initialInterval;
         this.minInterval = minInterval;
         this.intervalDecrement = intervalDecrement;
         this.minValue = minValue;
         this.maxValue = maxValue;
         this.speedCoeff = speedCoeff;
         this.var_738 = maxValue - minValue;
      }
      
      public function init(now:int) : void
      {
         this.value = this.maxValue;
         this.var_737 = this.initialInterval;
         this.speed = this.method_930(-1);
         this.var_739 = now + this.var_737;
      }
      
      public function method_931(value:Number) : void
      {
         if(value < this.minValue)
         {
            return;
         }
         this.maxValue = value;
         this.var_738 = this.maxValue - this.minValue;
      }
      
      public function name_765(value:Number) : void
      {
         if(value > this.maxValue)
         {
            return;
         }
         this.minValue = value;
         this.var_738 = this.maxValue - this.minValue;
      }
      
      public function name_766(now:int, delta:int) : Number
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
         if(now >= this.var_739)
         {
            if(this.var_737 > this.minInterval)
            {
               this.var_737 -= this.intervalDecrement;
               if(this.var_737 < this.minInterval)
               {
                  this.var_737 = this.minInterval;
               }
            }
            this.var_739 = now + this.var_737;
            if(this.speed < 0)
            {
               this.speed = this.method_930(1);
            }
            else
            {
               this.speed = this.method_930(-1);
            }
         }
         return this.value;
      }
      
      private function method_930(direction:Number) : Number
      {
         return direction * this.speedCoeff * this.var_738 / this.var_737;
      }
   }
}

