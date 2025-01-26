package package_92
{
   import package_46.name_194;
   
   public class name_674
   {
      public var pos:name_194 = new name_194();
      
      public var penetration:Number;
      
      public var feature1:int;
      
      public var feature2:int;
      
      public var name_677:Number;
      
      public var name_678:Number;
      
      public var name_675:Number;
      
      public var angularInertia1:Number;
      
      public var angularInertia2:Number;
      
      public var r1:name_194 = new name_194();
      
      public var r2:name_194 = new name_194();
      
      public var name_676:Number;
      
      public var name_680:Boolean;
      
      public function name_674()
      {
         super();
      }
      
      public function copyFrom(cp:name_674) : void
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

