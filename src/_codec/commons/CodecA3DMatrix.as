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
      
      private var §_-Bx§:ICodec;
      
      private var §_-Qh§:ICodec;
      
      private var §_-ir§:ICodec;
      
      private var §_-p§:ICodec;
      
      private var §_-Kw§:ICodec;
      
      private var §_-PP§:ICodec;
      
      private var §_-e7§:ICodec;
      
      private var §_-QE§:ICodec;
      
      private var §_-SL§:ICodec;
      
      private var §for §:ICodec;
      
      private var §_-Hb§:ICodec;
      
      private var §_-3B§:ICodec;
      
      public function CodecA3DMatrix()
      {
         super();
      }
      
      public function init(protocol:IProtocol) : void
      {
         this.§_-Bx§ = protocol.getCodec(new TypeCodecInfo(Float,false));
         this.§_-Qh§ = protocol.getCodec(new TypeCodecInfo(Float,false));
         this.§_-ir§ = protocol.getCodec(new TypeCodecInfo(Float,false));
         this.§_-p§ = protocol.getCodec(new TypeCodecInfo(Float,false));
         this.§_-Kw§ = protocol.getCodec(new TypeCodecInfo(Float,false));
         this.§_-PP§ = protocol.getCodec(new TypeCodecInfo(Float,false));
         this.§_-e7§ = protocol.getCodec(new TypeCodecInfo(Float,false));
         this.§_-QE§ = protocol.getCodec(new TypeCodecInfo(Float,false));
         this.§_-SL§ = protocol.getCodec(new TypeCodecInfo(Float,false));
         this.§for § = protocol.getCodec(new TypeCodecInfo(Float,false));
         this.§_-Hb§ = protocol.getCodec(new TypeCodecInfo(Float,false));
         this.§_-3B§ = protocol.getCodec(new TypeCodecInfo(Float,false));
      }
      
      public function decode(protocolBuffer:ProtocolBuffer) : Object
      {
         log = IClientLog(OSGi.getInstance().getService(IClientLog));
         var value_a:Number = Number(this.§_-Bx§.decode(protocolBuffer) as Number);
         log.log("codec","struct %1 field %2 value %3","commons.A3DMatrix","a",value_a);
         var value_b:Number = Number(this.§_-Qh§.decode(protocolBuffer) as Number);
         log.log("codec","struct %1 field %2 value %3","commons.A3DMatrix","b",value_b);
         var value_c:Number = Number(this.§_-ir§.decode(protocolBuffer) as Number);
         log.log("codec","struct %1 field %2 value %3","commons.A3DMatrix","c",value_c);
         var value_d:Number = Number(this.§_-p§.decode(protocolBuffer) as Number);
         log.log("codec","struct %1 field %2 value %3","commons.A3DMatrix","d",value_d);
         var value_e:Number = Number(this.§_-Kw§.decode(protocolBuffer) as Number);
         log.log("codec","struct %1 field %2 value %3","commons.A3DMatrix","e",value_e);
         var value_f:Number = Number(this.§_-PP§.decode(protocolBuffer) as Number);
         log.log("codec","struct %1 field %2 value %3","commons.A3DMatrix","f",value_f);
         var value_g:Number = Number(this.§_-e7§.decode(protocolBuffer) as Number);
         log.log("codec","struct %1 field %2 value %3","commons.A3DMatrix","g",value_g);
         var value_h:Number = Number(this.§_-QE§.decode(protocolBuffer) as Number);
         log.log("codec","struct %1 field %2 value %3","commons.A3DMatrix","h",value_h);
         var value_i:Number = Number(this.§_-SL§.decode(protocolBuffer) as Number);
         log.log("codec","struct %1 field %2 value %3","commons.A3DMatrix","i",value_i);
         var value_j:Number = Number(this.§for §.decode(protocolBuffer) as Number);
         log.log("codec","struct %1 field %2 value %3","commons.A3DMatrix","j",value_j);
         var value_k:Number = Number(this.§_-Hb§.decode(protocolBuffer) as Number);
         log.log("codec","struct %1 field %2 value %3","commons.A3DMatrix","k",value_k);
         var value_l:Number = Number(this.§_-3B§.decode(protocolBuffer) as Number);
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
         this.§_-Bx§.encode(protocolBuffer,struct.a);
         this.§_-Qh§.encode(protocolBuffer,struct.b);
         this.§_-ir§.encode(protocolBuffer,struct.c);
         this.§_-p§.encode(protocolBuffer,struct.d);
         this.§_-Kw§.encode(protocolBuffer,struct.e);
         this.§_-PP§.encode(protocolBuffer,struct.f);
         this.§_-e7§.encode(protocolBuffer,struct.g);
         this.§_-QE§.encode(protocolBuffer,struct.h);
         this.§_-SL§.encode(protocolBuffer,struct.i);
         this.§for §.encode(protocolBuffer,struct.j);
         this.§_-Hb§.encode(protocolBuffer,struct.k);
         this.§_-3B§.encode(protocolBuffer,struct.l);
      }
   }
}

