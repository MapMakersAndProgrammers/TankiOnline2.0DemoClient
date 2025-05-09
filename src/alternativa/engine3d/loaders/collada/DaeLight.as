package alternativa.engine3d.loaders.collada
{
   import alternativa.engine3d.core.Light3D;
   import alternativa.engine3d.lights.AmbientLight;
   import alternativa.engine3d.lights.DirectionalLight;
   import alternativa.engine3d.lights.OmniLight;
   import alternativa.engine3d.lights.SpotLight;
   
   use namespace collada;
   
   public class DaeLight extends DaeElement
   {
      public function DaeLight(data:XML, document:DaeDocument)
      {
         super(data,document);
      }
      
      private function float4ToUint(value:Array) : uint
      {
         var r:uint = value[0] * 255;
         var g:uint = value[1] * 255;
         var b:uint = value[2] * 255;
         return r << 16 | g << 8 | b | 4278190080;
      }
      
      public function get revertDirection() : Boolean
      {
         var info:XML = data.technique_common.children()[0];
         return info == null ? false : info.localName() == "directional" || info.localName() == "spot";
      }
      
      public function parseLight() : Light3D
      {
         var info:XML = null;
         var extra:XML = null;
         var light:Light3D = null;
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
            color = this.float4ToUint(parseNumbersArray(info.color[0]));
            linearAttenuation = 0;
            attenuationStart = 0;
            attenuationEnd = 1;
            switch(info.localName())
            {
               case "ambient":
                  light = new AmbientLight(color);
                  break;
               case "directional":
                  dLight = new DirectionalLight(color);
                  light = dLight;
                  break;
               case "point":
                  if(extra != null)
                  {
                     attenuationStart = parseNumber(extra.attenuation_far_start[0]);
                     attenuationEnd = parseNumber(extra.attenuation_far_end[0]);
                  }
                  else
                  {
                     constantAttenuationXML = info.constant_attenuation[0];
                     linearAttenuationXML = info.linear_attenuation[0];
                     if(constantAttenuationXML != null)
                     {
                        attenuationStart = -parseNumber(constantAttenuationXML);
                     }
                     if(linearAttenuationXML != null)
                     {
                        linearAttenuation = parseNumber(linearAttenuationXML);
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
                     attenuationStart = parseNumber(extra.attenuation_far_start[0]);
                     attenuationEnd = parseNumber(extra.attenuation_far_end[0]);
                     hotspot = DEG2RAD * parseNumber(extra.hotspot_beam[0]);
                     fallof = DEG2RAD * parseNumber(extra.falloff[0]);
                  }
                  else
                  {
                     constantAttenuationXML = info.constant_attenuation[0];
                     linearAttenuationXML = info.linear_attenuation[0];
                     if(constantAttenuationXML != null)
                     {
                        attenuationStart = -parseNumber(constantAttenuationXML);
                     }
                     if(linearAttenuationXML != null)
                     {
                        linearAttenuation = parseNumber(linearAttenuationXML);
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

