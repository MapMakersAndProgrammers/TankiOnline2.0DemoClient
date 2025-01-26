package package_19
{
   import alternativa.engine3d.alternativa3d;
   import package_21.name_116;
   import package_21.name_124;
   import package_21.name_128;
   import package_21.name_135;
   import package_21.name_397;
   import package_21.name_78;
   import package_30.name_114;
   import package_30.name_121;
   
   use namespace alternativa3d;
   
   public class name_91 extends name_380
   {
      private static var transformProcedureStatic:name_114 = new name_114(["sub t0.xyz, c0.xyz, i0.xyz","dp3 t0.w, t0.xyz, c1.xyz","mul t0.w, t0.w, c0.w","nrm t0.xyz, t0.xyz","mul t0.xyz, t0.xyz, t0.w","add o0.xyz, i0.xyz, t0.xyz","mov o0.w, c1.w","#c0=cPos","#c1=cDir"],"DecalTransformProcedure");
      
      public var offset:Number;
      
      public function name_91(offset:Number)
      {
         super();
         this.offset = offset;
         alternativa3d::transformProcedure = transformProcedureStatic;
      }
      
      override alternativa3d function collectDraws(camera:name_124, lights:Vector.<name_116>, lightsLength:int) : void
      {
         var surface:name_117 = null;
         var debug:int = 0;
         for(var i:int = 0; i < alternativa3d::var_93; )
         {
            surface = alternativa3d::var_92[i];
            if(surface.material != null)
            {
               surface.material.alternativa3d::collectDraws(camera,surface,geometry,lights,lightsLength,name_128.DECALS);
            }
            if(alternativa3d::listening)
            {
               camera.view.alternativa3d::name_398(surface,geometry,alternativa3d::transformProcedure);
            }
            i++;
         }
         if(camera.debug)
         {
            debug = int(camera.alternativa3d::checkInDebug(this));
            if(Boolean(debug & name_397.BOUNDS) && boundBox != null)
            {
               name_397.alternativa3d::name_399(camera,boundBox,alternativa3d::localToCameraTransform);
            }
         }
      }
      
      override alternativa3d function setTransformConstants(drawUnit:name_135, surface:name_117, vertexShader:name_121, camera:name_124) : void
      {
         var dx:Number = -alternativa3d::cameraToLocalTransform.c;
         var dy:Number = -alternativa3d::cameraToLocalTransform.g;
         var dz:Number = -alternativa3d::cameraToLocalTransform.k;
         var len:Number = this.offset / Math.sqrt(dx * dx + dy * dy + dz * dz) / camera.alternativa3d::focalLength;
         drawUnit.alternativa3d::name_144(vertexShader.getVariableIndex("cPos"),alternativa3d::cameraToLocalTransform.d,alternativa3d::cameraToLocalTransform.h,alternativa3d::cameraToLocalTransform.l,len);
         drawUnit.alternativa3d::name_144(vertexShader.getVariableIndex("cDir"),dx,dy,dz,1);
      }
      
      override public function clone() : name_78
      {
         var res:name_91 = new name_91(this.offset);
         res.clonePropertiesFrom(this);
         return res;
      }
      
      override protected function clonePropertiesFrom(source:name_78) : void
      {
         super.clonePropertiesFrom(source);
         this.offset = (source as name_91).offset;
      }
   }
}

