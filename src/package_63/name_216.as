package package_63
{
   import package_32.name_148;
   import package_36.name_152;
   import package_36.name_163;
   import package_36.name_442;
   import package_39.name_160;
   import package_5.name_3;
   import package_57.name_213;
   
   public class name_216 implements name_152
   {
      public static var log:name_160 = name_160(name_3.name_8().name_30(name_160));
      
      private var var_252:name_152;
      
      public function name_216()
      {
         super();
      }
      
      public function init(protocol:name_163) : void
      {
         this.var_252 = protocol.name_448(new name_148(uint,false));
      }
      
      public function method_296(protocolBuffer:name_442) : Object
      {
         log = name_160(name_3.name_8().name_30(name_160));
         var value_id:uint = uint(this.var_252.method_296(protocolBuffer) as uint);
         log.log("codec","struct %1 field %2 value %3","commons.Id","id",value_id);
         return new name_213(value_id);
      }
      
      public function method_295(protocolBuffer:name_442, object:Object) : void
      {
         if(object == null)
         {
            throw new Error("Object is null. Use @ProtocolOptional annotation.");
         }
         var struct:name_213 = name_213(object);
         this.var_252.method_295(protocolBuffer,struct.id);
      }
   }
}

