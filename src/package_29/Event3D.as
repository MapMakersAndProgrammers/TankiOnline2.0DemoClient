package package_29
{
   import alternativa.engine3d.alternativa3d;
   import flash.events.Event;
   import package_21.name_78;
   
   use namespace alternativa3d;
   
   public class Event3D extends Event
   {
      public static const ADDED:String = "added3D";
      
      public static const REMOVED:String = "removed3D";
      
      alternativa3d var name_394:name_78;
      
      alternativa3d var name_390:name_78;
      
      alternativa3d var var_107:Boolean;
      
      alternativa3d var name_388:uint = 3;
      
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
         return this.alternativa3d::name_388;
      }
      
      override public function get target() : Object
      {
         return this.alternativa3d::name_394;
      }
      
      override public function get currentTarget() : Object
      {
         return this.alternativa3d::name_390;
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
         result.alternativa3d::name_394 = this.alternativa3d::name_394;
         result.alternativa3d::name_390 = this.alternativa3d::name_390;
         result.alternativa3d::name_388 = this.alternativa3d::name_388;
         return result;
      }
      
      override public function toString() : String
      {
         return formatToString("Event3D","type","bubbles","eventPhase");
      }
   }
}

