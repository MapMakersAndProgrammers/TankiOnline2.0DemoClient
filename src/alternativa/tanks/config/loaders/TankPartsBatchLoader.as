package alternativa.tanks.config.loaders
{
   import alternativa.tanks.config.loaders.tankparts.ITankPartLoaderFactory;
   import alternativa.tanks.game.entities.tank.TankPart;
   import alternativa.tanks.utils.TaskSequence;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   
   [Event(name="complete",type="flash.events.Event")]
   public class TankPartsBatchLoader extends EventDispatcher
   {
      public var parts:Vector.<TankPart>;
      
      private var name_d5:TaskSequence;
      
      public function TankPartsBatchLoader()
      {
         super();
      }
      
      public function load(param1:String, param2:XMLList, param3:ITankPartLoaderFactory) : void
      {
         var _loc4_:XML = null;
         this.parts = new Vector.<TankPart>();
         this.name_d5 = new TaskSequence();
         for each(_loc4_ in param2)
         {
            this.name_d5.addTask(param3.createLoader(param1,_loc4_,this.parts));
         }
         this.name_d5.addEventListener(Event.COMPLETE,this.onSequenceComplete);
         this.name_d5.run();
      }
      
      private function onSequenceComplete(param1:Event) : void
      {
         this.name_d5 = null;
         if(hasEventListener(Event.COMPLETE))
         {
            dispatchEvent(new Event(Event.COMPLETE));
         }
      }
   }
}

