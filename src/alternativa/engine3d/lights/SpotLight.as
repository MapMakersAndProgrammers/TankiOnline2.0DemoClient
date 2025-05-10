package alternativa.engine3d.lights
{
   import alternativa.engine3d.alternativa3d;
   import alternativa.engine3d.core.BoundBox;
   import alternativa.engine3d.core.Camera3D;
   import alternativa.engine3d.core.Debug;
   import alternativa.engine3d.core.Light3D;
   import alternativa.engine3d.core.Object3D;
   import alternativa.engine3d.core.Transform3D;
   
   use namespace alternativa3d;
   
   public class SpotLight extends Light3D
   {
      public var attenuationBegin:Number;
      
      public var attenuationEnd:Number;
      
      public var hotspot:Number;
      
      public var falloff:Number;
      
      public function SpotLight(color:uint, attenuationBegin:Number, attenuationEnd:Number, hotspot:Number, falloff:Number)
      {
         super();
         this.color = color;
         this.attenuationBegin = attenuationBegin;
         this.attenuationEnd = attenuationEnd;
         this.hotspot = hotspot;
         this.falloff = falloff;
         calculateBoundBox();
      }
      
      override alternativa3d function updateBoundBox(boundBox:BoundBox, hierarchy:Boolean, transform:Transform3D = null) : void
      {
         var bottom:Number = NaN;
         var r:Number = this.falloff < Math.PI ? Math.sin(this.falloff * 0.5) * this.attenuationEnd : this.attenuationEnd;
         bottom = this.falloff < Math.PI ? 0 : Math.cos(this.falloff * 0.5) * this.attenuationEnd;
         boundBox.minX = -r;
         boundBox.minY = -r;
         boundBox.minZ = bottom;
         boundBox.maxX = r;
         boundBox.maxY = r;
         boundBox.maxZ = this.attenuationEnd;
      }
      
      public function lookAt(x:Number, y:Number, z:Number) : void
      {
         var dx:Number = x - this.x;
         var dy:Number = y - this.y;
         var dz:Number = z - this.z;
         rotationX = Math.atan2(dz,Math.sqrt(dx * dx + dy * dy)) - Math.PI / 2;
         rotationY = 0;
         rotationZ = -Math.atan2(dx,dy);
      }
      
      override alternativa3d function collectDraws(camera:Camera3D, lights:Vector.<Light3D>, lightsLength:int) : void
      {
         var debug:int = 0;
         if(camera.debug)
         {
            debug = camera.alternativa3d::checkInDebug(this);
            if(Boolean(debug & Debug.BOUNDS) && boundBox != null)
            {
               Debug.alternativa3d::drawBoundBox(camera,boundBox,alternativa3d::localToCameraTransform);
            }
         }
      }
      
      override alternativa3d function checkBound(targetObject:Object3D) : Boolean
      {
         var sum:Number = NaN;
         var pro:Number = NaN;
         var minX:Number = boundBox.minX;
         var minY:Number = boundBox.minY;
         var minZ:Number = boundBox.minZ;
         var maxX:Number = boundBox.maxX;
         var maxY:Number = boundBox.maxY;
         var maxZ:Number = boundBox.maxZ;
         var w:Number = (maxX - minX) * 0.5;
         var l:Number = (maxY - minY) * 0.5;
         var h:Number = (maxZ - minZ) * 0.5;
         var ax:Number = name_cl.a * w;
         var ay:Number = name_cl.e * w;
         var az:Number = name_cl.i * w;
         var bx:Number = name_cl.b * l;
         var by:Number = name_cl.f * l;
         var bz:Number = name_cl.j * l;
         var cx:Number = name_cl.c * h;
         var cy:Number = name_cl.g * h;
         var cz:Number = name_cl.k * h;
         var objectBB:BoundBox = targetObject.boundBox;
         var hw:Number = (objectBB.maxX - objectBB.minX) * 0.5;
         var hl:Number = (objectBB.maxY - objectBB.minY) * 0.5;
         var hh:Number = (objectBB.maxZ - objectBB.minZ) * 0.5;
         var dx:Number = name_cl.a * (minX + w) + name_cl.b * (minY + l) + name_cl.c * (minZ + h) + name_cl.d - objectBB.minX - hw;
         var dy:Number = name_cl.e * (minX + w) + name_cl.f * (minY + l) + name_cl.g * (minZ + h) + name_cl.h - objectBB.minY - hl;
         var dz:Number = name_cl.i * (minX + w) + name_cl.j * (minY + l) + name_cl.k * (minZ + h) + name_cl.l - objectBB.minZ - hh;
         sum = 0;
         if(ax >= 0)
         {
            sum += ax;
         }
         else
         {
            sum -= ax;
         }
         if(bx >= 0)
         {
            sum += bx;
         }
         else
         {
            sum -= bx;
         }
         if(cx >= 0)
         {
            sum += cx;
         }
         else
         {
            sum -= cx;
         }
         sum += hw;
         if(dx >= 0)
         {
            sum -= dx;
         }
         sum += dx;
         if(sum <= 0)
         {
            return false;
         }
         sum = 0;
         if(ay >= 0)
         {
            sum += ay;
         }
         else
         {
            sum -= ay;
         }
         if(by >= 0)
         {
            sum += by;
         }
         else
         {
            sum -= by;
         }
         if(cy >= 0)
         {
            sum += cy;
         }
         else
         {
            sum -= cy;
         }
         sum += hl;
         if(dy >= 0)
         {
            sum -= dy;
         }
         else
         {
            sum += dy;
         }
         if(sum <= 0)
         {
            return false;
         }
         sum = 0;
         if(az >= 0)
         {
            sum += az;
         }
         else
         {
            sum -= az;
         }
         if(bz >= 0)
         {
            sum += bz;
         }
         else
         {
            sum -= bz;
         }
         if(cz >= 0)
         {
            sum += cz;
         }
         else
         {
            sum -= cz;
         }
         sum += hl;
         if(dz >= 0)
         {
            sum -= dz;
         }
         else
         {
            sum += dz;
         }
         if(sum <= 0)
         {
            return false;
         }
         sum = 0;
         pro = name_cl.a * ax + name_cl.e * ay + name_cl.i * az;
         if(pro >= 0)
         {
            sum += pro;
         }
         else
         {
            sum -= pro;
         }
         pro = name_cl.a * bx + name_cl.e * by + name_cl.i * bz;
         if(pro >= 0)
         {
            sum += pro;
         }
         else
         {
            sum -= pro;
         }
         pro = name_cl.a * cx + name_cl.e * cy + name_cl.i * cz;
         if(pro >= 0)
         {
            sum += pro;
         }
         else
         {
            sum -= pro;
         }
         if(name_cl.a >= 0)
         {
            sum += name_cl.a * hw;
         }
         else
         {
            sum -= name_cl.a * hw;
         }
         if(name_cl.e >= 0)
         {
            sum += name_cl.e * hl;
         }
         else
         {
            sum -= name_cl.e * hl;
         }
         if(name_cl.i >= 0)
         {
            sum += name_cl.i * hh;
         }
         else
         {
            sum -= name_cl.i * hh;
         }
         pro = name_cl.a * dx + name_cl.e * dy + name_cl.i * dz;
         if(pro >= 0)
         {
            sum -= pro;
         }
         else
         {
            sum += pro;
         }
         if(sum <= 0)
         {
            return false;
         }
         sum = 0;
         pro = name_cl.b * ax + name_cl.f * ay + name_cl.j * az;
         if(pro >= 0)
         {
            sum += pro;
         }
         else
         {
            sum -= pro;
         }
         pro = name_cl.b * bx + name_cl.f * by + name_cl.j * bz;
         if(pro >= 0)
         {
            sum += pro;
         }
         else
         {
            sum -= pro;
         }
         pro = name_cl.b * cx + name_cl.f * cy + name_cl.j * cz;
         if(pro >= 0)
         {
            sum += pro;
         }
         else
         {
            sum -= pro;
         }
         if(name_cl.b >= 0)
         {
            sum += name_cl.b * hw;
         }
         else
         {
            sum -= name_cl.b * hw;
         }
         if(name_cl.f >= 0)
         {
            sum += name_cl.f * hl;
         }
         else
         {
            sum -= name_cl.f * hl;
         }
         if(name_cl.j >= 0)
         {
            sum += name_cl.j * hh;
         }
         else
         {
            sum -= name_cl.j * hh;
         }
         pro = name_cl.b * dx + name_cl.f * dy + name_cl.j * dz;
         if(pro >= 0)
         {
            sum -= pro;
         }
         sum += pro;
         if(sum <= 0)
         {
            return false;
         }
         sum = 0;
         pro = name_cl.c * ax + name_cl.g * ay + name_cl.k * az;
         if(pro >= 0)
         {
            sum += pro;
         }
         else
         {
            sum -= pro;
         }
         pro = name_cl.c * bx + name_cl.g * by + name_cl.k * bz;
         if(pro >= 0)
         {
            sum += pro;
         }
         else
         {
            sum -= pro;
         }
         pro = name_cl.c * cx + name_cl.g * cy + name_cl.k * cz;
         if(pro >= 0)
         {
            sum += pro;
         }
         else
         {
            sum -= pro;
         }
         if(name_cl.c >= 0)
         {
            sum += name_cl.c * hw;
         }
         else
         {
            sum -= name_cl.c * hw;
         }
         if(name_cl.g >= 0)
         {
            sum += name_cl.g * hl;
         }
         else
         {
            sum -= name_cl.g * hl;
         }
         if(name_cl.k >= 0)
         {
            sum += name_cl.k * hh;
         }
         else
         {
            sum -= name_cl.k * hh;
         }
         pro = name_cl.c * dx + name_cl.g * dy + name_cl.k * dz;
         if(pro >= 0)
         {
            sum -= pro;
         }
         else
         {
            sum += pro;
         }
         if(sum <= 0)
         {
            return false;
         }
         return true;
      }
      
      override public function clone() : Object3D
      {
         var res:SpotLight = new SpotLight(color,this.attenuationBegin,this.attenuationEnd,this.hotspot,this.falloff);
         res.clonePropertiesFrom(this);
         return res;
      }
   }
}

