package package_29
{
   import alternativa.engine3d.alternativa3d;
   import flash.events.Event;
   import package_19.name_117;
   import package_21.name_78;
   
   use namespace alternativa3d;
   
   public class MouseEvent3D extends Event3D
   {
      public static const CLICK:String = "click3D";
      
      public static const DOUBLE_CLICK:String = "doubleClick3D";
      
      public static const MOUSE_DOWN:String = "mouseDown3D";
      
      public static const MOUSE_UP:String = "mouseUp3D";
      
      public static const MOUSE_OVER:String = "mouseOver3D";
      
      public static const MOUSE_OUT:String = "mouseOut3D";
      
      public static const ROLL_OVER:String = "rollOver3D";
      
      public static const ROLL_OUT:String = "rollOut3D";
      
      public static const MOUSE_MOVE:String = "mouseMove3D";
      
      public static const MOUSE_WHEEL:String = "mouseWheel3D";
      
      public var ctrlKey:Boolean;
      
      public var altKey:Boolean;
      
      public var shiftKey:Boolean;
      
      public var buttonDown:Boolean;
      
      public var delta:int;
      
      public var relatedObject:name_78;
      
      public var localX:Number;
      
      public var localY:Number;
      
      public var localZ:Number;
      
      alternativa3d var var_109:name_117;
      
      public function MouseEvent3D(type:String, bubbles:Boolean = true, localX:Number = NaN, localY:Number = NaN, localZ:Number = NaN, relatedObject:name_78 = null, ctrlKey:Boolean = false, altKey:Boolean = false, shiftKey:Boolean = false, buttonDown:Boolean = false, delta:int = 0)
      {
         super(type,bubbles);
         this.localX = localX;
         this.localY = localY;
         this.localZ = localZ;
         this.relatedObject = relatedObject;
         this.ctrlKey = ctrlKey;
         this.altKey = altKey;
         this.shiftKey = shiftKey;
         this.buttonDown = buttonDown;
         this.delta = delta;
      }
      
      public function get surface() : name_117
      {
         return this.alternativa3d::var_109;
      }
      
      override public function clone() : Event
      {
         return new MouseEvent3D(type,alternativa3d::var_107,this.localX,this.localY,this.localZ,this.relatedObject,this.ctrlKey,this.altKey,this.shiftKey,this.buttonDown,this.delta);
      }
      
      override public function toString() : String
      {
         return formatToString("MouseEvent3D","type","bubbles","eventPhase","localX","localY","localZ","relatedObject","altKey","ctrlKey","shiftKey","buttonDown","delta");
      }
   }
}

