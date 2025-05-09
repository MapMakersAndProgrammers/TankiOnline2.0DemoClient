package alternativa.tanks.utils
{
   import flash.events.Event;
   
   public class TaskEvent extends Event
   {
      public static const TASK_COMPLETE:String = "taskComplete";
      
      public static const TASK_PROGRESS:String = "taskProgress";
      
      public var total:Number = 0;
      
      public var progress:Number = 0;
      
      public function TaskEvent(param1:String, param2:Number, param3:Number)
      {
         super(param1);
         this.total = param3;
         this.progress = param2;
      }
   }
}

