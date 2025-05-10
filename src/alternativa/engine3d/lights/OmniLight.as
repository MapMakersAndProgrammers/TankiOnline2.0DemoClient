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
   
   public class OmniLight extends Light3D
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
      
      override alternativa3d function updateBoundBox(boundBox:BoundBox, hierarchy:Boolean, transform:Transform3D = null) : void
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
         var rScale:Number = Number(Math.sqrt(alternativa3d::_-cl.a * alternativa3d::_-cl.a + alternativa3d::_-cl.e * alternativa3d::_-cl.e + alternativa3d::_-cl.i * alternativa3d::_-cl.i));
         rScale += Math.sqrt(alternativa3d::_-cl.b * alternativa3d::_-cl.b + alternativa3d::_-cl.f * alternativa3d::_-cl.f + alternativa3d::_-cl.j * alternativa3d::_-cl.j);
         rScale += Math.sqrt(alternativa3d::_-cl.c * alternativa3d::_-cl.c + alternativa3d::_-cl.g * alternativa3d::_-cl.g + alternativa3d::_-cl.k * alternativa3d::_-cl.k);
         rScale /= 3;
         rScale *= this.attenuationEnd;
         rScale *= rScale;
         var len:Number = 0;
         var bb:BoundBox = targetObject.boundBox;
         var minX:Number = bb.minX;
         var minY:Number = bb.minY;
         var minZ:Number = bb.minZ;
         var maxX:Number = bb.maxX;
         var px:Number = Number(alternativa3d::_-cl.d);
         var py:Number = Number(alternativa3d::_-cl.h);
         var pz:Number = Number(alternativa3d::_-cl.l);
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
      
      override public function clone() : Object3D
      {
         var res:OmniLight = new OmniLight(color,this.attenuationBegin,this.attenuationEnd);
         res.clonePropertiesFrom(this);
         return res;
      }
   }
}

