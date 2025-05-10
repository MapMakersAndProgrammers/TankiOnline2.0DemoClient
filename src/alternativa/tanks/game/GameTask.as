package alternativa.tanks.game
{
   public class GameTask
   {
      public var name_Uw:TaskManager;
      
      public var priority:int;
      
      protected var name_iS:Boolean;
      
      public function GameTask(priority:int)
      {
         super();
         this.priority = priority;
      }
      
      public function start() : void
      {
      }
      
      public function stop() : void
      {
      }
      
      public function run() : void
      {
      }
      
      final public function get paused() : Boolean
      {
         return this.name_iS;
      }
      
      final public function set paused(value:Boolean) : void
      {
         if(value)
         {
            this.pause();
         }
         else
         {
            this.resume();
         }
      }
      
      final public function pause() : void
      {
         if(!this.name_iS)
         {
            this.name_iS = true;
            this.onPause();
         }
      }
      
      final public function resume() : void
      {
         if(this.name_iS)
         {
            this.name_iS = false;
            this.onResume();
         }
      }
      
      protected function onPause() : void
      {
      }
      
      protected function onResume() : void
      {
      }
   }
}

