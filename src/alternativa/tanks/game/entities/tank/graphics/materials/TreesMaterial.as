package alternativa.tanks.game.entities.tank.graphics.materials
{
   import alternativa.engine3d.alternativa3d;
   import alternativa.engine3d.core.Camera3D;
   import alternativa.engine3d.core.DrawUnit;
   import alternativa.engine3d.core.Light3D;
   import alternativa.engine3d.core.RenderPriority;
   import alternativa.engine3d.materials.Material;
   import alternativa.engine3d.materials.StandardMaterial;
   import alternativa.engine3d.materials.compiler.Linker;
   import alternativa.engine3d.materials.compiler.Procedure;
   import alternativa.engine3d.objects.Surface;
   import alternativa.engine3d.resources.Geometry;
   import alternativa.engine3d.resources.TextureResource;
   
   use namespace alternativa3d;
   
   public class TreesMaterial extends StandardMaterial
   {
      public static const DISABLED:int = 0;
      
      public static const SIMPLE:int = 1;
      
      public static const ADVANCED:int = 2;
      
      private static const uvProcedure:Procedure = Procedure.compileFromArray(["#v0=vUV","#a0=aUV","#c0=cUVOffsets","add v0, a0, c0"]);
      
      public var alphaThreshold:Number = 1;
      
      public var uOffset:Number = 0;
      
      public var vOffset:Number = 0;
      
      public function TreesMaterial(diffuseMap:TextureResource = null, normalMap:TextureResource = null, specularMap:TextureResource = null, glossinessMap:TextureResource = null, opacityMap:TextureResource = null, alphaThreshold:Number = 1)
      {
         super(diffuseMap,normalMap,specularMap,glossinessMap,opacityMap);
         alternativa3d::outputAlpha = new Procedure(["#c0=cSurface","sub t0.w, i0.w, c0.w","kil t0.w","mov o0, i0"],"outputAlpha");
         alternativa3d::outputDiffuseAlpha = alternativa3d::outputAlpha;
         alternativa3d::outputOpacity = new Procedure(["#c0=cSurface","#s0=sOpacity","#v0=vUV","tex t0, v0, s0 <2d, repeat,linear,miplinear>","mov i0.w, t0.x","sub t0.x, t0.x, c0.w","kil t0.x","mov o0, i0"],"outputOpacity");
         this.alphaThreshold = alphaThreshold;
         this.name_ES = true;
      }
      
      public static function get fogMode() : int
      {
         return StandardMaterial.alternativa3d::fogMode;
      }
      
      public static function set fogMode(value:int) : void
      {
         StandardMaterial.alternativa3d::fogMode = value;
      }
      
      public static function get fogNear() : Number
      {
         return StandardMaterial.alternativa3d::fogNear;
      }
      
      public static function set fogNear(value:Number) : void
      {
         StandardMaterial.alternativa3d::fogNear = value;
      }
      
      public static function get fogFar() : Number
      {
         return StandardMaterial.alternativa3d::fogFar;
      }
      
      public static function set fogFar(value:Number) : void
      {
         StandardMaterial.alternativa3d::fogFar = value;
      }
      
      public static function get fogMaxDensity() : Number
      {
         return StandardMaterial.alternativa3d::fogMaxDensity;
      }
      
      public static function set fogMaxDensity(value:Number) : void
      {
         StandardMaterial.alternativa3d::fogMaxDensity = value;
      }
      
      public static function get fogColorR() : Number
      {
         return StandardMaterial.alternativa3d::fogColorR;
      }
      
      public static function set fogColorR(value:Number) : void
      {
         StandardMaterial.alternativa3d::fogColorR = value;
      }
      
      public static function get fogColorG() : Number
      {
         return StandardMaterial.alternativa3d::fogColorG;
      }
      
      public static function set fogColorG(value:Number) : void
      {
         StandardMaterial.alternativa3d::fogColorG = value;
      }
      
      public static function get fogColorB() : Number
      {
         return StandardMaterial.alternativa3d::fogColorB;
      }
      
      public static function set fogColorB(value:Number) : void
      {
         StandardMaterial.alternativa3d::fogColorB = value;
      }
      
      public static function setFogTexture(texture:TextureResource) : void
      {
         StandardMaterial.alternativa3d::fogTexture = texture;
      }
      
      override alternativa3d function getPassUVProcedure() : Procedure
      {
         return uvProcedure;
      }
      
      override alternativa3d function setPassUVProcedureConstants(destination:DrawUnit, vertexLinker:Linker) : void
      {
         destination.alternativa3d::setVertexConstantsFromNumbers(vertexLinker.getVariableIndex("cUVOffsets"),-this.uOffset,this.vOffset,0,0);
      }
      
      override alternativa3d function collectDraws(camera:Camera3D, surface:Surface, geometry:Geometry, lights:Vector.<Light3D>, lightsLength:int, objectRenderPriority:int = -1) : void
      {
         lightsLength = lightsLength > 5 ? 5 : lightsLength;
         alpha = 1 - this.alphaThreshold;
         super.alternativa3d::collectDraws(camera,surface,geometry,lights,lightsLength,RenderPriority.TANK_OPAQUE);
      }
      
      override public function clone() : Material
      {
         var cloned:TreesMaterial = new TreesMaterial(diffuseMap,normalMap,specularMap,glossinessMap);
         cloned.opacityMap = opacityMap;
         cloned.alpha = alpha;
         cloned.name_L4 = name_L4;
         cloned.glossiness = glossiness;
         cloned.name_kj = name_kj;
         cloned.normalMapSpace = normalMapSpace;
         cloned.uOffset = this.uOffset;
         cloned.vOffset = this.vOffset;
         cloned.alphaThreshold = this.alphaThreshold;
         return cloned;
      }
   }
}

