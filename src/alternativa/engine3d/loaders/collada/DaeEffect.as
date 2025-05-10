package alternativa.engine3d.loaders.collada
{
   import alternativa.engine3d.loaders.ParserMaterial;
   import alternativa.engine3d.resources.ExternalTextureResource;
   
   use namespace collada;
   
   public class DaeEffect extends DaeElement
   {
      public static var commonAlways:Boolean = false;
      
      private var name_3x:Object;
      
      private var name_El:Object;
      
      private var name_3H:Object;
      
      private var diffuse:DaeEffectParam;
      
      private var ambient:DaeEffectParam;
      
      private var transparent:DaeEffectParam;
      
      private var transparency:DaeEffectParam;
      
      private var bump:DaeEffectParam;
      
      private var reflective:DaeEffectParam;
      
      private var emission:DaeEffectParam;
      
      private var specular:DaeEffectParam;
      
      public function DaeEffect(data:XML, document:DaeDocument)
      {
         super(data,document);
         this.constructImages();
      }
      
      private function constructImages() : void
      {
         var element:XML = null;
         var image:DaeImage = null;
         var list:XMLList = data..image;
         for each(element in list)
         {
            image = new DaeImage(element,document);
            if(image.id != null)
            {
               document.images[image.id] = image;
            }
         }
      }
      
      override protected function parseImplementation() : Boolean
      {
         var shader:XML;
         var element:XML = null;
         var param:DaeParam = null;
         var technique:XML = null;
         var bumpXML:XML = null;
         var diffuseXML:XML = null;
         var transparentXML:XML = null;
         var transparencyXML:XML = null;
         var ambientXML:XML = null;
         var reflectiveXML:XML = null;
         var emissionXML:XML = null;
         var specularXML:XML = null;
         this.name_3x = new Object();
         for each(element in data.newparam)
         {
            param = new DaeParam(element,document);
            this.name_3x[param.sid] = param;
         }
         this.name_El = new Object();
         for each(element in data.profile_COMMON.newparam)
         {
            param = new DaeParam(element,document);
            this.name_El[param.sid] = param;
         }
         this.name_3H = new Object();
         technique = data.profile_COMMON.technique[0];
         if(technique != null)
         {
            for each(element in technique.newparam)
            {
               param = new DaeParam(element,document);
               this.name_3H[param.sid] = param;
            }
         }
         shader = data.profile_COMMON.technique.*.(localName() == "constant" || localName() == "lambert" || localName() == "phong" || localName() == "blinn")[0];
         if(shader != null)
         {
            diffuseXML = null;
            if(shader.localName() == "constant")
            {
               diffuseXML = shader.emission[0];
            }
            else
            {
               diffuseXML = shader.diffuse[0];
               emissionXML = shader.emission[0];
               if(emissionXML != null)
               {
                  this.emission = new DaeEffectParam(emissionXML,this);
               }
            }
            if(diffuseXML != null)
            {
               this.diffuse = new DaeEffectParam(diffuseXML,this);
            }
            if(shader.localName() == "phong" || shader.localName() == "blinn")
            {
               specularXML = shader.specular[0];
               if(specularXML != null)
               {
                  this.specular = new DaeEffectParam(specularXML,this);
               }
            }
            transparentXML = shader.transparent[0];
            if(transparentXML != null)
            {
               this.transparent = new DaeEffectParam(transparentXML,this);
            }
            transparencyXML = shader.transparency[0];
            if(transparencyXML != null)
            {
               this.transparency = new DaeEffectParam(transparencyXML,this);
            }
            ambientXML = shader.ambient[0];
            if(ambientXML != null)
            {
               this.ambient = new DaeEffectParam(ambientXML,this);
            }
            reflectiveXML = shader.reflective[0];
            if(reflectiveXML != null)
            {
               this.reflective = new DaeEffectParam(reflectiveXML,this);
            }
         }
         bumpXML = data.profile_COMMON.technique.extra.technique.(Boolean(hasOwnProperty("@profile")) && @profile == "OpenCOLLADA3dsMax").bump[0];
         if(bumpXML != null)
         {
            this.bump = new DaeEffectParam(bumpXML,this);
         }
         return true;
      }
      
      internal function getParam(name:String, setparams:Object) : DaeParam
      {
         var param:DaeParam = setparams[name];
         if(param != null)
         {
            return param;
         }
         param = this.name_3H[name];
         if(param != null)
         {
            return param;
         }
         param = this.name_El[name];
         if(param != null)
         {
            return param;
         }
         return this.name_3x[name];
      }
      
      private function float4ToUint(value:Array, alpha:Boolean = true) : uint
      {
         var a:uint = 0;
         var r:uint = value[0] * 255;
         var g:uint = value[1] * 255;
         var b:uint = value[2] * 255;
         if(alpha)
         {
            a = value[3] * 255;
            return a << 24 | r << 16 | g << 8 | b;
         }
         return r << 16 | g << 8 | b;
      }
      
      public function getMaterial(setparams:Object) : ParserMaterial
      {
         var material:ParserMaterial = null;
         if(this.diffuse != null)
         {
            material = new ParserMaterial();
            if(Boolean(this.diffuse))
            {
               this.pushMap(material,this.diffuse,setparams);
            }
            if(this.specular != null)
            {
               this.pushMap(material,this.specular,setparams);
            }
            if(this.emission != null)
            {
               this.pushMap(material,this.emission,setparams);
            }
            if(this.transparency != null)
            {
               material.transparency = this.transparency.getFloat(setparams);
            }
            if(this.transparent != null)
            {
               this.pushMap(material,this.transparent,setparams);
            }
            if(this.bump != null)
            {
               this.pushMap(material,this.bump,setparams);
            }
            if(Boolean(this.ambient))
            {
               this.pushMap(material,this.ambient,setparams);
            }
            if(Boolean(this.reflective))
            {
               this.pushMap(material,this.reflective,setparams);
            }
            return material;
         }
         return null;
      }
      
      private function pushMap(material:ParserMaterial, param:DaeEffectParam, setparams:Object) : void
      {
         var _loc5_:DaeImage = null;
         var color:Array = param.getColor(setparams);
         if(color != null)
         {
            material.colors[cloneString(param.data.localName())] = this.float4ToUint(color,true);
         }
         else
         {
            _loc5_ = param.getImage(setparams);
            if(_loc5_ != null)
            {
               material.textures[cloneString(param.data.localName())] = new ExternalTextureResource(cloneString(_loc5_.init_from));
            }
         }
      }
      
      public function get mainTexCoords() : String
      {
         var channel:String = null;
         channel = channel == null && this.diffuse != null ? this.diffuse.texCoord : channel;
         channel = channel == null && this.transparent != null ? this.transparent.texCoord : channel;
         channel = channel == null && this.bump != null ? this.bump.texCoord : channel;
         channel = channel == null && this.emission != null ? this.emission.texCoord : channel;
         return channel == null && this.specular != null ? this.specular.texCoord : channel;
      }
   }
}

