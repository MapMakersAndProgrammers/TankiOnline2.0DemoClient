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
   
   public class OmniLight extends name_116
   {
      public var attenuationBegin:Number;
      
      public var attenuationEnd:Number;
      
      public function OmniLight(color:uint, attenuationBegin:Number, attenuationEnd:Number)
      {
         super();
         this.color = color;
         this.attenuationBegin = attenuationBegin;
         this.attenuationEnd = attenuationEnd;
         calculateBoundBox();
      }
      
      override alternativa3d function updateBoundBox(boundBox:name_386, hierarchy:Boolean, transform:name_139 = null) : void
      {
         super.alternativa3d::updateBoundBox(boundBox,hierarchy,transform);
         if(transform == null)
         {
            if(-this.attenuationEnd < boundBox.minX)
            {
               boundBox.minX = -this.attenuationEnd;
            }
            if(this.attenuationEnd > boundBox.maxX)
            {
               boundBox.maxX = this.attenuationEnd;
            }
            if(-this.attenuationEnd < boundBox.minY)
            {
               boundBox.minY = -this.attenuationEnd;
            }
            if(this.attenuationEnd > boundBox.maxY)
            {
               boundBox.maxY = this.attenuationEnd;
            }
            if(-this.attenuationEnd < boundBox.minZ)
            {
               boundBox.minZ = -this.attenuationEnd;
            }
            if(this.attenuationEnd > boundBox.maxZ)
            {
               boundBox.maxZ = this.attenuationEnd;
            }
         }
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
         var rScale:Number = Number(Math.sqrt(alternativa3d::name_141.a * alternativa3d::name_141.a + alternativa3d::name_141.e * alternativa3d::name_141.e + alternativa3d::name_141.i * alternativa3d::name_141.i));
         rScale += Math.sqrt(alternativa3d::name_141.b * alternativa3d::name_141.b + alternativa3d::name_141.f * alternativa3d::name_141.f + alternativa3d::name_141.j * alternativa3d::name_141.j);
         rScale += Math.sqrt(alternativa3d::name_141.c * alternativa3d::name_141.c + alternativa3d::name_141.g * alternativa3d::name_141.g + alternativa3d::name_141.k * alternativa3d::name_141.k);
         rScale /= 3;
         rScale *= this.attenuationEnd;
         rScale *= rScale;
         var len:Number = 0;
         var bb:name_386 = targetObject.boundBox;
         var minX:Number = bb.minX;
         var minY:Number = bb.minY;
         var minZ:Number = bb.minZ;
         var maxX:Number = bb.maxX;
         var px:Number = Number(alternativa3d::name_141.d);
         var py:Number = Number(alternativa3d::name_141.h);
         var pz:Number = Number(alternativa3d::name_141.l);
         var maxY:Number = bb.maxY;
         var maxZ:Number = bb.maxZ;
         if(px < minX)
         {
            if(py < minY)
            {
               if(pz < minZ)
               {
                  len = (minX - px) * (minX - px) + (minY - py) * (minY - py) + (minZ - pz) * (minZ - pz);
                  return len < rScale;
               }
               if(pz < maxZ)
               {
                  len = (minX - px) * (minX - px) + (minY - py) * (minY - py);
                  return len < rScale;
               }
               if(pz > maxZ)
               {
                  len = (minX - px) * (minX - px) + (minY - py) * (minY - py) + (maxZ - pz) * (maxZ - pz);
                  return len < rScale;
               }
            }
            else if(py < maxY)
            {
               if(pz < minZ)
               {
                  len = (minX - px) * (minX - px) + (minZ - pz) * (minZ - pz);
                  return len < rScale;
               }
               if(pz < maxZ)
               {
                  len = (minX - px) * (minX - px);
                  return len < rScale;
               }
               if(pz > maxZ)
               {
                  len = (minX - px) * (minX - px) + (maxZ - pz) * (maxZ - pz);
                  return len < rScale;
               }
            }
            else if(py > maxY)
            {
               if(pz < minZ)
               {
                  len = (minX - px) * (minX - px) + (maxY - py) * (maxY - py) + (minZ - pz) * (minZ - pz);
                  return len < rScale;
               }
               if(pz < maxZ)
               {
                  len = (minX - px) * (minX - px) + (maxY - py) * (maxY - py);
                  return len < rScale;
               }
               if(pz > maxZ)
               {
                  len = (minX - px) * (minX - px) + (maxY - py) * (maxY - py) + (maxZ - pz) * (maxZ - pz);
                  return len < rScale;
               }
            }
         }
         else if(px < maxX)
         {
            if(py < minY)
            {
               if(pz < minZ)
               {
                  len = (minY - py) * (minY - py) + (minZ - pz) * (minZ - pz);
                  return len < rScale;
               }
               if(pz < maxZ)
               {
                  len = (minY - py) * (minY - py);
                  return len < rScale;
               }
               if(pz > maxZ)
               {
                  len = (minY - py) * (minY - py) + (maxZ - pz) * (maxZ - pz);
                  return len < rScale;
               }
            }
            else if(py < maxY)
            {
               if(pz < minZ)
               {
                  len = (minZ - pz) * (minZ - pz);
                  return len < rScale;
               }
               if(pz < maxZ)
               {
                  return true;
               }
               if(pz > maxZ)
               {
                  len = (maxZ - pz) * (maxZ - pz);
                  return len < rScale;
               }
            }
            else if(py > maxY)
            {
               if(pz < minZ)
               {
                  len = (maxY - py) * (maxY - py) + (minZ - pz) * (minZ - pz);
                  return len < rScale;
               }
               if(pz < maxZ)
               {
                  len = (maxY - py) * (maxY - py);
                  return len < rScale;
               }
               if(pz > maxZ)
               {
                  len = (maxY - py) * (maxY - py) + (maxZ - pz) * (maxZ - pz);
                  return len < rScale;
               }
            }
         }
         else if(px > maxX)
         {
            if(py < minY)
            {
               if(pz < minZ)
               {
                  len = (maxX - px) * (maxX - px) + (minY - py) * (minY - py) + (minZ - pz) * (minZ - pz);
                  return len < rScale;
               }
               if(pz < maxZ)
               {
                  len = (maxX - px) * (maxX - px) + (minY - py) * (minY - py);
                  return len < rScale;
               }
               if(pz > maxZ)
               {
                  len = (maxX - px) * (maxX - px) + (minY - py) * (minY - py) + (maxZ - pz) * (maxZ - pz);
                  return len < rScale;
               }
            }
            else if(py < maxY)
            {
               if(pz < minZ)
               {
                  len = (maxX - px) * (maxX - px) + (minZ - pz) * (minZ - pz);
                  return len < rScale;
               }
               if(pz < maxZ)
               {
                  len = (maxX - px) * (maxX - px);
                  return len < rScale;
               }
               if(pz > maxZ)
               {
                  len = (maxX - px) * (maxX - px) + (maxZ - pz) * (maxZ - pz);
                  return len < rScale;
               }
            }
            else if(py > maxY)
            {
               if(pz < minZ)
               {
                  len = (maxX - px) * (maxX - px) + (maxY - py) * (maxY - py) + (minZ - pz) * (minZ - pz);
                  return len < rScale;
               }
               if(pz < maxZ)
               {
                  len = (maxX - px) * (maxX - px) + (maxY - py) * (maxY - py);
                  return len < rScale;
               }
               if(pz > maxZ)
               {
                  len = (maxX - px) * (maxX - px) + (maxY - py) * (maxY - py) + (maxZ - pz) * (maxZ - pz);
                  return len < rScale;
               }
            }
         }
         return true;
      }
      
      override public function clone() : name_78
      {
         var res:OmniLight = new OmniLight(color,this.attenuationBegin,this.attenuationEnd);
         res.clonePropertiesFrom(this);
         return res;
      }
   }
}

