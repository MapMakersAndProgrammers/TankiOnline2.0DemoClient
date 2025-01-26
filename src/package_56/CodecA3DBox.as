package package_56
{
   import package_32.name_148;
   import package_32.name_149;
   import package_33.name_157;
   import package_36.name_152;
   import package_36.name_163;
   import package_36.name_442;
   import package_39.name_160;
   import package_5.name_3;
   import package_50.A3DBox;
   import package_57.name_213;
   
   public class CodecA3DBox implements name_152
   {
      public static var log:name_160 = name_160(name_3.name_8().name_30(name_160));
      
      private var var_284:name_152;
      
      private var var_252:name_152;
      
      public function CodecA3DBox()
      {
         super();
      }
      
      public function init(protocol:name_163) : void
      {
         this.var_284 = protocol.name_448(new name_149(new name_148(name_157,false),true,1));
         this.var_252 = protocol.name_448(new name_148(name_213,true));
      }
      
      public function method_296(protocolBuffer:name_442) : Object
      {
         log = name_160(name_3.name_8().name_30(name_160));
         var value_box:Vector.<Number> = this.var_284.method_296(protocolBuffer) as Vector.<Number>;
         log.log("codec","struct %1 field %2 value %3","versions.version1.a3d.objects.A3DBox","box",value_box);
         var value_id:name_213 = this.var_252.method_296(protocolBuffer) as name_213;
         log.log("codec","struct %1 field %2 value %3","versions.version1.a3d.objects.A3DBox","id",value_id);
         return new A3DBox(value_box,value_id);
      }
      
      public function method_295(protocolBuffer:name_442, object:Object) : void
      {
         if(object == null)
         {
            throw new Error("Object is null. Use @ProtocolOptional annotation.");
         }
         var struct:A3DBox = A3DBox(object);
         this.var_284.method_295(protocolBuffer,struct.box);
         this.var_252.method_295(protocolBuffer,struct.id);
      }
   }
}

