package alternativa.physics
{
   import alternativa.math.Quaternion;
   import alternativa.math.Vector3;
   
   public class BodyState
   {
      public var position:Vector3 = new Vector3();
      
      public var orientation:Quaternion = new Quaternion();
      
      public var velocity:Vector3 = new Vector3();
      
      public var rotation:Vector3 = new Vector3();
      
      public function BodyState()
      {
         super();
      }
      
      public function copy(state:BodyState) : void
      {
         this.position.copy(state.position);
         this.orientation.copy(state.orientation);
         this.velocity.copy(state.velocity);
         this.rotation.copy(state.rotation);
      }
   }
}

