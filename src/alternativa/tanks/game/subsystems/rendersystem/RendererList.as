package alternativa.tanks.game.subsystems.rendersystem
{
   public class RendererList
   {
      public var renderers:Vector.<IRenderer> = new Vector.<IRenderer>();
      
      public var numRenderers:int;
      
      public function RendererList()
      {
         super();
      }
      
      public function add(renderer:IRenderer) : void
      {
         if(this.renderers.indexOf(renderer) >= 0)
         {
            throw new Error("Renderer " + renderer + " already exists");
         }
         var _loc2_:* = this.numRenderers++;
         this.renderers[_loc2_] = renderer;
      }
      
      public function remove(renderer:IRenderer) : void
      {
         var index:int = int(this.renderers.indexOf(renderer));
         if(index < 0)
         {
            throw new Error("Renderer " + renderer + " not found");
         }
         this.renderers[index] = this.renderers[--this.numRenderers];
         this.renderers[this.numRenderers] = null;
      }
   }
}

