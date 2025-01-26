package package_19
{
   import alternativa.engine3d.alternativa3d;
   import package_21.name_116;
   import package_21.name_124;
   import package_21.name_126;
   import package_21.name_128;
   import package_21.name_135;
   import package_21.name_78;
   import package_28.name_119;
   import package_30.name_114;
   import package_30.name_121;
   import package_4.class_4;
   
   use namespace alternativa3d;
   
   public class name_53 extends name_380
   {
      public static const LEFT:String = "left";
      
      public static const RIGHT:String = "right";
      
      public static const BACK:String = "back";
      
      public static const FRONT:String = "front";
      
      public static const BOTTOM:String = "bottom";
      
      public static const TOP:String = "top";
      
      private static var transformProcedureStatic:name_114 = new name_114(["sub t0.xyz, i0.xyz, c0.xyz","mul t0.x, t0.x, c0.w","mul t0.y, t0.y, c0.w","mul t0.z, t0.z, c0.w","add o0.xyz, t0.xyz, c0.xyz","mov o0.w, i0.w","#c0=cTrans"]);
      
      private var var_98:name_117;
      
      private var var_95:name_117;
      
      private var var_96:name_117;
      
      private var var_94:name_117;
      
      private var var_99:name_117;
      
      private var var_97:name_117;
      
      private var size:Number;
      
      public function name_53(size:Number, left:class_4 = null, right:class_4 = null, back:class_4 = null, front:class_4 = null, bottom:class_4 = null, top:class_4 = null, uvPadding:Number = 0)
      {
         super();
         size *= 0.5;
         this.size = size;
         geometry = new name_119(24);
         var attributes:Array = new Array();
         attributes[0] = name_126.POSITION;
         attributes[1] = name_126.POSITION;
         attributes[2] = name_126.POSITION;
         attributes[6] = name_126.TEXCOORDS[0];
         attributes[7] = name_126.TEXCOORDS[0];
         geometry.addVertexStream(attributes);
         geometry.setAttributeValues(name_126.POSITION,Vector.<Number>([-size,-size,size,-size,-size,-size,-size,size,-size,-size,size,size,size,size,size,size,size,-size,size,-size,-size,size,-size,size,size,-size,size,size,-size,-size,-size,-size,-size,-size,-size,size,-size,size,size,-size,size,-size,size,size,-size,size,size,size,-size,size,-size,-size,-size,-size,size,-size,-size,size,size,-size,-size,-size,size,-size,size,size,size,size,size,size,-size,size]));
         geometry.setAttributeValues(name_126.TEXCOORDS[0],Vector.<Number>([uvPadding,uvPadding,uvPadding,1 - uvPadding,1 - uvPadding,1 - uvPadding,1 - uvPadding,uvPadding,uvPadding,uvPadding,uvPadding,1 - uvPadding,1 - uvPadding,1 - uvPadding,1 - uvPadding,uvPadding,uvPadding,uvPadding,uvPadding,1 - uvPadding,1 - uvPadding,1 - uvPadding,1 - uvPadding,uvPadding,uvPadding,uvPadding,uvPadding,1 - uvPadding,1 - uvPadding,1 - uvPadding,1 - uvPadding,uvPadding,uvPadding,uvPadding,uvPadding,1 - uvPadding,1 - uvPadding,1 - uvPadding,1 - uvPadding,uvPadding,uvPadding,uvPadding,uvPadding,1 - uvPadding,1 - uvPadding,1 - uvPadding,1 - uvPadding,uvPadding]));
         geometry.indices = Vector.<uint>([0,1,3,2,3,1,4,5,7,6,7,5,8,9,11,10,11,9,12,13,15,14,15,13,16,17,19,18,19,17,20,21,23,22,23,21]);
         this.var_98 = addSurface(left,0,2);
         this.var_95 = addSurface(right,6,2);
         this.var_96 = addSurface(back,12,2);
         this.var_94 = addSurface(front,18,2);
         this.var_99 = addSurface(bottom,24,2);
         this.var_97 = addSurface(top,30,2);
         alternativa3d::transformProcedure = transformProcedureStatic;
      }
      
      override alternativa3d function collectDraws(camera:name_124, lights:Vector.<name_116>, lightsLength:int) : void
      {
         var surface:name_117 = null;
         for(var i:int = 0; i < alternativa3d::var_93; )
         {
            surface = alternativa3d::var_92[i];
            if(surface.material != null)
            {
               surface.material.alternativa3d::collectDraws(camera,surface,geometry,lights,lightsLength,name_128.SKY);
            }
            if(alternativa3d::listening)
            {
               camera.view.alternativa3d::name_398(surface,geometry,alternativa3d::transformProcedure);
            }
            i++;
         }
      }
      
      override alternativa3d function setTransformConstants(drawUnit:name_135, surface:name_117, vertexShader:name_121, camera:name_124) : void
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
         drawUnit.alternativa3d::name_144(0,alternativa3d::cameraToLocalTransform.d,alternativa3d::cameraToLocalTransform.h,alternativa3d::cameraToLocalTransform.l,camera.farClipping / Math.sqrt(max));
      }
      
      public function name_383(side:String) : name_117
      {
         switch(side)
         {
            case LEFT:
               return this.var_98;
            case RIGHT:
               return this.var_95;
            case BACK:
               return this.var_96;
            case FRONT:
               return this.var_94;
            case BOTTOM:
               return this.var_99;
            case TOP:
               return this.var_97;
            default:
               return null;
         }
      }
      
      override public function clone() : name_78
      {
         var res:name_53 = new name_53(0);
         res.clonePropertiesFrom(this);
         return res;
      }
      
      override protected function clonePropertiesFrom(source:name_78) : void
      {
         var surface:name_117 = null;
         var newSurface:name_117 = null;
         super.clonePropertiesFrom(source);
         var src:name_53 = source as name_53;
         for(var i:int = 0; i < src.alternativa3d::var_93; )
         {
            surface = src.alternativa3d::var_92[i];
            newSurface = alternativa3d::var_92[i];
            if(surface == src.var_98)
            {
               this.var_98 = newSurface;
            }
            else if(surface == src.var_95)
            {
               this.var_95 = newSurface;
            }
            else if(surface == src.var_96)
            {
               this.var_96 = newSurface;
            }
            else if(surface == src.var_94)
            {
               this.var_94 = newSurface;
            }
            else if(surface == src.var_99)
            {
               this.var_99 = newSurface;
            }
            else if(surface == src.var_97)
            {
               this.var_97 = newSurface;
            }
            i++;
         }
      }
   }
}

