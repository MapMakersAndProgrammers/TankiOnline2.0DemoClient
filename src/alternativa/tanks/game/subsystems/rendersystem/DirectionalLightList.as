package alternativa.tanks.game.subsystems.rendersystem
{
   import alternativa.engine3d.core.Object3D;
   import alternativa.engine3d.lights.DirectionalLight;
   
   public class DirectionalLightList
   {
      private var container:Object3D;
      
      private var name_9k:Vector.<DirectionalLight>;
      
      public function DirectionalLightList(container:Object3D)
      {
         super();
         this.container = container;
         this.name_9k = new Vector.<DirectionalLight>();
      }
      
      public function add(light:DirectionalLight) : void
      {
         if(this.name_9k.indexOf(light) < 0)
         {
            this.name_9k.push(light);
            this.container.addChild(light);
         }
      }
      
      public function remove(light:DirectionalLight) : void
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
      
      public function get lights() : Vector.<DirectionalLight>
      {
         return Vector.<DirectionalLight>(this.name_9k);
      }
      
      public function getLightAt(i:int) : DirectionalLight
      {
         return this.name_9k[i];
      }
   }
}

