package alternativa.engine3d.objects
{
   import alternativa.engine3d.alternativa3d;
   import alternativa.engine3d.collisions.EllipsoidCollider;
   import alternativa.engine3d.core.BoundBox;
   import alternativa.engine3d.core.Camera3D;
   import alternativa.engine3d.core.Debug;
   import alternativa.engine3d.core.Light3D;
   import alternativa.engine3d.core.Object3D;
   import alternativa.engine3d.core.RayIntersectionData;
   import alternativa.engine3d.core.Transform3D;
   import alternativa.engine3d.materials.Material;
   import alternativa.engine3d.resources.Geometry;
   import flash.geom.Vector3D;
   import flash.utils.Dictionary;
   
   use namespace alternativa3d;
   
   public class Mesh extends Object3D
   {
      public var geometry:Geometry;
      
      alternativa3d var §_-eW§:Vector.<Surface> = new Vector.<Surface>();
      
      alternativa3d var §_-Oy§:int = 0;
      
      public function Mesh()
      {
         super();
      }
      
      override public function intersectRay(origin:Vector3D, direction:Vector3D) : RayIntersectionData
      {
         var contentData:RayIntersectionData = null;
         var minTime:Number = NaN;
         var s:Surface = null;
         var data:RayIntersectionData = null;
         var childrenData:RayIntersectionData = super.intersectRay(origin,direction);
         if(boundBox != null && !boundBox.intersectRay(origin,direction))
         {
            contentData = null;
         }
         else if(this.geometry != null)
         {
            minTime = 1e+22;
            for each(s in this.alternativa3d::_-eW)
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
      
      public function addSurface(material:Material, indexBegin:uint, numTriangles:uint) : Surface
      {
         var res:Surface = new Surface();
         res.alternativa3d::object = this;
         res.material = material;
         res.indexBegin = indexBegin;
         res.numTriangles = numTriangles;
         var _loc5_:* = this.alternativa3d::_-Oy++;
         this.alternativa3d::_-eW[_loc5_] = res;
         return res;
      }
      
      public function getSurface(index:int) : Surface
      {
         return this.alternativa3d::_-eW[index];
      }
      
      public function get numSurfaces() : int
      {
         return this.alternativa3d::_-Oy;
      }
      
      public function setMaterialToAllSurfaces(material:Material) : void
      {
         for(var i:int = 0; i < this.alternativa3d::_-eW.length; i++)
         {
            this.alternativa3d::_-eW[i].material = material;
         }
      }
      
      override alternativa3d function get useLights() : Boolean
      {
         return true;
      }
      
      override alternativa3d function updateBoundBox(boundBox:BoundBox, hierarchy:Boolean, transform:Transform3D = null) : void
      {
         super.alternativa3d::updateBoundBox(boundBox,hierarchy,transform);
         if(this.geometry != null)
         {
            this.geometry.alternativa3d::updateBoundBox(boundBox,transform);
         }
      }
      
      override alternativa3d function fillResources(resources:Dictionary, hierarchy:Boolean = false, resourceType:Class = null) : void
      {
         var s:Surface = null;
         if(this.geometry != null && (resourceType == null || this.geometry is resourceType))
         {
            resources[this.geometry] = true;
         }
         for(var i:int = 0; i < this.alternativa3d::_-Oy; )
         {
            s = this.alternativa3d::_-eW[i];
            if(s.material != null)
            {
               s.material.alternativa3d::fillResources(resources,resourceType);
            }
            i++;
         }
         super.alternativa3d::fillResources(resources,hierarchy,resourceType);
      }
      
      override alternativa3d function collectDraws(camera:Camera3D, lights:Vector.<Light3D>, lightsLength:int) : void
      {
         var surface:Surface = null;
         var debug:int = 0;
         for(var i:int = 0; i < this.alternativa3d::_-Oy; )
         {
            surface = this.alternativa3d::_-eW[i];
            if(surface.material != null)
            {
               surface.material.alternativa3d::collectDraws(camera,surface,this.geometry,lights,lightsLength);
            }
            if(alternativa3d::listening)
            {
               camera.view.alternativa3d::addSurfaceToMouseEvents(surface,this.geometry,alternativa3d::transformProcedure);
            }
            i++;
         }
         if(camera.debug)
         {
            debug = camera.alternativa3d::checkInDebug(this);
            if(Boolean(debug & Debug.BOUNDS) && boundBox != null)
            {
               Debug.alternativa3d::drawBoundBox(camera,boundBox,alternativa3d::localToCameraTransform);
            }
         }
      }
      
      override alternativa3d function collectGeometry(collider:EllipsoidCollider, excludedObjects:Dictionary) : void
      {
         collider.alternativa3d::geometries.push(this.geometry);
         collider.alternativa3d::_-QK.push(alternativa3d::localToGlobalTransform);
      }
      
      override public function clone() : Object3D
      {
         var res:Mesh = new Mesh();
         res.clonePropertiesFrom(this);
         return res;
      }
      
      override protected function clonePropertiesFrom(source:Object3D) : void
      {
         var s:Surface = null;
         super.clonePropertiesFrom(source);
         var mesh:Mesh = source as Mesh;
         this.geometry = mesh.geometry;
         this.alternativa3d::_-Oy = 0;
         this.alternativa3d::_-eW.length = 0;
         for each(s in mesh.alternativa3d::_-eW)
         {
            this.addSurface(s.material,s.indexBegin,s.numTriangles);
         }
      }
   }
}

