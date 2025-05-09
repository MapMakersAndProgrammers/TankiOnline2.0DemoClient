package alternativa.tanks.game.subsystems.rendersystem
{
   import alternativa.engine3d.core.Object3D;
   import alternativa.engine3d.lights.SpotLight;
   
   public class SpotLightList
   {
      private var container:Object3D;
      
      private var var_16:Vector.<SpotLight>;
      
      public function SpotLightList(container:Object3D)
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
      
      public function getLightAt(i:int) : SpotLight
      {
         return this.var_16[i];
      }
   }
}

