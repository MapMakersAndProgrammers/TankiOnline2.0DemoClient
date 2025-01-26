package package_86
{
   import package_109.name_377;
   import package_46.Matrix4;
   import package_46.name_194;
   
   public class name_500 extends name_377
   {
      public var m:Matrix4;
      
      public function name_500(hs:name_194, localMatrix:Matrix4, collisionGroup:int, collisionMask:int)
      {
         super(hs,collisionGroup,collisionMask);
         this.m = localMatrix.clone();
      }
   }
}

