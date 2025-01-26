package package_18
{
   import package_21.name_78;
   import package_24.SpotLight;
   
   public class name_422
   {
      private var container:name_78;
      
      private var var_16:Vector.<SpotLight>;
      
      public function name_422(container:name_78)
      {
         super();
         this.container = container;
         this.var_16 = new Vector.<SpotLight>();
      }
      
      public function add(light:SpotLight) : void
      {
         if(this.var_16.indexOf(light) < 0)
         {
            this.var_16.push(light);
            this.container.addChild(light);
         }
      }
      
      public function remove(light:SpotLight) : void
      {
         var index:int = int(this.var_16.indexOf(light));
         if(index >= 0)
         {
            this.var_16[index] = this.var_16[this.var_16.length - 1];
            this.var_16.length -= 1;
         }
      }
      
      public function get size() : int
      {
         return this.var_16.length;
      }
      
      public function get lights() : Vector.<SpotLight>
      {
         return Vector.<SpotLight>(this.var_16);
      }
      
      public function method_645(i:int) : SpotLight
      {
         return this.var_16[i];
      }
   }
}

