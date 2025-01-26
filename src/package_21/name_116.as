package package_21
{
   import alternativa.engine3d.alternativa3d;
   
   use namespace alternativa3d;
   
   public class name_116 extends name_78
   {
      private static var lastLightNumber:uint = 0;
      
      public var color:uint;
      
      public var intensity:Number = 1;
      
      alternativa3d var name_141:name_139 = new name_139();
      
      alternativa3d var name_138:String;
      
      alternativa3d var red:Number;
      
      alternativa3d var green:Number;
      
      alternativa3d var blue:Number;
      
      public function name_116()
      {
         super();
         this.alternativa3d::name_138 = "l" + lastLightNumber.toString(16);
         name = "L" + (lastLightNumber++).toString();
      }
      
      override alternativa3d function calculateVisibility(camera:name_124) : void
      {
         if(this.intensity != 0 && this.color > 0)
         {
            camera.alternativa3d::lights[camera.alternativa3d::lightsLength] = this;
            ++camera.alternativa3d::lightsLength;
         }
      }
      
      alternativa3d function checkBound(targetObject:name_78) : Boolean
      {
         return true;
      }
      
      override public function clone() : name_78
      {
         var res:name_116 = new name_116();
         res.clonePropertiesFrom(this);
         return res;
      }
      
      override protected function clonePropertiesFrom(source:name_78) : void
      {
         super.clonePropertiesFrom(source);
         var src:name_116 = source as name_116;
         this.color = src.color;
         this.intensity = src.intensity;
      }
   }
}

