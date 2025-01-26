package package_19
{
   import alternativa.engine3d.alternativa3d;
   import flash.geom.Vector3D;
   import flash.utils.Dictionary;
   import package_110.name_389;
   import package_21.name_116;
   import package_21.name_124;
   import package_21.name_139;
   import package_21.name_386;
   import package_21.name_387;
   import package_21.name_397;
   import package_21.name_78;
   import package_28.name_119;
   import package_4.class_4;
   
   use namespace alternativa3d;
   
   public class name_380 extends name_78
   {
      public var geometry:name_119;
      
      alternativa3d var var_92:Vector.<name_117> = new Vector.<name_117>();
      
      alternativa3d var var_93:int = 0;
      
      public function name_380()
      {
         super();
      }
      
      override public function intersectRay(origin:Vector3D, direction:Vector3D) : name_387
      {
         var contentData:name_387 = null;
         var minTime:Number = NaN;
         var s:name_117 = null;
         var data:name_387 = null;
         var childrenData:name_387 = super.intersectRay(origin,direction);
         if(boundBox != null && !boundBox.intersectRay(origin,direction))
         {
            contentData = null;
         }
         else if(this.geometry != null)
         {
            minTime = 1e+22;
            for each(s in this.alternativa3d::var_92)
            {
               data = this.geometry.alternativa3d::intersectRay(origin,direction,s.indexBegin,s.numTriangles);
               if(data != null && data.time < minTime)
               {
                  contentData = data;
                  contentData.object = this;
                  contentData.surface = s;
                  minTime = data.time;
               }
            }
         }
         if(childrenData == null)
         {
            return contentData;
         }
         if(contentData == null)
         {
            return childrenData;
         }
         return childrenData.time < contentData.time ? childrenData : contentData;
      }
      
      public function addSurface(material:class_4, indexBegin:uint, numTriangles:uint) : name_117
      {
         var res:name_117 = new name_117();
         res.alternativa3d::object = this;
         res.material = material;
         res.indexBegin = indexBegin;
         res.numTriangles = numTriangles;
         var _loc5_:* = this.alternativa3d::var_93++;
         this.alternativa3d::var_92[_loc5_] = res;
         return res;
      }
      
      public function method_216(index:int) : name_117
      {
         return this.alternativa3d::var_92[index];
      }
      
      public function get method_217() : int
      {
         return this.alternativa3d::var_93;
      }
      
      public function setMaterialToAllSurfaces(material:class_4) : void
      {
         for(var i:int = 0; i < this.alternativa3d::var_92.length; i++)
         {
            this.alternativa3d::var_92[i].material = material;
         }
      }
      
      override alternativa3d function get useLights() : Boolean
      {
         return true;
      }
      
      override alternativa3d function updateBoundBox(boundBox:name_386, hierarchy:Boolean, transform:name_139 = null) : void
      {
         super.alternativa3d::updateBoundBox(boundBox,hierarchy,transform);
         if(this.geometry != null)
         {
            this.geometry.alternativa3d::updateBoundBox(boundBox,transform);
         }
      }
      
      override alternativa3d function fillResources(resources:Dictionary, hierarchy:Boolean = false, resourceType:Class = null) : void
      {
         var s:name_117 = null;
         if(this.geometry != null && (resourceType == null || this.geometry is resourceType))
         {
            resources[this.geometry] = true;
         }
         for(var i:int = 0; i < this.alternativa3d::var_93; )
         {
            s = this.alternativa3d::var_92[i];
            if(s.material != null)
            {
               s.material.alternativa3d::fillResources(resources,resourceType);
            }
            i++;
         }
         super.alternativa3d::fillResources(resources,hierarchy,resourceType);
      }
      
      override alternativa3d function collectDraws(camera:name_124, lights:Vector.<name_116>, lightsLength:int) : void
      {
         var surface:name_117 = null;
         var debug:int = 0;
         for(var i:int = 0; i < this.alternativa3d::var_93; )
         {
            surface = this.alternativa3d::var_92[i];
            if(surface.material != null)
            {
               surface.material.alternativa3d::collectDraws(camera,surface,this.geometry,lights,lightsLength);
            }
            if(alternativa3d::listening)
            {
               camera.view.alternativa3d::name_398(surface,this.geometry,alternativa3d::transformProcedure);
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
      
      override alternativa3d function collectGeometry(collider:name_389, excludedObjects:Dictionary) : void
      {
         collider.alternativa3d::geometries.push(this.geometry);
         collider.alternativa3d::name_400.push(alternativa3d::localToGlobalTransform);
      }
      
      override public function clone() : name_78
      {
         var res:name_380 = new name_380();
         res.clonePropertiesFrom(this);
         return res;
      }
      
      override protected function clonePropertiesFrom(source:name_78) : void
      {
         var s:name_117 = null;
         super.clonePropertiesFrom(source);
         var mesh:name_380 = source as name_380;
         this.geometry = mesh.geometry;
         this.alternativa3d::var_93 = 0;
         this.alternativa3d::var_92.length = 0;
         for each(s in mesh.alternativa3d::var_92)
         {
            this.addSurface(s.material,s.indexBegin,s.numTriangles);
         }
      }
   }
}

