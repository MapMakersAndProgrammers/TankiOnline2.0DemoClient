package alternativa.tanks.game
{
   public class GameTask
   {
      public var var_4:TaskManager;
      
      public var priority:int;
      
      protected var var_3:Boolean;
      
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
         return this.var_3;
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
         if(!this.var_3)
         {
            this.var_3 = true;
            this.onPause();
         }
      }
      
      final public function resume() : void
      {
         if(this.var_3)
         {
            this.var_3 = false;
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

