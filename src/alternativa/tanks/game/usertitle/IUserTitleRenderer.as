package alternativa.tanks.game.usertitle
{
   import alternativa.tanks.game.Entity;
   import alternativa.tanks.game.usertitle.component.UserTitleComponent;
   
   public interface IUserTitleRenderer
   {
      function renderUserTitle(param1:Entity, param2:UserTitleComponent) : void;
   }
}

