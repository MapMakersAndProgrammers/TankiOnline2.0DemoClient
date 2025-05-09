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
      
      alternativa3d var §_-5E§:Object3D;
      
      alternativa3d var §_-Kh§:Object3D;
      
      alternativa3d var §_-iJ§:Boolean;
      
      alternativa3d var §_-VE§:uint = 3;
      
      alternativa3d var stop:Boolean = false;
      
      alternativa3d var §_-XD§:Boolean = false;
      
      public function Event3D(type:String, bubbles:Boolean = true)
      {
         super(type,bubbles);
         this.alternativa3d::_-iJ = bubbles;
      }
      
      override public function get bubbles() : Boolean
      {
         return this.alternativa3d::_-iJ;
      }
      
      override public function get eventPhase() : uint
      {
         return this.alternativa3d::_-VE;
      }
      
      override public function get target() : Object
      {
         return this.alternativa3d::_-5E;
      }
      
      override public function get currentTarget() : Object
      {
         return this.alternativa3d::_-Kh;
      }
      
      override public function stopPropagation() : void
      {
         this.alternativa3d::stop = true;
      }
      
      override public function stopImmediatePropagation() : void
      {
         this.alternativa3d::_-XD = true;
      }
      
      override public function clone() : Event
      {
         var result:Event3D = new Event3D(type,this.alternativa3d::_-iJ);
         result.alternativa3d::_-5E = this.alternativa3d::_-5E;
         result.alternativa3d::_-Kh = this.alternativa3d::_-Kh;
         result.alternativa3d::_-VE = this.alternativa3d::_-VE;
         return result;
      }
      
      override public function toString() : String
      {
         return formatToString("Event3D","type","bubbles","eventPhase");
      }
   }
}

