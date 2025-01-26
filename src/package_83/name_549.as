package package_83
{
   import package_118.class_38;
   import package_46.name_194;
   import package_92.name_271;
   
   public class name_549 implements class_38
   {
      private var primaryTarget:name_271;
      
      public function name_549()
      {
         super();
      }
      
      public function method_759(body:name_271) : void
      {
         this.primaryTarget = body;
      }
      
      public function name_670(center:name_194, body:name_271) : Boolean
      {
         return body != this.primaryTarget;
      }
   }
}

