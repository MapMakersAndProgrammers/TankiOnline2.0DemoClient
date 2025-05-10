package alternativa.engine3d.core
{
   import alternativa.engine3d.alternativa3d;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.display.Stage3D;
   import flash.display.StageAlign;
   import flash.display3D.Context3D;
   import flash.events.Event;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.geom.Vector3D;
   import flash.system.System;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import flash.utils.Dictionary;
   import flash.utils.getDefinitionByName;
   import flash.utils.getQualifiedClassName;
   import flash.utils.getQualifiedSuperclassName;
   import flash.utils.getTimer;
   
   use namespace alternativa3d;
   
   public class Camera3D extends Object3D
   {
      public var view:View;
      
      public var fov:Number = 1.5707963267948966;
      
      public var nearClipping:Number;
      
      public var farClipping:Number;
      
      public var orthographic:Boolean = false;
      
      alternativa3d var focalLength:Number;
      
      alternativa3d var m0:Number;
      
      alternativa3d var m5:Number;
      
      alternativa3d var m10:Number;
      
      alternativa3d var m14:Number;
      
      alternativa3d var correctionX:Number;
      
      alternativa3d var correctionY:Number;
      
      alternativa3d var lights:Vector.<Light3D> = new Vector.<Light3D>();
      
      alternativa3d var lightsLength:int = 0;
      
      alternativa3d var ambient:Vector.<Number> = new Vector.<Number>(4);
      
      alternativa3d var childLights:Vector.<Light3D> = new Vector.<Light3D>();
      
      alternativa3d var frustum:CullingPlane;
      
      alternativa3d var origins:Vector.<Vector3D> = new Vector.<Vector3D>();
      
      alternativa3d var directions:Vector.<Vector3D> = new Vector.<Vector3D>();
      
      alternativa3d var raysLength:int = 0;
      
      alternativa3d var occluders:Vector.<Occluder> = new Vector.<Occluder>();
      
      alternativa3d var occludersLength:int = 0;
      
      alternativa3d var context3D:Context3D;
      
      alternativa3d var renderer:Renderer;
      
      alternativa3d var numDraws:int;
      
      alternativa3d var numTriangles:int;
      
      public var debug:Boolean = false;
      
      private var debugSet:Object = new Object();
      
      private var _diagram:Sprite = this.createDiagram();
      
      public var fpsUpdatePeriod:int = 10;
      
      public var timerUpdatePeriod:int = 10;
      
      private var fpsTextField:TextField;
      
      private var memoryTextField:TextField;
      
      private var drawsTextField:TextField;
      
      private var trianglesTextField:TextField;
      
      private var timerTextField:TextField;
      
      private var graph:Bitmap;
      
      private var rect:Rectangle;
      
      private var _diagramAlign:String = "TR";
      
      private var _diagramHorizontalMargin:Number = 2;
      
      private var _diagramVerticalMargin:Number = 2;
      
      private var fpsUpdateCounter:int;
      
      private var previousFrameTime:int;
      
      private var previousPeriodTime:int;
      
      private var maxMemory:int;
      
      private var timerUpdateCounter:int;
      
      private var timeSum:int;
      
      private var timeCount:int;
      
      private var timer:int;
      
      public function Camera3D(nearClipping:Number, farClipping:Number)
      {
         super();
         this.nearClipping = nearClipping;
         this.farClipping = farClipping;
         this.alternativa3d::renderer = new Renderer();
         this.alternativa3d::frustum = new CullingPlane();
         this.alternativa3d::frustum.next = new CullingPlane();
         this.alternativa3d::frustum.next.next = new CullingPlane();
         this.alternativa3d::frustum.next.next.next = new CullingPlane();
         this.alternativa3d::frustum.next.next.next.next = new CullingPlane();
         this.alternativa3d::frustum.next.next.next.next.next = new CullingPlane();
      }
      
      public function render(stage3D:Stage3D) : void
      {
         var i:int = 0;
         var light:Light3D = null;
         var root:Object3D = null;
         var childLightsLength:int = 0;
         if(stage3D == null)
         {
            throw new TypeError("Parameter stage3D must be non-null.");
         }
         this.alternativa3d::numDraws = 0;
         this.alternativa3d::numTriangles = 0;
         this.alternativa3d::occludersLength = 0;
         this.alternativa3d::lightsLength = 0;
         this.alternativa3d::ambient[0] = 0;
         this.alternativa3d::ambient[1] = 0;
         this.alternativa3d::ambient[2] = 0;
         this.alternativa3d::ambient[3] = 1;
         this.alternativa3d::context3D = stage3D.context3D;
         if(this.alternativa3d::context3D != null && this.view != null && this.alternativa3d::renderer != null && (this.view.stage != null || this.view.alternativa3d::_-gJ != null))
         {
            this.alternativa3d::renderer.alternativa3d::camera = this;
            this.alternativa3d::calculateProjection(this.view.alternativa3d::_-qj,this.view.alternativa3d::_height);
            this.view.alternativa3d::prepareToRender(stage3D,this.alternativa3d::context3D);
            if(alternativa3d::transformChanged)
            {
               alternativa3d::composeTransforms();
            }
            alternativa3d::localToGlobalTransform.copy(alternativa3d::transform);
            alternativa3d::globalToLocalTransform.copy(alternativa3d::inverseTransform);
            for(root = this; root.parent != null; )
            {
               root = root.parent;
               if(root.alternativa3d::transformChanged)
               {
                  root.alternativa3d::composeTransforms();
               }
               alternativa3d::localToGlobalTransform.append(root.alternativa3d::transform);
               alternativa3d::globalToLocalTransform.prepend(root.alternativa3d::inverseTransform);
            }
            this.view.alternativa3d::calculateRays(this);
            for(i = int(this.alternativa3d::origins.length); i < this.view.alternativa3d::raysLength; i++)
            {
               this.alternativa3d::origins[i] = new Vector3D();
               this.alternativa3d::directions[i] = new Vector3D();
            }
            this.alternativa3d::raysLength = this.view.alternativa3d::raysLength;
            if(root.visible)
            {
               root.alternativa3d::cameraToLocalTransform.combine(root.alternativa3d::inverseTransform,alternativa3d::localToGlobalTransform);
               root.alternativa3d::listening = root.alternativa3d::bubbleListeners != null || root.alternativa3d::captureListeners != null;
               if(root.boundBox != null)
               {
                  this.alternativa3d::calculateFrustum(root.alternativa3d::cameraToLocalTransform);
                  root.alternativa3d::culling = root.boundBox.alternativa3d::checkFrustumCulling(this.alternativa3d::frustum,63);
               }
               else
               {
                  root.alternativa3d::culling = 63;
               }
               if(root.alternativa3d::culling >= 0)
               {
                  root.alternativa3d::calculateVisibility(this);
               }
               root.alternativa3d::calculateChildrenVisibility(this);
               for(i = 0; i < this.alternativa3d::lightsLength; i++)
               {
                  light = this.alternativa3d::lights[i];
                  light.alternativa3d::localToCameraTransform.calculateInversion(light.alternativa3d::cameraToLocalTransform);
                  light.alternativa3d::red = (light.color >> 16 & 0xFF) * light.intensity / 255;
                  light.alternativa3d::green = (light.color >> 8 & 0xFF) * light.intensity / 255;
                  light.alternativa3d::blue = (light.color & 0xFF) * light.intensity / 255;
               }
               root.alternativa3d::localToCameraTransform.combine(alternativa3d::globalToLocalTransform,root.alternativa3d::transform);
               if(root.alternativa3d::culling >= 0 && (root.boundBox == null || this.alternativa3d::occludersLength == 0 || Boolean(root.boundBox.alternativa3d::checkOcclusionCulling(this,root))))
               {
                  if(root.alternativa3d::listening && root.boundBox != null)
                  {
                     this.alternativa3d::calculateRays(root.alternativa3d::cameraToLocalTransform);
                     root.alternativa3d::listening = root.boundBox.alternativa3d::checkRays(this.alternativa3d::origins,this.alternativa3d::directions,this.alternativa3d::raysLength);
                  }
                  if(this.alternativa3d::lightsLength > 0 && root.alternativa3d::useLights)
                  {
                     if(root.boundBox != null)
                     {
                        childLightsLength = 0;
                        for(i = 0; i < this.alternativa3d::lightsLength; )
                        {
                           light = this.alternativa3d::lights[i];
                           light.alternativa3d::_-cl.combine(root.alternativa3d::cameraToLocalTransform,light.alternativa3d::localToCameraTransform);
                           if(light.boundBox == null || light.alternativa3d::checkBound(root))
                           {
                              this.alternativa3d::childLights[childLightsLength] = light;
                              childLightsLength++;
                           }
                           i++;
                        }
                        root.alternativa3d::collectDraws(this,this.alternativa3d::childLights,childLightsLength);
                     }
                     else
                     {
                        for(i = 0; i < this.alternativa3d::lightsLength; )
                        {
                           light = this.alternativa3d::lights[i];
                           light.alternativa3d::_-cl.combine(root.alternativa3d::cameraToLocalTransform,light.alternativa3d::localToCameraTransform);
                           i++;
                        }
                        root.alternativa3d::collectDraws(this,this.alternativa3d::lights,this.alternativa3d::lightsLength);
                     }
                  }
                  else
                  {
                     root.alternativa3d::collectDraws(this,null,0);
                  }
               }
               root.alternativa3d::collectChildrenDraws(this,this.alternativa3d::lights,this.alternativa3d::lightsLength);
            }
            this.view.alternativa3d::processMouseEvents(this.alternativa3d::context3D,this);
            this.alternativa3d::renderer.alternativa3d::render(this.alternativa3d::context3D);
            if(this.view.alternativa3d::_-gJ == null)
            {
               this.alternativa3d::context3D.present();
            }
            else
            {
               this.alternativa3d::context3D.drawToBitmapData(this.view.alternativa3d::_-gJ);
               this.alternativa3d::context3D.present();
            }
         }
         this.alternativa3d::lights.length = 0;
         this.alternativa3d::childLights.length = 0;
         this.alternativa3d::occluders.length = 0;
         this.alternativa3d::context3D = null;
      }
      
      public function projectGlobal(point:Vector3D) : Vector3D
      {
         if(this.view == null)
         {
            throw new Error("It is necessary to have view set.");
         }
         var viewSizeX:Number = this.view.alternativa3d::_-qj * 0.5;
         var viewSizeY:Number = this.view.alternativa3d::_height * 0.5;
         var focalLength:Number = Math.sqrt(viewSizeX * viewSizeX + viewSizeY * viewSizeY) / Math.tan(this.fov * 0.5);
         var res:Vector3D = globalToLocal(point);
         res.x = res.x * focalLength / res.z + viewSizeX;
         res.y = res.y * focalLength / res.z + viewSizeY;
         return res;
      }
      
      public function calculateRay(origin:Vector3D, direction:Vector3D, viewX:Number, viewY:Number) : void
      {
         if(this.view == null)
         {
            throw new Error("It is necessary to have view set.");
         }
         var viewSizeX:Number = this.view.alternativa3d::_-qj * 0.5;
         var viewSizeY:Number = this.view.alternativa3d::_height * 0.5;
         var focalLength:Number = Math.sqrt(viewSizeX * viewSizeX + viewSizeY * viewSizeY) / Math.tan(this.fov * 0.5);
         var dx:Number = viewX - viewSizeX;
         var dy:Number = viewY - viewSizeY;
         var ox:Number = dx * this.nearClipping / focalLength;
         var oy:Number = dy * this.nearClipping / focalLength;
         var oz:Number = this.nearClipping;
         if(alternativa3d::transformChanged)
         {
            alternativa3d::composeTransforms();
         }
         trm.copy(alternativa3d::transform);
         for(var root:Object3D = this; root.parent != null; )
         {
            root = root.parent;
            if(root.alternativa3d::transformChanged)
            {
               root.alternativa3d::composeTransforms();
            }
            trm.append(root.alternativa3d::transform);
         }
         origin.x = trm.a * ox + trm.b * oy + trm.c * oz + trm.d;
         origin.y = trm.e * ox + trm.f * oy + trm.g * oz + trm.h;
         origin.z = trm.i * ox + trm.j * oy + trm.k * oz + trm.l;
         direction.x = trm.a * dx + trm.b * dy + trm.c * focalLength;
         direction.y = trm.e * dx + trm.f * dy + trm.g * focalLength;
         direction.z = trm.i * dx + trm.j * dy + trm.k * focalLength;
         var directionL:Number = 1 / Math.sqrt(direction.x * direction.x + direction.y * direction.y + direction.z * direction.z);
         direction.x *= directionL;
         direction.y *= directionL;
         direction.z *= directionL;
      }
      
      override public function clone() : Object3D
      {
         var res:Camera3D = new Camera3D(this.nearClipping,this.farClipping);
         res.clonePropertiesFrom(this);
         return res;
      }
      
      override protected function clonePropertiesFrom(source:Object3D) : void
      {
         super.clonePropertiesFrom(source);
         this.view = (source as Camera3D).view;
      }
      
      alternativa3d function calculateProjection(width:Number, height:Number) : void
      {
         var viewSizeX:Number = width * 0.5;
         var viewSizeY:Number = height * 0.5;
         this.alternativa3d::focalLength = Math.sqrt(viewSizeX * viewSizeX + viewSizeY * viewSizeY) / Math.tan(this.fov * 0.5);
         if(!this.orthographic)
         {
            this.alternativa3d::m0 = this.alternativa3d::focalLength / viewSizeX;
            this.alternativa3d::m5 = -this.alternativa3d::focalLength / viewSizeY;
            this.alternativa3d::m10 = this.farClipping / (this.farClipping - this.nearClipping);
            this.alternativa3d::m14 = -this.nearClipping * this.alternativa3d::m10;
         }
         else
         {
            this.alternativa3d::m0 = 1 / viewSizeX;
            this.alternativa3d::m5 = -1 / viewSizeY;
            this.alternativa3d::m10 = 1 / (this.farClipping - this.nearClipping);
            this.alternativa3d::m14 = -this.nearClipping * this.alternativa3d::m10;
         }
         this.alternativa3d::correctionX = viewSizeX / this.alternativa3d::focalLength;
         this.alternativa3d::correctionY = viewSizeY / this.alternativa3d::focalLength;
      }
      
      alternativa3d function calculateFrustum(transform:Transform3D) : void
      {
         var fa:Number = NaN;
         var fe:Number = NaN;
         var fi:Number = NaN;
         var fb:Number = NaN;
         var ff:Number = NaN;
         var fj:Number = NaN;
         var ax:Number = NaN;
         var ay:Number = NaN;
         var az:Number = NaN;
         var bx:Number = NaN;
         var by:Number = NaN;
         var bz:Number = NaN;
         var _loc20_:Number = NaN;
         var _loc21_:Number = NaN;
         var nearPlane:CullingPlane = this.alternativa3d::frustum;
         var farPlane:CullingPlane = nearPlane.next;
         var leftPlane:CullingPlane = farPlane.next;
         var rightPlane:CullingPlane = leftPlane.next;
         var topPlane:CullingPlane = rightPlane.next;
         var bottomPlane:CullingPlane = topPlane.next;
         if(!this.orthographic)
         {
            fa = transform.a * this.alternativa3d::correctionX;
            fe = transform.e * this.alternativa3d::correctionX;
            fi = transform.i * this.alternativa3d::correctionX;
            fb = transform.b * this.alternativa3d::correctionY;
            ff = transform.f * this.alternativa3d::correctionY;
            fj = transform.j * this.alternativa3d::correctionY;
            nearPlane.x = fj * fe - ff * fi;
            nearPlane.y = fb * fi - fj * fa;
            nearPlane.z = ff * fa - fb * fe;
            nearPlane.offset = (transform.d + transform.c * this.nearClipping) * nearPlane.x + (transform.h + transform.g * this.nearClipping) * nearPlane.y + (transform.l + transform.k * this.nearClipping) * nearPlane.z;
            farPlane.x = -nearPlane.x;
            farPlane.y = -nearPlane.y;
            farPlane.z = -nearPlane.z;
            farPlane.offset = (transform.d + transform.c * this.farClipping) * farPlane.x + (transform.h + transform.g * this.farClipping) * farPlane.y + (transform.l + transform.k * this.farClipping) * farPlane.z;
            ax = -fa - fb + transform.c;
            ay = -fe - ff + transform.g;
            az = -fi - fj + transform.k;
            bx = fa - fb + transform.c;
            by = fe - ff + transform.g;
            bz = fi - fj + transform.k;
            topPlane.x = bz * ay - by * az;
            topPlane.y = bx * az - bz * ax;
            topPlane.z = by * ax - bx * ay;
            topPlane.offset = transform.d * topPlane.x + transform.h * topPlane.y + transform.l * topPlane.z;
            ax = bx;
            ay = by;
            az = bz;
            bx = fa + fb + transform.c;
            by = fe + ff + transform.g;
            bz = fi + fj + transform.k;
            rightPlane.x = bz * ay - by * az;
            rightPlane.y = bx * az - bz * ax;
            rightPlane.z = by * ax - bx * ay;
            rightPlane.offset = transform.d * rightPlane.x + transform.h * rightPlane.y + transform.l * rightPlane.z;
            ax = bx;
            ay = by;
            az = bz;
            bx = -fa + fb + transform.c;
            by = -fe + ff + transform.g;
            bz = -fi + fj + transform.k;
            bottomPlane.x = bz * ay - by * az;
            bottomPlane.y = bx * az - bz * ax;
            bottomPlane.z = by * ax - bx * ay;
            bottomPlane.offset = transform.d * bottomPlane.x + transform.h * bottomPlane.y + transform.l * bottomPlane.z;
            ax = bx;
            ay = by;
            az = bz;
            bx = -fa - fb + transform.c;
            by = -fe - ff + transform.g;
            bz = -fi - fj + transform.k;
            leftPlane.x = bz * ay - by * az;
            leftPlane.y = bx * az - bz * ax;
            leftPlane.z = by * ax - bx * ay;
            leftPlane.offset = transform.d * leftPlane.x + transform.h * leftPlane.y + transform.l * leftPlane.z;
         }
         else
         {
            _loc20_ = this.view.alternativa3d::_-qj * 0.5;
            _loc21_ = this.view.alternativa3d::_height * 0.5;
            nearPlane.x = transform.j * transform.e - transform.f * transform.i;
            nearPlane.y = transform.b * transform.i - transform.j * transform.a;
            nearPlane.z = transform.f * transform.a - transform.b * transform.e;
            nearPlane.offset = (transform.d + transform.c * this.nearClipping) * nearPlane.x + (transform.h + transform.g * this.nearClipping) * nearPlane.y + (transform.l + transform.k * this.nearClipping) * nearPlane.z;
            farPlane.x = -nearPlane.x;
            farPlane.y = -nearPlane.y;
            farPlane.z = -nearPlane.z;
            farPlane.offset = (transform.d + transform.c * this.farClipping) * farPlane.x + (transform.h + transform.g * this.farClipping) * farPlane.y + (transform.l + transform.k * this.farClipping) * farPlane.z;
            topPlane.x = transform.i * transform.g - transform.e * transform.k;
            topPlane.y = transform.a * transform.k - transform.i * transform.c;
            topPlane.z = transform.e * transform.c - transform.a * transform.g;
            topPlane.offset = (transform.d - transform.b * _loc21_) * topPlane.x + (transform.h - transform.f * _loc21_) * topPlane.y + (transform.l - transform.j * _loc21_) * topPlane.z;
            bottomPlane.x = -topPlane.x;
            bottomPlane.y = -topPlane.y;
            bottomPlane.z = -topPlane.z;
            bottomPlane.offset = (transform.d + transform.b * _loc21_) * bottomPlane.x + (transform.h + transform.f * _loc21_) * bottomPlane.y + (transform.l + transform.j * _loc21_) * bottomPlane.z;
            leftPlane.x = transform.k * transform.f - transform.g * transform.j;
            leftPlane.y = transform.c * transform.j - transform.k * transform.b;
            leftPlane.z = transform.g * transform.b - transform.c * transform.f;
            leftPlane.offset = (transform.d - transform.a * _loc20_) * leftPlane.x + (transform.h - transform.e * _loc20_) * leftPlane.y + (transform.l - transform.i * _loc20_) * leftPlane.z;
            rightPlane.x = -leftPlane.x;
            rightPlane.y = -leftPlane.y;
            rightPlane.z = -leftPlane.z;
            rightPlane.offset = (transform.d + transform.a * _loc20_) * rightPlane.x + (transform.h + transform.e * _loc20_) * rightPlane.y + (transform.l + transform.i * _loc20_) * rightPlane.z;
         }
      }
      
      alternativa3d function calculateRays(transform:Transform3D) : void
      {
         var o:Vector3D = null;
         var d:Vector3D = null;
         var origin:Vector3D = null;
         var direction:Vector3D = null;
         for(var i:int = 0; i < this.alternativa3d::raysLength; i++)
         {
            o = this.view.alternativa3d::_-Cr[i];
            d = this.view.alternativa3d::_-g4[i];
            origin = this.alternativa3d::origins[i];
            direction = this.alternativa3d::directions[i];
            origin.x = transform.a * o.x + transform.b * o.y + transform.c * o.z + transform.d;
            origin.y = transform.e * o.x + transform.f * o.y + transform.g * o.z + transform.h;
            origin.z = transform.i * o.x + transform.j * o.y + transform.k * o.z + transform.l;
            direction.x = transform.a * d.x + transform.b * d.y + transform.c * d.z;
            direction.y = transform.e * d.x + transform.f * d.y + transform.g * d.z;
            direction.z = transform.i * d.x + transform.j * d.y + transform.k * d.z;
         }
      }
      
      public function addToDebug(debug:int, objectOrClass:*) : void
      {
         if(!this.debugSet[debug])
         {
            this.debugSet[debug] = new Dictionary();
         }
         this.debugSet[debug][objectOrClass] = true;
      }
      
      public function removeFromDebug(debug:int, objectOrClass:*) : void
      {
         var key:* = undefined;
         if(Boolean(this.debugSet[debug]))
         {
            delete this.debugSet[debug][objectOrClass];
            var _loc4_:int = 0;
            var _loc5_:* = this.debugSet[debug];
            for(key in _loc5_)
            {
            }
            if(!key)
            {
               delete this.debugSet[debug];
            }
         }
      }
      
      alternativa3d function checkInDebug(object:Object3D) : int
      {
         var _loc4_:Class = null;
         var res:int = 0;
         for(var debug:int = 1; debug <= 512; )
         {
            if(Boolean(this.debugSet[debug]))
            {
               if(Boolean(this.debugSet[debug][Object3D]) || Boolean(this.debugSet[debug][object]))
               {
                  res |= debug;
               }
               else
               {
                  for(_loc4_ = getDefinitionByName(getQualifiedClassName(object)) as Class; _loc4_ != Object3D; )
                  {
                     if(Boolean(this.debugSet[debug][_loc4_]))
                     {
                        res |= debug;
                        break;
                     }
                     _loc4_ = Class(getDefinitionByName(getQualifiedSuperclassName(_loc4_)));
                  }
               }
            }
            debug <<= 1;
         }
         return res;
      }
      
      public function startTimer() : void
      {
         this.timer = getTimer();
      }
      
      public function stopTimer() : void
      {
         this.timeSum += getTimer() - this.timer;
         ++this.timeCount;
      }
      
      public function get diagram() : DisplayObject
      {
         return this._diagram;
      }
      
      public function get diagramAlign() : String
      {
         return this._diagramAlign;
      }
      
      public function set diagramAlign(value:String) : void
      {
         this._diagramAlign = value;
         this.resizeDiagram();
      }
      
      public function get diagramHorizontalMargin() : Number
      {
         return this._diagramHorizontalMargin;
      }
      
      public function set diagramHorizontalMargin(value:Number) : void
      {
         this._diagramHorizontalMargin = value;
         this.resizeDiagram();
      }
      
      public function get diagramVerticalMargin() : Number
      {
         return this._diagramVerticalMargin;
      }
      
      public function set diagramVerticalMargin(value:Number) : void
      {
         this._diagramVerticalMargin = value;
         this.resizeDiagram();
      }
      
      private function createDiagram() : Sprite
      {
         var diagram:Sprite = null;
         diagram = new Sprite();
         diagram.mouseEnabled = false;
         diagram.mouseChildren = false;
         this.fpsTextField = new TextField();
         this.fpsTextField.defaultTextFormat = new TextFormat("Tahoma",10,13421772);
         this.fpsTextField.autoSize = TextFieldAutoSize.LEFT;
         this.fpsTextField.text = "FPS:";
         this.fpsTextField.selectable = false;
         this.fpsTextField.x = -3;
         this.fpsTextField.y = -5;
         diagram.addChild(this.fpsTextField);
         this.timerTextField = new TextField();
         this.timerTextField.defaultTextFormat = new TextFormat("Tahoma",10,26367);
         this.timerTextField.autoSize = TextFieldAutoSize.LEFT;
         this.timerTextField.text = "MS:";
         this.timerTextField.selectable = false;
         this.timerTextField.x = -3;
         this.timerTextField.y = 4;
         diagram.addChild(this.timerTextField);
         this.memoryTextField = new TextField();
         this.memoryTextField.defaultTextFormat = new TextFormat("Tahoma",10,13421568);
         this.memoryTextField.autoSize = TextFieldAutoSize.LEFT;
         this.memoryTextField.text = "MEM:";
         this.memoryTextField.selectable = false;
         this.memoryTextField.x = -3;
         this.memoryTextField.y = 13;
         diagram.addChild(this.memoryTextField);
         this.drawsTextField = new TextField();
         this.drawsTextField.defaultTextFormat = new TextFormat("Tahoma",10,52224);
         this.drawsTextField.autoSize = TextFieldAutoSize.LEFT;
         this.drawsTextField.text = "DRW:";
         this.drawsTextField.selectable = false;
         this.drawsTextField.x = -3;
         this.drawsTextField.y = 22;
         diagram.addChild(this.drawsTextField);
         this.trianglesTextField = new TextField();
         this.trianglesTextField.defaultTextFormat = new TextFormat("Tahoma",10,16724736);
         this.trianglesTextField.autoSize = TextFieldAutoSize.LEFT;
         this.trianglesTextField.text = "TRI:";
         this.trianglesTextField.selectable = false;
         this.trianglesTextField.x = -3;
         this.trianglesTextField.y = 31;
         diagram.addChild(this.trianglesTextField);
         diagram.addEventListener(Event.ADDED_TO_STAGE,function():void
         {
            fpsTextField = new TextField();
            fpsTextField.defaultTextFormat = new TextFormat("Tahoma",10,13421772);
            fpsTextField.autoSize = TextFieldAutoSize.RIGHT;
            fpsTextField.text = Number(diagram.stage.frameRate).toFixed(2);
            fpsTextField.selectable = false;
            fpsTextField.x = -3;
            fpsTextField.y = -5;
            fpsTextField.width = 85;
            diagram.addChild(fpsTextField);
            timerTextField = new TextField();
            timerTextField.defaultTextFormat = new TextFormat("Tahoma",10,26367);
            timerTextField.autoSize = TextFieldAutoSize.RIGHT;
            timerTextField.text = "";
            timerTextField.selectable = false;
            timerTextField.x = -3;
            timerTextField.y = 4;
            timerTextField.width = 85;
            diagram.addChild(timerTextField);
            memoryTextField = new TextField();
            memoryTextField.defaultTextFormat = new TextFormat("Tahoma",10,13421568);
            memoryTextField.autoSize = TextFieldAutoSize.RIGHT;
            memoryTextField.text = bytesToString(System.totalMemory);
            memoryTextField.selectable = false;
            memoryTextField.x = -3;
            memoryTextField.y = 13;
            memoryTextField.width = 85;
            diagram.addChild(memoryTextField);
            drawsTextField = new TextField();
            drawsTextField.defaultTextFormat = new TextFormat("Tahoma",10,52224);
            drawsTextField.autoSize = TextFieldAutoSize.RIGHT;
            drawsTextField.text = "0";
            drawsTextField.selectable = false;
            drawsTextField.x = -3;
            drawsTextField.y = 22;
            drawsTextField.width = 72;
            diagram.addChild(drawsTextField);
            trianglesTextField = new TextField();
            trianglesTextField.defaultTextFormat = new TextFormat("Tahoma",10,16724736);
            trianglesTextField.autoSize = TextFieldAutoSize.RIGHT;
            trianglesTextField.text = "0";
            trianglesTextField.selectable = false;
            trianglesTextField.x = -3;
            trianglesTextField.y = 31;
            trianglesTextField.width = 72;
            diagram.addChild(trianglesTextField);
            graph = new Bitmap(new BitmapData(80,40,true,553648127));
            rect = new Rectangle(0,0,1,40);
            graph.x = 0;
            graph.y = 45;
            diagram.addChild(graph);
            previousPeriodTime = getTimer();
            previousFrameTime = previousPeriodTime;
            fpsUpdateCounter = 0;
            maxMemory = 0;
            timerUpdateCounter = 0;
            timeSum = 0;
            timeCount = 0;
            diagram.stage.addEventListener(Event.ENTER_FRAME,updateDiagram,false,-1000);
            diagram.stage.addEventListener(Event.RESIZE,resizeDiagram,false,-1000);
            resizeDiagram();
         });
         diagram.addEventListener(Event.REMOVED_FROM_STAGE,function():void
         {
            diagram.removeChild(fpsTextField);
            diagram.removeChild(memoryTextField);
            diagram.removeChild(drawsTextField);
            diagram.removeChild(trianglesTextField);
            diagram.removeChild(timerTextField);
            diagram.removeChild(graph);
            fpsTextField = null;
            memoryTextField = null;
            drawsTextField = null;
            trianglesTextField = null;
            timerTextField = null;
            graph.bitmapData.dispose();
            graph = null;
            rect = null;
            diagram.stage.removeEventListener(Event.ENTER_FRAME,updateDiagram);
            diagram.stage.removeEventListener(Event.RESIZE,resizeDiagram);
         });
         return diagram;
      }
      
      private function resizeDiagram(e:Event = null) : void
      {
         var coord:Point = null;
         if(this._diagram.stage != null)
         {
            coord = this._diagram.parent.globalToLocal(new Point());
            if(this._diagramAlign == StageAlign.TOP_LEFT || this._diagramAlign == StageAlign.LEFT || this._diagramAlign == StageAlign.BOTTOM_LEFT)
            {
               this._diagram.x = Math.round(coord.x + this._diagramHorizontalMargin);
            }
            if(this._diagramAlign == StageAlign.TOP || this._diagramAlign == StageAlign.BOTTOM)
            {
               this._diagram.x = Math.round(coord.x + this._diagram.stage.stageWidth / 2 - this.graph.width / 2);
            }
            if(this._diagramAlign == StageAlign.TOP_RIGHT || this._diagramAlign == StageAlign.RIGHT || this._diagramAlign == StageAlign.BOTTOM_RIGHT)
            {
               this._diagram.x = Math.round(coord.x + this._diagram.stage.stageWidth - this._diagramHorizontalMargin - this.graph.width);
            }
            if(this._diagramAlign == StageAlign.TOP_LEFT || this._diagramAlign == StageAlign.TOP || this._diagramAlign == StageAlign.TOP_RIGHT)
            {
               this._diagram.y = Math.round(coord.y + this._diagramVerticalMargin);
            }
            if(this._diagramAlign == StageAlign.LEFT || this._diagramAlign == StageAlign.RIGHT)
            {
               this._diagram.y = Math.round(coord.y + this._diagram.stage.stageHeight / 2 - (this.graph.y + this.graph.height) / 2);
            }
            if(this._diagramAlign == StageAlign.BOTTOM_LEFT || this._diagramAlign == StageAlign.BOTTOM || this._diagramAlign == StageAlign.BOTTOM_RIGHT)
            {
               this._diagram.y = Math.round(coord.y + this._diagram.stage.stageHeight - this._diagramVerticalMargin - this.graph.y - this.graph.height);
            }
         }
      }
      
      private function updateDiagram(e:Event) : void
      {
         var value:Number = NaN;
         var mod:int = 0;
         var time:int = int(getTimer());
         var stageFrameRate:int = int(this._diagram.stage.frameRate);
         if(++this.fpsUpdateCounter == this.fpsUpdatePeriod)
         {
            value = 1000 * this.fpsUpdatePeriod / (time - this.previousPeriodTime);
            if(value > stageFrameRate)
            {
               value = stageFrameRate;
            }
            mod = value * 100 % 100;
            this.fpsTextField.text = int(value) + "." + (mod >= 10 ? mod : (mod > 0 ? "0" + mod : "00"));
            this.previousPeriodTime = time;
            this.fpsUpdateCounter = 0;
         }
         value = 1000 / (time - this.previousFrameTime);
         if(value > stageFrameRate)
         {
            value = stageFrameRate;
         }
         this.graph.bitmapData.scroll(1,0);
         this.graph.bitmapData.fillRect(this.rect,553648127);
         this.graph.bitmapData.setPixel32(0,40 * (1 - value / stageFrameRate),4291611852);
         this.previousFrameTime = time;
         if(++this.timerUpdateCounter == this.timerUpdatePeriod)
         {
            if(this.timeCount > 0)
            {
               value = this.timeSum / this.timeCount;
               mod = value * 100 % 100;
               this.timerTextField.text = int(value) + "." + (mod >= 10 ? mod : (mod > 0 ? "0" + mod : "00"));
            }
            else
            {
               this.timerTextField.text = "";
            }
            this.timerUpdateCounter = 0;
            this.timeSum = 0;
            this.timeCount = 0;
         }
         var memory:int = int(System.totalMemory);
         value = memory / 1048576;
         mod = value * 100 % 100;
         this.memoryTextField.text = int(value) + "." + (mod >= 10 ? mod : (mod > 0 ? "0" + mod : "00"));
         if(memory > this.maxMemory)
         {
            this.maxMemory = memory;
         }
         this.graph.bitmapData.setPixel32(0,40 * (1 - memory / this.maxMemory),4291611648);
         this.drawsTextField.text = this.formatInt(this.alternativa3d::numDraws);
         this.trianglesTextField.text = this.formatInt(this.alternativa3d::numTriangles);
      }
      
      private function formatInt(num:int) : String
      {
         var n:int = 0;
         var s:String = null;
         if(num < 1000)
         {
            return "" + num;
         }
         if(num < 1000000)
         {
            n = num % 1000;
            if(n < 10)
            {
               s = "00" + n;
            }
            else if(n < 100)
            {
               s = "0" + n;
            }
            else
            {
               s = "" + n;
            }
            return int(num / 1000) + " " + s;
         }
         n = num % 1000000 / 1000;
         if(n < 10)
         {
            s = "00" + n;
         }
         else if(n < 100)
         {
            s = "0" + n;
         }
         else
         {
            s = "" + n;
         }
         n = num % 1000;
         if(n < 10)
         {
            s += " 00" + n;
         }
         else if(n < 100)
         {
            s += " 0" + n;
         }
         else
         {
            s += " " + n;
         }
         return int(num / 1000000) + " " + s;
      }
      
      private function bytesToString(bytes:int) : String
      {
         if(bytes < 1024)
         {
            return bytes + "b";
         }
         if(bytes < 10240)
         {
            return (bytes / 1024).toFixed(2) + "kb";
         }
         if(bytes < 102400)
         {
            return (bytes / 1024).toFixed(1) + "kb";
         }
         if(bytes < 1048576)
         {
            return (bytes >> 10) + "kb";
         }
         if(bytes < 10485760)
         {
            return (bytes / 1048576).toFixed(2);
         }
         if(bytes < 104857600)
         {
            return (bytes / 1048576).toFixed(1);
         }
         return String(bytes >> 20);
      }
   }
}

