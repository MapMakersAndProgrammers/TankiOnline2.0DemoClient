package alternativa.engine3d.loaders.collada
{
   import alternativa.engine3d.loaders.ParserMaterial;
   
   use namespace collada;
   
   public class DaeMaterial extends DaeElement
   {
      public var material:ParserMaterial;
      
      public var mainTexCoords:String;
      
      public var used:Boolean = false;
      
      public function DaeMaterial(data:XML, document:DaeDocument)
      {
         super(data,document);
      }
      
      private function parseSetParams() : Object
      {
         var element:XML = null;
         var param:DaeParam = null;
         var params:Object = new Object();
         var list:XMLList = data.instance_effect.setparam;
         for each(element in list)
         {
            param = new DaeParam(element,document);
            params[param.ref] = param;
         }
         return params;
      }
      
      private function get effectURL() : XML
      {
         return data.instance_effect.@url[0];
      }
      
      override protected function parseImplementation() : Boolean
      {
         var effect:DaeEffect = document.findEffect(this.effectURL);
         if(effect != null)
         {
            effect.parse();
            this.material = effect.getMaterial(this.parseSetParams());
            this.mainTexCoords = effect.mainTexCoords;
            if(this.material != null)
            {
               this.material.name = cloneString(name);
            }
            return true;
         }
         return false;
      }
   }
}

