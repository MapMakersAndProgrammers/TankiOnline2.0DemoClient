package package_18
{
   import package_21.name_78;
   import package_24.OmniLight;
   
   public class name_424
   {
      private var container:name_78;
      
      private var var_16:Vector.<OmniLight>;
      
      public function name_424(container:name_78)
      {
         super();
         this.container = container;
         this.var_16 = new Vector.<OmniLight>();
      }
      
      public function add(light:OmniLight) : void
      {
         if(this.var_16.indexOf(light) < 0)
         {
            this.var_16.push(light);
            this.container.addChild(light);
         }
      }
      
      public function remove(light:OmniLight) : void
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
      
      public function get lights() : Vector.<OmniLight>
      {
         return Vector.<OmniLight>(this.var_16);
      }
      
      public function method_645(i:int) : OmniLight
      {
         return this.var_16[i];
      }
   }
}

