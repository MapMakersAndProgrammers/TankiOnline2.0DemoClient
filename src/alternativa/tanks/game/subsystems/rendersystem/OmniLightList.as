package alternativa.tanks.game.subsystems.rendersystem
{
   import alternativa.engine3d.core.Object3D;
   import alternativa.engine3d.lights.OmniLight;
   
   public class OmniLightList
   {
      private var container:Object3D;
      
      private var §_-9k§:Vector.<OmniLight>;
      
      public function OmniLightList(container:Object3D)
      {
         super();
         this.container = container;
         this.§_-9k§ = new Vector.<OmniLight>();
      }
      
      public function add(light:OmniLight) : void
      {
         if(this.§_-9k§.indexOf(light) < 0)
         {
            this.§_-9k§.push(light);
            this.container.addChild(light);
         }
      }
      
      public function remove(light:OmniLight) : void
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
      
      public function get lights() : Vector.<OmniLight>
      {
         return Vector.<OmniLight>(this.§_-9k§);
      }
      
      public function getLightAt(i:int) : OmniLight
      {
         return this.§_-9k§[i];
      }
   }
}

