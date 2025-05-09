package _codec.commons
{
   import alternativa.osgi.OSGi;
   import alternativa.osgi.service.clientlog.IClientLog;
   import alternativa.protocol.ICodec;
   import alternativa.protocol.IProtocol;
   import alternativa.protocol.ProtocolBuffer;
   import alternativa.protocol.info.TypeCodecInfo;
   import alternativa.types.Float;
   import commons.A3DMatrix;
   
   public class CodecA3DMatrix implements ICodec
   {
      public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));
      
      private var var_324:ICodec;
      
      private var var_329:ICodec;
      
      private var var_332:ICodec;
      
      private var var_333:ICodec;
      
      private var var_326:ICodec;
      
      private var var_327:ICodec;
      
      private var var_331:ICodec;
      
      private var var_328:ICodec;
      
      private var var_330:ICodec;
      
      private var var_334:ICodec;
      
      private var var_325:ICodec;
      
      private var var_323:ICodec;
      
      public function CodecA3DMatrix()
      {
         super();
      }
      
      public function init(protocol:IProtocol) : void
      {
         this.var_324 = protocol.getCodec(new TypeCodecInfo(Float,false));
         this.var_329 = protocol.getCodec(new TypeCodecInfo(Float,false));
         this.var_332 = protocol.getCodec(new TypeCodecInfo(Float,false));
         this.var_333 = protocol.getCodec(new TypeCodecInfo(Float,false));
         this.var_326 = protocol.getCodec(new TypeCodecInfo(Float,false));
         this.var_327 = protocol.getCodec(new TypeCodecInfo(Float,false));
         this.var_331 = protocol.getCodec(new TypeCodecInfo(Float,false));
         this.var_328 = protocol.getCodec(new TypeCodecInfo(Float,false));
         this.var_330 = protocol.getCodec(new TypeCodecInfo(Float,false));
         this.var_334 = protocol.getCodec(new TypeCodecInfo(Float,false));
         this.var_325 = protocol.getCodec(new TypeCodecInfo(Float,false));
         this.var_323 = protocol.getCodec(new TypeCodecInfo(Float,false));
      }
      
      public function decode(protocolBuffer:ProtocolBuffer) : Object
      {
         log = IClientLog(OSGi.getInstance().getService(IClientLog));
         var value_a:Number = Number(this.var_324.decode(protocolBuffer) as Number);
         log.log("codec","struct %1 field %2 value %3","commons.A3DMatrix","a",value_a);
         var value_b:Number = Number(this.var_329.decode(protocolBuffer) as Number);
         log.log("codec","struct %1 field %2 value %3","commons.A3DMatrix","b",value_b);
         var value_c:Number = Number(this.var_332.decode(protocolBuffer) as Number);
         log.log("codec","struct %1 field %2 value %3","commons.A3DMatrix","c",value_c);
         var value_d:Number = Number(this.var_333.decode(protocolBuffer) as Number);
         log.log("codec","struct %1 field %2 value %3","commons.A3DMatrix","d",value_d);
         var value_e:Number = Number(this.var_326.decode(protocolBuffer) as Number);
         log.log("codec","struct %1 field %2 value %3","commons.A3DMatrix","e",value_e);
         var value_f:Number = Number(this.var_327.decode(protocolBuffer) as Number);
         log.log("codec","struct %1 field %2 value %3","commons.A3DMatrix","f",value_f);
         var value_g:Number = Number(this.var_331.decode(protocolBuffer) as Number);
         log.log("codec","struct %1 field %2 value %3","commons.A3DMatrix","g",value_g);
         var value_h:Number = Number(this.var_328.decode(protocolBuffer) as Number);
         log.log("codec","struct %1 field %2 value %3","commons.A3DMatrix","h",value_h);
         var value_i:Number = Number(this.var_330.decode(protocolBuffer) as Number);
         log.log("codec","struct %1 field %2 value %3","commons.A3DMatrix","i",value_i);
         var value_j:Number = Number(this.var_334.decode(protocolBuffer) as Number);
         log.log("codec","struct %1 field %2 value %3","commons.A3DMatrix","j",value_j);
         var value_k:Number = Number(this.var_325.decode(protocolBuffer) as Number);
         log.log("codec","struct %1 field %2 value %3","commons.A3DMatrix","k",value_k);
         var value_l:Number = Number(this.var_323.decode(protocolBuffer) as Number);
         log.log("codec","struct %1 field %2 value %3","commons.A3DMatrix","l",value_l);
         return new A3DMatrix(value_a,value_b,value_c,value_d,value_e,value_f,value_g,value_h,value_i,value_j,value_k,value_l);
      }
      
      public function encode(protocolBuffer:ProtocolBuffer, object:Object) : void
      {
         if(object == null)
         {
            throw new Error("Object is null. Use @ProtocolOptional annotation.");
         }
         var struct:A3DMatrix = A3DMatrix(object);
         this.var_324.encode(protocolBuffer,struct.a);
         this.var_329.encode(protocolBuffer,struct.b);
         this.var_332.encode(protocolBuffer,struct.c);
         this.var_333.encode(protocolBuffer,struct.d);
         this.var_326.encode(protocolBuffer,struct.e);
         this.var_327.encode(protocolBuffer,struct.f);
         this.var_331.encode(protocolBuffer,struct.g);
         this.var_328.encode(protocolBuffer,struct.h);
         this.var_330.encode(protocolBuffer,struct.i);
         this.var_334.encode(protocolBuffer,struct.j);
         this.var_325.encode(protocolBuffer,struct.k);
         this.var_323.encode(protocolBuffer,struct.l);
      }
   }
}

