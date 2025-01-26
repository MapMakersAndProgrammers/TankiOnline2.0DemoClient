package package_61
{
   import package_32.name_148;
   import package_32.name_149;
   import package_33.name_155;
   import package_36.name_152;
   import package_36.name_163;
   import package_36.name_442;
   import package_39.name_160;
   import alternativa.osgi.OSGi;
   import package_55.A3D2AnimationClip;
   
   public class CodecA3D2AnimationClip implements name_152
   {
      public static var log:name_160 = name_160(OSGi.name_8().name_30(name_160));
      
      private var var_252:name_152;
      
      private var var_306:name_152;
      
      private var var_253:name_152;
      
      private var var_304:name_152;
      
      private var var_305:name_152;
      
      public function CodecA3D2AnimationClip()
      {
         super();
      }
      
      public function init(protocol:name_163) : void
      {
         this.var_252 = protocol.name_448(new name_148(int,false));
         this.var_306 = protocol.name_448(new name_148(Boolean,false));
         this.var_253 = protocol.name_448(new name_148(String,true));
         this.var_304 = protocol.name_448(new name_149(new name_148(name_155,false),true,1));
         this.var_305 = protocol.name_448(new name_149(new name_148(int,false),false,1));
      }
      
      public function method_296(protocolBuffer:name_442) : Object
      {
         log = name_160(OSGi.name_8().name_30(name_160));
         var value_id:int = int(this.var_252.method_296(protocolBuffer) as int);
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.animation.A3D2AnimationClip","id",value_id);
         var value_loop:Boolean = Boolean(this.var_306.method_296(protocolBuffer) as Boolean);
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.animation.A3D2AnimationClip","loop",value_loop);
         var value_name:String = this.var_253.method_296(protocolBuffer) as String;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.animation.A3D2AnimationClip","name",value_name);
         var value_objectIDs:Vector.<name_155> = this.var_304.method_296(protocolBuffer) as Vector.<name_155>;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.animation.A3D2AnimationClip","objectIDs",value_objectIDs);
         var value_tracks:Vector.<int> = this.var_305.method_296(protocolBuffer) as Vector.<int>;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.animation.A3D2AnimationClip","tracks",value_tracks);
         return new A3D2AnimationClip(value_id,value_loop,value_name,value_objectIDs,value_tracks);
      }
      
      public function method_295(protocolBuffer:name_442, object:Object) : void
      {
         if(object == null)
         {
            throw new Error("Object is null. Use @ProtocolOptional annotation.");
         }
         var struct:A3D2AnimationClip = A3D2AnimationClip(object);
         this.var_252.method_295(protocolBuffer,struct.id);
         this.var_306.method_295(protocolBuffer,struct.loop);
         this.var_253.method_295(protocolBuffer,struct.name);
         this.var_304.method_295(protocolBuffer,struct.objectIDs);
         this.var_305.method_295(protocolBuffer,struct.tracks);
      }
   }
}

