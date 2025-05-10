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
      
      private var name_Bx:ICodec;
      
      private var name_Qh:ICodec;
      
      private var name_ir:ICodec;
      
      private var name_p:ICodec;
      
      private var name_Kw:ICodec;
      
      private var name_PP:ICodec;
      
      private var name_e7:ICodec;
      
      private var name_QE:ICodec;
      
      private var name_SL:ICodec;
      
      private var name_for:ICodec;
      
      private var name_Hb:ICodec;
      
      private var name_3B:ICodec;
      
      public function CodecA3DMatrix()
      {
         super();
      }
      
      public function init(protocol:IProtocol) : void
      {
         this.name_Bx = protocol.getCodec(new TypeCodecInfo(Float,false));
         this.name_Qh = protocol.getCodec(new TypeCodecInfo(Float,false));
         this.name_ir = protocol.getCodec(new TypeCodecInfo(Float,false));
         this.name_p = protocol.getCodec(new TypeCodecInfo(Float,false));
         this.name_Kw = protocol.getCodec(new TypeCodecInfo(Float,false));
         this.name_PP = protocol.getCodec(new TypeCodecInfo(Float,false));
         this.name_e7 = protocol.getCodec(new TypeCodecInfo(Float,false));
         this.name_QE = protocol.getCodec(new TypeCodecInfo(Float,false));
         this.name_SL = protocol.getCodec(new TypeCodecInfo(Float,false));
         this.name_for = protocol.getCodec(new TypeCodecInfo(Float,false));
         this.name_Hb = protocol.getCodec(new TypeCodecInfo(Float,false));
         this.name_3B = protocol.getCodec(new TypeCodecInfo(Float,false));
      }
      
      public function decode(protocolBuffer:ProtocolBuffer) : Object
      {
         log = IClientLog(OSGi.getInstance().getService(IClientLog));
         var value_a:Number = Number(this.name_Bx.decode(protocolBuffer) as Number);
         log.log("codec","struct %1 field %2 value %3","commons.A3DMatrix","a",value_a);
         var value_b:Number = Number(this.name_Qh.decode(protocolBuffer) as Number);
         log.log("codec","struct %1 field %2 value %3","commons.A3DMatrix","b",value_b);
         var value_c:Number = Number(this.name_ir.decode(protocolBuffer) as Number);
         log.log("codec","struct %1 field %2 value %3","commons.A3DMatrix","c",value_c);
         var value_d:Number = Number(this.name_p.decode(protocolBuffer) as Number);
         log.log("codec","struct %1 field %2 value %3","commons.A3DMatrix","d",value_d);
         var value_e:Number = Number(this.name_Kw.decode(protocolBuffer) as Number);
         log.log("codec","struct %1 field %2 value %3","commons.A3DMatrix","e",value_e);
         var value_f:Number = Number(this.name_PP.decode(protocolBuffer) as Number);
         log.log("codec","struct %1 field %2 value %3","commons.A3DMatrix","f",value_f);
         var value_g:Number = Number(this.name_e7.decode(protocolBuffer) as Number);
         log.log("codec","struct %1 field %2 value %3","commons.A3DMatrix","g",value_g);
         var value_h:Number = Number(this.name_QE.decode(protocolBuffer) as Number);
         log.log("codec","struct %1 field %2 value %3","commons.A3DMatrix","h",value_h);
         var value_i:Number = Number(this.name_SL.decode(protocolBuffer) as Number);
         log.log("codec","struct %1 field %2 value %3","commons.A3DMatrix","i",value_i);
         var value_j:Number = Number(this.name_for.decode(protocolBuffer) as Number);
         log.log("codec","struct %1 field %2 value %3","commons.A3DMatrix","j",value_j);
         var value_k:Number = Number(this.name_Hb.decode(protocolBuffer) as Number);
         log.log("codec","struct %1 field %2 value %3","commons.A3DMatrix","k",value_k);
         var value_l:Number = Number(this.name_3B.decode(protocolBuffer) as Number);
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
         this.name_Bx.encode(protocolBuffer,struct.a);
         this.name_Qh.encode(protocolBuffer,struct.b);
         this.name_ir.encode(protocolBuffer,struct.c);
         this.name_p.encode(protocolBuffer,struct.d);
         this.name_Kw.encode(protocolBuffer,struct.e);
         this.name_PP.encode(protocolBuffer,struct.f);
         this.name_e7.encode(protocolBuffer,struct.g);
         this.name_QE.encode(protocolBuffer,struct.h);
         this.name_SL.encode(protocolBuffer,struct.i);
         this.name_for.encode(protocolBuffer,struct.j);
         this.name_Hb.encode(protocolBuffer,struct.k);
         this.name_3B.encode(protocolBuffer,struct.l);
      }
   }
}

