package alternativa.tanks.game.weapons.ammunition.splashhit
{
   import alternativa.physics.Body;
   import alternativa.tanks.game.physics.IRadiusQueryFilter;
   
   public interface ISplashTargetFilter extends IRadiusQueryFilter
   {
      function setPrimaryTarget(param1:Body) : void;
   }
}

