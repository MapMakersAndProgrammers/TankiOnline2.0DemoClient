package alternativa.engine3d.core.events
{
   import alternativa.engine3d.alternativa3d;
   import alternativa.engine3d.core.Object3D;
   import flash.events.Event;
   
   use namespace alternativa3d;
   
   public class Event3D extends Event
   {
      public static const ADDED:String = "added3D";
      
      public static const REMOVED:String = "removed3D";
      
      alternativa3d var name_314:Object3D;
      
      alternativa3d var name_313:Object3D;
      
      alternativa3d var var_107:Boolean;
      
      alternativa3d var name_312:uint = 3;
      
      alternativa3d var stop:Boolean = false;
      
      alternativa3d var var_108:Boolean = false;
      
      public function Event3D(type:String, bubbles:Boolean = true)
      {
         super(type,bubbles);
         this.alternativa3d::var_107 = bubbles;
      }
      
      override public function get bubbles() : Boolean
      {
         return this.alternativa3d::var_107;
      }
      
      override public function get eventPhase() : uint
      {
         return this.alternativa3d::name_312;
      }
      
      override public function get target() : Object
      {
         return this.alternativa3d::name_314;
      }
      
      override public function get currentTarget() : Object
      {
         return this.alternativa3d::name_313;
      }
      
      override public function stopPropagation() : void
      {
         this.alternativa3d::stop = true;
      }
      
      override public function stopImmediatePropagation() : void
      {
         this.alternativa3d::var_108 = true;
      }
      
      override public function clone() : Event
      {
         var result:Event3D = new Event3D(type,this.alternativa3d::var_107);
         result.alternativa3d::name_314 = this.alternativa3d::name_314;
         result.alternativa3d::name_313 = this.alternativa3d::name_313;
         result.alternativa3d::name_312 = this.alternativa3d::name_312;
         return result;
      }
      
      override public function toString() : String
      {
         return formatToString("Event3D","type","bubbles","eventPhase");
      }
   }
}

