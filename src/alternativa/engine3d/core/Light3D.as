package alternativa.engine3d.core
{
   import alternativa.engine3d.alternativa3d;
   
   use namespace alternativa3d;
   
   public class Light3D extends Object3D
   {
      private static var lastLightNumber:uint = 0;
      
      public var color:uint;
      
      public var intensity:Number = 1;
      
      alternativa3d var name_cl:Transform3D = new Transform3D();
      
      alternativa3d var name_oG:String;
      
      alternativa3d var red:Number;
      
      alternativa3d var green:Number;
      
      alternativa3d var blue:Number;
      
      public function Light3D()
      {
         super();
         this.name_oG = "l" + lastLightNumber.toString(16);
         name = "L" + (lastLightNumber++).toString();
      }
      
      override alternativa3d function calculateVisibility(camera:Camera3D) : void
      {
         if(this.intensity != 0 && this.color > 0)
         {
            camera.alternativa3d::lights[camera.alternativa3d::lightsLength] = this;
            ++camera.alternativa3d::lightsLength;
         }
      }
      
      alternativa3d function checkBound(targetObject:Object3D) : Boolean
      {
         return true;
      }
      
      override public function clone() : Object3D
      {
         var res:Light3D = new Light3D();
         res.clonePropertiesFrom(this);
         return res;
      }
      
      override protected function clonePropertiesFrom(source:Object3D) : void
      {
         super.clonePropertiesFrom(source);
         var src:Light3D = source as Light3D;
         this.color = src.color;
         this.intensity = src.intensity;
      }
   }
}

