package package_123
{
   import package_116.name_641;
   
   use namespace collada;
   
   public class name_713 extends class_43
   {
      public var material:name_641;
      
      public var var_698:String;
      
      public var used:Boolean = false;
      
      public function name_713(data:XML, document:name_707)
      {
         super(data,document);
      }
      
      private function method_869() : Object
      {
         var element:XML = null;
         var param:name_754 = null;
         var params:Object = new Object();
         var list:XMLList = data.instance_effect.setparam;
         for each(element in list)
         {
            param = new name_754(element,document);
            params[param.ref] = param;
         }
         return params;
      }
      
      private function get method_868() : XML
      {
         return data.instance_effect.@url[0];
      }
      
      override protected function parseImplementation() : Boolean
      {
         var effect:name_738 = document.findEffect(this.method_868);
         if(effect != null)
         {
            effect.method_314();
            this.material = effect.name_755(this.method_869());
            this.var_698 = effect.var_698;
            if(this.material != null)
            {
               this.material.name = name_708(name);
            }
            return true;
         }
         return false;
      }
   }
}

