package package_92
{
   import package_46.name_194;
   import package_46.name_566;
   
   public class name_599
   {
      public var position:name_194 = new name_194();
      
      public var orientation:name_566 = new name_566();
      
      public var velocity:name_194 = new name_194();
      
      public var rotation:name_194 = new name_194();
      
      public function name_599()
      {
         super();
      }
      
      public function copy(state:name_599) : void
      {
         this.position.copy(state.position);
         this.orientation.copy(state.orientation);
         this.velocity.copy(state.velocity);
         this.rotation.copy(state.rotation);
      }
   }
}

