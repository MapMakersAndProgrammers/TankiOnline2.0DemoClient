package package_58
{
   import package_32.name_148;
   import package_36.name_152;
   import package_36.name_163;
   import package_36.name_442;
   import package_39.name_160;
   import package_5.name_3;
   import package_51.A3D2Image;
   
   public class CodecA3D2Image implements name_152
   {
      public static var log:name_160 = name_160(name_3.name_8().name_30(name_160));
      
      private var var_252:name_152;
      
      private var var_307:name_152;
      
      public function CodecA3D2Image()
      {
         super();
      }
      
      public function init(protocol:name_163) : void
      {
         this.var_252 = protocol.name_448(new name_148(int,false));
         this.var_307 = protocol.name_448(new name_148(String,false));
      }
      
      public function method_296(protocolBuffer:name_442) : Object
      {
         log = name_160(name_3.name_8().name_30(name_160));
         var value_id:int = int(this.var_252.method_296(protocolBuffer) as int);
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.materials.A3D2Image","id",value_id);
         var value_url:String = this.var_307.method_296(protocolBuffer) as String;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.materials.A3D2Image","url",value_url);
         return new A3D2Image(value_id,value_url);
      }
      
      public function method_295(protocolBuffer:name_442, object:Object) : void
      {
         if(object == null)
         {
            throw new Error("Object is null. Use @ProtocolOptional annotation.");
         }
         var struct:A3D2Image = A3D2Image(object);
         this.var_252.method_295(protocolBuffer,struct.id);
         this.var_307.method_295(protocolBuffer,struct.url);
      }
   }
}

