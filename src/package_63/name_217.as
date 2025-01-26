package package_63
{
   import package_32.name_148;
   import package_33.name_157;
   import package_36.name_152;
   import package_36.name_163;
   import package_36.name_442;
   import package_39.name_160;
   import package_5.name_3;
   import package_57.name_214;
   
   public class name_217 implements name_152
   {
      public static var log:name_160 = name_160(name_3.name_8().name_30(name_160));
      
      private var var_333:name_152;
      
      private var var_327:name_152;
      
      private var var_331:name_152;
      
      private var var_329:name_152;
      
      private var var_326:name_152;
      
      private var var_328:name_152;
      
      private var var_332:name_152;
      
      private var var_325:name_152;
      
      private var var_334:name_152;
      
      private var var_330:name_152;
      
      private var var_324:name_152;
      
      private var var_323:name_152;
      
      public function name_217()
      {
         super();
      }
      
      public function init(protocol:name_163) : void
      {
         this.var_333 = protocol.name_448(new name_148(name_157,false));
         this.var_327 = protocol.name_448(new name_148(name_157,false));
         this.var_331 = protocol.name_448(new name_148(name_157,false));
         this.var_329 = protocol.name_448(new name_148(name_157,false));
         this.var_326 = protocol.name_448(new name_148(name_157,false));
         this.var_328 = protocol.name_448(new name_148(name_157,false));
         this.var_332 = protocol.name_448(new name_148(name_157,false));
         this.var_325 = protocol.name_448(new name_148(name_157,false));
         this.var_334 = protocol.name_448(new name_148(name_157,false));
         this.var_330 = protocol.name_448(new name_148(name_157,false));
         this.var_324 = protocol.name_448(new name_148(name_157,false));
         this.var_323 = protocol.name_448(new name_148(name_157,false));
      }
      
      public function method_296(protocolBuffer:name_442) : Object
      {
         log = name_160(name_3.name_8().name_30(name_160));
         var value_a:Number = Number(this.var_333.method_296(protocolBuffer) as Number);
         log.log("codec","struct %1 field %2 value %3","commons.A3DMatrix","a",value_a);
         var value_b:Number = Number(this.var_327.method_296(protocolBuffer) as Number);
         log.log("codec","struct %1 field %2 value %3","commons.A3DMatrix","b",value_b);
         var value_c:Number = Number(this.var_331.method_296(protocolBuffer) as Number);
         log.log("codec","struct %1 field %2 value %3","commons.A3DMatrix","c",value_c);
         var value_d:Number = Number(this.var_329.method_296(protocolBuffer) as Number);
         log.log("codec","struct %1 field %2 value %3","commons.A3DMatrix","d",value_d);
         var value_e:Number = Number(this.var_326.method_296(protocolBuffer) as Number);
         log.log("codec","struct %1 field %2 value %3","commons.A3DMatrix","e",value_e);
         var value_f:Number = Number(this.var_328.method_296(protocolBuffer) as Number);
         log.log("codec","struct %1 field %2 value %3","commons.A3DMatrix","f",value_f);
         var value_g:Number = Number(this.var_332.method_296(protocolBuffer) as Number);
         log.log("codec","struct %1 field %2 value %3","commons.A3DMatrix","g",value_g);
         var value_h:Number = Number(this.var_325.method_296(protocolBuffer) as Number);
         log.log("codec","struct %1 field %2 value %3","commons.A3DMatrix","h",value_h);
         var value_i:Number = Number(this.var_334.method_296(protocolBuffer) as Number);
         log.log("codec","struct %1 field %2 value %3","commons.A3DMatrix","i",value_i);
         var value_j:Number = Number(this.var_330.method_296(protocolBuffer) as Number);
         log.log("codec","struct %1 field %2 value %3","commons.A3DMatrix","j",value_j);
         var value_k:Number = Number(this.var_324.method_296(protocolBuffer) as Number);
         log.log("codec","struct %1 field %2 value %3","commons.A3DMatrix","k",value_k);
         var value_l:Number = Number(this.var_323.method_296(protocolBuffer) as Number);
         log.log("codec","struct %1 field %2 value %3","commons.A3DMatrix","l",value_l);
         return new name_214(value_a,value_b,value_c,value_d,value_e,value_f,value_g,value_h,value_i,value_j,value_k,value_l);
      }
      
      public function method_295(protocolBuffer:name_442, object:Object) : void
      {
         if(object == null)
         {
            throw new Error("Object is null. Use @ProtocolOptional annotation.");
         }
         var struct:name_214 = name_214(object);
         this.var_333.method_295(protocolBuffer,struct.a);
         this.var_327.method_295(protocolBuffer,struct.b);
         this.var_331.method_295(protocolBuffer,struct.c);
         this.var_329.method_295(protocolBuffer,struct.d);
         this.var_326.method_295(protocolBuffer,struct.e);
         this.var_328.method_295(protocolBuffer,struct.f);
         this.var_332.method_295(protocolBuffer,struct.g);
         this.var_325.method_295(protocolBuffer,struct.h);
         this.var_334.method_295(protocolBuffer,struct.i);
         this.var_330.method_295(protocolBuffer,struct.j);
         this.var_324.method_295(protocolBuffer,struct.k);
         this.var_323.method_295(protocolBuffer,struct.l);
      }
   }
}

