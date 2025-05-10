package alternativa.tanks.game.subsystems.rendersystem
{
   import alternativa.engine3d.core.Object3D;
   import alternativa.engine3d.lights.OmniLight;
   
   public class OmniLightList
   {
      private var container:Object3D;
      
      private var name_9k:Vector.<OmniLight>;
      
      public function OmniLightList(container:Object3D)
      {
         super();
         this.container = container;
         this.name_9k = new Vector.<OmniLight>();
      }
      
      public function add(light:OmniLight) : void
      {
         if(this.name_9k.indexOf(light) < 0)
         {
            this.name_9k.push(light);
            this.container.addChild(light);
         }
      }
      
      public function remove(light:OmniLight) : void
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
      
      public function get lights() : Vector.<OmniLight>
      {
         return Vector.<OmniLight>(this.name_9k);
      }
      
      public function getLightAt(i:int) : OmniLight
      {
         return this.name_9k[i];
      }
   }
}

