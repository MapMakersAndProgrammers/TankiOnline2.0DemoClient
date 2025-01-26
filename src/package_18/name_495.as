package package_18
{
   import alternativa.engine3d.alternativa3d;
   import package_19.name_117;
   import package_21.name_116;
   import package_21.name_124;
   import package_28.name_119;
   import package_28.name_129;
   import package_4.class_5;
   
   use namespace alternativa3d;
   
   public class name_495 extends class_5
   {
      public var blendModeSource:String = "one";
      
      public var blendModeDestination:String = "zero";
      
      public function name_495(diffuseMap:name_129 = null, opacityMap:name_129 = null, alpha:Number = 1, blendModeSource:String = "one", blendModeDestination:String = "zero")
      {
         super(diffuseMap,opacityMap,alpha);
         this.blendModeSource = blendModeSource;
         this.blendModeDestination = blendModeDestination;
      }
      
      override alternativa3d function collectDraws(camera:name_124, surface:name_117, geometry:name_119, lights:Vector.<name_116>, lightsLength:int, objectRenderPriority:int = -1) : void
      {
      }
   }
}

