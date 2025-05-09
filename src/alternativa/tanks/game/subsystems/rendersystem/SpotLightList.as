package alternativa.tanks.game.subsystems.rendersystem
{
   import alternativa.engine3d.core.Object3D;
   import alternativa.engine3d.lights.SpotLight;
   
   public class SpotLightList
   {
      private var container:Object3D;
      
      private var §_-9k§:Vector.<SpotLight>;
      
      public function SpotLightList(container:Object3D)
      {
         super();
         this.container = container;
         this.§_-9k§ = new Vector.<SpotLight>();
      }
      
      public function add(light:SpotLight) : void
      {
         if(this.§_-9k§.indexOf(light) < 0)
         {
            this.§_-9k§.push(light);
            this.container.addChild(light);
         }
      }
      
      public function remove(light:SpotLight) : void
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
      
      public function get lights() : Vector.<SpotLight>
      {
         return Vector.<SpotLight>(this.§_-9k§);
      }
      
      public function getLightAt(i:int) : SpotLight
      {
         return this.§_-9k§[i];
      }
   }
}

