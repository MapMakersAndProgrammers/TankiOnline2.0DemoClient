package package_24
{
   import alternativa.engine3d.alternativa3d;
   import package_21.name_116;
   import package_21.name_124;
   import package_21.name_139;
   import package_21.name_386;
   import package_21.name_397;
   import package_21.name_78;
   
   use namespace alternativa3d;
   
   public class SpotLight extends name_116
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
      
      override alternativa3d function updateBoundBox(boundBox:name_386, hierarchy:Boolean, transform:name_139 = null) : void
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
      
      override alternativa3d function collectDraws(camera:name_124, lights:Vector.<name_116>, lightsLength:int) : void
      {
         var debug:int = 0;
         if(camera.debug)
         {
            debug = int(camera.alternativa3d::checkInDebug(this));
            if(Boolean(debug & name_397.BOUNDS) && boundBox != null)
            {
               name_397.alternativa3d::name_399(camera,boundBox,alternativa3d::localToCameraTransform);
            }
         }
      }
      
      override alternativa3d function checkBound(targetObject:name_78) : Boolean
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
         var ax:Number = alternativa3d::name_141.a * w;
         var ay:Number = alternativa3d::name_141.e * w;
         var az:Number = alternativa3d::name_141.i * w;
         var bx:Number = alternativa3d::name_141.b * l;
         var by:Number = alternativa3d::name_141.f * l;
         var bz:Number = alternativa3d::name_141.j * l;
         var cx:Number = alternativa3d::name_141.c * h;
         var cy:Number = alternativa3d::name_141.g * h;
         var cz:Number = alternativa3d::name_141.k * h;
         var objectBB:name_386 = targetObject.boundBox;
         var hw:Number = (objectBB.maxX - objectBB.minX) * 0.5;
         var hl:Number = (objectBB.maxY - objectBB.minY) * 0.5;
         var hh:Number = (objectBB.maxZ - objectBB.minZ) * 0.5;
         var dx:Number = alternativa3d::name_141.a * (minX + w) + alternativa3d::name_141.b * (minY + l) + alternativa3d::name_141.c * (minZ + h) + alternativa3d::name_141.d - objectBB.minX - hw;
         var dy:Number = alternativa3d::name_141.e * (minX + w) + alternativa3d::name_141.f * (minY + l) + alternativa3d::name_141.g * (minZ + h) + alternativa3d::name_141.h - objectBB.minY - hl;
         var dz:Number = alternativa3d::name_141.i * (minX + w) + alternativa3d::name_141.j * (minY + l) + alternativa3d::name_141.k * (minZ + h) + alternativa3d::name_141.l - objectBB.minZ - hh;
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
         pro = alternativa3d::name_141.a * ax + alternativa3d::name_141.e * ay + alternativa3d::name_141.i * az;
         if(pro >= 0)
         {
            sum += pro;
         }
         else
         {
            sum -= pro;
         }
         pro = alternativa3d::name_141.a * bx + alternativa3d::name_141.e * by + alternativa3d::name_141.i * bz;
         if(pro >= 0)
         {
            sum += pro;
         }
         else
         {
            sum -= pro;
         }
         pro = alternativa3d::name_141.a * cx + alternativa3d::name_141.e * cy + alternativa3d::name_141.i * cz;
         if(pro >= 0)
         {
            sum += pro;
         }
         else
         {
            sum -= pro;
         }
         if(alternativa3d::name_141.a >= 0)
         {
            sum += alternativa3d::name_141.a * hw;
         }
         else
         {
            sum -= alternativa3d::name_141.a * hw;
         }
         if(alternativa3d::name_141.e >= 0)
         {
            sum += alternativa3d::name_141.e * hl;
         }
         else
         {
            sum -= alternativa3d::name_141.e * hl;
         }
         if(alternativa3d::name_141.i >= 0)
         {
            sum += alternativa3d::name_141.i * hh;
         }
         else
         {
            sum -= alternativa3d::name_141.i * hh;
         }
         pro = alternativa3d::name_141.a * dx + alternativa3d::name_141.e * dy + alternativa3d::name_141.i * dz;
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
         pro = alternativa3d::name_141.b * ax + alternativa3d::name_141.f * ay + alternativa3d::name_141.j * az;
         if(pro >= 0)
         {
            sum += pro;
         }
         else
         {
            sum -= pro;
         }
         pro = alternativa3d::name_141.b * bx + alternativa3d::name_141.f * by + alternativa3d::name_141.j * bz;
         if(pro >= 0)
         {
            sum += pro;
         }
         else
         {
            sum -= pro;
         }
         pro = alternativa3d::name_141.b * cx + alternativa3d::name_141.f * cy + alternativa3d::name_141.j * cz;
         if(pro >= 0)
         {
            sum += pro;
         }
         else
         {
            sum -= pro;
         }
         if(alternativa3d::name_141.b >= 0)
         {
            sum += alternativa3d::name_141.b * hw;
         }
         else
         {
            sum -= alternativa3d::name_141.b * hw;
         }
         if(alternativa3d::name_141.f >= 0)
         {
            sum += alternativa3d::name_141.f * hl;
         }
         else
         {
            sum -= alternativa3d::name_141.f * hl;
         }
         if(alternativa3d::name_141.j >= 0)
         {
            sum += alternativa3d::name_141.j * hh;
         }
         else
         {
            sum -= alternativa3d::name_141.j * hh;
         }
         pro = alternativa3d::name_141.b * dx + alternativa3d::name_141.f * dy + alternativa3d::name_141.j * dz;
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
         pro = alternativa3d::name_141.c * ax + alternativa3d::name_141.g * ay + alternativa3d::name_141.k * az;
         if(pro >= 0)
         {
            sum += pro;
         }
         else
         {
            sum -= pro;
         }
         pro = alternativa3d::name_141.c * bx + alternativa3d::name_141.g * by + alternativa3d::name_141.k * bz;
         if(pro >= 0)
         {
            sum += pro;
         }
         else
         {
            sum -= pro;
         }
         pro = alternativa3d::name_141.c * cx + alternativa3d::name_141.g * cy + alternativa3d::name_141.k * cz;
         if(pro >= 0)
         {
            sum += pro;
         }
         else
         {
            sum -= pro;
         }
         if(alternativa3d::name_141.c >= 0)
         {
            sum += alternativa3d::name_141.c * hw;
         }
         else
         {
            sum -= alternativa3d::name_141.c * hw;
         }
         if(alternativa3d::name_141.g >= 0)
         {
            sum += alternativa3d::name_141.g * hl;
         }
         else
         {
            sum -= alternativa3d::name_141.g * hl;
         }
         if(alternativa3d::name_141.k >= 0)
         {
            sum += alternativa3d::name_141.k * hh;
         }
         else
         {
            sum -= alternativa3d::name_141.k * hh;
         }
         pro = alternativa3d::name_141.c * dx + alternativa3d::name_141.g * dy + alternativa3d::name_141.k * dz;
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
      
      override public function clone() : name_78
      {
         var res:SpotLight = new SpotLight(color,this.attenuationBegin,this.attenuationEnd,this.hotspot,this.falloff);
         res.clonePropertiesFrom(this);
         return res;
      }
   }
}

