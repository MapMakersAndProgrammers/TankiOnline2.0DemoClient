package package_18
{
   public class name_86
   {
      public var renderers:Vector.<name_82> = new Vector.<name_82>();
      
      public var numRenderers:int;
      
      public function name_86()
      {
         super();
      }
      
      public function add(renderer:name_82) : void
      {
         if(this.renderers.indexOf(renderer) >= 0)
         {
            throw new Error("Renderer " + renderer + " already exists");
         }
         var _loc2_:* = this.numRenderers++;
         this.renderers[_loc2_] = renderer;
      }
      
      public function remove(renderer:name_82) : void
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

