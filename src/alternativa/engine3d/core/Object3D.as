package alternativa.engine3d.core
{
   import alternativa.engine3d.alternativa3d;
   import alternativa.engine3d.collisions.EllipsoidCollider;
   import alternativa.engine3d.core.events.Event3D;
   import alternativa.engine3d.materials.compiler.Linker;
   import alternativa.engine3d.materials.compiler.Procedure;
   import alternativa.engine3d.objects.Surface;
   import alternativa.engine3d.shadows.ShadowRenderer;
   import flash.events.Event;
   import flash.events.EventPhase;
   import flash.events.IEventDispatcher;
   import flash.geom.Matrix3D;
   import flash.geom.Vector3D;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   
   use namespace alternativa3d;
   
   [Event(name="mouseWheel",type="alternativa.engine3d.core.events.MouseEvent3D")]
   [Event(name="mouseMove",type="alternativa.engine3d.core.events.MouseEvent3D")]
   [Event(name="rollOut",type="alternativa.engine3d.core.events.MouseEvent3D")]
   [Event(name="rollOver",type="alternativa.engine3d.core.events.MouseEvent3D")]
   [Event(name="mouseOut",type="alternativa.engine3d.core.events.MouseEvent3D")]
   [Event(name="mouseOver",type="alternativa.engine3d.core.events.MouseEvent3D")]
   [Event(name="mouseUp",type="alternativa.engine3d.core.events.MouseEvent3D")]
   [Event(name="mouseDown",type="alternativa.engine3d.core.events.MouseEvent3D")]
   [Event(name="doubleClick",type="alternativa.engine3d.core.events.MouseEvent3D")]
   [Event(name="click",type="alternativa.engine3d.core.events.MouseEvent3D")]
   [Event(name="removed",type="alternativa.engine3d.core.events.Event3D")]
   [Event(name="added",type="alternativa.engine3d.core.events.Event3D")]
   public class Object3D implements IEventDispatcher
   {
      protected static const trm:Transform3D = new Transform3D();
      
      public var data:Object;
      
      public var useShadow:Boolean = true;
      
      public var name:String;
      
      public var visible:Boolean = true;
      
      public var mouseEnabled:Boolean = true;
      
      public var mouseChildren:Boolean = true;
      
      public var doubleClickEnabled:Boolean = false;
      
      public var useHandCursor:Boolean = false;
      
      public var boundBox:BoundBox;
      
      alternativa3d var _x:Number = 0;
      
      alternativa3d var _y:Number = 0;
      
      alternativa3d var _z:Number = 0;
      
      alternativa3d var _rotationX:Number = 0;
      
      alternativa3d var _rotationY:Number = 0;
      
      alternativa3d var _rotationZ:Number = 0;
      
      alternativa3d var _scaleX:Number = 1;
      
      alternativa3d var _scaleY:Number = 1;
      
      alternativa3d var _scaleZ:Number = 1;
      
      alternativa3d var _parent:Object3D;
      
      alternativa3d var childrenList:Object3D;
      
      alternativa3d var next:Object3D;
      
      alternativa3d var transform:Transform3D = new Transform3D();
      
      alternativa3d var inverseTransform:Transform3D = new Transform3D();
      
      alternativa3d var transformChanged:Boolean = true;
      
      alternativa3d var cameraToLocalTransform:Transform3D = new Transform3D();
      
      alternativa3d var localToCameraTransform:Transform3D = new Transform3D();
      
      alternativa3d var localToGlobalTransform:Transform3D = new Transform3D();
      
      alternativa3d var globalToLocalTransform:Transform3D = new Transform3D();
      
      alternativa3d var culling:int;
      
      alternativa3d var listening:Boolean;
      
      alternativa3d var bubbleListeners:Object;
      
      alternativa3d var captureListeners:Object;
      
      alternativa3d var transformProcedure:Procedure;
      
      alternativa3d var deltaTransformProcedure:Procedure;
      
      alternativa3d var shadowRenderers:Vector.<ShadowRenderer>;
      
      alternativa3d var numShadowRenderers:int;
      
      public function Object3D()
      {
         super();
      }
      
      public function get x() : Number
      {
         return this.alternativa3d::_x;
      }
      
      public function set x(value:Number) : void
      {
         if(this.alternativa3d::_x != value)
         {
            this.alternativa3d::_x = value;
            this.alternativa3d::transformChanged = true;
         }
      }
      
      public function get y() : Number
      {
         return this.alternativa3d::_y;
      }
      
      public function set y(value:Number) : void
      {
         if(this.alternativa3d::_y != value)
         {
            this.alternativa3d::_y = value;
            this.alternativa3d::transformChanged = true;
         }
      }
      
      public function get z() : Number
      {
         return this.alternativa3d::_z;
      }
      
      public function set z(value:Number) : void
      {
         if(this.alternativa3d::_z != value)
         {
            this.alternativa3d::_z = value;
            this.alternativa3d::transformChanged = true;
         }
      }
      
      public function get rotationX() : Number
      {
         return this.alternativa3d::_rotationX;
      }
      
      public function set rotationX(value:Number) : void
      {
         if(this.alternativa3d::_rotationX != value)
         {
            this.alternativa3d::_rotationX = value;
            this.alternativa3d::transformChanged = true;
         }
      }
      
      public function get rotationY() : Number
      {
         return this.alternativa3d::_rotationY;
      }
      
      public function set rotationY(value:Number) : void
      {
         if(this.alternativa3d::_rotationY != value)
         {
            this.alternativa3d::_rotationY = value;
            this.alternativa3d::transformChanged = true;
         }
      }
      
      public function get rotationZ() : Number
      {
         return this.alternativa3d::_rotationZ;
      }
      
      public function set rotationZ(value:Number) : void
      {
         if(this.alternativa3d::_rotationZ != value)
         {
            this.alternativa3d::_rotationZ = value;
            this.alternativa3d::transformChanged = true;
         }
      }
      
      public function get scaleX() : Number
      {
         return this.alternativa3d::_scaleX;
      }
      
      public function set scaleX(value:Number) : void
      {
         if(this.alternativa3d::_scaleX != value)
         {
            this.alternativa3d::_scaleX = value;
            this.alternativa3d::transformChanged = true;
         }
      }
      
      public function get scaleY() : Number
      {
         return this.alternativa3d::_scaleY;
      }
      
      public function set scaleY(value:Number) : void
      {
         if(this.alternativa3d::_scaleY != value)
         {
            this.alternativa3d::_scaleY = value;
            this.alternativa3d::transformChanged = true;
         }
      }
      
      public function get scaleZ() : Number
      {
         return this.alternativa3d::_scaleZ;
      }
      
      public function set scaleZ(value:Number) : void
      {
         if(this.alternativa3d::_scaleZ != value)
         {
            this.alternativa3d::_scaleZ = value;
            this.alternativa3d::transformChanged = true;
         }
      }
      
      public function get matrix() : Matrix3D
      {
         if(this.alternativa3d::transformChanged)
         {
            this.alternativa3d::composeTransforms();
         }
         return new Matrix3D(Vector.<Number>([this.alternativa3d::transform.a,this.alternativa3d::transform.e,this.alternativa3d::transform.i,0,this.alternativa3d::transform.b,this.alternativa3d::transform.f,this.alternativa3d::transform.j,0,this.alternativa3d::transform.c,this.alternativa3d::transform.g,this.alternativa3d::transform.k,0,this.alternativa3d::transform.d,this.alternativa3d::transform.h,this.alternativa3d::transform.l,1]));
      }
      
      public function set matrix(value:Matrix3D) : void
      {
         var v:Vector.<Vector3D> = value.decompose();
         var t:Vector3D = v[0];
         var r:Vector3D = v[1];
         var s:Vector3D = v[2];
         this.alternativa3d::_x = t.x;
         this.alternativa3d::_y = t.y;
         this.alternativa3d::_z = t.z;
         this.alternativa3d::_rotationX = r.x;
         this.alternativa3d::_rotationY = r.y;
         this.alternativa3d::_rotationZ = r.z;
         this.alternativa3d::_scaleX = s.x;
         this.alternativa3d::_scaleY = s.y;
         this.alternativa3d::_scaleZ = s.z;
         this.alternativa3d::transformChanged = true;
      }
      
      public function intersectRay(origin:Vector3D, direction:Vector3D) : RayIntersectionData
      {
         return this.alternativa3d::intersectRayChildren(origin,direction);
      }
      
      alternativa3d function intersectRayChildren(origin:Vector3D, direction:Vector3D) : RayIntersectionData
      {
         var childOrigin:Vector3D = null;
         var childDirection:Vector3D = null;
         var childTransform:Transform3D = null;
         var ma:Number = NaN;
         var mb:Number = NaN;
         var mc:Number = NaN;
         var md:Number = NaN;
         var me:Number = NaN;
         var mf:Number = NaN;
         var mg:Number = NaN;
         var mh:Number = NaN;
         var mi:Number = NaN;
         var mj:Number = NaN;
         var mk:Number = NaN;
         var ml:Number = NaN;
         var data:RayIntersectionData = null;
         var minTime:Number = 1e+22;
         var minData:RayIntersectionData = null;
         for(var child:Object3D = this.alternativa3d::childrenList; child != null; )
         {
            if(childOrigin == null)
            {
               childOrigin = new Vector3D();
               childDirection = new Vector3D();
            }
            childTransform = child.alternativa3d::inverseTransform;
            ma = childTransform.a;
            mb = childTransform.b;
            mc = childTransform.c;
            md = childTransform.d;
            me = childTransform.e;
            mf = childTransform.f;
            mg = childTransform.g;
            mh = childTransform.h;
            mi = childTransform.i;
            mj = childTransform.j;
            mk = childTransform.k;
            ml = childTransform.l;
            childOrigin.x = ma * origin.x + mb * origin.y + mc * origin.z + md;
            childOrigin.y = me * origin.x + mf * origin.y + mg * origin.z + mh;
            childOrigin.z = mi * origin.x + mj * origin.y + mk * origin.z + ml;
            childDirection.x = ma * direction.x + mb * direction.y + mc * direction.z;
            childDirection.y = me * direction.x + mf * direction.y + mg * direction.z;
            childDirection.z = mi * direction.x + mj * direction.y + mk * direction.z;
            data = child.intersectRay(childOrigin,childDirection);
            if(data != null && data.time < minTime)
            {
               minData = data;
               minTime = data.time;
            }
            child = child.alternativa3d::next;
         }
         return minData;
      }
      
      public function get concatenatedMatrix() : Matrix3D
      {
         if(this.alternativa3d::transformChanged)
         {
            this.alternativa3d::composeTransforms();
         }
         trm.copy(this.alternativa3d::transform);
         for(var root:Object3D = this; root.parent != null; )
         {
            root = root.parent;
            if(root.alternativa3d::transformChanged)
            {
               root.alternativa3d::composeTransforms();
            }
            trm.append(root.alternativa3d::transform);
         }
         return new Matrix3D(Vector.<Number>([trm.a,trm.e,trm.i,0,trm.b,trm.f,trm.j,0,trm.c,trm.g,trm.k,0,trm.d,trm.h,trm.l,1]));
      }
      
      public function localToGlobal(point:Vector3D) : Vector3D
      {
         if(this.alternativa3d::transformChanged)
         {
            this.alternativa3d::composeTransforms();
         }
         trm.copy(this.alternativa3d::transform);
         for(var root:Object3D = this; root.parent != null; )
         {
            root = root.parent;
            if(root.alternativa3d::transformChanged)
            {
               root.alternativa3d::composeTransforms();
            }
            trm.append(root.alternativa3d::transform);
         }
         var res:Vector3D = new Vector3D();
         res.x = trm.a * point.x + trm.b * point.y + trm.c * point.z + trm.d;
         res.y = trm.e * point.x + trm.f * point.y + trm.g * point.z + trm.h;
         res.z = trm.i * point.x + trm.j * point.y + trm.k * point.z + trm.l;
         return res;
      }
      
      public function globalToLocal(point:Vector3D) : Vector3D
      {
         if(this.alternativa3d::transformChanged)
         {
            this.alternativa3d::composeTransforms();
         }
         trm.copy(this.alternativa3d::inverseTransform);
         for(var root:Object3D = this; root.parent != null; )
         {
            root = root.parent;
            if(root.alternativa3d::transformChanged)
            {
               root.alternativa3d::composeTransforms();
            }
            trm.prepend(root.alternativa3d::inverseTransform);
         }
         var res:Vector3D = new Vector3D();
         res.x = trm.a * point.x + trm.b * point.y + trm.c * point.z + trm.d;
         res.y = trm.e * point.x + trm.f * point.y + trm.g * point.z + trm.h;
         res.z = trm.i * point.x + trm.j * point.y + trm.k * point.z + trm.l;
         return res;
      }
      
      alternativa3d function get useLights() : Boolean
      {
         return false;
      }
      
      public function calculateBoundBox() : void
      {
         if(this.boundBox != null)
         {
            this.boundBox.reset();
         }
         else
         {
            this.boundBox = new BoundBox();
         }
         this.alternativa3d::updateBoundBox(this.boundBox,false,null);
      }
      
      alternativa3d function updateBoundBox(boundBox:BoundBox, hierarchy:Boolean, transform:Transform3D = null) : void
      {
         var child:Object3D = null;
         if(hierarchy)
         {
            for(child = this.alternativa3d::childrenList; child != null; child = child.alternativa3d::next)
            {
               if(child.alternativa3d::transformChanged)
               {
                  child.alternativa3d::composeTransforms();
               }
               child.alternativa3d::localToCameraTransform.copy(child.alternativa3d::transform);
               if(transform != null)
               {
                  child.alternativa3d::localToCameraTransform.append(transform);
               }
               child.alternativa3d::updateBoundBox(boundBox,true,child.alternativa3d::localToCameraTransform);
            }
         }
      }
      
      public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false) : void
      {
         var listeners:Object = null;
         if(listener == null)
         {
            throw new TypeError("Parameter listener must be non-null.");
         }
         if(useCapture)
         {
            if(this.alternativa3d::captureListeners == null)
            {
               this.alternativa3d::captureListeners = new Object();
            }
            listeners = this.alternativa3d::captureListeners;
         }
         else
         {
            if(this.alternativa3d::bubbleListeners == null)
            {
               this.alternativa3d::bubbleListeners = new Object();
            }
            listeners = this.alternativa3d::bubbleListeners;
         }
         var vector:Vector.<Function> = listeners[type];
         if(vector == null)
         {
            vector = new Vector.<Function>();
            listeners[type] = vector;
         }
         if(vector.indexOf(listener) < 0)
         {
            vector.push(listener);
         }
      }
      
      public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false) : void
      {
         var vector:Vector.<Function> = null;
         var i:int = 0;
         var length:int = 0;
         var j:int = 0;
         var _loc9_:* = undefined;
         if(listener == null)
         {
            throw new TypeError("Parameter listener must be non-null.");
         }
         var listeners:Object = useCapture ? this.alternativa3d::captureListeners : this.alternativa3d::bubbleListeners;
         if(listeners != null)
         {
            vector = listeners[type];
            if(vector != null)
            {
               i = int(vector.indexOf(listener));
               if(i >= 0)
               {
                  length = int(vector.length);
                  for(j = i + 1; j < length; j++,i++)
                  {
                     vector[i] = vector[j];
                  }
                  if(length > 1)
                  {
                     vector.length = length - 1;
                  }
                  else
                  {
                     delete listeners[type];
                     var _loc10_:int = 0;
                     var _loc11_:* = listeners;
                     for(_loc9_ in _loc11_)
                     {
                     }
                     if(!_loc9_)
                     {
                        if(listeners == this.alternativa3d::captureListeners)
                        {
                           this.alternativa3d::captureListeners = null;
                        }
                        else
                        {
                           this.alternativa3d::bubbleListeners = null;
                        }
                     }
                  }
               }
            }
         }
      }
      
      public function hasEventListener(type:String) : Boolean
      {
         return this.alternativa3d::captureListeners != null && Boolean(this.alternativa3d::captureListeners[type]) || this.alternativa3d::bubbleListeners != null && Boolean(this.alternativa3d::bubbleListeners[type]);
      }
      
      public function willTrigger(type:String) : Boolean
      {
         for(var object:Object3D = this; object != null; )
         {
            if(object.alternativa3d::captureListeners != null && object.alternativa3d::captureListeners[type] || object.alternativa3d::bubbleListeners != null && object.alternativa3d::bubbleListeners[type])
            {
               return true;
            }
            object = object.alternativa3d::_parent;
         }
         return false;
      }
      
      public function dispatchEvent(event:Event) : Boolean
      {
         var object:Object3D = null;
         var i:int = 0;
         var j:int = 0;
         var length:int = 0;
         var vector:Vector.<Function> = null;
         var functions:Vector.<Function> = null;
         if(event == null)
         {
            throw new TypeError("Parameter event must be non-null.");
         }
         var event3D:Event3D = event as Event3D;
         if(event3D != null)
         {
            event3D.alternativa3d::name_314 = this;
         }
         var branch:Vector.<Object3D> = new Vector.<Object3D>();
         var branchLength:int = 0;
         for(object = this; object != null; object = object.alternativa3d::_parent)
         {
            branch[branchLength] = object;
            branchLength++;
         }
         for(i = branchLength - 1; i > 0; )
         {
            object = branch[i];
            if(event3D != null)
            {
               event3D.alternativa3d::name_313 = object;
               event3D.alternativa3d::name_312 = EventPhase.CAPTURING_PHASE;
            }
            if(object.alternativa3d::captureListeners != null)
            {
               vector = object.alternativa3d::captureListeners[event.type];
               if(vector != null)
               {
                  length = int(vector.length);
                  functions = new Vector.<Function>();
                  for(j = 0; j < length; functions[j] = vector[j],j++)
                  {
                  }
                  for(j = 0; j < length; (functions[j] as Function).call(null,event),j++)
                  {
                  }
               }
            }
            i--;
         }
         if(event3D != null)
         {
            event3D.alternativa3d::name_312 = EventPhase.AT_TARGET;
         }
         for(i = 0; i < branchLength; )
         {
            object = branch[i];
            if(event3D != null)
            {
               event3D.alternativa3d::name_313 = object;
               if(i > 0)
               {
                  event3D.alternativa3d::name_312 = EventPhase.BUBBLING_PHASE;
               }
            }
            if(object.alternativa3d::bubbleListeners != null)
            {
               vector = object.alternativa3d::bubbleListeners[event.type];
               if(vector != null)
               {
                  length = int(vector.length);
                  functions = new Vector.<Function>();
                  for(j = 0; j < length; functions[j] = vector[j],j++)
                  {
                  }
                  for(j = 0; j < length; (functions[j] as Function).call(null,event),j++)
                  {
                  }
               }
            }
            if(!event.bubbles)
            {
               break;
            }
            i++;
         }
         return true;
      }
      
      public function get parent() : Object3D
      {
         return this.alternativa3d::_parent;
      }
      
      alternativa3d function removeFromParent() : void
      {
         if(this.alternativa3d::_parent != null)
         {
            this.alternativa3d::_parent.removeFromList(this);
         }
      }
      
      public function addChild(child:Object3D) : Object3D
      {
         if(child == null)
         {
            throw new TypeError("Parameter child must be non-null.");
         }
         if(child == this)
         {
            throw new ArgumentError("An object cannot be added as a child of itself.");
         }
         for(var container:Object3D = this.alternativa3d::_parent; container != null; )
         {
            if(container == child)
            {
               throw new ArgumentError("An object cannot be added as a child to one of it\'s children (or children\'s children, etc.).");
            }
            container = container.alternativa3d::_parent;
         }
         if(child.alternativa3d::_parent != null)
         {
            child.alternativa3d::_parent.removeChild(child);
         }
         this.addToList(child);
         if(child.willTrigger(Event3D.ADDED))
         {
            child.dispatchEvent(new Event3D(Event3D.ADDED,true));
         }
         return child;
      }
      
      public function removeChild(child:Object3D) : Object3D
      {
         if(child == null)
         {
            throw new TypeError("Parameter child must be non-null.");
         }
         if(child.alternativa3d::_parent != this)
         {
            throw new ArgumentError("The supplied Object3D must be a child of the caller.");
         }
         if(child.willTrigger(Event3D.REMOVED))
         {
            child.dispatchEvent(new Event3D(Event3D.REMOVED,true));
         }
         var result:Object3D = this.removeFromList(child);
         if(result == null)
         {
            throw new ArgumentError("Cannot remove child.");
         }
         return result;
      }
      
      private function removeFromList(child:Object3D) : Object3D
      {
         var prev:Object3D = null;
         var current:Object3D = null;
         for(current = this.alternativa3d::childrenList; current != null; current = current.alternativa3d::next)
         {
            if(current == child)
            {
               if(prev != null)
               {
                  prev.alternativa3d::next = current.alternativa3d::next;
               }
               else
               {
                  this.alternativa3d::childrenList = current.alternativa3d::next;
               }
               current.alternativa3d::next = null;
               current.alternativa3d::_parent = null;
               return child;
            }
            prev = current;
         }
         return null;
      }
      
      public function addChildAt(child:Object3D, index:int) : Object3D
      {
         if(child == null)
         {
            throw new TypeError("Parameter child must be non-null.");
         }
         if(child == this)
         {
            throw new ArgumentError("An object cannot be added as a child of itself.");
         }
         if(index < 0)
         {
            throw new RangeError("The supplied index is out of bounds.");
         }
         for(var container:Object3D = this.alternativa3d::_parent; container != null; )
         {
            if(container == child)
            {
               throw new ArgumentError("An object cannot be added as a child to one of it\'s children (or children\'s children, etc.).");
            }
            container = container.alternativa3d::_parent;
         }
         var current:Object3D = this.alternativa3d::childrenList;
         for(var i:int = 0; i < index; i++)
         {
            if(current == null)
            {
               throw new RangeError("The supplied index is out of bounds.");
            }
            current = current.alternativa3d::next;
         }
         if(child.alternativa3d::_parent != null)
         {
            child.alternativa3d::_parent.removeChild(child);
         }
         this.addToList(child,current);
         if(child.willTrigger(Event3D.ADDED))
         {
            child.dispatchEvent(new Event3D(Event3D.ADDED,true));
         }
         return child;
      }
      
      public function removeChildAt(index:int) : Object3D
      {
         if(index < 0)
         {
            throw new RangeError("The supplied index is out of bounds.");
         }
         var current:Object3D = this.alternativa3d::childrenList;
         for(var i:int = 0; i < index; i++)
         {
            if(current == null)
            {
               throw new RangeError("The supplied index is out of bounds.");
            }
            current = current.alternativa3d::next;
         }
         if(current == null)
         {
            throw new RangeError("The supplied index is out of bounds.");
         }
         this.removeChild(current);
         return current;
      }
      
      public function getChildAt(index:int) : Object3D
      {
         if(index < 0)
         {
            throw new RangeError("The supplied index is out of bounds.");
         }
         var current:Object3D = this.alternativa3d::childrenList;
         for(var i:int = 0; i < index; i++)
         {
            if(current == null)
            {
               throw new RangeError("The supplied index is out of bounds.");
            }
            current = current.alternativa3d::next;
         }
         if(current == null)
         {
            throw new RangeError("The supplied index is out of bounds.");
         }
         return current;
      }
      
      public function getChildIndex(child:Object3D) : int
      {
         if(child == null)
         {
            throw new TypeError("Parameter child must be non-null.");
         }
         if(child.alternativa3d::_parent != this)
         {
            throw new ArgumentError("The supplied Object3D must be a child of the caller.");
         }
         var index:int = 0;
         for(var current:Object3D = this.alternativa3d::childrenList; current != null; current = current.alternativa3d::next)
         {
            if(current == child)
            {
               return index;
            }
            index++;
         }
         throw new ArgumentError("Cannot get child index.");
      }
      
      public function setChildIndex(child:Object3D, index:int) : void
      {
         if(child == null)
         {
            throw new TypeError("Parameter child must be non-null.");
         }
         if(child.alternativa3d::_parent != this)
         {
            throw new ArgumentError("The supplied Object3D must be a child of the caller.");
         }
         if(index < 0)
         {
            throw new RangeError("The supplied index is out of bounds.");
         }
         var current:Object3D = this.alternativa3d::childrenList;
         for(var i:int = 0; i < index; i++)
         {
            if(current == null)
            {
               throw new RangeError("The supplied index is out of bounds.");
            }
            current = current.alternativa3d::next;
         }
         this.removeFromList(child);
         this.addToList(child,current);
      }
      
      public function swapChildren(child1:Object3D, child2:Object3D) : void
      {
         var _loc3_:Object3D = null;
         if(child1 == null || child2 == null)
         {
            throw new TypeError("Parameter child must be non-null.");
         }
         if(child1.alternativa3d::_parent != this || child2.alternativa3d::_parent != this)
         {
            throw new ArgumentError("The supplied Object3D must be a child of the caller.");
         }
         if(child1 != child2)
         {
            if(child1.alternativa3d::next == child2)
            {
               this.removeFromList(child2);
               this.addToList(child2,child1);
            }
            else if(child2.alternativa3d::next == child1)
            {
               this.removeFromList(child1);
               this.addToList(child1,child2);
            }
            else
            {
               _loc3_ = child1.alternativa3d::next;
               this.removeFromList(child1);
               this.addToList(child1,child2);
               this.removeFromList(child2);
               this.addToList(child2,_loc3_);
            }
         }
      }
      
      public function swapChildrenAt(index1:int, index2:int) : void
      {
         var i:int = 0;
         var child1:Object3D = null;
         var child2:Object3D = null;
         var _loc6_:Object3D = null;
         if(index1 < 0 || index2 < 0)
         {
            throw new RangeError("The supplied index is out of bounds.");
         }
         if(index1 != index2)
         {
            child1 = this.alternativa3d::childrenList;
            for(i = 0; i < index1; i++)
            {
               if(child1 == null)
               {
                  throw new RangeError("The supplied index is out of bounds.");
               }
               child1 = child1.alternativa3d::next;
            }
            if(child1 == null)
            {
               throw new RangeError("The supplied index is out of bounds.");
            }
            child2 = this.alternativa3d::childrenList;
            for(i = 0; i < index2; i++)
            {
               if(child2 == null)
               {
                  throw new RangeError("The supplied index is out of bounds.");
               }
               child2 = child2.alternativa3d::next;
            }
            if(child2 == null)
            {
               throw new RangeError("The supplied index is out of bounds.");
            }
            if(child1 != child2)
            {
               if(child1.alternativa3d::next == child2)
               {
                  this.removeFromList(child2);
                  this.addToList(child2,child1);
               }
               else if(child2.alternativa3d::next == child1)
               {
                  this.removeFromList(child1);
                  this.addToList(child1,child2);
               }
               else
               {
                  _loc6_ = child1.alternativa3d::next;
                  this.removeFromList(child1);
                  this.addToList(child1,child2);
                  this.removeFromList(child2);
                  this.addToList(child2,_loc6_);
               }
            }
         }
      }
      
      public function getChildByName(name:String) : Object3D
      {
         if(name == null)
         {
            throw new TypeError("Parameter name must be non-null.");
         }
         for(var child:Object3D = this.alternativa3d::childrenList; child != null; )
         {
            if(child.name == name)
            {
               return child;
            }
            child = child.alternativa3d::next;
         }
         return null;
      }
      
      public function contains(child:Object3D) : Boolean
      {
         if(child == null)
         {
            throw new TypeError("Parameter child must be non-null.");
         }
         if(child == this)
         {
            return true;
         }
         for(var object:Object3D = this.alternativa3d::childrenList; object != null; )
         {
            if(object.contains(child))
            {
               return true;
            }
            object = object.alternativa3d::next;
         }
         return false;
      }
      
      public function get numChildren() : int
      {
         var num:int = 0;
         for(var current:Object3D = this.alternativa3d::childrenList; current != null; num++,current = current.alternativa3d::next)
         {
         }
         return num;
      }
      
      private function addToList(child:Object3D, item:Object3D = null) : void
      {
         var _loc3_:Object3D = null;
         child.alternativa3d::next = item;
         child.alternativa3d::_parent = this;
         if(item == this.alternativa3d::childrenList)
         {
            this.alternativa3d::childrenList = child;
         }
         else
         {
            for(_loc3_ = this.alternativa3d::childrenList; _loc3_ != null; )
            {
               if(_loc3_.alternativa3d::next == item)
               {
                  _loc3_.alternativa3d::next = child;
                  break;
               }
               _loc3_ = _loc3_.alternativa3d::next;
            }
         }
      }
      
      public function getResources(hierarchy:Boolean = false, resourceType:Class = null) : Vector.<Resource>
      {
         var key:* = undefined;
         var res:Vector.<Resource> = new Vector.<Resource>();
         var dict:Dictionary = new Dictionary();
         var count:int = 0;
         this.alternativa3d::fillResources(dict,hierarchy,resourceType);
         for(key in dict)
         {
            var _loc9_:* = count++;
            res[_loc9_] = key as Resource;
         }
         return res;
      }
      
      alternativa3d function fillResources(resources:Dictionary, hierarchy:Boolean = false, resourceType:Class = null) : void
      {
         var child:Object3D = null;
         if(hierarchy)
         {
            for(child = this.alternativa3d::childrenList; child != null; child = child.alternativa3d::next)
            {
               child.alternativa3d::fillResources(resources,hierarchy,resourceType);
            }
         }
      }
      
      alternativa3d function composeTransforms() : void
      {
         var cosX:Number = NaN;
         var sinX:Number = NaN;
         var cosY:Number = NaN;
         var sinY:Number = NaN;
         var cosZ:Number = NaN;
         var sinZ:Number = NaN;
         cosX = Number(Math.cos(this.alternativa3d::_rotationX));
         sinX = Number(Math.sin(this.alternativa3d::_rotationX));
         cosY = Number(Math.cos(this.alternativa3d::_rotationY));
         sinY = Number(Math.sin(this.alternativa3d::_rotationY));
         cosZ = Number(Math.cos(this.alternativa3d::_rotationZ));
         sinZ = Number(Math.sin(this.alternativa3d::_rotationZ));
         var cosZsinY:Number = cosZ * sinY;
         var sinZsinY:Number = sinZ * sinY;
         var cosYscaleX:Number = cosY * this.alternativa3d::_scaleX;
         var sinXscaleY:Number = sinX * this.alternativa3d::_scaleY;
         var cosXscaleY:Number = cosX * this.alternativa3d::_scaleY;
         var cosXscaleZ:Number = cosX * this.alternativa3d::_scaleZ;
         var sinXscaleZ:Number = sinX * this.alternativa3d::_scaleZ;
         this.alternativa3d::transform.a = cosZ * cosYscaleX;
         this.alternativa3d::transform.b = cosZsinY * sinXscaleY - sinZ * cosXscaleY;
         this.alternativa3d::transform.c = cosZsinY * cosXscaleZ + sinZ * sinXscaleZ;
         this.alternativa3d::transform.d = this.alternativa3d::_x;
         this.alternativa3d::transform.e = sinZ * cosYscaleX;
         this.alternativa3d::transform.f = sinZsinY * sinXscaleY + cosZ * cosXscaleY;
         this.alternativa3d::transform.g = sinZsinY * cosXscaleZ - cosZ * sinXscaleZ;
         this.alternativa3d::transform.h = this.alternativa3d::_y;
         this.alternativa3d::transform.i = -sinY * this.alternativa3d::_scaleX;
         this.alternativa3d::transform.j = cosY * sinXscaleY;
         this.alternativa3d::transform.k = cosY * cosXscaleZ;
         this.alternativa3d::transform.l = this.alternativa3d::_z;
         var sinXsinY:Number = sinX * sinY;
         cosYscaleX = cosY / this.alternativa3d::_scaleX;
         cosXscaleY = cosX / this.alternativa3d::_scaleY;
         sinXscaleZ = -sinX / this.alternativa3d::_scaleZ;
         cosXscaleZ = cosX / this.alternativa3d::_scaleZ;
         this.alternativa3d::inverseTransform.a = cosZ * cosYscaleX;
         this.alternativa3d::inverseTransform.b = sinZ * cosYscaleX;
         this.alternativa3d::inverseTransform.c = -sinY / this.alternativa3d::_scaleX;
         this.alternativa3d::inverseTransform.d = -this.alternativa3d::inverseTransform.a * this.alternativa3d::_x - this.alternativa3d::inverseTransform.b * this.alternativa3d::_y - this.alternativa3d::inverseTransform.c * this.alternativa3d::_z;
         this.alternativa3d::inverseTransform.e = sinXsinY * cosZ / this.alternativa3d::_scaleY - sinZ * cosXscaleY;
         this.alternativa3d::inverseTransform.f = cosZ * cosXscaleY + sinXsinY * sinZ / this.alternativa3d::_scaleY;
         this.alternativa3d::inverseTransform.g = sinX * cosY / this.alternativa3d::_scaleY;
         this.alternativa3d::inverseTransform.h = -this.alternativa3d::inverseTransform.e * this.alternativa3d::_x - this.alternativa3d::inverseTransform.f * this.alternativa3d::_y - this.alternativa3d::inverseTransform.g * this.alternativa3d::_z;
         this.alternativa3d::inverseTransform.i = cosZ * sinY * cosXscaleZ - sinZ * sinXscaleZ;
         this.alternativa3d::inverseTransform.j = cosZ * sinXscaleZ + sinY * sinZ * cosXscaleZ;
         this.alternativa3d::inverseTransform.k = cosY * cosXscaleZ;
         this.alternativa3d::inverseTransform.l = -this.alternativa3d::inverseTransform.i * this.alternativa3d::_x - this.alternativa3d::inverseTransform.j * this.alternativa3d::_y - this.alternativa3d::inverseTransform.k * this.alternativa3d::_z;
         this.alternativa3d::transformChanged = false;
      }
      
      alternativa3d function calculateVisibility(camera:Camera3D) : void
      {
      }
      
      alternativa3d function calculateChildrenVisibility(camera:Camera3D) : void
      {
         for(var child:Object3D = this.alternativa3d::childrenList; child != null; )
         {
            if(child.visible)
            {
               if(child.alternativa3d::transformChanged)
               {
                  child.alternativa3d::composeTransforms();
               }
               child.alternativa3d::cameraToLocalTransform.combine(child.alternativa3d::inverseTransform,this.alternativa3d::cameraToLocalTransform);
               child.alternativa3d::listening = this.alternativa3d::listening || child.alternativa3d::bubbleListeners != null || child.alternativa3d::captureListeners != null;
               if(child.boundBox != null)
               {
                  camera.alternativa3d::calculateFrustum(child.alternativa3d::cameraToLocalTransform);
                  child.alternativa3d::culling = child.boundBox.alternativa3d::checkFrustumCulling(camera.alternativa3d::frustum,63);
               }
               else
               {
                  child.alternativa3d::culling = 63;
               }
               if(child.alternativa3d::culling >= 0)
               {
                  child.alternativa3d::calculateVisibility(camera);
               }
               if(child.alternativa3d::childrenList != null)
               {
                  child.alternativa3d::calculateChildrenVisibility(camera);
               }
            }
            child = child.alternativa3d::next;
         }
      }
      
      alternativa3d function collectDraws(camera:Camera3D, lights:Vector.<Light3D>, lightsLength:int) : void
      {
      }
      
      alternativa3d function collectChildrenDraws(camera:Camera3D, lights:Vector.<Light3D>, lightsLength:int) : void
      {
         var i:int = 0;
         var light:Light3D = null;
         var childLightsLength:int = 0;
         for(var child:Object3D = this.alternativa3d::childrenList; child != null; )
         {
            if(child.visible)
            {
               child.alternativa3d::localToCameraTransform.combine(this.alternativa3d::localToCameraTransform,child.alternativa3d::transform);
               if(child.alternativa3d::culling >= 0 && (child.boundBox == null || camera.alternativa3d::occludersLength == 0 || Boolean(child.boundBox.alternativa3d::checkOcclusionCulling(camera,child))))
               {
                  if(child.alternativa3d::listening && child.boundBox != null)
                  {
                     camera.alternativa3d::calculateRays(child.alternativa3d::cameraToLocalTransform);
                     child.alternativa3d::listening = child.boundBox.alternativa3d::checkRays(camera.alternativa3d::origins,camera.alternativa3d::directions,camera.alternativa3d::raysLength);
                  }
                  if(lightsLength > 0 && child.alternativa3d::useLights)
                  {
                     if(child.boundBox != null)
                     {
                        childLightsLength = 0;
                        for(i = 0; i < lightsLength; )
                        {
                           light = lights[i];
                           light.alternativa3d::name_80.combine(child.alternativa3d::cameraToLocalTransform,light.alternativa3d::localToCameraTransform);
                           if(light.boundBox == null || light.alternativa3d::checkBound(child))
                           {
                              camera.alternativa3d::childLights[childLightsLength] = light;
                              childLightsLength++;
                           }
                           i++;
                        }
                        child.alternativa3d::collectDraws(camera,camera.alternativa3d::childLights,childLightsLength);
                     }
                     else
                     {
                        for(i = 0; i < lightsLength; )
                        {
                           light = lights[i];
                           light.alternativa3d::name_80.combine(child.alternativa3d::cameraToLocalTransform,light.alternativa3d::localToCameraTransform);
                           i++;
                        }
                        child.alternativa3d::collectDraws(camera,lights,lightsLength);
                     }
                  }
                  else
                  {
                     child.alternativa3d::collectDraws(camera,null,0);
                  }
               }
               if(child.alternativa3d::childrenList != null)
               {
                  child.alternativa3d::collectChildrenDraws(camera,lights,lightsLength);
               }
            }
            child = child.alternativa3d::next;
         }
      }
      
      alternativa3d function collectGeometry(collider:EllipsoidCollider, excludedObjects:Dictionary) : void
      {
      }
      
      alternativa3d function collectChildrenGeometry(collider:EllipsoidCollider, excludedObjects:Dictionary) : void
      {
         var intersects:Boolean = false;
         for(var child:Object3D = this.alternativa3d::childrenList; child != null; )
         {
            if(excludedObjects == null || !excludedObjects[child])
            {
               if(child.alternativa3d::transformChanged)
               {
                  child.alternativa3d::composeTransforms();
               }
               child.alternativa3d::globalToLocalTransform.combine(child.alternativa3d::inverseTransform,this.alternativa3d::globalToLocalTransform);
               intersects = true;
               if(child.boundBox != null)
               {
                  collider.alternativa3d::calculateSphere(child.alternativa3d::globalToLocalTransform);
                  intersects = Boolean(child.boundBox.alternativa3d::checkSphere(collider.alternativa3d::sphere));
               }
               if(intersects)
               {
                  child.alternativa3d::localToGlobalTransform.combine(this.alternativa3d::localToGlobalTransform,child.alternativa3d::transform);
                  child.alternativa3d::collectGeometry(collider,excludedObjects);
               }
               if(child.alternativa3d::childrenList != null)
               {
                  child.alternativa3d::collectChildrenGeometry(collider,excludedObjects);
               }
            }
            child = child.alternativa3d::next;
         }
      }
      
      alternativa3d function setTransformConstants(drawUnit:DrawUnit, surface:Surface, vertexShader:Linker, camera:Camera3D) : void
      {
      }
      
      public function clone() : Object3D
      {
         var res:Object3D = new Object3D();
         res.clonePropertiesFrom(this);
         return res;
      }
      
      protected function clonePropertiesFrom(source:Object3D) : void
      {
         var lastChild:Object3D = null;
         var newChild:Object3D = null;
         this.name = source.name;
         this.visible = source.visible;
         this.mouseEnabled = source.mouseEnabled;
         this.mouseChildren = source.mouseChildren;
         this.doubleClickEnabled = source.doubleClickEnabled;
         this.useHandCursor = source.useHandCursor;
         this.boundBox = Boolean(source.boundBox) ? source.boundBox.clone() : null;
         this.alternativa3d::_x = source.alternativa3d::_x;
         this.alternativa3d::_y = source.alternativa3d::_y;
         this.alternativa3d::_z = source.alternativa3d::_z;
         this.alternativa3d::_rotationX = source.alternativa3d::_rotationX;
         this.alternativa3d::_rotationY = source.alternativa3d::_rotationY;
         this.alternativa3d::_rotationZ = source.alternativa3d::_rotationZ;
         this.alternativa3d::_scaleX = source.alternativa3d::_scaleX;
         this.alternativa3d::_scaleY = source.alternativa3d::_scaleY;
         this.alternativa3d::_scaleZ = source.alternativa3d::_scaleZ;
         for(var child:Object3D = source.alternativa3d::childrenList; child != null; child = child.alternativa3d::next)
         {
            newChild = child.clone();
            if(this.alternativa3d::childrenList != null)
            {
               lastChild.alternativa3d::next = newChild;
            }
            else
            {
               this.alternativa3d::childrenList = newChild;
            }
            lastChild = newChild;
            newChild.alternativa3d::_parent = this;
         }
      }
      
      public function toString() : String
      {
         var className:String = getQualifiedClassName(this);
         return "[" + className.substr(className.indexOf("::") + 2) + " " + this.name + "]";
      }
   }
}

