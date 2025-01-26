package package_45
{
   import flash.utils.getTimer;
   import package_10.class_1;
   
   public class name_182 extends class_1
   {
      public static var time:int;
      
      public static var timeSeconds:Number;
      
      public static var timeDelta:int;
      
      public static var timeDeltaSeconds:Number;
      
      public function name_182(priority:int)
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

