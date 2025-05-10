package alternativa.physics
{
   import alternativa.math.Vector3;
   
   public class ContactPoint
   {
      public var pos:Vector3 = new Vector3();
      
      public var penetration:Number;
      
      public var feature1:int;
      
      public var feature2:int;
      
      public var name_0C:Number;
      
      public var name_A:Number;
      
      public var name_DS:Number;
      
      public var angularInertia1:Number;
      
      public var angularInertia2:Number;
      
      public var r1:Vector3 = new Vector3();
      
      public var r2:Vector3 = new Vector3();
      
      public var name_Dv:Number;
      
      public var name_CV:Boolean;
      
      public function ContactPoint()
      {
         super();
      }
      
      public function copyFrom(cp:ContactPoint) : void
      {
         this.pos.copy(cp.pos);
         this.penetration = cp.penetration;
         this.feature1 = cp.feature1;
         this.feature2 = cp.feature2;
         this.r1.copy(cp.r1);
         this.r2.copy(cp.r2);
      }
   }
}

