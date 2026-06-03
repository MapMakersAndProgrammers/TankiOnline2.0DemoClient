package alternativa.init
{
   import alternativa.osgi.OSGi;
   import alternativa.osgi.bundle.IBundleActivator;
   import alternativa.protocol.IProtocol;
   import alternativa.protocol.codec.ModelDataCodecHook;
   import platform.client.core.general.spaces.models.dispatcher.ModelData;
   
   public class SpacesModelsActivator implements IBundleActivator
   {
      
      public function SpacesModelsActivator()
      {
         super();
      }
      
      public function start(param1:OSGi) : void
      {
         var _loc2_:IProtocol = IProtocol(param1.getService(IProtocol));
         _loc2_.registerCodecForType(ModelData,new ModelDataCodecHook());
      }
      
      public function stop(param1:OSGi) : void
      {
      }
   }
}

