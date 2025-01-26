package package_38
{
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   import flash.utils.IDataInput;
   import flash.utils.IDataOutput;
   import package_111.name_456;
   import package_111.name_457;
   import package_32.name_148;
   import package_33.name_154;
   import package_33.name_155;
   import package_33.name_156;
   import package_33.name_157;
   import package_33.name_158;
   import package_34.name_150;
   import package_36.*;
   import package_39.name_160;
   import package_70.name_224;
   import package_70.name_225;
   import package_70.name_226;
   import package_70.name_227;
   import package_70.name_228;
   import package_70.name_230;
   import package_70.name_231;
   import package_70.name_232;
   import package_70.name_458;
   
   public class name_159 implements name_163
   {
      [Inject]
      public static var clientLog:name_160;
      
      private static const LOG_CHANNEL:String = "protocol";
      
      public static var defaultInstance:name_163 = new name_159();
      
      private var var_190:Object = new Object();
      
      private var var_191:Dictionary = new Dictionary(false);
      
      public function name_159()
      {
         super();
         this.name_151(new name_148(int,false),new name_232());
         this.name_151(new name_148(name_158,false),new name_224());
         this.name_151(new name_148(name_154,false),new name_225());
         this.name_151(new name_148(name_156,false),new name_230());
         this.name_151(new name_148(uint,false),new name_228());
         this.name_151(new name_148(Number,false),new name_231());
         this.name_151(new name_148(name_157,false),new name_226());
         this.name_151(new name_148(Boolean,false),new name_458());
         this.name_151(new name_148(name_155,false),new name_227());
         this.name_151(new name_148(String,false),new name_457());
         this.name_151(new name_148(ByteArray,false),new name_456());
         this.name_151(new name_148(int,true),new name_150(new name_232()));
         this.name_151(new name_148(name_158,true),new name_150(new name_224()));
         this.name_151(new name_148(name_154,true),new name_150(new name_225()));
         this.name_151(new name_148(name_156,true),new name_150(new name_230()));
         this.name_151(new name_148(uint,true),new name_150(new name_228()));
         this.name_151(new name_148(Number,true),new name_150(new name_231()));
         this.name_151(new name_148(name_157,true),new name_150(new name_226()));
         this.name_151(new name_148(Boolean,true),new name_150(new name_458()));
         this.name_151(new name_148(name_155,true),new name_150(new name_227()));
         this.name_151(new name_148(String,true),new name_150(new name_457()));
         this.name_151(new name_148(ByteArray,true),new name_150(new name_456()));
      }
      
      public function name_151(codecInfo:class_19, codec:name_152) : void
      {
         this.var_190[codecInfo] = codec;
      }
      
      public function name_223(type:Class, codec:name_152) : void
      {
         this.var_190[new name_148(type,false)] = codec;
         this.var_190[new name_148(type,true)] = new name_150(codec);
      }
      
      public function name_448(codecInfo:class_19) : name_152
      {
         var result:name_152 = this.var_190[codecInfo];
         if(result == null)
         {
            throw Error("Codec not found for  " + codecInfo);
         }
         if(this.var_191[result] == null)
         {
            result.init(this);
            this.var_191[result] = result;
         }
         return result;
      }
      
      public function method_304(type:Class) : class_19
      {
         return new name_148(type,false);
      }
      
      public function method_305(dest:IDataOutput, source:name_442, compressionType:name_449) : void
      {
         name_162.method_305(dest,source,compressionType);
      }
      
      public function method_303(source:IDataInput, dest:name_442) : Boolean
      {
         return name_162.method_303(source,dest);
      }
   }
}

