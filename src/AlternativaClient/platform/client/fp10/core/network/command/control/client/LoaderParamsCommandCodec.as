package platform.client.fp10.core.network.command.control.client
{
   import alternativa.protocol.ICodec;
   import alternativa.protocol.IProtocol;
   import alternativa.protocol.ProtocolBuffer;
   import alternativa.protocol.info.CollectionCodecInfo;
   import alternativa.protocol.info.TypeCodecInfo;
   
   public class LoaderParamsCommandCodec implements ICodec
   {
      
      private var arrayCodec:ICodec;
      
      public function LoaderParamsCommandCodec(param1:IProtocol)
      {
         super();
         this.init(param1);
      }
      
      public function init(param1:IProtocol) : void
      {
         this.arrayCodec = param1.getCodec(new CollectionCodecInfo(new TypeCodecInfo(String,false),false,1));
      }
      
      public function encode(param1:ProtocolBuffer, param2:Object) : void
      {
         var _loc3_:LoaderParamsCommand = LoaderParamsCommand(param2);
         this.arrayCodec.encode(param1,_loc3_.parameterNames);
         this.arrayCodec.encode(param1,_loc3_.parameterValues);
      }
      
      public function decode(param1:ProtocolBuffer) : Object
      {
         return null;
      }
   }
}

