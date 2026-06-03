package platform.client.fp10.core.network.command.control.server
{
   import platform.client.fp10.core.dispatcher.DispatcherItem;
   import platform.client.fp10.core.dispatcher.DispatcherItemId;
   import platform.client.fp10.core.network.ControlChannelContext;
   import platform.client.fp10.core.network.command.ControlCommand;
   import platform.client.fp10.core.network.command.IServerControlCommand;
   import platform.client.fp10.core.registry.GameTypeRegistry;
   import platform.client.fp10.core.registry.ResourceRegistry;
   import platform.client.fp10.core.resource.Resource;
   
   public class UnloadDependenciesCommand extends ControlCommand implements IServerControlCommand
   {
      
      [Inject]
      public static var gameTypeRegistry:GameTypeRegistry;
      
      [Inject]
      public static var resourceRegistry:ResourceRegistry;
      
      private var items:Vector.<DispatcherItemId>;
      
      public function UnloadDependenciesCommand(param1:Vector.<DispatcherItemId>)
      {
         super(ControlCommand.SV_UNLOAD_DEPENDENCIES,"Unload dependencies");
         this.items = param1;
      }
      
      public function execute(param1:ControlChannelContext) : void
      {
         var _loc2_:DispatcherItemId = null;
         var _loc3_:Resource = null;
         for each(_loc2_ in this.items)
         {
            switch(_loc2_.type)
            {
               case DispatcherItem.CLASS:
                  gameTypeRegistry.destroyClass(_loc2_.id);
                  break;
               case DispatcherItem.RESOURCE:
                  _loc3_ = resourceRegistry.getResource(_loc2_.id);
                  if(_loc3_ != null)
                  {
                     resourceRegistry.unregisterResource(_loc3_.id);
                     _loc3_.unload();
                  }
            }
         }
      }
   }
}

