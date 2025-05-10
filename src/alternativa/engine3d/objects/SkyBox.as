package alternativa.engine3d.objects
{
   import alternativa.engine3d.alternativa3d;
   import alternativa.engine3d.core.Camera3D;
   import alternativa.engine3d.core.DrawUnit;
   import alternativa.engine3d.core.Light3D;
   import alternativa.engine3d.core.Object3D;
   import alternativa.engine3d.core.RenderPriority;
   import alternativa.engine3d.core.VertexAttributes;
   import alternativa.engine3d.materials.Material;
   import alternativa.engine3d.materials.compiler.Linker;
   import alternativa.engine3d.materials.compiler.Procedure;
   import alternativa.engine3d.resources.Geometry;
   
   use namespace alternativa3d;
   
   public class SkyBox extends Mesh
   {
      public static const LEFT:String = "left";
      
      public static const RIGHT:String = "right";
      
      public static const BACK:String = "back";
      
      public static const FRONT:String = "front";
      
      public static const BOTTOM:String = "bottom";
      
      public static const TOP:String = "top";
      
      private static var transformProcedureStatic:Procedure = new Procedure(["sub t0.xyz, i0.xyz, c0.xyz","mul t0.x, t0.x, c0.w","mul t0.y, t0.y, c0.w","mul t0.z, t0.z, c0.w","add o0.xyz, t0.xyz, c0.xyz","mov o0.w, i0.w","#c0=cTrans"]);
      
      private var name_gj:Surface;
      
      private var name_69:Surface;
      
      private var name_EB:Surface;
      
      private var name_iw:Surface;
      
      private var name_1V:Surface;
      
      private var name_Oz:Surface;
      
      private var size:Number;
      
      public function SkyBox(size:Number, left:Material = null, right:Material = null, back:Material = null, front:Material = null, bottom:Material = null, top:Material = null, uvPadding:Number = 0)
      {
         super();
         size *= 0.5;
         this.size = size;
         geometry = new Geometry(24);
         var attributes:Array = new Array();
         attributes[0] = VertexAttributes.POSITION;
         attributes[1] = VertexAttributes.POSITION;
         attributes[2] = VertexAttributes.POSITION;
         attributes[6] = VertexAttributes.TEXCOORDS[0];
         attributes[7] = VertexAttributes.TEXCOORDS[0];
         geometry.addVertexStream(attributes);
         geometry.setAttributeValues(VertexAttributes.POSITION,Vector.<Number>([-size,-size,size,-size,-size,-size,-size,size,-size,-size,size,size,size,size,size,size,size,-size,size,-size,-size,size,-size,size,size,-size,size,size,-size,-size,-size,-size,-size,-size,-size,size,-size,size,size,-size,size,-size,size,size,-size,size,size,size,-size,size,-size,-size,-size,-size,size,-size,-size,size,size,-size,-size,-size,size,-size,size,size,size,size,size,size,-size,size]));
         geometry.setAttributeValues(VertexAttributes.TEXCOORDS[0],Vector.<Number>([uvPadding,uvPadding,uvPadding,1 - uvPadding,1 - uvPadding,1 - uvPadding,1 - uvPadding,uvPadding,uvPadding,uvPadding,uvPadding,1 - uvPadding,1 - uvPadding,1 - uvPadding,1 - uvPadding,uvPadding,uvPadding,uvPadding,uvPadding,1 - uvPadding,1 - uvPadding,1 - uvPadding,1 - uvPadding,uvPadding,uvPadding,uvPadding,uvPadding,1 - uvPadding,1 - uvPadding,1 - uvPadding,1 - uvPadding,uvPadding,uvPadding,uvPadding,uvPadding,1 - uvPadding,1 - uvPadding,1 - uvPadding,1 - uvPadding,uvPadding,uvPadding,uvPadding,uvPadding,1 - uvPadding,1 - uvPadding,1 - uvPadding,1 - uvPadding,uvPadding]));
         geometry.indices = Vector.<uint>([0,1,3,2,3,1,4,5,7,6,7,5,8,9,11,10,11,9,12,13,15,14,15,13,16,17,19,18,19,17,20,21,23,22,23,21]);
         this.name_gj = addSurface(left,0,2);
         this.name_69 = addSurface(right,6,2);
         this.name_EB = addSurface(back,12,2);
         this.name_iw = addSurface(front,18,2);
         this.name_1V = addSurface(bottom,24,2);
         this.name_Oz = addSurface(top,30,2);
         alternativa3d::transformProcedure = transformProcedureStatic;
      }
      
      override alternativa3d function collectDraws(camera:Camera3D, lights:Vector.<Light3D>, lightsLength:int) : void
      {
         var surface:Surface = null;
         for(var i:int = 0; i < name_Oy; )
         {
            surface = name_eW[i];
            if(surface.material != null)
            {
               surface.material.alternativa3d::collectDraws(camera,surface,geometry,lights,lightsLength,RenderPriority.SKY);
            }
            if(alternativa3d::listening)
            {
               camera.view.alternativa3d::addSurfaceToMouseEvents(surface,geometry,alternativa3d::transformProcedure);
            }
            i++;
         }
      }
      
      override alternativa3d function setTransformConstants(drawUnit:DrawUnit, surface:Surface, vertexShader:Linker, camera:Camera3D) : void
      {
         var dx:Number = NaN;
         var dy:Number = NaN;
         var dz:Number = NaN;
         var len:Number = NaN;
         var max:Number = 0;
         dx = -this.size - alternativa3d::cameraToLocalTransform.d;
         dy = -this.size - alternativa3d::cameraToLocalTransform.h;
         dz = -this.size - alternativa3d::cameraToLocalTransform.l;
         len = dx * dx + dy * dy + dz * dz;
         if(len > max)
         {
            max = len;
         }
         dx = this.size - alternativa3d::cameraToLocalTransform.d;
         dy = -this.size - alternativa3d::cameraToLocalTransform.h;
         dz = -this.size - alternativa3d::cameraToLocalTransform.l;
         len = dx * dx + dy * dy + dz * dz;
         if(len > max)
         {
            max = len;
         }
         dx = this.size - alternativa3d::cameraToLocalTransform.d;
         dy = this.size - alternativa3d::cameraToLocalTransform.h;
         dz = -this.size - alternativa3d::cameraToLocalTransform.l;
         len = dx * dx + dy * dy + dz * dz;
         if(len > max)
         {
            max = len;
         }
         dx = -this.size - alternativa3d::cameraToLocalTransform.d;
         dy = this.size - alternativa3d::cameraToLocalTransform.h;
         dz = -this.size - alternativa3d::cameraToLocalTransform.l;
         len = dx * dx + dy * dy + dz * dz;
         if(len > max)
         {
            max = len;
         }
         dx = -this.size - alternativa3d::cameraToLocalTransform.d;
         dy = -this.size - alternativa3d::cameraToLocalTransform.h;
         dz = this.size - alternativa3d::cameraToLocalTransform.l;
         len = dx * dx + dy * dy + dz * dz;
         if(len > max)
         {
            max = len;
         }
         dx = this.size - alternativa3d::cameraToLocalTransform.d;
         dy = -this.size - alternativa3d::cameraToLocalTransform.h;
         dz = this.size - alternativa3d::cameraToLocalTransform.l;
         len = dx * dx + dy * dy + dz * dz;
         if(len > max)
         {
            max = len;
         }
         dx = this.size - alternativa3d::cameraToLocalTransform.d;
         dy = this.size - alternativa3d::cameraToLocalTransform.h;
         dz = this.size - alternativa3d::cameraToLocalTransform.l;
         len = dx * dx + dy * dy + dz * dz;
         if(len > max)
         {
            max = len;
         }
         dx = -this.size - alternativa3d::cameraToLocalTransform.d;
         dy = this.size - alternativa3d::cameraToLocalTransform.h;
         dz = this.size - alternativa3d::cameraToLocalTransform.l;
         len = dx * dx + dy * dy + dz * dz;
         if(len > max)
         {
            max = len;
         }
         drawUnit.alternativa3d::setVertexConstantsFromNumbers(0,alternativa3d::cameraToLocalTransform.d,alternativa3d::cameraToLocalTransform.h,alternativa3d::cameraToLocalTransform.l,camera.farClipping / Math.sqrt(max));
      }
      
      public function getSide(side:String) : Surface
      {
         switch(side)
         {
            case LEFT:
               return this.name_gj;
            case RIGHT:
               return this.name_69;
            case BACK:
               return this.name_EB;
            case FRONT:
               return this.name_iw;
            case BOTTOM:
               return this.name_1V;
            case TOP:
               return this.name_Oz;
            default:
               return null;
         }
      }
      
      override public function clone() : Object3D
      {
         var res:SkyBox = new SkyBox(0);
         res.clonePropertiesFrom(this);
         return res;
      }
      
      override protected function clonePropertiesFrom(source:Object3D) : void
      {
         var surface:Surface = null;
         var newSurface:Surface = null;
         super.clonePropertiesFrom(source);
         var src:SkyBox = source as SkyBox;
         for(var i:int = 0; i < src.name_Oy; )
         {
            surface = src.name_eW[i];
            newSurface = name_eW[i];
            if(surface == src.name_gj)
            {
               this.name_gj = newSurface;
            }
            else if(surface == src.name_69)
            {
               this.name_69 = newSurface;
            }
            else if(surface == src.name_EB)
            {
               this.name_EB = newSurface;
            }
            else if(surface == src.name_iw)
            {
               this.name_iw = newSurface;
            }
            else if(surface == src.name_1V)
            {
               this.name_1V = newSurface;
            }
            else if(surface == src.name_Oz)
            {
               this.name_Oz = newSurface;
            }
            i++;
         }
      }
   }
}

