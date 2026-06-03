package platform.client.core.general.spaces.models.quadrosimple
{
   import alternativa.osgi.OSGi;
   import alternativa.protocol.ICodec;
   import alternativa.protocol.IProtocol;
   import alternativa.protocol.ProtocolBuffer;
   import alternativa.protocol.info.TypeCodecInfo;
   import alternativa.types.Long;
   import platform.client.core.general.spaces.models.quadro.Test;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;
   import platform.client.fp10.core.registry.ModelRegistry;
   
   public class QuadroSimpleModelBase extends Model
   {
      
      private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));
      
      protected var server:QuadroSimpleModelServer = new QuadroSimpleModelServer(IModel(this));
      
      private var client:IQuadroSimpleModelBase = IQuadroSimpleModelBase(this);
      
      private var modelId:Long = Long.getLong(0,100012);
      
      private var _changeId:Long = Long.getLong(0,100009);
      
      private var _change_valueCodec:ICodec;
      
      private var _change_valueNullCodec:ICodec;
      
      private var _clickId:Long = Long.getLong(0,100010);
      
      private var _click_xCodec:ICodec;
      
      private var _click_yCodec:ICodec;
      
      private var _setTestId:Long = Long.getLong(0,100011);
      
      private var _setTest_testCodec:ICodec;
      
      public function QuadroSimpleModelBase()
      {
         super();
         var _loc1_:ModelRegistry = ModelRegistry(OSGi.getInstance().getService(ModelRegistry));
         _loc1_.registerModelConstructorCodec(this.modelId,this._protocol.getCodec(new TypeCodecInfo(QuadroSimpleModelCC,false)));
         this._change_valueCodec = this._protocol.getCodec(new TypeCodecInfo(int,false));
         this._change_valueNullCodec = this._protocol.getCodec(new TypeCodecInfo(int,false));
         this._click_xCodec = this._protocol.getCodec(new TypeCodecInfo(int,false));
         this._click_yCodec = this._protocol.getCodec(new TypeCodecInfo(int,false));
         this._setTest_testCodec = this._protocol.getCodec(new TypeCodecInfo(Test,false));
      }
      
      protected function getInitParam() : QuadroSimpleModelCC
      {
         return QuadroSimpleModelCC(initParams[Model.object]);
      }
      
      override public function invoke(param1:Long, param2:ProtocolBuffer) : void
      {
         switch(param1)
         {
            case this._changeId:
               this.client.change(int(this._change_valueCodec.decode(param2)),int(this._change_valueNullCodec.decode(param2)));
               break;
            case this._clickId:
               this.client.click(int(this._click_xCodec.decode(param2)),int(this._click_yCodec.decode(param2)));
               break;
            case this._setTestId:
               this.client.setTest(Test(this._setTest_testCodec.decode(param2)));
         }
      }
      
      override public function get id() : Long
      {
         return this.modelId;
      }
   }
}

