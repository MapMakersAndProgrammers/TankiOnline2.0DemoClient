package alternativa.tanks.game.entities.tank.graphics.materials
{
   import alternativa.engine3d.alternativa3d;
   import package_19.name_117;
   import package_21.name_116;
   import package_21.name_124;
   import package_21.name_128;
   import package_21.name_135;
   import package_28.name_119;
   import package_28.name_129;
   import package_30.name_114;
   import package_30.name_121;
   import package_4.class_4;
   import package_4.class_9;
   
   use namespace alternativa3d;
   
   public class TreesMaterial extends class_9
   {
      public static const DISABLED:int = 0;
      
      public static const SIMPLE:int = 1;
      
      public static const ADVANCED:int = 2;
      
      private static const uvProcedure:name_114 = name_114.name_140(["#v0=vUV","#a0=aUV","#c0=cUVOffsets","add v0, a0, c0"]);
      
      public var alphaThreshold:Number = 1;
      
      public var uOffset:Number = 0;
      
      public var vOffset:Number = 0;
      
      public function TreesMaterial(diffuseMap:name_129 = null, normalMap:name_129 = null, specularMap:name_129 = null, glossinessMap:name_129 = null, opacityMap:name_129 = null, alphaThreshold:Number = 1)
      {
         super(diffuseMap,normalMap,specularMap,glossinessMap,opacityMap);
         alternativa3d::outputAlpha = new name_114(["#c0=cSurface","sub t0.w, i0.w, c0.w","kil t0.w","mov o0, i0"],"outputAlpha");
         alternativa3d::outputDiffuseAlpha = alternativa3d::outputAlpha;
         alternativa3d::outputOpacity = new name_114(["#c0=cSurface","#s0=sOpacity","#v0=vUV","tex t0, v0, s0 <2d, repeat,linear,miplinear>","mov i0.w, t0.x","sub t0.x, t0.x, c0.w","kil t0.x","mov o0, i0"],"outputOpacity");
         this.alphaThreshold = alphaThreshold;
         this.alternativa3d::var_54 = true;
      }
      
      public static function get fogMode() : int
      {
         return class_9.alternativa3d::fogMode;
      }
      
      public static function set fogMode(value:int) : void
      {
         class_9.alternativa3d::fogMode = value;
      }
      
      public static function get fogNear() : Number
      {
         return class_9.alternativa3d::fogNear;
      }
      
      public static function set fogNear(value:Number) : void
      {
         class_9.alternativa3d::fogNear = value;
      }
      
      public static function get fogFar() : Number
      {
         return class_9.alternativa3d::fogFar;
      }
      
      public static function set fogFar(value:Number) : void
      {
         class_9.alternativa3d::fogFar = value;
      }
      
      public static function get fogMaxDensity() : Number
      {
         return class_9.alternativa3d::fogMaxDensity;
      }
      
      public static function set fogMaxDensity(value:Number) : void
      {
         class_9.alternativa3d::fogMaxDensity = value;
      }
      
      public static function get fogColorR() : Number
      {
         return class_9.alternativa3d::fogColorR;
      }
      
      public static function set fogColorR(value:Number) : void
      {
         class_9.alternativa3d::fogColorR = value;
      }
      
      public static function get fogColorG() : Number
      {
         return class_9.alternativa3d::fogColorG;
      }
      
      public static function set fogColorG(value:Number) : void
      {
         class_9.alternativa3d::fogColorG = value;
      }
      
      public static function get fogColorB() : Number
      {
         return class_9.alternativa3d::fogColorB;
      }
      
      public static function set fogColorB(value:Number) : void
      {
         class_9.alternativa3d::fogColorB = value;
      }
      
      public static function method_33(texture:name_129) : void
      {
         class_9.alternativa3d::fogTexture = texture;
      }
      
      override alternativa3d function getPassUVProcedure() : name_114
      {
         return uvProcedure;
      }
      
      override alternativa3d function setPassUVProcedureConstants(destination:name_135, vertexLinker:name_121) : void
      {
         destination.alternativa3d::name_144(vertexLinker.getVariableIndex("cUVOffsets"),-this.uOffset,this.vOffset,0,0);
      }
      
      override alternativa3d function collectDraws(camera:name_124, surface:name_117, geometry:name_119, lights:Vector.<name_116>, lightsLength:int, objectRenderPriority:int = -1) : void
      {
         lightsLength = lightsLength > 5 ? 5 : lightsLength;
         alpha = 1 - this.alphaThreshold;
         super.alternativa3d::collectDraws(camera,surface,geometry,lights,lightsLength,name_128.TANK_OPAQUE);
      }
      
      override public function clone() : class_4
      {
         var cloned:TreesMaterial = new TreesMaterial(diffuseMap,normalMap,specularMap,glossinessMap);
         cloned.opacityMap = opacityMap;
         cloned.alpha = alpha;
         cloned.var_21 = var_21;
         cloned.glossiness = glossiness;
         cloned.var_25 = var_25;
         cloned.method_124 = method_124;
         cloned.uOffset = this.uOffset;
         cloned.vOffset = this.vOffset;
         cloned.alphaThreshold = this.alphaThreshold;
         return cloned;
      }
   }
}

