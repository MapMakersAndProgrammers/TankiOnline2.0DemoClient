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
      
      alternativa3d var name_5E:Object3D;
      
      alternativa3d var name_Kh:Object3D;
      
      alternativa3d var name_iJ:Boolean;
      
      alternativa3d var name_VE:uint = 3;
      
      alternativa3d var stop:Boolean = false;
      
      alternativa3d var name_XD:Boolean = false;
      
      public function Event3D(type:String, bubbles:Boolean = true)
      {
         super(type,bubbles);
         this.name_iJ = bubbles;
      }
      
      override public function get bubbles() : Boolean
      {
         return this.name_iJ;
      }
      
      override public function get eventPhase() : uint
      {
         return this.name_VE;
      }
      
      override public function get target() : Object
      {
         return this.name_5E;
      }
      
      override public function get currentTarget() : Object
      {
         return this.name_Kh;
      }
      
      override public function stopPropagation() : void
      {
         this.alternativa3d::stop = true;
      }
      
      override public function stopImmediatePropagation() : void
      {
         this.name_XD = true;
      }
      
      override public function clone() : Event
      {
         var result:Event3D = new Event3D(type,this.name_iJ);
         result.name_5E = this.name_5E;
         result.name_Kh = this.name_Kh;
         result.name_VE = this.name_VE;
         return result;
      }
      
      override public function toString() : String
      {
         return formatToString("Event3D","type","bubbles","eventPhase");
      }
   }
}

