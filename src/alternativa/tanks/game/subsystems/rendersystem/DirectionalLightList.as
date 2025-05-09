package alternativa.tanks.game.subsystems.rendersystem
{
   import alternativa.engine3d.core.Object3D;
   import alternativa.engine3d.lights.DirectionalLight;
   
   public class DirectionalLightList
   {
      private var container:Object3D;
      
      private var var_16:Vector.<DirectionalLight>;
      
      public function DirectionalLightList(container:Object3D)
      {
         super();
         this.container = container;
         this.var_16 = new Vector.<DirectionalLight>();
      }
      
      public function add(light:DirectionalLight) : void
      {
         if(this.var_16.indexOf(light) < 0)
         {
            this.var_16.push(light);
            this.container.addChild(light);
         }
      }
      
      public function remove(light:DirectionalLight) : void
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
      
      public function get lights() : Vector.<DirectionalLight>
      {
         return Vector.<DirectionalLight>(this.var_16);
      }
      
      public function getLightAt(i:int) : DirectionalLight
      {
         return this.var_16[i];
      }
   }
}

