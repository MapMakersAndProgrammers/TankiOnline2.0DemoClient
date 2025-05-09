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
            debug = int(camera.alternativa3d::checkInDebug(this));
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
         var ax:Number = alternativa3d::_-cl.a * w;
         var ay:Number = alternativa3d::_-cl.e * w;
         var az:Number = alternativa3d::_-cl.i * w;
         var bx:Number = alternativa3d::_-cl.b * l;
         var by:Number = alternativa3d::_-cl.f * l;
         var bz:Number = alternativa3d::_-cl.j * l;
         var cx:Number = alternativa3d::_-cl.c * h;
         var cy:Number = alternativa3d::_-cl.g * h;
         var cz:Number = alternativa3d::_-cl.k * h;
         var objectBB:BoundBox = targetObject.boundBox;
         var hw:Number = (objectBB.maxX - objectBB.minX) * 0.5;
         var hl:Number = (objectBB.maxY - objectBB.minY) * 0.5;
         var hh:Number = (objectBB.maxZ - objectBB.minZ) * 0.5;
         var dx:Number = alternativa3d::_-cl.a * (minX + w) + alternativa3d::_-cl.b * (minY + l) + alternativa3d::_-cl.c * (minZ + h) + alternativa3d::_-cl.d - objectBB.minX - hw;
         var dy:Number = alternativa3d::_-cl.e * (minX + w) + alternativa3d::_-cl.f * (minY + l) + alternativa3d::_-cl.g * (minZ + h) + alternativa3d::_-cl.h - objectBB.minY - hl;
         var dz:Number = alternativa3d::_-cl.i * (minX + w) + alternativa3d::_-cl.j * (minY + l) + alternativa3d::_-cl.k * (minZ + h) + alternativa3d::_-cl.l - objectBB.minZ - hh;
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
         pro = alternativa3d::_-cl.a * ax + alternativa3d::_-cl.e * ay + alternativa3d::_-cl.i * az;
         if(pro >= 0)
         {
            sum += pro;
         }
         else
         {
            sum -= pro;
         }
         pro = alternativa3d::_-cl.a * bx + alternativa3d::_-cl.e * by + alternativa3d::_-cl.i * bz;
         if(pro >= 0)
         {
            sum += pro;
         }
         else
         {
            sum -= pro;
         }
         pro = alternativa3d::_-cl.a * cx + alternativa3d::_-cl.e * cy + alternativa3d::_-cl.i * cz;
         if(pro >= 0)
         {
            sum += pro;
         }
         else
         {
            sum -= pro;
         }
         if(alternativa3d::_-cl.a >= 0)
         {
            sum += alternativa3d::_-cl.a * hw;
         }
         else
         {
            sum -= alternativa3d::_-cl.a * hw;
         }
         if(alternativa3d::_-cl.e >= 0)
         {
            sum += alternativa3d::_-cl.e * hl;
         }
         else
         {
            sum -= alternativa3d::_-cl.e * hl;
         }
         if(alternativa3d::_-cl.i >= 0)
         {
            sum += alternativa3d::_-cl.i * hh;
         }
         else
         {
            sum -= alternativa3d::_-cl.i * hh;
         }
         pro = alternativa3d::_-cl.a * dx + alternativa3d::_-cl.e * dy + alternativa3d::_-cl.i * dz;
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
         pro = alternativa3d::_-cl.b * ax + alternativa3d::_-cl.f * ay + alternativa3d::_-cl.j * az;
         if(pro >= 0)
         {
            sum += pro;
         }
         else
         {
            sum -= pro;
         }
         pro = alternativa3d::_-cl.b * bx + alternativa3d::_-cl.f * by + alternativa3d::_-cl.j * bz;
         if(pro >= 0)
         {
            sum += pro;
         }
         else
         {
            sum -= pro;
         }
         pro = alternativa3d::_-cl.b * cx + alternativa3d::_-cl.f * cy + alternativa3d::_-cl.j * cz;
         if(pro >= 0)
         {
            sum += pro;
         }
         else
         {
            sum -= pro;
         }
         if(alternativa3d::_-cl.b >= 0)
         {
            sum += alternativa3d::_-cl.b * hw;
         }
         else
         {
            sum -= alternativa3d::_-cl.b * hw;
         }
         if(alternativa3d::_-cl.f >= 0)
         {
            sum += alternativa3d::_-cl.f * hl;
         }
         else
         {
            sum -= alternativa3d::_-cl.f * hl;
         }
         if(alternativa3d::_-cl.j >= 0)
         {
            sum += alternativa3d::_-cl.j * hh;
         }
         else
         {
            sum -= alternativa3d::_-cl.j * hh;
         }
         pro = alternativa3d::_-cl.b * dx + alternativa3d::_-cl.f * dy + alternativa3d::_-cl.j * dz;
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
         pro = alternativa3d::_-cl.c * ax + alternativa3d::_-cl.g * ay + alternativa3d::_-cl.k * az;
         if(pro >= 0)
         {
            sum += pro;
         }
         else
         {
            sum -= pro;
         }
         pro = alternativa3d::_-cl.c * bx + alternativa3d::_-cl.g * by + alternativa3d::_-cl.k * bz;
         if(pro >= 0)
         {
            sum += pro;
         }
         else
         {
            sum -= pro;
         }
         pro = alternativa3d::_-cl.c * cx + alternativa3d::_-cl.g * cy + alternativa3d::_-cl.k * cz;
         if(pro >= 0)
         {
            sum += pro;
         }
         else
         {
            sum -= pro;
         }
         if(alternativa3d::_-cl.c >= 0)
         {
            sum += alternativa3d::_-cl.c * hw;
         }
         else
         {
            sum -= alternativa3d::_-cl.c * hw;
         }
         if(alternativa3d::_-cl.g >= 0)
         {
            sum += alternativa3d::_-cl.g * hl;
         }
         else
         {
            sum -= alternativa3d::_-cl.g * hl;
         }
         if(alternativa3d::_-cl.k >= 0)
         {
            sum += alternativa3d::_-cl.k * hh;
         }
         else
         {
            sum -= alternativa3d::_-cl.k * hh;
         }
         pro = alternativa3d::_-cl.c * dx + alternativa3d::_-cl.g * dy + alternativa3d::_-cl.k * dz;
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

