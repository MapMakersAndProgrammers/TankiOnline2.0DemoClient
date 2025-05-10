package alternativa.tanks.game.subsystems.rendersystem
{
   import alternativa.engine3d.core.Object3D;
   import alternativa.engine3d.lights.SpotLight;
   
   public class SpotLightList
   {
      private var container:Object3D;
      
      private var name_9k:Vector.<SpotLight>;
      
      public function SpotLightList(container:Object3D)
      {
         super();
         this.container = container;
         this.name_9k = new Vector.<SpotLight>();
      }
      
      public function add(light:SpotLight) : void
      {
         if(this.name_9k.indexOf(light) < 0)
         {
            this.name_9k.push(light);
            this.container.addChild(light);
         }
      }
      
      public function remove(light:SpotLight) : void
      {
         var index:int = int(this.name_9k.indexOf(light));
         if(index >= 0)
         {
            this.name_9k[index] = this.name_9k[this.name_9k.length - 1];
            this.name_9k.length -= 1;
         }
      }
      
      public function get size() : int
      {
         return this.name_9k.length;
      }
      
      public function get lights() : Vector.<SpotLight>
      {
         return Vector.<SpotLight>(this.name_9k);
      }
      
      public function getLightAt(i:int) : SpotLight
      {
         return this.name_9k[i];
      }
   }
}

