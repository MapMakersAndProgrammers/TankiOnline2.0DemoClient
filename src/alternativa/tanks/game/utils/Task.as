package alternativa.tanks.game.utils
{
   public class Task
   {
      private var §_-UZ§:TaskSequence;
      
      public function Task()
      {
         super();
      }
      
      public function run() : void
      {
         throw new Error("Not implemented");
      }
      
      internal function set taskSequence(value:TaskSequence) : void
      {
         this.§_-UZ§ = value;
      }
      
      final protected function completeTask() : void
      {
         this.§_-UZ§.taskComplete(this);
      }
   }
}

