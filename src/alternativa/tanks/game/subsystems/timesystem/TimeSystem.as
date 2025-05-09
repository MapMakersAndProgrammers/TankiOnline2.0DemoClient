package alternativa.tanks.game.subsystems.timesystem
{
   import alternativa.tanks.game.GameTask;
   import flash.utils.getTimer;
   
   public class TimeSystem extends GameTask
   {
      public static var time:int;
      
      public static var timeSeconds:Number;
      
      public static var timeDelta:int;
      
      public static var timeDeltaSeconds:Number;
      
      public function TimeSystem(priority:int)
      {
         super(priority);
      }
      
      override public function start() : void
      {
         time = getTimer();
         timeSeconds = time / 1000;
         timeDelta = 0;
         timeDeltaSeconds = 0;
      }
      
      override public function run() : void
      {
         var now:int = int(getTimer());
         timeDelta = now - time;
         timeDeltaSeconds = timeDelta / 1000;
         time = now;
         timeSeconds = time / 1000;
      }
   }
}

