package package_18
{
   import flash.display3D.Context3D;
   import package_21.name_78;
   import package_23.name_97;
   import package_24.DirectionalLight;
   
   public class name_96
   {
      private var staticShadowRenderer:name_97;
      
      private var container:name_78;
      
      private var light:DirectionalLight;
      
      public function name_96(staticShadowRenderer:name_97, container:name_78, light:DirectionalLight)
      {
         super();
         this.staticShadowRenderer = staticShadowRenderer;
         this.container = container;
         this.light = light;
      }
      
      public function execute(context3D:Context3D) : void
      {
         context3D.configureBackBuffer(50,50,0);
         this.staticShadowRenderer.name_401(this.container,this.light,5,3,1000);
         this.light.shadow = this.staticShadowRenderer;
      }
   }
}

