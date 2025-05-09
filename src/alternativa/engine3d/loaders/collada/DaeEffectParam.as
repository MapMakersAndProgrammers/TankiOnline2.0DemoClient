package alternativa.engine3d.loaders.collada
{
   use namespace collada;
   
   public class DaeEffectParam extends DaeElement
   {
      private var effect:DaeEffect;
      
      public function DaeEffectParam(data:XML, effect:DaeEffect)
      {
         super(data,effect.document);
         this.effect = effect;
      }
      
      public function getFloat(setparams:Object) : Number
      {
         var param:DaeParam = null;
         var floatXML:XML = data.float[0];
         if(floatXML != null)
         {
            return parseNumber(floatXML);
         }
         var paramRef:XML = data.param.@ref[0];
         if(paramRef != null)
         {
            param = this.effect.getParam(paramRef.toString(),setparams);
            if(param != null)
            {
               return param.getFloat();
            }
         }
         return NaN;
      }
      
      public function getColor(setparams:Object) : Array
      {
         var param:DaeParam = null;
         var colorXML:XML = data.color[0];
         if(colorXML != null)
         {
            return parseNumbersArray(colorXML);
         }
         var paramRef:XML = data.param.@ref[0];
         if(paramRef != null)
         {
            param = this.effect.getParam(paramRef.toString(),setparams);
            if(param != null)
            {
               return param.getFloat4();
            }
         }
         return null;
      }
      
      private function get texture() : String
      {
         var attr:XML = data.texture.@texture[0];
         return attr == null ? null : attr.toString();
      }
      
      public function getSampler(setparams:Object) : DaeParam
      {
         var sid:String = this.texture;
         if(sid != null)
         {
            return this.effect.getParam(sid,setparams);
         }
         return null;
      }
      
      public function getImage(setparams:Object) : DaeImage
      {
         var surfaceSID:String = null;
         var surface:DaeParam = null;
         var sampler:DaeParam = this.getSampler(setparams);
         if(sampler != null)
         {
            surfaceSID = sampler.surfaceSID;
            if(surfaceSID != null)
            {
               surface = this.effect.getParam(surfaceSID,setparams);
               if(surface != null)
               {
                  return surface.image;
               }
               return null;
            }
            return sampler.image;
         }
         return document.findImageByID(this.texture);
      }
      
      public function get texCoord() : String
      {
         var attr:XML = data.texture.@texcoord[0];
         return attr == null ? null : attr.toString();
      }
   }
}

