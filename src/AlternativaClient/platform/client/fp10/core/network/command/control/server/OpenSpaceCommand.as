package platform.client.fp10.core.network.command.control.server
{
   import alternativa.types.Long;
   import platform.client.fp10.core.network.ControlChannelContext;
   import platform.client.fp10.core.network.command.ControlCommand;
   import platform.client.fp10.core.network.command.IServerControlCommand;
   import platform.client.fp10.core.network.handler.SpaceCommandHandler;
   import platform.client.fp10.core.registry.SpaceRegistry;
   import platform.client.fp10.core.type.impl.Space;
   
   public class OpenSpaceCommand extends ControlCommand implements IServerControlCommand
   {
      
      [Inject]
      public static var spaceRegistry:SpaceRegistry;
      
      private var spaceId:Long;
      
      private var host:String;
      
      private var ports:Vector.<int>;
      
      public function OpenSpaceCommand(param1:Long, param2:String, param3:Vector.<int>)
      {
         super(ControlCommand.SV_OPEN_SPACE,"Open space");
         this.spaceId = param1;
         this.host = param2;
         this.ports = param3;
      }
      
      public function execute(param1:ControlChannelContext) : void
      {
         var _loc2_:SpaceCommandHandler = new SpaceCommandHandler(param1.hash);
         var _loc3_:Space = new Space(this.spaceId,_loc2_,param1.spaceProtocol);
         spaceRegistry.addSpace(_loc3_);
         _loc3_.connect(this.host,this.ports);
      }
   }
}

