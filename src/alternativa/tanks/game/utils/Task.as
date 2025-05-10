package alternativa.tanks.game.utils
{
   public class Task
   {
      private var name_UZ:TaskSequence;
      
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
         this.name_UZ = value;
      }
      
      final protected function completeTask() : void
      {
         this.name_UZ.taskComplete(this);
      }
   }
}

