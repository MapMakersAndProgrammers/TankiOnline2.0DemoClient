package alternativa.tanks.game.subsystems.rendersystem
{
   import alternativa.engine3d.core.Object3D;
   import alternativa.engine3d.lights.DirectionalLight;
   
   public class DirectionalLightList
   {
      private var container:Object3D;
      
      private var §_-9k§:Vector.<DirectionalLight>;
      
      public function DirectionalLightList(container:Object3D)
      {
         super();
         this.container = container;
         this.§_-9k§ = new Vector.<DirectionalLight>();
      }
      
      public function add(light:DirectionalLight) : void
      {
         if(this.§_-9k§.indexOf(light) < 0)
         {
            this.§_-9k§.push(light);
            this.container.addChild(light);
         }
      }
      
      public function remove(light:DirectionalLight) : void
      {
         var index:int = int(this.§_-9k§.indexOf(light));
         if(index >= 0)
         {
            this.§_-9k§[index] = this.§_-9k§[this.§_-9k§.length - 1];
            this.§_-9k§.length -= 1;
         }
      }
      
      public function get size() : int
      {
         return this.§_-9k§.length;
      }
      
      public function get lights() : Vector.<DirectionalLight>
      {
         return Vector.<DirectionalLight>(this.§_-9k§);
      }
      
      public function getLightAt(i:int) : DirectionalLight
      {
         return this.§_-9k§[i];
      }
   }
}

