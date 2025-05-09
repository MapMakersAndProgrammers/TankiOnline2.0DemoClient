package alternativa.engine3d.objects
{
   import alternativa.engine3d.alternativa3d;
   import alternativa.engine3d.core.Camera3D;
   import alternativa.engine3d.core.Debug;
   import alternativa.engine3d.core.DrawUnit;
   import alternativa.engine3d.core.Light3D;
   import alternativa.engine3d.core.Object3D;
   import alternativa.engine3d.core.RenderPriority;
   import alternativa.engine3d.materials.compiler.Linker;
   import alternativa.engine3d.materials.compiler.Procedure;
   
   use namespace alternativa3d;
   
   public class Decal extends Mesh
   {
      private static var transformProcedureStatic:Procedure = new Procedure(["sub t0.xyz, c0.xyz, i0.xyz","dp3 t0.w, t0.xyz, c1.xyz","mul t0.w, t0.w, c0.w","nrm t0.xyz, t0.xyz","mul t0.xyz, t0.xyz, t0.w","add o0.xyz, i0.xyz, t0.xyz","mov o0.w, c1.w","#c0=cPos","#c1=cDir"],"DecalTransformProcedure");
      
      public var offset:Number;
      
      public function Decal(offset:Number)
      {
         super();
         this.offset = offset;
         alternativa3d::transformProcedure = transformProcedureStatic;
      }
      
      override alternativa3d function collectDraws(camera:Camera3D, lights:Vector.<Light3D>, lightsLength:int) : void
      {
         var surface:Surface = null;
         var debug:int = 0;
         for(var i:int = 0; i < alternativa3d::_-Oy; )
         {
            surface = alternativa3d::_-eW[i];
            if(surface.material != null)
            {
               surface.material.alternativa3d::collectDraws(camera,surface,geometry,lights,lightsLength,RenderPriority.DECALS);
            }
            if(alternativa3d::listening)
            {
               camera.view.alternativa3d::addSurfaceToMouseEvents(surface,geometry,alternativa3d::transformProcedure);
            }
            i++;
         }
         if(camera.debug)
         {
            debug = int(camera.alternativa3d::checkInDebug(this));
            if(Boolean(debug & Debug.BOUNDS) && boundBox != null)
            {
               Debug.alternativa3d::drawBoundBox(camera,boundBox,alternativa3d::localToCameraTransform);
            }
         }
      }
      
      override alternativa3d function setTransformConstants(drawUnit:DrawUnit, surface:Surface, vertexShader:Linker, camera:Camera3D) : void
      {
         var dx:Number = -alternativa3d::cameraToLocalTransform.c;
         var dy:Number = -alternativa3d::cameraToLocalTransform.g;
         var dz:Number = -alternativa3d::cameraToLocalTransform.k;
         var len:Number = this.offset / Math.sqrt(dx * dx + dy * dy + dz * dz) / camera.alternativa3d::focalLength;
         drawUnit.alternativa3d::setVertexConstantsFromNumbers(vertexShader.getVariableIndex("cPos"),alternativa3d::cameraToLocalTransform.d,alternativa3d::cameraToLocalTransform.h,alternativa3d::cameraToLocalTransform.l,len);
         drawUnit.alternativa3d::setVertexConstantsFromNumbers(vertexShader.getVariableIndex("cDir"),dx,dy,dz,1);
      }
      
      override public function clone() : Object3D
      {
         var res:Decal = new Decal(this.offset);
         res.clonePropertiesFrom(this);
         return res;
      }
      
      override protected function clonePropertiesFrom(source:Object3D) : void
      {
         super.clonePropertiesFrom(source);
         this.offset = (source as Decal).offset;
      }
   }
}

