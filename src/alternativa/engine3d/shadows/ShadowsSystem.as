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
      
      private var var_12:Dictionary = new Dictionary();
      
      private var var_161:int;
      
      private var var_158:int;
      
      private var var_159:Vector.<ShadowRenderer> = new Vector.<ShadowRenderer>();
      
      private var var_160:int;
      
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
         this.var_158 = 0;
         var num:int = int(this.renderers.length);
         for(var i:int = 0; i < num; )
         {
            renderer = this.renderers[i];
            renderer.update();
            if(renderer.active)
            {
               this.var_159[this.var_158] = renderer;
               ++this.var_158;
            }
            i++;
         }
         if(root.alternativa3d::transformChanged)
         {
            root.alternativa3d::composeTransforms();
         }
         root.alternativa3d::localToGlobalTransform.copy(root.alternativa3d::transform);
         this.var_161 = 0;
         this.var_160 = 0;
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
               for(i = 0; i < this.var_158; )
               {
                  renderer = this.var_159[i];
                  if(child.useShadow)
                  {
                     if(child.boundBox == null || renderer.alternativa3d::cullReciever(child.boundBox,child))
                     {
                        ++this.var_161;
                        if(value == null)
                        {
                           value = this.var_12[child];
                           if(value == null)
                           {
                              value = new Vector.<ShadowRenderer>();
                              this.var_12[child] = value;
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
         if(numShadowRenderers > this.var_160)
         {
            this.var_160 = numShadowRenderers;
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

