package package_16
{
   import package_31.class_6;
   import package_33.name_153;
   import package_33.name_154;
   import package_33.name_155;
   import package_33.name_156;
   import package_33.name_157;
   import package_33.name_158;
   import package_36.name_163;
   import package_38.name_159;
   import alternativa.osgi.OSGi;
   import package_70.name_224;
   import package_70.name_225;
   import package_70.name_226;
   import package_70.name_227;
   import package_70.name_228;
   import package_70.name_229;
   import package_70.name_230;
   import package_70.name_231;
   import package_70.name_232;
   
   public class name_26 implements class_6
   {
      public function name_26()
      {
         super();
      }
      
      public function start(osgi:OSGi) : void
      {
         var protocol:name_163 = name_159.defaultInstance;
         osgi.method_116(name_163,protocol);
         protocol.name_223(name_154,new name_225());
         protocol.name_223(name_157,new name_226());
         protocol.name_223(name_155,new name_227());
         protocol.name_223(name_158,new name_224());
         protocol.name_223(name_153,new name_229());
         protocol.name_223(name_156,new name_230());
         protocol.name_223(uint,new name_228());
         protocol.name_223(int,new name_232());
         protocol.name_223(Number,new name_231());
      }
      
      public function stop(osgi:OSGi) : void
      {
      }
   }
}

