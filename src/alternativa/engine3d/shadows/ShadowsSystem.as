package alternativa.engine3d.shadows
{
   import alternativa.engine3d.alternativa3d;
   import alternativa.engine3d.core.Object3D;
   import flash.utils.Dictionary;
   
   use namespace alternativa3d;
   
   public class ShadowsSystem
   {
      private static const MAX_SHADOWMAPS:int = 3;
      
      public var renderers:Vector.<ShadowRenderer> = new Vector.<ShadowRenderer>();
      
      private var §_-jy§:Dictionary = new Dictionary();
      
      private var §_-gR§:int;
      
      private var §_-i-§:int;
      
      private var §_-O0§:Vector.<ShadowRenderer> = new Vector.<ShadowRenderer>();
      
      private var §_-aJ§:int;
      
      public function ShadowsSystem()
      {
         super();
      }
      
      public function update(root:Object3D) : void
      {
         var renderer:ShadowRenderer = null;
         if(this.renderers.length == 0)
         {
            return;
         }
         this.§_-i-§ = 0;
         var num:int = int(this.renderers.length);
         for(var i:int = 0; i < num; )
         {
            renderer = this.renderers[i];
            renderer.update();
            if(renderer.active)
            {
               this.§_-O0§[this.§_-i-§] = renderer;
               ++this.§_-i-§;
            }
            i++;
         }
         if(root.alternativa3d::transformChanged)
         {
            root.alternativa3d::composeTransforms();
         }
         root.alternativa3d::localToGlobalTransform.copy(root.alternativa3d::transform);
         this.§_-gR§ = 0;
         this.§_-aJ§ = 0;
         this.recursive(root);
      }
      
      private function recursive(object:Object3D) : void
      {
         var value:Vector.<ShadowRenderer> = null;
         var numRenderers:int = 0;
         var i:int = 0;
         var renderer:ShadowRenderer = null;
         for(var child:Object3D = object.alternativa3d::childrenList; child != null; child = child.alternativa3d::next)
         {
            value = null;
            numRenderers = 0;
            if(child.visible)
            {
               if(child.alternativa3d::transformChanged)
               {
                  child.alternativa3d::composeTransforms();
               }
               child.alternativa3d::localToGlobalTransform.combine(object.alternativa3d::localToGlobalTransform,child.alternativa3d::transform);
               for(i = 0; i < this.§_-i-§; )
               {
                  renderer = this.§_-O0§[i];
                  if(child.useShadow)
                  {
                     if(child.boundBox == null || renderer.alternativa3d::cullReciever(child.boundBox,child))
                     {
                        ++this.§_-gR§;
                        if(value == null)
                        {
                           value = this.§_-jy§[child];
                           if(value == null)
                           {
                              value = new Vector.<ShadowRenderer>();
                              this.§_-jy§[child] = value;
                           }
                           else
                           {
                              value.length = 0;
                           }
                        }
                        value[numRenderers] = renderer;
                        numRenderers++;
                     }
                  }
                  i++;
               }
               this.recursive(child);
            }
            this.setRenderers(child,value,numRenderers);
         }
      }
      
      private function setRenderers(object:Object3D, renderers:Vector.<ShadowRenderer>, numShadowRenderers:int) : void
      {
         if(numShadowRenderers > this.§_-aJ§)
         {
            this.§_-aJ§ = numShadowRenderers;
         }
         if(numShadowRenderers > MAX_SHADOWMAPS)
         {
            numShadowRenderers = MAX_SHADOWMAPS;
            renderers.length = MAX_SHADOWMAPS;
         }
         object.alternativa3d::shadowRenderers = renderers;
         object.alternativa3d::numShadowRenderers = numShadowRenderers;
      }
   }
}

