package alternativa.tanks.game.utils
{
   public class Task
   {
      private var var_33:TaskSequence;
      
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
         this.var_33 = value;
      }
      
      final protected function completeTask() : void
      {
         this.var_33.taskComplete(this);
      }
   }
}

