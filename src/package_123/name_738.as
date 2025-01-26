package package_123
{
   import package_116.name_641;
   import package_28.name_167;
   
   use namespace collada;
   
   public class name_738 extends class_43
   {
      public static var commonAlways:Boolean = false;
      
      private var var_717:Object;
      
      private var var_718:Object;
      
      private var var_719:Object;
      
      private var diffuse:name_775;
      
      private var ambient:name_775;
      
      private var transparent:name_775;
      
      private var transparency:name_775;
      
      private var bump:name_775;
      
      private var reflective:name_775;
      
      private var emission:name_775;
      
      private var specular:name_775;
      
      public function name_738(data:XML, document:name_707)
      {
         super(data,document);
         this.method_891();
      }
      
      private function method_891() : void
      {
         var element:XML = null;
         var image:name_734 = null;
         var list:XMLList = data..image;
         for each(element in list)
         {
            image = new name_734(element,document);
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
         var param:name_754 = null;
         var technique:XML = null;
         var bumpXML:XML = null;
         var diffuseXML:XML = null;
         var transparentXML:XML = null;
         var transparencyXML:XML = null;
         var ambientXML:XML = null;
         var reflectiveXML:XML = null;
         var emissionXML:XML = null;
         var specularXML:XML = null;
         this.var_717 = new Object();
         for each(element in data.newparam)
         {
            param = new name_754(element,document);
            this.var_717[param.sid] = param;
         }
         this.var_718 = new Object();
         for each(element in data.profile_COMMON.newparam)
         {
            param = new name_754(element,document);
            this.var_718[param.sid] = param;
         }
         this.var_719 = new Object();
         technique = data.profile_COMMON.technique[0];
         if(technique != null)
         {
            for each(element in technique.newparam)
            {
               param = new name_754(element,document);
               this.var_719[param.sid] = param;
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
                  this.emission = new name_775(emissionXML,this);
               }
            }
            if(diffuseXML != null)
            {
               this.diffuse = new name_775(diffuseXML,this);
            }
            if(shader.localName() == "phong" || shader.localName() == "blinn")
            {
               specularXML = shader.specular[0];
               if(specularXML != null)
               {
                  this.specular = new name_775(specularXML,this);
               }
            }
            transparentXML = shader.transparent[0];
            if(transparentXML != null)
            {
               this.transparent = new name_775(transparentXML,this);
            }
            transparencyXML = shader.transparency[0];
            if(transparencyXML != null)
            {
               this.transparency = new name_775(transparencyXML,this);
            }
            ambientXML = shader.ambient[0];
            if(ambientXML != null)
            {
               this.ambient = new name_775(ambientXML,this);
            }
            reflectiveXML = shader.reflective[0];
            if(reflectiveXML != null)
            {
               this.reflective = new name_775(reflectiveXML,this);
            }
         }
         bumpXML = data.profile_COMMON.technique.extra.technique.(Boolean(hasOwnProperty("@profile")) && @profile == "OpenCOLLADA3dsMax").bump[0];
         if(bumpXML != null)
         {
            this.bump = new name_775(bumpXML,this);
         }
         return true;
      }
      
      internal function method_893(name:String, setparams:Object) : name_754
      {
         var param:name_754 = setparams[name];
         if(param != null)
         {
            return param;
         }
         param = this.var_719[name];
         if(param != null)
         {
            return param;
         }
         param = this.var_718[name];
         if(param != null)
         {
            return param;
         }
         return this.var_717[name];
      }
      
      private function method_892(value:Array, alpha:Boolean = true) : uint
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
      
      public function name_755(setparams:Object) : name_641
      {
         var material:name_641 = null;
         if(this.diffuse != null)
         {
            material = new name_641();
            if(Boolean(this.diffuse))
            {
               this.method_890(material,this.diffuse,setparams);
            }
            if(this.specular != null)
            {
               this.method_890(material,this.specular,setparams);
            }
            if(this.emission != null)
            {
               this.method_890(material,this.emission,setparams);
            }
            if(this.transparency != null)
            {
               material.transparency = this.transparency.name_777(setparams);
            }
            if(this.transparent != null)
            {
               this.method_890(material,this.transparent,setparams);
            }
            if(this.bump != null)
            {
               this.method_890(material,this.bump,setparams);
            }
            if(Boolean(this.ambient))
            {
               this.method_890(material,this.ambient,setparams);
            }
            if(Boolean(this.reflective))
            {
               this.method_890(material,this.reflective,setparams);
            }
            return material;
         }
         return null;
      }
      
      private function method_890(material:name_641, param:name_775, setparams:Object) : void
      {
         var image:name_734 = null;
         var color:Array = param.method_273(setparams);
         if(color != null)
         {
            material.colors[name_708(param.data.localName())] = this.method_892(color,true);
         }
         else
         {
            image = param.method_604(setparams);
            if(image != null)
            {
               material.textures[name_708(param.data.localName())] = new name_167(name_708(image.init_from));
            }
         }
      }
      
      public function get var_698() : String
      {
         var channel:String = null;
         channel = channel == null && this.diffuse != null ? this.diffuse.name_776 : channel;
         channel = channel == null && this.transparent != null ? this.transparent.name_776 : channel;
         channel = channel == null && this.bump != null ? this.bump.name_776 : channel;
         channel = channel == null && this.emission != null ? this.emission.name_776 : channel;
         return channel == null && this.specular != null ? this.specular.name_776 : channel;
      }
   }
}

