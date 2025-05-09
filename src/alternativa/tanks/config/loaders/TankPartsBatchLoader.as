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
      
      private var var_34:TaskSequence;
      
      public function TankPartsBatchLoader()
      {
         super();
      }
      
      public function load(param1:String, param2:XMLList, param3:ITankPartLoaderFactory) : void
      {
         var _loc4_:XML = null;
         this.parts = new Vector.<TankPart>();
         this.var_34 = new TaskSequence();
         for each(_loc4_ in param2)
         {
            this.var_34.addTask(param3.createLoader(param1,_loc4_,this.parts));
         }
         this.var_34.addEventListener(Event.COMPLETE,this.onSequenceComplete);
         this.var_34.run();
      }
      
      private function onSequenceComplete(param1:Event) : void
      {
         this.var_34 = null;
         if(hasEventListener(Event.COMPLETE))
         {
            dispatchEvent(new Event(Event.COMPLETE));
         }
      }
   }
}

