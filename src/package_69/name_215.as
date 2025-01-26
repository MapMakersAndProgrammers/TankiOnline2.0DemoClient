package package_69
{
   import package_32.name_148;
   import package_36.name_152;
   import package_36.name_163;
   import package_36.name_442;
   import package_39.name_160;
   import alternativa.osgi.OSGi;
   import package_64.name_212;
   
   public class name_215 implements name_152
   {
      public static var log:name_160 = name_160(OSGi.name_8().name_30(name_160));
      
      private var var_252:name_152;
      
      public function name_215()
      {
         super();
      }
      
      public function init(protocol:name_163) : void
      {
         this.var_252 = protocol.name_448(new name_148(uint,false));
      }
      
      public function method_296(protocolBuffer:name_442) : Object
      {
         log = name_160(OSGi.name_8().name_30(name_160));
         var value_id:uint = uint(this.var_252.method_296(protocolBuffer) as uint);
         log.log("codec","struct %1 field %2 value %3","versions.version1.a3d.id.ParentId","id",value_id);
         return new name_212(value_id);
      }
      
      public function method_295(protocolBuffer:name_442, object:Object) : void
      {
         if(object == null)
         {
            throw new Error("Object is null. Use @ProtocolOptional annotation.");
         }
         var struct:name_212 = name_212(object);
         this.var_252.method_295(protocolBuffer,struct.id);
      }
   }
}

