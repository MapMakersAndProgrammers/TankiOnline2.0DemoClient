package package_123
{
   import package_21.name_116;
   import package_24.DirectionalLight;
   import package_24.OmniLight;
   import package_24.SpotLight;
   import package_24.name_376;
   
   use namespace collada;
   
   public class name_741 extends class_43
   {
      public function name_741(data:XML, document:name_707)
      {
         super(data,document);
      }
      
      private function method_892(value:Array) : uint
      {
         var r:uint = value[0] * 255;
         var g:uint = value[1] * 255;
         var b:uint = value[2] * 255;
         return r << 16 | g << 8 | b | 4278190080;
      }
      
      public function get name_761() : Boolean
      {
         var info:XML = data.technique_common.children()[0];
         return info == null ? false : info.localName() == "directional" || info.localName() == "spot";
      }
      
      public function name_762() : name_116
      {
         var info:XML = null;
         var extra:XML = null;
         var light:name_116 = null;
         var color:uint = 0;
         var constantAttenuationXML:XML = null;
         var linearAttenuationXML:XML = null;
         var linearAttenuation:Number = NaN;
         var attenuationStart:Number = NaN;
         var attenuationEnd:Number = NaN;
         var dLight:DirectionalLight = null;
         var oLight:OmniLight = null;
         var hotspot:Number = NaN;
         var fallof:Number = NaN;
         var DEG2RAD:Number = NaN;
         var sLight:SpotLight = null;
         info = data.technique_common.children()[0];
         extra = data.extra.technique.(@profile[0] == "OpenCOLLADA3dsMax").light[0];
         light = null;
         if(info != null)
         {
            color = this.method_892(method_866(info.color[0]));
            linearAttenuation = 0;
            attenuationStart = 0;
            attenuationEnd = 1;
            switch(info.localName())
            {
               case "ambient":
                  light = new name_376(color);
                  break;
               case "directional":
                  dLight = new DirectionalLight(color);
                  light = dLight;
                  break;
               case "point":
                  if(extra != null)
                  {
                     attenuationStart = method_761(extra.attenuation_far_start[0]);
                     attenuationEnd = method_761(extra.attenuation_far_end[0]);
                  }
                  else
                  {
                     constantAttenuationXML = info.constant_attenuation[0];
                     linearAttenuationXML = info.linear_attenuation[0];
                     if(constantAttenuationXML != null)
                     {
                        attenuationStart = -method_761(constantAttenuationXML);
                     }
                     if(linearAttenuationXML != null)
                     {
                        linearAttenuation = method_761(linearAttenuationXML);
                     }
                     if(linearAttenuation > 0)
                     {
                        attenuationEnd = 1 / linearAttenuation + attenuationStart;
                     }
                     else
                     {
                        attenuationEnd = attenuationStart + 1;
                     }
                  }
                  oLight = new OmniLight(color,attenuationStart,attenuationEnd);
                  light = oLight;
                  break;
               case "spot":
                  hotspot = 0;
                  fallof = Math.PI / 4;
                  DEG2RAD = Math.PI / 180;
                  if(extra != null)
                  {
                     attenuationStart = method_761(extra.attenuation_far_start[0]);
                     attenuationEnd = method_761(extra.attenuation_far_end[0]);
                     hotspot = DEG2RAD * method_761(extra.hotspot_beam[0]);
                     fallof = DEG2RAD * method_761(extra.falloff[0]);
                  }
                  else
                  {
                     constantAttenuationXML = info.constant_attenuation[0];
                     linearAttenuationXML = info.linear_attenuation[0];
                     if(constantAttenuationXML != null)
                     {
                        attenuationStart = -method_761(constantAttenuationXML);
                     }
                     if(linearAttenuationXML != null)
                     {
                        linearAttenuation = method_761(linearAttenuationXML);
                     }
                     if(linearAttenuation > 0)
                     {
                        attenuationEnd = 1 / linearAttenuation + attenuationStart;
                     }
                     else
                     {
                        attenuationEnd = attenuationStart + 1;
                     }
                  }
                  sLight = new SpotLight(color,attenuationStart,attenuationEnd,hotspot,fallof);
                  light = sLight;
            }
         }
         return light;
      }
   }
}

