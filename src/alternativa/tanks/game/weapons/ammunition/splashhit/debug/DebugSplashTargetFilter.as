package alternativa.tanks.game.weapons.ammunition.splashhit.debug
{
   import alternativa.math.Vector3;
   import alternativa.physics.Body;
   import alternativa.tanks.game.weapons.ammunition.splashhit.ISplashTargetFilter;
   
   public class DebugSplashTargetFilter implements ISplashTargetFilter
   {
      private var primaryTarget:Body;
      
      public function DebugSplashTargetFilter()
      {
         super();
      }
      
      public function setPrimaryTarget(body:Body) : void
      {
         this.primaryTarget = body;
      }
      
      public function acceptBody(center:Vector3, body:Body) : Boolean
      {
         return body != this.primaryTarget;
      }
   }
}

