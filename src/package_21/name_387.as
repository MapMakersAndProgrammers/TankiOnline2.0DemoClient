package package_21
{
   import flash.geom.Point;
   import flash.geom.Vector3D;
   import package_19.name_117;
   
   public class name_387
   {
      public var object:name_78;
      
      public var point:Vector3D;
      
      public var surface:name_117;
      
      public var time:Number;
      
      public var uv:Point;
      
      public function name_387()
      {
         super();
      }
      
      public function toString() : String
      {
         return "[RayIntersectionData " + this.object + ", " + this.point + ", " + this.uv + ", " + this.time + "]";
      }
   }
}

