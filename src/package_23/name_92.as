package package_23
{
   import alternativa.engine3d.alternativa3d;
   import flash.utils.Dictionary;
   import package_21.name_78;
   
   use namespace alternativa3d;
   
   public class name_92
   {
      private static const MAX_SHADOWMAPS:int = 3;
      
      public var renderers:Vector.<name_103> = new Vector.<name_103>();
      
      private var var_12:Dictionary = new Dictionary();
      
      private var var_159:int;
      
      private var var_158:int;
      
      private var var_160:Vector.<name_103> = new Vector.<name_103>();
      
      private var var_161:int;
      
      public function name_92()
      {
         super();
      }
      
      public function update(root:name_78) : void
      {
         var renderer:name_103 = null;
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
               this.var_160[this.var_158] = renderer;
               ++this.var_158;
            }
            i++;
         }
         if(root.alternativa3d::transformChanged)
         {
            root.alternativa3d::composeTransforms();
         }
         root.alternativa3d::localToGlobalTransform.copy(root.alternativa3d::transform);
         this.var_159 = 0;
         this.var_161 = 0;
         this.method_259(root);
      }
      
      private function method_259(object:name_78) : void
      {
         var value:Vector.<name_103> = null;
         var numRenderers:int = 0;
         var i:int = 0;
         var renderer:name_103 = null;
         for(var child:name_78 = object.alternativa3d::childrenList; child != null; child = child.alternativa3d::next)
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
                  renderer = this.var_160[i];
                  if(child.useShadow)
                  {
                     if(child.boundBox == null || Boolean(renderer.alternativa3d::cullReciever(child.boundBox,child)))
                     {
                        ++this.var_159;
                        if(value == null)
                        {
                           value = this.var_12[child];
                           if(value == null)
                           {
                              value = new Vector.<name_103>();
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
               this.method_259(child);
            }
            this.method_260(child,value,numRenderers);
         }
      }
      
      private function method_260(object:name_78, renderers:Vector.<name_103>, numShadowRenderers:int) : void
      {
         if(numShadowRenderers > this.var_161)
         {
            this.var_161 = numShadowRenderers;
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

