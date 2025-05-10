package alternativa.engine3d.core
{
   import alternativa.Alternativa3D;
   import alternativa.engine3d.alternativa3d;
   import alternativa.engine3d.core.events.MouseEvent3D;
   import alternativa.engine3d.materials.ShaderProgram;
   import alternativa.engine3d.materials.compiler.Linker;
   import alternativa.engine3d.materials.compiler.Procedure;
   import alternativa.engine3d.materials.compiler.VariableType;
   import alternativa.engine3d.objects.Surface;
   import alternativa.engine3d.resources.Geometry;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.display.Stage3D;
   import flash.display.StageAlign;
   import flash.display3D.Context3D;
   import flash.display3D.Context3DBlendFactor;
   import flash.display3D.Context3DCompareMode;
   import flash.display3D.Context3DProgramType;
   import flash.display3D.Context3DTextureFormat;
   import flash.display3D.Context3DTriangleFace;
   import flash.display3D.VertexBuffer3D;
   import flash.display3D.textures.Texture;
   import flash.events.ContextMenuEvent;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.geom.Vector3D;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import flash.ui.ContextMenu;
   import flash.ui.ContextMenuItem;
   import flash.ui.Keyboard;
   import flash.ui.Mouse;
   import flash.utils.Dictionary;
   import flash.utils.setTimeout;
   
   use namespace alternativa3d;
   
   public class View extends Sprite
   {
      private static var drawDistanceFragment:Linker;
      
      private static var drawDistanceVertexProcedure:Procedure;
      
      private static const renderEvent:MouseEvent = new MouseEvent("render");
      
      private static const drawDistancePrograms:Dictionary = new Dictionary();
      
      private static const drawUnit:DrawUnit = new DrawUnit();
      
      private static const pixels:Dictionary = new Dictionary();
      
      private static const stack:Vector.<int> = new Vector.<int>();
      
      private static const point:Point = new Point();
      
      private static const scissor:Rectangle = new Rectangle(0,0,1,1);
      
      private static const rectangle:Rectangle = new Rectangle();
      
      private static const zeroRectangle:Rectangle = new Rectangle();
      
      private static const localCoords:Vector3D = new Vector3D();
      
      private static const branch:Vector.<Object3D> = new Vector.<Object3D>();
      
      private static const overedBranch:Vector.<Object3D> = new Vector.<Object3D>();
      
      private static const changedBranch:Vector.<Object3D> = new Vector.<Object3D>();
      
      private static const functions:Vector.<Function> = new Vector.<Function>();
      
      private static var drawRectGeometries:Dictionary = new Dictionary(true);
      
      private static var drawDistanceTextures:Dictionary = new Dictionary(true);
      
      private static var drawDistanceTexturesWidths:Dictionary = new Dictionary(true);
      
      private static var drawTexturedRectPrograms:Dictionary = new Dictionary(true);
      
      private static const drawTexturedRectUVScaleConst:Vector.<Number> = Vector.<Number>([1,1,1,1]);
      
      private static var drawColoredRectPrograms:Dictionary = new Dictionary(true);
      
      private static const drawColoredRectConst:Vector.<Number> = Vector.<Number>([0,0,-1,1]);
      
      private static const drawRectColor:Vector.<Number> = new Vector.<Number>(4);
      
      public var backgroundColor:uint;
      
      public var backgroundAlpha:Number;
      
      public var antiAlias:int;
      
      alternativa3d var name_qj:int;
      
      alternativa3d var _height:int;
      
      alternativa3d var name_gJ:BitmapData = null;
      
      private var name_j6:Vector.<MouseEvent>;
      
      private var indices:Vector.<int>;
      
      private var name_Zv:int = 0;
      
      private var surfaces:Vector.<Surface>;
      
      private var geometries:Vector.<Geometry>;
      
      private var name_2L:Vector.<Procedure>;
      
      private var name_8b:int = 0;
      
      alternativa3d var name_Cr:Vector.<Vector3D>;
      
      alternativa3d var name_g4:Vector.<Vector3D>;
      
      private var name_Ql:Vector.<Point>;
      
      private var name_extends:Vector.<Vector.<Surface>>;
      
      private var name_9L:Vector.<Vector.<Number>>;
      
      private var name_4N:Vector.<int>;
      
      private var name_ff:Vector.<int>;
      
      alternativa3d var raysLength:int = 0;
      
      private var name_Ki:MouseEvent;
      
      private var target:Object3D;
      
      private var targetSurface:Surface;
      
      private var name_Cu:Number;
      
      private var name_B4:Object3D;
      
      private var name_c3:Object3D;
      
      private var name_Lx:Object3D;
      
      private var name_H7:Surface;
      
      private var altKey:Boolean;
      
      private var ctrlKey:Boolean;
      
      private var shiftKey:Boolean;
      
      private var container:Bitmap;
      
      private var area:Sprite;
      
      private var name_N2:Logo;
      
      private var name_OE:Bitmap;
      
      private var name_bx:String = "BR";
      
      private var name_hq:Number = 0;
      
      private var name_Xc:Number = 0;
      
      private var name_IE:Boolean;
      
      public function View(width:int, height:int, renderToBitmap:Boolean = false, backgroundColor:uint = 0, backgroundAlpha:Number = 1, antiAlias:int = 0)
      {
         var item:ContextMenuItem;
         var menu:ContextMenu;
         this.name_j6 = new Vector.<MouseEvent>();
         this.indices = new Vector.<int>();
         this.surfaces = new Vector.<Surface>();
         this.geometries = new Vector.<Geometry>();
         this.name_2L = new Vector.<Procedure>();
         this.name_Cr = new Vector.<Vector3D>();
         this.name_g4 = new Vector.<Vector3D>();
         this.name_Ql = new Vector.<Point>();
         this.name_extends = new Vector.<Vector.<Surface>>();
         this.name_9L = new Vector.<Vector.<Number>>();
         this.name_4N = new Vector.<int>();
         this.name_ff = new Vector.<int>();
         super();
         if(width < 50)
         {
            width = 50;
         }
         if(height < 50)
         {
            height = 50;
         }
         this.name_qj = width;
         this.alternativa3d::_height = height;
         this.name_IE = renderToBitmap;
         this.backgroundColor = backgroundColor;
         this.backgroundAlpha = backgroundAlpha;
         this.antiAlias = antiAlias;
         mouseEnabled = true;
         mouseChildren = true;
         doubleClickEnabled = true;
         buttonMode = true;
         useHandCursor = false;
         tabEnabled = false;
         tabChildren = false;
         item = new ContextMenuItem("Powered by Alternativa3D " + Alternativa3D.version);
         item.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT,function(e:ContextMenuEvent):void
         {
            try
            {
               navigateToURL(new URLRequest("http://alternativaplatform.com"),"_blank");
            }
            catch(e:Error)
            {
            }
         });
         menu = new ContextMenu();
         menu.customItems = [item];
         contextMenu = menu;
         this.container = new Bitmap();
         if(renderToBitmap)
         {
            this.createRenderBitmap();
         }
         super.addChild(this.container);
         this.area = new Sprite();
         this.area.graphics.beginFill(16711680);
         this.area.graphics.drawRect(0,0,100,100);
         this.area.mouseEnabled = false;
         this.area.visible = false;
         this.area.width = this.name_qj;
         this.area.height = this.alternativa3d::_height;
         hitArea = this.area;
         super.addChild(hitArea);
         this.showLogo();
         if(drawDistanceFragment == null)
         {
            drawDistanceVertexProcedure = Procedure.compileFromArray(["#v0=distance","#c0=transform0","#c1=transform1","#c2=transform2","#c3=coefficient","#c4=projection","dp4 t0.x, i0, c0","dp4 t0.y, i0, c1","dp4 t0.z, i0, c2","mul v0.x, t0.z, c3.z","mov v0.y, i0.x","mov v0.z, i0.x","mov v0.w, i0.x","mul t1.x, t0.x, c4.x","mul t1.y, t0.y, c4.y","mul t0.w, t0.z, c4.z","add t1.z, t0.w, c4.w","mov t3.z, c4.x","div t3.z, t3.z, c4.x","sub t3.z, t3.z, c3.w","mul t1.w, t0.z, t3.z","add t1.w, t1.w, c3.w","mul t0.x, c3.x, t1.w","mul t0.y, c3.y, t1.w","add t1.x, t1.x, t0.x","add t1.y, t1.y, t0.y","mov o0, t1"],"mouseEventsVertex");
            drawDistanceFragment = new Linker(Context3DProgramType.FRAGMENT);
            drawDistanceFragment.addProcedure(new Procedure(["mov t0.z, c0.z","mov t0.w, c0.w","frc t0.y, v0.x","sub t0.x, v0.x, t0.y","mul t0.x, t0.x, c0.x","mov o0, ft0","#v0=distance","#c0=code"],"mouseEventsFragment"));
         }
         addEventListener(MouseEvent.MOUSE_DOWN,this.onMouse);
         addEventListener(MouseEvent.CLICK,this.onMouse);
         addEventListener(MouseEvent.DOUBLE_CLICK,this.onMouse);
         addEventListener(MouseEvent.MOUSE_MOVE,this.onMouse);
         addEventListener(MouseEvent.MOUSE_OVER,this.onMouse);
         addEventListener(MouseEvent.MOUSE_WHEEL,this.onMouse);
         addEventListener(MouseEvent.MOUSE_OUT,this.onLeave);
         addEventListener(Event.ADDED_TO_STAGE,this.onAddToStage);
         addEventListener(Event.REMOVED_FROM_STAGE,this.onRemoveFromStage);
      }
      
      private function onMouse(mouseEvent:MouseEvent) : void
      {
         var prev:int = this.name_Zv - 1;
         if(this.name_Zv > 0 && mouseEvent.type == "mouseMove" && (this.name_j6[prev] as MouseEvent).type == "mouseMove")
         {
            this.name_j6[prev] = mouseEvent;
         }
         else
         {
            this.name_j6[this.name_Zv] = mouseEvent;
            ++this.name_Zv;
         }
         this.name_Ki = mouseEvent;
      }
      
      private function onLeave(mouseEvent:MouseEvent) : void
      {
         this.name_j6[this.name_Zv] = mouseEvent;
         ++this.name_Zv;
         this.name_Ki = null;
      }
      
      private function createRenderBitmap() : void
      {
         this.name_gJ = new BitmapData(this.name_qj,this.alternativa3d::_height,this.backgroundAlpha < 1,this.backgroundColor);
         this.container.bitmapData = this.name_gJ;
         this.container.smoothing = true;
      }
      
      private function onAddToStage(e:Event) : void
      {
         stage.addEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDown);
         stage.addEventListener(KeyboardEvent.KEY_UP,this.onKeyUp);
      }
      
      private function onRemoveFromStage(e:Event) : void
      {
         stage.removeEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDown);
         stage.removeEventListener(KeyboardEvent.KEY_UP,this.onKeyUp);
         this.altKey = false;
         this.ctrlKey = false;
         this.shiftKey = false;
      }
      
      private function onKeyDown(keyboardEvent:KeyboardEvent) : void
      {
         this.altKey = keyboardEvent.altKey;
         this.ctrlKey = keyboardEvent.ctrlKey;
         this.shiftKey = keyboardEvent.shiftKey;
         if(this.ctrlKey && this.shiftKey && keyboardEvent.keyCode == Keyboard.F1 && this.name_OE == null)
         {
            this.name_OE = new Bitmap(Logo.image);
            this.name_OE.x = Math.round((this.name_qj - this.name_OE.width) / 2);
            this.name_OE.y = Math.round((this.alternativa3d::_height - this.name_OE.height) / 2);
            super.addChild(this.name_OE);
            setTimeout(this.removeBitmap,2048);
         }
      }
      
      private function onKeyUp(keyboardEvent:KeyboardEvent) : void
      {
         this.altKey = keyboardEvent.altKey;
         this.ctrlKey = keyboardEvent.ctrlKey;
         this.shiftKey = keyboardEvent.shiftKey;
      }
      
      private function removeBitmap() : void
      {
         if(this.name_OE != null)
         {
            super.removeChild(this.name_OE);
            this.name_OE = null;
         }
      }
      
      alternativa3d function calculateRays(camera:Camera3D) : void
      {
         var i:int = 0;
         var mouseEvent:MouseEvent = null;
         var mouseMoved:Boolean = false;
         var origin:Vector3D = null;
         var direction:Vector3D = null;
         var coefficient:Point = null;
         if(this.name_Ki != null)
         {
            mouseMoved = false;
            for(i = 0; i < this.name_Zv; )
            {
               mouseEvent = this.name_j6[i];
               if(mouseEvent.type == "mouseMove" || mouseEvent.type == "mouseOut")
               {
                  mouseMoved = true;
                  break;
               }
               i++;
            }
            if(!mouseMoved)
            {
               renderEvent.localX = this.name_Ki.localX;
               renderEvent.localY = this.name_Ki.localY;
               renderEvent.ctrlKey = this.ctrlKey;
               renderEvent.altKey = this.altKey;
               renderEvent.shiftKey = this.shiftKey;
               renderEvent.buttonDown = this.name_Ki.buttonDown;
               renderEvent.delta = 0;
               this.name_j6[this.name_Zv] = renderEvent;
               ++this.name_Zv;
            }
         }
         var mouseX:Number = 1e+22;
         var mouseY:Number = 1e+22;
         for(i = 0; i < this.name_Zv; i++)
         {
            mouseEvent = this.name_j6[i];
            if(mouseEvent.type != "mouseOut")
            {
               if(mouseEvent.localX != mouseX || mouseEvent.localY != mouseY)
               {
                  mouseX = Number(mouseEvent.localX);
                  mouseY = Number(mouseEvent.localY);
                  if(this.alternativa3d::raysLength < this.name_Cr.length)
                  {
                     origin = this.name_Cr[this.alternativa3d::raysLength];
                     direction = this.name_g4[this.alternativa3d::raysLength];
                     coefficient = this.name_Ql[this.alternativa3d::raysLength];
                  }
                  else
                  {
                     origin = new Vector3D();
                     direction = new Vector3D();
                     coefficient = new Point();
                     this.name_Cr[this.alternativa3d::raysLength] = origin;
                     this.name_g4[this.alternativa3d::raysLength] = direction;
                     this.name_Ql[this.alternativa3d::raysLength] = coefficient;
                     this.name_extends[this.alternativa3d::raysLength] = new Vector.<Surface>();
                     this.name_9L[this.alternativa3d::raysLength] = new Vector.<Number>();
                  }
                  if(!camera.orthographic)
                  {
                     direction.x = mouseX - this.name_qj * 0.5;
                     direction.y = mouseY - this.alternativa3d::_height * 0.5;
                     direction.z = camera.alternativa3d::focalLength;
                     origin.x = direction.x * camera.nearClipping / camera.alternativa3d::focalLength;
                     origin.y = direction.y * camera.nearClipping / camera.alternativa3d::focalLength;
                     origin.z = camera.nearClipping;
                     direction.normalize();
                     coefficient.x = mouseX * 2 / this.name_qj;
                     coefficient.y = mouseY * 2 / this.alternativa3d::_height;
                  }
                  else
                  {
                     direction.x = 0;
                     direction.y = 0;
                     direction.z = 1;
                     origin.x = mouseX - this.name_qj * 0.5;
                     origin.y = mouseY - this.alternativa3d::_height * 0.5;
                     origin.z = camera.nearClipping;
                     coefficient.x = mouseX * 2 / this.name_qj;
                     coefficient.y = mouseY * 2 / this.alternativa3d::_height;
                  }
                  ++this.alternativa3d::raysLength;
               }
               this.indices[i] = this.alternativa3d::raysLength - 1;
            }
            else
            {
               this.indices[i] = -1;
            }
         }
      }
      
      alternativa3d function addSurfaceToMouseEvents(surface:Surface, geometry:Geometry, procedure:Procedure) : void
      {
         this.surfaces[this.name_8b] = surface;
         this.geometries[this.name_8b] = geometry;
         this.name_2L[this.name_8b] = procedure;
         ++this.name_8b;
      }
      
      alternativa3d function prepareToRender(stage3D:Stage3D, context:Context3D) : void
      {
         var vis:Boolean = false;
         var parent:DisplayObject = null;
         var coords:Point = null;
         var stage3DObject:Object = stage3D;
         var isIncubator:Boolean = "viewPort" in stage3DObject;
         if(isIncubator)
         {
            if(this.name_qj > 2048)
            {
               this.name_qj = 2048;
            }
            if(this.alternativa3d::_height > 2048)
            {
               this.alternativa3d::_height = 2048;
            }
         }
         if(this.name_gJ == null)
         {
            vis = Boolean(this.visible);
            for(parent = this.parent; parent != null; parent = parent.parent)
            {
               vis &&= Boolean(parent.visible);
            }
            point.x = 0;
            point.y = 0;
            coords = localToGlobal(point);
            if(isIncubator)
            {
               if(vis)
               {
                  rectangle.x = coords.x;
                  rectangle.y = coords.y;
                  point.x = this.name_qj;
                  point.y = this.alternativa3d::_height;
                  coords = localToGlobal(point);
                  rectangle.width = coords.x - rectangle.x;
                  rectangle.height = coords.y - rectangle.y;
                  if(rectangle.width < 0)
                  {
                     rectangle.width = 0;
                  }
                  if(rectangle.height < 0)
                  {
                     rectangle.height = 0;
                  }
                  stage3DObject.viewPort = rectangle;
               }
               else
               {
                  stage3DObject.viewPort = zeroRectangle;
               }
            }
            else
            {
               stage3DObject.x = coords.x;
               stage3DObject.y = coords.y;
               stage3DObject.visible = vis;
            }
         }
         else
         {
            if(isIncubator)
            {
               stage3DObject.viewPort = zeroRectangle;
            }
            else
            {
               stage3DObject.visible = false;
            }
            if(this.name_qj != this.name_gJ.width || this.alternativa3d::_height != this.name_gJ.height || this.backgroundAlpha < 1 != this.name_gJ.transparent)
            {
               this.name_gJ.dispose();
               this.createRenderBitmap();
            }
         }
         context.configureBackBuffer(this.name_qj,this.alternativa3d::_height,this.antiAlias);
         var r:Number = (this.backgroundColor >> 16 & 0xFF) / 255;
         var g:Number = (this.backgroundColor >> 8 & 0xFF) / 255;
         var b:Number = (this.backgroundColor & 0xFF) / 255;
         if(this.canvas != null)
         {
            r *= this.backgroundAlpha;
            g *= this.backgroundAlpha;
            b *= this.backgroundAlpha;
         }
         context.clear(r,g,b,this.backgroundAlpha);
      }
      
      alternativa3d function processMouseEvents(context:Context3D, camera:Camera3D) : void
      {
         var i:int = 0;
         var raySurfaces:Vector.<Surface> = null;
         var rayDepths:Vector.<Number> = null;
         var raySurfacesLength:int = 0;
         var mouseEvent:MouseEvent = null;
         var index:int = 0;
         if(this.name_Zv > 0)
         {
            if(this.name_8b > 0)
            {
               this.calculateSurfacesDepths(context,camera,this.name_qj,this.alternativa3d::_height);
               for(i = 0; i < this.alternativa3d::raysLength; )
               {
                  raySurfaces = this.name_extends[i];
                  rayDepths = this.name_9L[i];
                  raySurfacesLength = int(raySurfaces.length);
                  if(raySurfacesLength > 1)
                  {
                     this.sort(raySurfaces,rayDepths,raySurfacesLength);
                  }
                  i++;
               }
            }
            this.name_Cu = camera.farClipping;
            for(i = 0; i < this.name_Zv; i++)
            {
               mouseEvent = this.name_j6[i];
               index = this.indices[i];
               switch(mouseEvent.type)
               {
                  case "mouseDown":
                     this.defineTarget(index);
                     if(this.target != null)
                     {
                        this.propagateEvent(MouseEvent3D.MOUSE_DOWN,mouseEvent,camera,this.target,this.targetSurface,this.branchToVector(this.target,branch));
                     }
                     this.name_B4 = this.target;
                     break;
                  case "mouseWheel":
                     this.defineTarget(index);
                     if(this.target != null)
                     {
                        this.propagateEvent(MouseEvent3D.MOUSE_WHEEL,mouseEvent,camera,this.target,this.targetSurface,this.branchToVector(this.target,branch));
                     }
                     break;
                  case "click":
                     this.defineTarget(index);
                     if(this.target != null)
                     {
                        this.propagateEvent(MouseEvent3D.MOUSE_UP,mouseEvent,camera,this.target,this.targetSurface,this.branchToVector(this.target,branch));
                        if(this.name_B4 == this.target)
                        {
                           this.name_c3 = this.target;
                           this.propagateEvent(MouseEvent3D.CLICK,mouseEvent,camera,this.target,this.targetSurface,this.branchToVector(this.target,branch));
                        }
                     }
                     this.name_B4 = null;
                     break;
                  case "doubleClick":
                     this.defineTarget(index);
                     if(this.target != null)
                     {
                        this.propagateEvent(MouseEvent3D.MOUSE_UP,mouseEvent,camera,this.target,this.targetSurface,this.branchToVector(this.target,branch));
                        if(this.name_B4 == this.target)
                        {
                           this.propagateEvent(this.name_c3 == this.target && this.target.doubleClickEnabled ? MouseEvent3D.DOUBLE_CLICK : MouseEvent3D.CLICK,mouseEvent,camera,this.target,this.targetSurface,this.branchToVector(this.target,branch));
                        }
                     }
                     this.name_c3 = null;
                     this.name_B4 = null;
                     break;
                  case "mouseMove":
                     this.defineTarget(index);
                     if(this.target != null)
                     {
                        this.propagateEvent(MouseEvent3D.MOUSE_MOVE,mouseEvent,camera,this.target,this.targetSurface,this.branchToVector(this.target,branch));
                     }
                     if(this.name_Lx != this.target)
                     {
                        this.processOverOut(mouseEvent,camera);
                     }
                     break;
                  case "mouseOut":
                     this.name_Ki = null;
                     this.target = null;
                     this.targetSurface = null;
                     if(this.name_Lx != this.target)
                     {
                        this.processOverOut(mouseEvent,camera);
                     }
                     break;
                  case "render":
                     this.defineTarget(index);
                     if(this.name_Lx != this.target)
                     {
                        this.processOverOut(mouseEvent,camera);
                     }
                     break;
               }
               this.target = null;
               this.targetSurface = null;
               this.name_Cu = camera.farClipping;
            }
         }
         this.surfaces.length = 0;
         this.name_8b = 0;
         this.name_j6.length = 0;
         this.name_Zv = 0;
         for(i = 0; i < this.alternativa3d::raysLength; i++)
         {
            this.name_extends[i].length = 0;
            this.name_9L[i].length = 0;
         }
         this.alternativa3d::raysLength = 0;
      }
      
      private function calculateSurfacesDepths(context:Context3D, camera:Camera3D, contextWidth:int, contextHeight:int) : void
      {
         var vLinker:Linker = null;
         var fLinker:Linker = null;
         var i:int = 0;
         var j:int = 0;
         var log2Width:int = 0;
         var texture:Texture = null;
         var textureLog2Width:int = 0;
         var textureHeight:int = 0;
         var rayCoefficients:Point = null;
         var pixel:BitmapData = null;
         var k:int = 0;
         var textureScreenSize:Number = NaN;
         var color:int = 0;
         var red:int = 0;
         var green:int = 0;
         var ind:int = 0;
         var raySurfaces:Vector.<Surface> = null;
         var rayDepths:Vector.<Number> = null;
         context.setBlendFactors(Context3DBlendFactor.ONE,Context3DBlendFactor.ZERO);
         context.setCulling(Context3DTriangleFace.FRONT);
         context.setTextureAt(0,null);
         context.setTextureAt(1,null);
         context.setTextureAt(2,null);
         context.setTextureAt(3,null);
         context.setTextureAt(4,null);
         context.setTextureAt(5,null);
         context.setTextureAt(6,null);
         context.setTextureAt(7,null);
         context.setVertexBufferAt(0,null);
         context.setVertexBufferAt(1,null);
         context.setVertexBufferAt(2,null);
         context.setVertexBufferAt(3,null);
         context.setVertexBufferAt(4,null);
         context.setVertexBufferAt(5,null);
         context.setVertexBufferAt(6,null);
         context.setVertexBufferAt(7,null);
         var drawRectGeometry:Geometry = drawRectGeometries[context];
         if(drawRectGeometry == null)
         {
            drawRectGeometry = new Geometry(4);
            drawRectGeometry.addVertexStream([VertexAttributes.POSITION,VertexAttributes.POSITION,VertexAttributes.POSITION,VertexAttributes.TEXCOORDS[0],VertexAttributes.TEXCOORDS[0]]);
            drawRectGeometry.setAttributeValues(VertexAttributes.POSITION,Vector.<Number>([0,0,1,0,1,1,1,1,1,1,0,1]));
            drawRectGeometry.setAttributeValues(VertexAttributes.TEXCOORDS[0],Vector.<Number>([0,0,0,1,1,1,1,0]));
            drawRectGeometry.indices = Vector.<uint>([0,1,3,2,3,1]);
            drawRectGeometry.upload(context);
            drawRectGeometries[context] = drawRectGeometry;
         }
         var drawColoredRectProgram:ShaderProgram = drawColoredRectPrograms[context];
         if(drawColoredRectProgram == null)
         {
            vLinker = new Linker(Context3DProgramType.VERTEX);
            vLinker.addProcedure(Procedure.compileFromArray(["#a0=a0","#c0=c0","mul t0.x, a0.x, c0.x","mul t0.y, a0.y, c0.y","add o0.x, t0.x, c0.z","add o0.y, t0.y, c0.w","mov o0.z, a0.z","mov o0.w, a0.z"]));
            fLinker = new Linker(Context3DProgramType.FRAGMENT);
            fLinker.addProcedure(Procedure.compileFromArray(["#c0=c0","mov o0, c0"]));
            drawColoredRectProgram = new ShaderProgram(vLinker,fLinker);
            drawColoredRectProgram.upload(context);
            drawColoredRectPrograms[context] = drawColoredRectProgram;
         }
         var drawTexturedRectProgram:ShaderProgram = drawTexturedRectPrograms[context];
         if(drawTexturedRectProgram == null)
         {
            vLinker = new Linker(Context3DProgramType.VERTEX);
            vLinker.addProcedure(Procedure.compileFromArray(["#a0=a0","#a1=a1","#v0=v0","#c0=c0","#c1=c1","mul v0, a1, c1","mul t0.x, a0.x, c0.x","mul t0.y, a0.y, c0.y","add o0.x, t0.x, c0.z","add o0.y, t0.y, c0.w","mov o0.z, a0.z","mov o0.w, a0.z"]));
            fLinker = new Linker(Context3DProgramType.FRAGMENT);
            fLinker.addProcedure(Procedure.compileFromArray(["#v0=v0","#s0=s0","tex t0, v0, s0 <2d, nearest, mipnone>","mov o0, t0"]));
            drawTexturedRectProgram = new ShaderProgram(vLinker,fLinker);
            drawTexturedRectProgram.upload(context);
            drawTexturedRectPrograms[context] = drawTexturedRectProgram;
         }
         if(this.antiAlias > 0)
         {
            log2Width = Math.ceil(Math.log(contextWidth) / Math.LN2) - 1;
            texture = drawDistanceTextures[context];
            textureLog2Width = int(drawDistanceTexturesWidths[context]);
            textureHeight = 1;
            if(texture == null || textureLog2Width != log2Width)
            {
               textureLog2Width = log2Width;
               if(texture != null)
               {
                  texture.dispose();
               }
               texture = context.createTexture(2 << textureLog2Width,textureHeight,Context3DTextureFormat.BGRA,true);
               drawDistanceTextures[context] = texture;
               drawDistanceTexturesWidths[context] = textureLog2Width;
            }
         }
         context.setDepthTest(true,Context3DCompareMode.LESS);
         var m0:Number = Number(camera.alternativa3d::m0);
         var m5:Number = Number(camera.alternativa3d::m5);
         var m10:Number = Number(camera.alternativa3d::m10);
         var m11:Number = Number(camera.alternativa3d::m14);
         var kZ:Number = 255 / camera.farClipping;
         var fragmentConst:Number = 1 / 255;
         var drawTextureWidthScale:Number = 1;
         var drawTextureWidthOffset:Number = 0;
         var drawTextureHeightScale:Number = 1;
         var drawTextureHeightOffset:Number = 0;
         if(this.antiAlias > 0)
         {
            drawTextureWidthScale = contextWidth / (2 << textureLog2Width);
            drawTextureWidthOffset = drawTextureWidthScale - 1;
            drawTextureHeightScale = contextHeight / textureHeight;
            drawTextureHeightOffset = drawTextureHeightScale - 1;
            m0 *= drawTextureWidthScale;
            m5 *= drawTextureHeightScale;
         }
         var pixelIndex:int = 0;
         for(i = 0; i < this.alternativa3d::raysLength; )
         {
            rayCoefficients = this.name_Ql[i];
            i++;
            for(j = 0; j < this.name_8b; )
            {
               if(pixelIndex == 0)
               {
                  if(this.antiAlias > 0)
                  {
                     context.setRenderToTexture(texture,true,0,0);
                     context.clear(1,0,0,1);
                  }
                  else
                  {
                     drawColoredRectConst[0] = this.alternativa3d::raysLength * this.name_8b * 2 / contextWidth;
                     drawColoredRectConst[1] = -2 / contextHeight;
                     context.setDepthTest(false,Context3DCompareMode.ALWAYS);
                     context.setProgram(drawColoredRectProgram.program);
                     context.setVertexBufferAt(0,drawRectGeometry.alternativa3d::getVertexBuffer(VertexAttributes.POSITION),drawRectGeometry.alternativa3d::_attributesOffsets[VertexAttributes.POSITION],VertexAttributes.alternativa3d::FORMATS[VertexAttributes.POSITION]);
                     context.setProgramConstantsFromVector(Context3DProgramType.VERTEX,0,drawColoredRectConst);
                     drawRectColor[0] = 1;
                     drawRectColor[1] = 0;
                     drawRectColor[2] = 0;
                     drawRectColor[3] = 1;
                     context.setProgramConstantsFromVector(Context3DProgramType.FRAGMENT,0,drawRectColor);
                     context.drawTriangles(drawRectGeometry.name_EM,0,2);
                     context.setVertexBufferAt(0,null);
                  }
               }
               scissor.x = pixelIndex;
               context.setScissorRectangle(scissor);
               this.drawSurface(context,camera,j,m0,m5,m10,m11,(pixelIndex * 2 / contextWidth - rayCoefficients.x) * drawTextureWidthScale + drawTextureWidthOffset,rayCoefficients.y * drawTextureHeightScale - drawTextureHeightOffset,kZ,fragmentConst,camera.orthographic);
               this.name_4N[pixelIndex] = i - 1;
               this.name_ff[pixelIndex] = j;
               j++;
               pixelIndex++;
               if(pixelIndex >= contextWidth || i >= this.alternativa3d::raysLength && j >= this.name_8b)
               {
                  if(this.antiAlias > 0)
                  {
                     context.setRenderToBackBuffer();
                     textureScreenSize = pixelIndex / (2 << textureLog2Width);
                     drawColoredRectConst[0] = 2 * textureScreenSize * (2 << textureLog2Width) / contextWidth;
                     drawColoredRectConst[1] = -2 * textureHeight / contextHeight;
                     drawTexturedRectUVScaleConst[0] = textureScreenSize;
                     context.setDepthTest(false,Context3DCompareMode.ALWAYS);
                     context.setProgram(drawTexturedRectProgram.program);
                     context.setVertexBufferAt(0,drawRectGeometry.alternativa3d::getVertexBuffer(VertexAttributes.POSITION),drawRectGeometry.alternativa3d::_attributesOffsets[VertexAttributes.POSITION],VertexAttributes.alternativa3d::FORMATS[VertexAttributes.POSITION]);
                     context.setVertexBufferAt(1,drawRectGeometry.alternativa3d::getVertexBuffer(VertexAttributes.TEXCOORDS[0]),drawRectGeometry.alternativa3d::_attributesOffsets[VertexAttributes.TEXCOORDS[0]],VertexAttributes.alternativa3d::FORMATS[VertexAttributes.TEXCOORDS[0]]);
                     context.setProgramConstantsFromVector(Context3DProgramType.VERTEX,0,drawColoredRectConst);
                     context.setProgramConstantsFromVector(Context3DProgramType.VERTEX,1,drawTexturedRectUVScaleConst);
                     context.setTextureAt(0,texture);
                     context.drawTriangles(drawRectGeometry.name_EM,0,2);
                     context.setTextureAt(0,null);
                     context.setVertexBufferAt(0,null);
                     context.setVertexBufferAt(1,null);
                  }
                  pixel = pixels[pixelIndex];
                  if(pixel == null)
                  {
                     pixel = new BitmapData(pixelIndex,1,false,16711680);
                     pixels[pixelIndex] = pixel;
                  }
                  context.drawToBitmapData(pixel);
                  for(k = 0; k < pixelIndex; )
                  {
                     color = int(pixel.getPixel(k,0));
                     red = color >> 16 & 0xFF;
                     green = color >> 8 & 0xFF;
                     if(red < 255)
                     {
                        ind = this.name_4N[k];
                        raySurfaces = this.name_extends[ind];
                        rayDepths = this.name_9L[ind];
                        ind = this.name_ff[k];
                        raySurfaces.push(this.surfaces[ind]);
                        rayDepths.push((red + green / 255) / kZ);
                     }
                     k++;
                  }
                  pixelIndex = 0;
               }
            }
         }
         context.setScissorRectangle(null);
         context.setDepthTest(true,Context3DCompareMode.ALWAYS);
         context.setProgram(drawColoredRectProgram.program);
         context.setVertexBufferAt(0,drawRectGeometry.alternativa3d::getVertexBuffer(VertexAttributes.POSITION),drawRectGeometry.alternativa3d::_attributesOffsets[VertexAttributes.POSITION],VertexAttributes.alternativa3d::FORMATS[VertexAttributes.POSITION]);
         drawColoredRectConst[0] = this.alternativa3d::raysLength * this.name_8b * 2 / contextWidth;
         drawColoredRectConst[1] = -2 / contextHeight;
         context.setProgramConstantsFromVector(Context3DProgramType.VERTEX,0,drawColoredRectConst);
         var r:Number = (this.backgroundColor >> 16 & 0xFF) / 255;
         var g:Number = (this.backgroundColor >> 8 & 0xFF) / 255;
         var b:Number = (this.backgroundColor & 0xFF) / 255;
         if(this.canvas != null)
         {
            drawRectColor[0] = this.backgroundAlpha * r;
            drawRectColor[1] = this.backgroundAlpha * g;
            drawRectColor[2] = this.backgroundAlpha * b;
         }
         else
         {
            drawRectColor[0] = r;
            drawRectColor[1] = g;
            drawRectColor[2] = b;
         }
         drawRectColor[3] = this.backgroundAlpha;
         context.setProgramConstantsFromVector(Context3DProgramType.FRAGMENT,0,drawRectColor);
         context.drawTriangles(drawRectGeometry.name_EM,0,2);
         context.setVertexBufferAt(0,null);
      }
      
      private function drawSurface(context:Context3D, camera:Camera3D, index:int, m0:Number, m5:Number, m10:Number, m14:Number, xOffset:Number, yOffset:Number, vertexConst:Number, fragmentConst:Number, orthographic:Boolean) : void
      {
         var i:int = 0;
         var vertex:Linker = null;
         var position:String = null;
         var surface:Surface = this.surfaces[index];
         var geometry:Geometry = this.geometries[index];
         var procedure:Procedure = this.name_2L[index];
         var object:Object3D = surface.alternativa3d::object;
         var drawDistanceProgram:ShaderProgram = drawDistancePrograms[procedure];
         if(drawDistanceProgram == null)
         {
            vertex = new Linker(Context3DProgramType.VERTEX);
            position = "position";
            vertex.declareVariable(position,VariableType.ATTRIBUTE);
            if(procedure != null)
            {
               vertex.addProcedure(procedure);
               vertex.declareVariable("localPosition",VariableType.TEMPORARY);
               vertex.setInputParams(procedure,position);
               vertex.setOutputParams(procedure,"localPosition");
               position = "localPosition";
            }
            vertex.addProcedure(drawDistanceVertexProcedure);
            vertex.setInputParams(drawDistanceVertexProcedure,position);
            drawDistanceProgram = new ShaderProgram(vertex,drawDistanceFragment);
            drawDistanceFragment.setOppositeLinker(vertex);
            drawDistanceProgram.upload(context);
            drawDistancePrograms[procedure] = drawDistanceProgram;
         }
         var buffer:VertexBuffer3D = geometry.alternativa3d::getVertexBuffer(VertexAttributes.POSITION);
         if(buffer == null)
         {
            return;
         }
         drawUnit.name_3G = 0;
         drawUnit.name_9X = 0;
         drawUnit.name_Kv = 0;
         object.alternativa3d::setTransformConstants(drawUnit,surface,drawDistanceProgram.vertexShader,camera);
         drawUnit.alternativa3d::setVertexConstantsFromTransform(drawDistanceProgram.vertexShader.getVariableIndex("transform0"),object.alternativa3d::localToCameraTransform);
         drawUnit.alternativa3d::setVertexConstantsFromNumbers(drawDistanceProgram.vertexShader.getVariableIndex("coefficient"),xOffset,yOffset,vertexConst,orthographic ? 1 : 0);
         drawUnit.alternativa3d::setVertexConstantsFromNumbers(drawDistanceProgram.vertexShader.getVariableIndex("projection"),m0,m5,m10,m14);
         drawUnit.alternativa3d::setFragmentConstantsFromNumbers(drawDistanceProgram.fragmentShader.getVariableIndex("code"),fragmentConst,0,0,1);
         context.setProgram(drawDistanceProgram.program);
         context.setVertexBufferAt(0,buffer,geometry.alternativa3d::_attributesOffsets[VertexAttributes.POSITION],VertexAttributes.alternativa3d::FORMATS[VertexAttributes.POSITION]);
         for(i = 0; i < drawUnit.name_3G; i++)
         {
            context.setVertexBufferAt(drawUnit.name_else[i],drawUnit.alternativa3d::vertexBuffers[i],drawUnit.name_nw[i],drawUnit.name_EL[i]);
         }
         context.setProgramConstantsFromVector(Context3DProgramType.VERTEX,0,drawUnit.name_Aq,drawUnit.name_9X);
         context.setProgramConstantsFromVector(Context3DProgramType.FRAGMENT,0,drawUnit.name_Cl,drawUnit.name_Kv);
         context.drawTriangles(geometry.name_EM,surface.indexBegin,surface.numTriangles);
         context.setVertexBufferAt(0,null);
         for(i = 0; i < drawUnit.name_3G; i++)
         {
            context.setVertexBufferAt(drawUnit.name_else[i],null);
         }
      }
      
      private function sort(surfaces:Vector.<Surface>, depths:Vector.<Number>, length:int) : void
      {
         var r:int = 0;
         var j:int = 0;
         var l:int = 0;
         var i:int = 0;
         var median:Number = NaN;
         var left:Number = NaN;
         var right:Number = NaN;
         var surface:Surface = null;
         stack[0] = 0;
         stack[1] = length - 1;
         for(var index:int = 2; index > 0; )
         {
            index--;
            r = stack[index];
            j = r;
            index--;
            l = stack[index];
            i = l;
            for(median = depths[r + l >> 1]; i <= j; )
            {
               for(left = depths[i]; left > median; )
               {
                  i++;
                  left = depths[i];
               }
               for(right = depths[j]; right < median; )
               {
                  j--;
                  right = depths[j];
               }
               if(i <= j)
               {
                  depths[i] = right;
                  depths[j] = left;
                  surface = surfaces[i];
                  surfaces[i] = surfaces[j];
                  surfaces[j] = surface;
                  i++;
                  j--;
               }
            }
            if(l < j)
            {
               stack[index] = l;
               index++;
               stack[index] = j;
               index++;
            }
            if(i < r)
            {
               stack[index] = i;
               index++;
               stack[index] = r;
               index++;
            }
         }
      }
      
      private function processOverOut(mouseEvent:MouseEvent, camera:Camera3D) : void
      {
         var changedBranchLength:int = 0;
         var i:int = 0;
         var j:int = 0;
         var object:Object3D = null;
         this.branchToVector(this.target,branch);
         this.branchToVector(this.name_Lx,overedBranch);
         var branchLength:int = int(branch.length);
         var overedBranchLength:int = int(overedBranch.length);
         if(this.name_Lx != null)
         {
            this.propagateEvent(MouseEvent3D.MOUSE_OUT,mouseEvent,camera,this.name_Lx,this.name_H7,overedBranch,true,this.target);
            changedBranchLength = 0;
            for(i = 0; i < overedBranchLength; )
            {
               object = overedBranch[i];
               for(j = 0; j < branchLength; j++)
               {
                  if(object == branch[j])
                  {
                     break;
                  }
               }
               if(j == branchLength)
               {
                  changedBranch[changedBranchLength] = object;
                  changedBranchLength++;
               }
               i++;
            }
            if(changedBranchLength > 0)
            {
               changedBranch.length = changedBranchLength;
               this.propagateEvent(MouseEvent3D.ROLL_OUT,mouseEvent,camera,this.name_Lx,this.name_H7,changedBranch,false,this.target);
            }
         }
         if(this.target != null)
         {
            changedBranchLength = 0;
            for(i = 0; i < branchLength; )
            {
               object = branch[i];
               for(j = 0; j < overedBranchLength; j++)
               {
                  if(object == overedBranch[j])
                  {
                     break;
                  }
               }
               if(j == overedBranchLength)
               {
                  changedBranch[changedBranchLength] = object;
                  changedBranchLength++;
               }
               i++;
            }
            if(changedBranchLength > 0)
            {
               changedBranch.length = changedBranchLength;
               this.propagateEvent(MouseEvent3D.ROLL_OVER,mouseEvent,camera,this.target,this.targetSurface,changedBranch,false,this.name_Lx);
            }
            this.propagateEvent(MouseEvent3D.MOUSE_OVER,mouseEvent,camera,this.target,this.targetSurface,branch,true,this.name_Lx);
            useHandCursor = this.target.useHandCursor;
         }
         else
         {
            useHandCursor = false;
         }
         Mouse.cursor = Mouse.cursor;
         this.name_Lx = this.target;
         this.name_H7 = this.targetSurface;
      }
      
      private function branchToVector(object:Object3D, vector:Vector.<Object3D>) : Vector.<Object3D>
      {
         for(var len:int = 0; object != null; )
         {
            vector[len] = object;
            len++;
            object = object.alternativa3d::_parent;
         }
         vector.length = len;
         return vector;
      }
      
      private function propagateEvent(type:String, mouseEvent:MouseEvent, camera:Camera3D, target:Object3D, targetSurface:Surface, objects:Vector.<Object3D>, bubbles:Boolean = true, relatedObject:Object3D = null) : void
      {
         var object:Object3D = null;
         var vector:Vector.<Function> = null;
         var length:int = 0;
         var i:int = 0;
         var j:int = 0;
         var mouseEvent3D:MouseEvent3D = null;
         var oblectsLength:int = int(objects.length);
         for(i = oblectsLength - 1; i > 0; )
         {
            object = objects[i];
            if(object.alternativa3d::captureListeners != null)
            {
               vector = object.alternativa3d::captureListeners[type];
               if(vector != null)
               {
                  if(mouseEvent3D == null)
                  {
                     this.calculateLocalCoords(camera,target.alternativa3d::cameraToLocalTransform,this.name_Cu,mouseEvent);
                     mouseEvent3D = new MouseEvent3D(type,bubbles,localCoords.x,localCoords.y,localCoords.z,relatedObject,mouseEvent.ctrlKey,mouseEvent.altKey,mouseEvent.shiftKey,mouseEvent.buttonDown,mouseEvent.delta);
                     mouseEvent3D.name_5E = target;
                     mouseEvent3D.name_BX = targetSurface;
                  }
                  mouseEvent3D.name_Kh = object;
                  mouseEvent3D.name_VE = 1;
                  length = int(vector.length);
                  for(j = 0; j < length; functions[j] = vector[j],j++)
                  {
                  }
                  for(j = 0; j < length; )
                  {
                     (functions[j] as Function).call(null,mouseEvent3D);
                     if(mouseEvent3D.name_XD)
                     {
                        return;
                     }
                     j++;
                  }
                  if(mouseEvent3D.alternativa3d::stop)
                  {
                     return;
                  }
               }
            }
            i--;
         }
         for(i = 0; i < oblectsLength; )
         {
            object = objects[i];
            if(object.alternativa3d::bubbleListeners != null)
            {
               vector = object.alternativa3d::bubbleListeners[type];
               if(vector != null)
               {
                  if(mouseEvent3D == null)
                  {
                     this.calculateLocalCoords(camera,target.alternativa3d::cameraToLocalTransform,this.name_Cu,mouseEvent);
                     mouseEvent3D = new MouseEvent3D(type,bubbles,localCoords.x,localCoords.y,localCoords.z,relatedObject,mouseEvent.ctrlKey,mouseEvent.altKey,mouseEvent.shiftKey,mouseEvent.buttonDown,mouseEvent.delta);
                     mouseEvent3D.name_5E = target;
                     mouseEvent3D.name_BX = targetSurface;
                  }
                  mouseEvent3D.name_Kh = object;
                  mouseEvent3D.name_VE = i == 0 ? 2 : 3;
                  length = int(vector.length);
                  for(j = 0; j < length; functions[j] = vector[j],j++)
                  {
                  }
                  for(j = 0; j < length; )
                  {
                     (functions[j] as Function).call(null,mouseEvent3D);
                     if(mouseEvent3D.name_XD)
                     {
                        return;
                     }
                     j++;
                  }
                  if(mouseEvent3D.alternativa3d::stop)
                  {
                     return;
                  }
               }
            }
            i++;
         }
      }
      
      private function calculateLocalCoords(camera:Camera3D, transform:Transform3D, z:Number, mouseEvent:MouseEvent) : void
      {
         var x:Number = NaN;
         var y:Number = NaN;
         if(!camera.orthographic)
         {
            x = z * (mouseEvent.localX - this.name_qj * 0.5) / camera.alternativa3d::focalLength;
            y = z * (mouseEvent.localY - this.alternativa3d::_height * 0.5) / camera.alternativa3d::focalLength;
         }
         else
         {
            x = mouseEvent.localX - this.name_qj * 0.5;
            y = mouseEvent.localY - this.alternativa3d::_height * 0.5;
         }
         localCoords.x = transform.a * x + transform.b * y + transform.c * z + transform.d;
         localCoords.y = transform.e * x + transform.f * y + transform.g * z + transform.h;
         localCoords.z = transform.i * x + transform.j * y + transform.k * z + transform.l;
      }
      
      private function defineTarget(index:int) : void
      {
         var source:Object3D = null;
         var surface:Surface = null;
         var depth:Number = NaN;
         var object:Object3D = null;
         var potentialTarget:Object3D = null;
         var obj:Object3D = null;
         var surfaces:Vector.<Surface> = this.name_extends[index];
         var depths:Vector.<Number> = this.name_9L[index];
         for(var i:int = surfaces.length - 1; i >= 0; )
         {
            surface = surfaces[i];
            depth = depths[i];
            object = surface.alternativa3d::object;
            potentialTarget = null;
            for(obj = object; obj != null; )
            {
               if(!obj.mouseChildren)
               {
                  potentialTarget = null;
               }
               if(potentialTarget == null && obj.mouseEnabled)
               {
                  potentialTarget = obj;
               }
               obj = obj.alternativa3d::_parent;
            }
            if(potentialTarget != null)
            {
               if(this.target != null)
               {
                  for(obj = potentialTarget; obj != null; )
                  {
                     if(obj == this.target)
                     {
                        source = object;
                        if(this.target != potentialTarget)
                        {
                           this.target = potentialTarget;
                           this.targetSurface = surface;
                           this.name_Cu = depth;
                        }
                        break;
                     }
                     obj = obj.alternativa3d::_parent;
                  }
               }
               else
               {
                  source = object;
                  this.target = potentialTarget;
                  this.targetSurface = surface;
                  this.name_Cu = depth;
               }
               if(source == this.target)
               {
                  break;
               }
            }
            i--;
         }
      }
      
      public function get renderToBitmap() : Boolean
      {
         return this.name_gJ != null;
      }
      
      public function set renderToBitmap(value:Boolean) : void
      {
         if(value)
         {
            if(this.name_gJ == null)
            {
               this.createRenderBitmap();
            }
         }
         else if(this.name_gJ != null)
         {
            this.container.bitmapData = null;
            this.name_gJ.dispose();
            this.name_gJ = null;
         }
      }
      
      public function get canvas() : BitmapData
      {
         return this.name_gJ;
      }
      
      public function showLogo() : void
      {
         if(this.name_N2 == null)
         {
            this.name_N2 = new Logo();
            super.addChild(this.name_N2);
            this.name_package();
         }
      }
      
      public function hideLogo() : void
      {
         if(this.name_N2 != null)
         {
            super.removeChild(this.name_N2);
            this.name_N2 = null;
         }
      }
      
      public function get logoAlign() : String
      {
         return this.name_bx;
      }
      
      public function set logoAlign(value:String) : void
      {
         this.name_bx = value;
         this.name_package();
      }
      
      public function get logoHorizontalMargin() : Number
      {
         return this.name_hq;
      }
      
      public function set logoHorizontalMargin(value:Number) : void
      {
         this.name_hq = value;
         this.name_package();
      }
      
      public function get logoVerticalMargin() : Number
      {
         return this.name_Xc;
      }
      
      public function set logoVerticalMargin(value:Number) : void
      {
         this.name_Xc = value;
         this.name_package();
      }
      
      private function name_package() : void
      {
         if(this.name_N2 != null)
         {
            if(this.name_bx == StageAlign.TOP_LEFT || this.name_bx == StageAlign.LEFT || this.name_bx == StageAlign.BOTTOM_LEFT)
            {
               this.name_N2.x = Math.round(this.name_hq);
            }
            if(this.name_bx == StageAlign.TOP || this.name_bx == StageAlign.BOTTOM)
            {
               this.name_N2.x = Math.round((this.name_qj - this.name_N2.width) / 2);
            }
            if(this.name_bx == StageAlign.TOP_RIGHT || this.name_bx == StageAlign.RIGHT || this.name_bx == StageAlign.BOTTOM_RIGHT)
            {
               this.name_N2.x = Math.round(this.name_qj - this.name_hq - this.name_N2.width);
            }
            if(this.name_bx == StageAlign.TOP_LEFT || this.name_bx == StageAlign.TOP || this.name_bx == StageAlign.TOP_RIGHT)
            {
               this.name_N2.y = Math.round(this.name_Xc);
            }
            if(this.name_bx == StageAlign.LEFT || this.name_bx == StageAlign.RIGHT)
            {
               this.name_N2.y = Math.round((this.alternativa3d::_height - this.name_N2.height) / 2);
            }
            if(this.name_bx == StageAlign.BOTTOM_LEFT || this.name_bx == StageAlign.BOTTOM || this.name_bx == StageAlign.BOTTOM_RIGHT)
            {
               this.name_N2.y = Math.round(this.alternativa3d::_height - this.name_Xc - this.name_N2.height);
            }
         }
      }
      
      override public function get width() : Number
      {
         return this.name_qj;
      }
      
      override public function set width(value:Number) : void
      {
         if(value < 50)
         {
            value = 50;
         }
         this.name_qj = value;
         this.area.width = value;
         this.name_package();
      }
      
      override public function get height() : Number
      {
         return this.alternativa3d::_height;
      }
      
      override public function set height(value:Number) : void
      {
         if(value < 50)
         {
            value = 50;
         }
         this.alternativa3d::_height = value;
         this.area.height = value;
         this.name_package();
      }
      
      override public function addChild(child:DisplayObject) : DisplayObject
      {
         throw new Error("Unsupported operation.");
      }
      
      override public function removeChild(child:DisplayObject) : DisplayObject
      {
         throw new Error("Unsupported operation.");
      }
      
      override public function addChildAt(child:DisplayObject, index:int) : DisplayObject
      {
         throw new Error("Unsupported operation.");
      }
      
      override public function removeChildAt(index:int) : DisplayObject
      {
         throw new Error("Unsupported operation.");
      }
      
      override public function getChildAt(index:int) : DisplayObject
      {
         throw new Error("Unsupported operation.");
      }
      
      override public function getChildIndex(child:DisplayObject) : int
      {
         throw new Error("Unsupported operation.");
      }
      
      override public function setChildIndex(child:DisplayObject, index:int) : void
      {
         throw new Error("Unsupported operation.");
      }
      
      override public function swapChildren(child1:DisplayObject, child2:DisplayObject) : void
      {
         throw new Error("Unsupported operation.");
      }
      
      override public function swapChildrenAt(index1:int, index2:int) : void
      {
         throw new Error("Unsupported operation.");
      }
      
      override public function getChildByName(name:String) : DisplayObject
      {
         throw new Error("Unsupported operation.");
      }
      
      override public function contains(child:DisplayObject) : Boolean
      {
         throw new Error("Unsupported operation.");
      }
   }
}

import flash.display.BitmapData;
import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.InteractiveObject;
import flash.display.Sprite;
import flash.events.EventDispatcher;
import flash.events.MouseEvent;
import flash.geom.ColorTransform;
import flash.geom.Matrix;
import flash.net.URLRequest;
import flash.net.navigateToURL;

class Logo extends Sprite
{
   public static const image:BitmapData = createBMP();
   
   private static const normal:ColorTransform = new ColorTransform();
   
   private static const highlighted:ColorTransform = new ColorTransform(1.1,1.1,1.1,1);
   
   private var border:int = 5;
   
   public function Logo()
   {
      super();
      graphics.beginFill(16711680,0);
      graphics.drawRect(0,0,image.width + this.border + this.border,image.height + this.border + this.border);
      graphics.drawRect(this.border,this.border,image.width,image.height);
      graphics.beginBitmapFill(image,new Matrix(1,0,0,1,this.border,this.border),false,true);
      graphics.drawRect(this.border,this.border,image.width,image.height);
      tabEnabled = false;
      buttonMode = true;
      useHandCursor = true;
      addEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown);
      addEventListener(MouseEvent.CLICK,this.onClick);
      addEventListener(MouseEvent.DOUBLE_CLICK,this.onDoubleClick);
      addEventListener(MouseEvent.MOUSE_MOVE,this.onMouseMove);
      addEventListener(MouseEvent.MOUSE_OVER,this.onMouseMove);
      addEventListener(MouseEvent.MOUSE_OUT,this.onMouseOut);
      addEventListener(MouseEvent.MOUSE_WHEEL,this.onMouseWheel);
   }
   
   private static function createBMP() : BitmapData
   {
      var bmp:BitmapData = new BitmapData(165,27,true,0);
      bmp.setVector(bmp.rect,Vector.<uint>([0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,134217728,503316480,721420288,503316480,134217728,134217728,503316480,721420288,503316480,134217728,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,100663296,419430400,721420288,788529152,536870912,234881024,50331648,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,503316480,1677721600,2348810240,1677721600,503316480,503316480,1677721600,2348810240,1677721600,503316480,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,67108864,301989888,822083584,1677721600,2365587456,2483027968
      ,1996488704,1241513984,536870912,117440512,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,16777216,167772160,520093696,822083584,905969664,822083584,520093696,301989888,520093696,822083584,905969664,822083584,620756992,620756992,721420288,620756992,620756992,721420288,620756992,620756992,721420288,620756992,620756992,822083584,905969664,822083584,520093696,218103808,234881024,536870912,721420288,620756992,620756992,822083584,905969664,822083584,520093696,301989888,520093696,822083584,1493172224,2768240640,4292467161,2533359616,822083584,822083584,2533359616,4292467161,2768240640,1493172224,822083584,620756992,620756992,721420288,503316480,268435456,503316480,721420288,503316480,134217728,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,134217728,620756992,1392508928,2248146944,3514129719,4192520610,4277921461,3886715221,2905283846,1778384896,788529152,234881024,50331648,0,0,0,0,0,0,0,0,0,0,0,0,0,0
      ,0,167772160,822083584,1845493760,2533359616,2734686208,2533359616,1845493760,1325400064,1845493760,2533359616,2734686208,2533359616,2164260864,2164260864,2348810240,2164260864,2164260864,2348810240,2164260864,2164260864,2348810240,2164260864,2164260864,2533359616,2734686208,2533359616,1845493760,1056964608,1107296256,1895825408,2348810240,2164260864,2164260864,2533359616,2734686208,2533359616,1845493760,1325400064,1845493760,2533359616,2952790016,3730463322,4292467161,2734686208,905969664,905969664,2734686208,4292467161,3730463322,2952790016,2533359616,2164260864,2164260864,2348810240,1677721600,989855744,1677721600,2348810240,1677721600,503316480,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,16777216,167772160,754974720,1828716544,3022988562,4022445697,4294959283,4294953296,4294953534,4294961056,4226733479,3463135252,2130706432,1224736768,486539264,83886080,0,0,0,0,0,0,0,0,0,0,0,0,0
      ,0,520093696,1845493760,3665591420,4292467161,4292467161,4292467161,3665591420,2650800128,3665591420,4292467161,4292467161,4292467161,3816191606,3355443200,4292467161,3355443200,3355443200,4292467161,3355443200,3355443200,4292467161,3355443200,3816191606,4292467161,4292467161,4292467161,3665591420,2382364672,2415919104,3801125008,4292467161,3355443200,3816191606,4292467161,4292467161,4292467161,3495911263,2650800128,3665591420,4292467161,4292467161,4292467161,4292467161,2533359616,822083584,822083584,2533359616,4292467161,4292467161,4292467161,4292467161,3816191606,3355443200,4292467161,2533359616,1627389952,2533359616,4292467161,2533359616,822083584,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,50331648,251658240,889192448,1962934272,3463338042,4260681651,4294955128,4294949388,4294949120,4294948864,4294948864,4294953816,4294960063,3903219779,2701722370,1627389952,620756992,100663296,0,0
      ,0,0,0,0,0,0,0,0,0,0,0,822083584,2533359616,4292467161,3730463322,3187671040,3730463322,4292467161,3456106496,4292467161,3849680245,3221225472,3849680245,4292467161,3640655872,4292467161,3640655872,3640655872,4292467161,3640655872,3640655872,4292467161,3640655872,4292467161,3966923378,3640655872,3966923378,4292467161,3355443200,3918236555,4292467161,3763951961,3539992576,4292467161,3966923378,3640655872,3966923378,4292467161,3456106496,4292467161,3849680245,3221225472,3422552064,3456106496,2348810240,721420288,721420288,2348810240,3456106496,3422552064,3221225472,3849680245,4292467161,3640655872,4292467161,2734686208,1828716544,2734686208,4292467161,2734686208,905969664,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,50331648,318767104,1006632960,2080374784,3683940948,4294958002,4294949951,4294946816,4294946048,4294944256,4294944256,4294945536,4294944512,4294944799,4294954914,4123823487,3056010753
      ,1778384896,671088640,117440512,0,0,0,0,0,0,0,0,0,0,0,0,822083584,2533359616,4292467161,3187671040,2734686208,3187671040,4292467161,3640655872,4292467161,3221225472,2801795072,3221225472,4292467161,3640655872,4292467161,3966923378,3640655872,4292467161,3966923378,3640655872,4292467161,3640655872,4292467161,3640655872,4292467161,4292467161,4292467161,3640655872,4292467161,3613154396,2818572288,3221225472,4292467161,3640655872,4292467161,4292467161,4292467161,3640655872,4292467161,3221225472,2801795072,3221225472,4292467161,2533359616,822083584,822083584,2533359616,4292467161,3221225472,2801795072,3221225472,4292467161,3640655872,4292467161,2952790016,2264924160,2952790016,4292467161,2533359616,822083584,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,50331648,318767104,1056964608,2147483648,3819605095,4294955172,4294944795,4294943744,4294941184,4294939392,4294940672,4294940160,4294938624,4294941440
      ,4294940672,4294936323,4294815095,4208955271,3208382211,1845493760,721420288,134217728,0,0,0,0,0,0,0,0,0,0,0,721420288,2348810240,3456106496,3405774848,3187671040,3730463322,4292467161,3456106496,4292467161,3849680245,3221225472,3849680245,4292467161,3355443200,3816191606,4292467161,3966923378,3966923378,4292467161,3966923378,4292467161,3640655872,4292467161,3966923378,3640655872,3640655872,3640655872,3640655872,4292467161,2868903936,1996488704,2684354560,4292467161,3966923378,3640655872,3640655872,3539992576,3456106496,4292467161,3849680245,3221225472,3849680245,4292467161,2533359616,822083584,822083584,2533359616,4292467161,3849680245,3221225472,3849680245,4292467161,3456106496,4292467161,3730463322,3187671040,3405774848,3456106496,2348810240,721420288,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,16777216,234881024,989855744,2147483648,3836647021,4294952084,4294939916,4294939392,4294936064
      ,4294935808,4294939907,3970992676,3783616794,4260594952,4294933248,4294937088,4294937088,4294865664,4294676569,4243165579,3292924164,1862270976,721420288,134217728,0,0,0,0,0,0,0,0,0,0,822083584,2533359616,4292467161,4292467161,4292467161,4292467161,3665591420,2650800128,3665591420,4292467161,4292467161,4292467161,3665591420,2348810240,2348810240,3665591420,4292467161,3355443200,3816191606,4292467161,4292467161,3355443200,3816191606,4292467161,4292467161,4292467161,3696908890,3355443200,4292467161,2533359616,1325400064,1845493760,3665591420,4292467161,4292467161,4292467161,3665591420,2650800128,3665591420,4292467161,4292467161,4292467161,3665591420,1845493760,520093696,520093696,1845493760,3665591420,4292467161,4292467161,4292467161,3665591420,2650800128,3665591420,4292467161,4292467161,4292467161,4292467161,2533359616,822083584,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,150994944,855638016
      ,2063597568,3785853032,4294949263,4294935301,4294934528,4294931200,4294865408,4294739211,3598869795,2348810240,2248146944,3157861897,4158024716,4294930432,4294934272,4294934016,4294796032,4294604868,4260400774,3309963524,1862270976,704643072,117440512,0,0,0,0,0,0,0,0,0,905969664,2734686208,4292467161,3730463322,2952790016,2533359616,1845493760,1325400064,1845493760,2533359616,2734686208,2533359616,1845493760,1006632960,1006632960,1845493760,2348810240,2164260864,2164260864,2533359616,2533359616,2164260864,2164260864,2533359616,2734686208,2533359616,2164260864,2164260864,2348810240,1677721600,671088640,822083584,1845493760,2533359616,2734686208,2533359616,1845493760,1325400064,1845493760,2533359616,2734686208,2533359616,1845493760,822083584,167772160,167772160,822083584,1845493760,2533359616,2734686208,2533359616,1845493760,1325400064,1845493760,2533359616,2952790016,3730463322,4292467161,2734686208,905969664,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
      ,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,117440512,738197504,1962934272,3632951638,4294947982,4294931462,4294930176,4294794752,4294662144,4260327185,3378071325,1946157056,922746880,822083584,1677721600,2785937666,3954400527,4294929408,4294931968,4294931712,4294661120,4294469180,4260200571,3208316675,1795162112,620756992,83886080,0,0,0,0,0,0,0,0,822083584,2533359616,4292467161,2768240640,1493172224,822083584,520093696,301989888,520093696,822083584,905969664,822083584,520093696,184549376,184549376,520093696,721420288,620756992,620756992,822083584,822083584,620756992,620756992,822083584,905969664,822083584,620756992,620756992,721420288,503316480,150994944,167772160,520093696,822083584,905969664,822083584,520093696,301989888,520093696,822083584,905969664,822083584,520093696,167772160,16777216,16777216,167772160,520093696,822083584,905969664,822083584,520093696,301989888,520093696,822083584,1493172224,2768240640,4292467161,2533359616,822083584,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
      ,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,67108864,620756992,1811939328,3429059385,4294882972,4294796301,4294727936,4294526208,4294325760,4226241553,3242276118,1862270976,738197504,150994944,100663296,520093696,1325400064,2264924160,3768667144,4294928385,4294929408,4294796800,4294460416,4294335293,4225986666,3055813377,1644167168,503316480,50331648,0,0,0,0,0,0,0,503316480,1677721600,2348810240,1677721600,503316480,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,503316480,1677721600,2348810240,1677721600,503316480,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,16777216,335544320,1459617792,3005750036,4243500445,4294661403,4294524672,4294258432,4294121728,4259985678,3259118102,1845493760,704643072,134217728,0,0,50331648,335544320,1006632960,2080374784,3751757574,4294794241,4294794240,4294592771
      ,4294323463,4294400588,4123811671,2769158144,1275068416,251658240,0,0,0,0,0,0,0,134217728,503316480,721420288,503316480,134217728,0,0,0,0,134217728,503316480,721420288,503316480,268435456,503316480,721420288,503316480,134217728,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,134217728,503316480,721420288,503316480,134217728,0,0,0,0,134217728,503316480,721420288,503316480,134217728,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,134217728,503316480,721420288,520093696,167772160,16777216,0,0,0,0,0,0,0,0,134217728,503316480,721420288,520093696,234881024,285212672,570425344,687865856,436207616,117440512,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,150994944,922746880,2348810240,4056321414,4294197820,4294119936,4294056448,4293921536,4293991688,3394978333,1879048192,704643072,117440512,0,0,0,0,33554432,268435456,1023410176,2248146944,3869450497,4293927168,4293661957,4293331976,4293330946,4293609799,3936365867,2181038080,822083584,134217728,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,503316480,1677721600
      ,2348810240,1744830464,1140850688,1744830464,2348810240,1744830464,637534208,67108864,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,503316480,1677721600,2348810240,1744830464,637534208,67108864,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,503316480,1677721600,2348810240,1811939328,771751936,150994944,0,0,0,0,0,0,0,0,503316480,1677721600,2348810240,1811939328,1040187392,1207959552,1979711488,2248146944,1509949440,436207616,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,50331648,620756992,1879048192,3649264467,4294272360,4293853184,4293920000,4293920000,4293918720,3649195041,1979711488,754974720,134217728,0,0,0,0,0,67108864,335544320,1023410176,2080374784,3036676096,4088070144,4292476928,4292608000,4292739072,4292804608,4293347915,3581022738,1879048192,654311424,83886080,0,0,0,0,0,0,0,0,50331648,201326592,335544320,201326592,50331648,0,822083584,2533359616,4294967295,3261885548,2080374784,2768240640,4294967295,3261885548,1258291200,234881024,117440512,402653184,671088640
      ,687865856,469762048,184549376,33554432,0,83886080,318767104,419430400,352321536,469762048,620756992,620756992,520093696,335544320,150994944,50331648,0,0,50331648,201326592,335544320,201326592,50331648,0,822083584,2533359616,4294967295,3295439980,1610612736,872415232,520093696,318767104,301989888,167772160,33554432,0,33554432,167772160,301989888,167772160,33554432,50331648,201326592,335544320,201326592,50331648,0,0,0,50331648,184549376,469762048,704643072,704643072,469762048,184549376,855638016,2533359616,4294809856,3566287616,1493172224,335544320,0,0,50331648,234881024,402653184,234881024,50331648,0,822083584,2550136832,4294809856,3583064832,2147483648,2382364672,3921236224,4209802240,2181038080,687865856,184549376,469762048,704643072,704643072,469762048,184549376,50331648,50331648,234881024,520093696,671088640,704643072,822083584,889192448,771751936,721420288,805306368,771751936,520093696,234881024,50331648,0,0,0,0,268435456,1358954496,3023117852,4260334217,4293854213,4293919488,4293921024
      ,4293853184,4055516443,2348810240,939524096,150994944,0,0,0,0,33554432,201326592,671088640,1442840576,2264924160,3513790764,3356295425,3473866752,4207017984,4292673536,4292804608,4292870144,4292937479,4276240705,3174499075,1610612736,419430400,0,0,0,0,0,0,0,83886080,452984832,1157627904,1577058304,1174405120,486539264,83886080,905969664,2734686208,4294967295,3479528805,2533359616,3087007744,4294967295,3429394536,1543503872,520093696,754974720,1610612736,2248146944,2298478592,1845493760,1107296256,385875968,150994944,587202560,1409286144,1644167168,1442840576,1761607680,2147483648,2147483648,1962934272,1593835520,1040187392,385875968,50331648,83886080,452984832,1157627904,1577058304,1174405120,486539264,234881024,1191182336,2868903936,4294967295,3630326370,2734686208,2432696320,1962934272,1526726656,1392508928,822083584,167772160,0,167772160,822083584,1392508928,1073741824,436207616,503316480,1157627904,1577058304,1174405120,486539264,83886080,0,83886080,452984832,1140850688,1845493760,2315255808
      ,2315255808,1845493760,1140850688,1375731712,2818572288,4294804480,3666292992,1744830464,419430400,0,100663296,520093696,1275068416,1694498816,1291845632,536870912,234881024,1191182336,2868903936,4294804480,3783471360,2952790016,3768006912,4294606336,3681495040,2130706432,1023410176,1140850688,1845493760,2315255808,2315255808,1845493760,1140850688,469762048,335544320,1006632960,1879048192,2248146944,2298478592,2533359616,2667577344,2449473536,2332033024,2499805184,2449473536,1962934272,1191182336,419430400,50331648,0,0,83886080,754974720,2181038080,3971250292,4293995053,4293853184,4293855488,4293591040,4208406034,2938050314,1426063360,335544320,16777216,0,0,50331648,234881024,620756992,1207959552,2013265920,3107396370,4055000155,4293554803,4003672881,3221225472,3544186880,4292673536,4292804608,4292870144,4292870144,4293006099,4122616354,2600796160,1023410176,134217728,0,0,0,0,0,67108864,520093696,1560281088,2685209869,3768886436,2736133654,1644167168,603979776,1006632960,2734686208,4294967295
      ,3630326370,2952790016,3630326370,4294967295,3429394536,1711276032,1191182336,1979711488,3531768450,4140814287,4140945873,3801519766,2584349194,1493172224,1006632960,1728053248,3380576127,3769610159,2734686208,3752175013,4022386880,4022386880,3886721706,3513806960,2739028546,1140850688,285212672,520093696,1560281088,2685209869,3768886436,2736133654,1644167168,1107296256,1996488704,3579994722,4294967295,3780992349,3456106496,4294967295,3596837731,3173130786,3600916897,1828716544,553648128,50331648,553648128,1828716544,3600916897,2620009002,1509949440,1694498816,2685209869,3768886436,2736133654,1644167168,603979776,150994944,503316480,1543503872,2889486848,3767873792,4175254272,4175254272,3767873792,2889486848,2399141888,3120562176,4294798592,3632408576,1694498816,402653184,83886080,587202560,1644167168,2786133248,3870512384,2870872320,1711276032,1140850688,2013265920,3682543616,4294798592,3866764800,3456106496,4294798592,4054399232,3338665984,2516582400,2097152000,2889486848,3767873792,4175254272
      ,4175254272,3767873792,2889486848,1660944384,1275068416,2097152000,3836689152,4192360448,3422552064,4294798592,4294798592,4192360448,3970513152,4294798592,4192360448,3903601152,2788757760,1174405120,234881024,0,0,335544320,1493172224,3259970090,4294206305,4293591040,4293263872,4292935936,4292806915,3648730389,1862270976,620756992,117440512,117440512,285212672,553648128,922746880,1392508928,2063597568,2938704652,3834466116,4276189301,4292948534,4293067009,4293740360,3732214294,3187671040,3918004480,4293132288,4293066752,4292935680,4292870144,4293073434,3681683208,1879048192,536870912,33554432,0,0,0,16777216,402653184,1509949440,2869890831,4106733511,4277729528,4157920468,3022135842,1644167168,1392508928,2751463424,4294967295,3730726494,3271557120,4294967295,4294967295,3429394536,2030043136,2147483648,3768820643,4209699562,3832574064,3815599469,4260820726,3970410407,2936999695,2499805184,3464001656,4022189501,3578678862,3355443200,4294967295,3747569503,3426828609,3426828609,4004030632,3784347792
      ,1996488704,922746880,1509949440,2869890831,4106733511,4277729528,4157920468,3022135842,2348810240,2768240640,4294967295,4294967295,3847969627,3640655872,4294967295,3847969627,4020084125,4260820726,2888510251,1157627904,335544320,1157627904,2888510251,4260820726,3852772516,2734686208,3004174352,4106733511,4277729528,4157920468,3022135842,1644167168,721420288,1275068416,3058897920,4106697728,4294726912,4020186368,4020186368,4294726912,4106697728,3561427200,3489660928,4294792448,3598458880,1660944384,402653184,452984832,1577058304,2937455616,4158017536,4277752576,4192228608,3090025216,2382364672,2801795072,4294792448,4294792448,3916570368,3640655872,4294792448,4294792448,4294792448,3170893824,3460961024,4106697728,4294726912,4020186368,4020186368,4294726912,4106697728,3259962368,2617245696,3649906432,4277752576,3730839552,3539992576,4294792448,3849592320,3679458560,4277752576,4037094656,3813479168,4277752576,3886493184,1996488704,536870912,0,67108864,788529152,2281701376,4072894821,4293201424
      ,4292870144,4292804608,4292608000,4156898324,2634022912,1392508928,822083584,905969664,1140850688,1476395008,2013265920,2617573888,3292798484,3902098491,4241976422,4292888908,4292806923,4293001216,4293263360,4293525760,4294260515,3510376966,3305308160,4191289856,4293394432,4293066752,4292935680,4293001473,4242215445,2871133184,1191182336,201326592,0,0,0,268435456,1291845632,2701723913,4072652735,4260754933,3782702967,4175355614,4158446812,2870877726,2264924160,3019898880,4294967295,3630326370,2952790016,3305111552,4294967295,3462817382,2399141888,3243660886,4277795321,3764675684,3372220416,3405774848,3780071247,4174829270,3729542220,3456106496,4294967295,3801256594,2885681152,3271557120,4294967295,3546506083,2298478592,2348810240,3648616825,4294967295,2818572288,2097152000,2701723913,4072652735,4260754933,3782702967,4175355614,4158446812,3289979161,3137339392,3456106496,4294967295,3847969627,3640655872,4294967295,3780992349,3645064003,4226674157,3767833748,1996488704,1174405120,1996488704
      ,3767833748,4243385580,3712107074,3473278470,4072652735,4260754933,3782702967,4175355614,4158446812,2870877726,1711276032,1811939328,3685360896,4124521216,3410759424,2920416000,2920416000,3427536640,4157944576,4105775616,3640655872,4294787072,3564509184,1627389952,637534208,1342177280,2785739264,4106956544,4260773120,3867745792,4209325824,4192286208,3323987200,3137339392,3456106496,4294787072,3899463168,3640655872,4294787072,3798931456,3204448256,3221225472,4055509504,4157944576,3427536640,2920416000,2920416000,3427536640,4157944576,4072286720,3456106496,4294787072,3886162944,2969567232,3305111552,4294787072,3698464768,2952790016,3783794432,4294787072,3640655872,3951172864,4294787072,2550136832,822083584,0,285212672,1426063360,3277007389,4293737023,4293066752,4292870144,4292739072,4241565196,3423471106,2717908992,2197815296,2264924160,2685010432,3005286916,3377536014,3851039012,4139536965,4292959323,4292818747,4292742414,4292804608,4292804608,4292935680,4293725440,4294590464,3954466066,2871071238
      ,2466250752,3445623808,4294119168,4293525504,4293132288,4293001216,4293462024,3835439624,2030043136,654311424,67108864,0,50331648,788529152,2348941826,3851061898,4260886519,3529005144,3120562176,3525452322,4243451373,3902446234,3288926473,3439329280,4294967295,3513017444,2634022912,3137339392,4294967295,3496306021,2583691264,3717567893,4209041632,3489660928,4141406424,4141538010,4124168657,4192461795,3868365458,3523215360,4294967295,3462817382,2499805184,3070230528,4294967295,3429394536,1811939328,1845493760,3446040166,4294967295,3422552064,3221225472,3851061898,4260886519,3529005144,3120562176,3525452322,4243451373,3952580503,3490318858,3539992576,4294967295,3847969627,3640655872,4294967295,3630326370,2952790016,3869483939,4260689140,3123917619,2415919104,3123917619,4260689140,4020084125,3640655872,3968239238,4260886519,3529005144,3120562176,3525452322,4243451373,3902446234,2735475724,2113929216,2600468480,3019898880,2583691264,2063597568,2063597568,2667577344,3714912256,4294781952,3640655872
      ,4294781952,3547336960,1728053248,1191182336,2382495744,3902150144,4277545472,3580038656,3120562176,3559458048,4243531776,3986889472,3490382080,3539992576,4294781952,3882225408,3640655872,4294781952,3614249216,2634022912,2919235584,4294781952,3714912256,2667577344,2063597568,2063597568,2667577344,3714912256,4294781952,3640655872,4294781952,3547336960,2583691264,3120562176,4294781952,3547336960,2566914048,3547336960,4294781952,3640655872,3882225408,4294781952,2734686208,905969664,50331648,687865856,2164260864,4004986156,4293526023,4293132288,4292804608,4292739072,4190049031,3866102791,3816952331,3868467732,4003800346,4156500256,4275644710,4292683559,4292682277,4292679193,4292739073,4292739072,4292608000,4292411392,4292673536,4293661184,4174923273,3446360857,2164260864,1291845632,1191182336,2332033024,4073140736,4294119168,4293525504,4293066752,4293263360,4276230916,3260750080,1392508928,318767104,16777216,184549376,1275068416,3157340465,4274439878,3678486849,3120562176,3289452817,3848232799
      ,4120681628,4291611852,3711251765,3456106496,4291611852,3799348597,2919235584,3288334336,4291611852,3461435729,2499805184,3410446151,4206212533,3778952766,3591574291,3388997632,3305111552,3170893824,3036676096,3372220416,4291611852,3427947090,2415919104,3019898880,4291611852,3427947090,1795162112,1795162112,3427947090,4291611852,3640655872,3760793897,4274439878,3678486849,3120562176,3289452817,3848232799,4120681628,4291611852,3795137845,3640655872,4291611852,3846785353,3640655872,4291611852,3478212945,2399141888,3073322799,4172394929,4121339558,3491832097,4121339558,4172394929,3542690089,3643353385,4274439878,3678486849,3120562176,3289452817,3848232799,4120681628,4291611852,3510188345,2785017856,3582069760,4090368512,3376612608,2920218624,2920218624,3393389824,4123791872,4037807872,3456106496,4294514688,3835038720,2231369728,1862270976,3191800832,4277278208,3696690944,3137339392,3323461888,3883600384,4140044544,4294514688,3813017088,3640655872,4294514688,3865118720,3640655872,4294514688
      ,3496610048,2130706432,2399141888,3954183936,4123791872,3393389824,2920218624,2920218624,3393389824,4123791872,4071296768,3640655872,4294514688,3496610048,2466250752,3053453312,4294514688,3496610048,2466250752,3496610048,4294514688,3640655872,3865118720,4294514688,2734686208,905969664,201326592,1224736768,3023639812,4277017613,4293656576,4293263360,4292870144,4292804608,4292870144,4292871176,4292939794,4292939796,4292873232,4292871689,4292739587,4292804608,4292804608,4292673536,4292542464,4292345856,4292542464,4293133568,4157219336,3665638928,2651785731,1677721600,771751936,251658240,385875968,1526726656,3327729408,4294721792,4294119168,4293591040,4293197824,4293925893,3987551235,2248146944,872415232,134217728,385875968,1677721600,3630721128,4291546059,3813757265,3849088108,4189172145,4154893990,3881063508,4154762404,3781387107,3070230528,3629931612,4257728455,3661512254,3539992576,4291611852,3427947090,2231369728,2769885465,3934158462,4205949361,3847311697,3643419178,3729081669,4037585064
      ,2902458368,3288334336,4291611852,3427947090,2415919104,3019898880,4291611852,3427947090,1795162112,1795162112,3427947090,4291611852,3640655872,3932250465,4291546059,3813757265,3849088108,4189172145,4154893990,3881063508,4154762404,3915275870,3640655872,4291611852,3846785353,3640655872,4291611852,3427947090,1929379840,1946157056,3309980234,4206541498,4274374085,4206541498,3427289160,2835349504,3731187045,4291546059,3813757265,3849088108,4189172145,4154893990,3881063508,4154762404,3865075808,3456106496,4294511104,4088530432,4294380032,3968205824,3968205824,4294380032,4038395392,3158180096,2533359616,3531015424,4260563200,3310682880,2583691264,3665954048,4294445568,3815047936,3867608064,4191881216,4157409024,3899130624,4157277952,3933602816,3640655872,4294511104,3864789504,3640655872,4294511104,3462923264,1778384896,1577058304,2957115648,4038395392,4294380032,3968205824,3968205824,4294380032,4038395392,3493396736,3472883712,4294511104,3462923264,2449473536,3036676096,4294511104,3462923264
      ,2449473536,3462923264,4294511104,3640655872,3864789504,4294511104,2734686208,905969664,436207616,1795162112,3784914178,4294453760,4293985792,4293525504,4293263360,4293066752,4293001216,4292870144,4292870144,4292870144,4292804608,4292739072,4292608000,4292411392,4292411392,4292411392,4292804608,4276096257,4055439621,3462337541,2617967874,1778384896,1006632960,436207616,100663296,0,83886080,822083584,2332033024,4107292928,4294722560,4294251776,4293656576,4293856768,4276101633,3515097344,1342177280,234881024,436207616,1711276032,3817968017,4206673084,4223647679,4019952539,3613812326,3157077293,2869101315,3461238350,4037716650,2516582400,2365587456,3614865014,4104759721,3405774848,4291611852,3260503895,1560281088,1526726656,2703500324,3630786921,4036861341,4240490688,3867575942,2973514812,2231369728,2885681152,4291611852,3260503895,2080374784,2768240640,4291611852,3260503895,1493172224,1493172224,3260503895,4291611852,3372220416,3951922573,4206673084,4223647679,4019952539,3613812326,3157077293
      ,2869101315,3461238350,4087982505,3405774848,4291611852,3662499149,3355443200,4291611852,3260503895,1358954496,872415232,1795162112,3224646708,4257662662,3224646708,2147483648,2147483648,3817968017,4206673084,4223647679,4019952539,3613812326,3157077293,2869101315,3461238350,4104628135,3590324224,4294508544,3815702528,3698589696,4073127936,4073127936,3598123008,2720661504,1543503872,1107296256,1929379840,3616538624,4057071616,2801795072,3870294016,4209246208,4226351104,4022140928,3615162368,3157852160,2869100544,3462266880,4090298368,3405774848,4294508544,3663659008,3355443200,4294508544,3261661184,1325400064,687865856,1476395008,2720661504,3598123008,4073127936,4073127936,3598123008,2720661504,2231369728,2902458368,4294508544,3261661184,2080374784,2768240640,4294508544,3261661184,2080374784,3261661184,4294508544,3355443200,3663659008,4294508544,2533359616,822083584,520093696,1962934272,4022817026,4294132225,4294521600,4294253056,4293920768,4293591296,4293197824,4293132288,4292935680,4292804608
      ,4292804608,4292804608,4292935936,4293135104,4242084099,4072214529,3597801734,3023440387,2231369728,1577058304,956301312,452984832,117440512,16777216,0,0,0,352321536,1627389952,3530502912,4294929408,4294791936,4294592513,4158276864,3444975876,2535986688,1006632960,150994944,234881024,1006632960,1929379840,2449473536,2483027968,2164260864,1694498816,1258291200,1174405120,1610612736,1929379840,1459617792,1124073472,1660944384,2130706432,2264924160,2348810240,1744830464,687865856,436207616,1023410176,1694498816,2197815296,2348810240,1962934272,1224736768,989855744,1761607680,2348810240,1744830464,1140850688,1744830464,2348810240,1744830464,721420288,721420288,1744830464,2348810240,2197815296,2164260864,2449473536,2483027968,2164260864,1694498816,1258291200,1174405120,1610612736,2063597568,2248146944,2348810240,2164260864,2164260864,2348810240,1744830464,637534208,184549376,704643072,1728053248,2281701376,1728053248,939524096,1124073472,1929379840,2449473536,2483027968,2164260864,1694498816
      ,1258291200,1174405120,1610612736,2483027968,3305111552,4294508544,3563126784,2449473536,2214592512,2147483648,1677721600,1023410176,402653184,234881024,788529152,1660944384,1996488704,1828716544,2030043136,2449473536,2483027968,2164260864,1694498816,1258291200,1174405120,1610612736,2063597568,2248146944,2348810240,2164260864,2164260864,2348810240,1744830464,637534208,150994944,402653184,1023410176,1677721600,2147483648,2147483648,1677721600,1023410176,905969664,1744830464,2348810240,1744830464,1140850688,1744830464,2348810240,1744830464,1140850688,1744830464,2348810240,2164260864,2164260864,2348810240,1677721600,503316480,318767104,1375731712,3059226113,3699846145,3869130506,4022230030,4141306627,4226171904,4260378112,4260178176,4259914240,4191428864,4089652224,3936955141,3648853506,3361147392,2887846915,2248146944,1694498816,1191182336,721420288,335544320,83886080,16777216,0,0,0,0,0,117440512,989855744,2585332736,4039860480,3784984577,3226543360,2382364672,1728053248,989855744,318767104
      ,33554432,50331648,234881024,536870912,771751936,788529152,620756992,385875968,167772160,134217728,352321536,520093696,369098752,234881024,436207616,620756992,671088640,721420288,503316480,134217728,33554432,150994944,385875968,637534208,721420288,520093696,234881024,184549376,503316480,721420288,503316480,268435456,503316480,721420288,503316480,134217728,134217728,503316480,721420288,637534208,620756992,771751936,788529152,620756992,385875968,167772160,134217728,352321536,587202560,671088640,721420288,620756992,620756992,721420288,503316480,134217728,0,134217728,469762048,687865856,469762048,167772160,234881024,536870912,771751936,788529152,620756992,385875968,167772160,134217728,352321536,1258291200,2734686208,4294508544,3278503936,1476395008,754974720,620756992,385875968,150994944,33554432,16777216,150994944,436207616,570425344,503316480,587202560,771751936,788529152,620756992,385875968,167772160,134217728,352321536,587202560,671088640,721420288,620756992,620756992,721420288,503316480
      ,134217728,0,33554432,150994944,385875968,620756992,620756992,385875968,150994944,150994944,503316480,721420288,503316480,268435456,503316480,721420288,503316480,268435456,503316480,721420288,620756992,620756992,721420288,503316480,134217728,67108864,503316480,1224736768,1744830464,1979711488,2181038080,2382364672,2533359616,2634022912,2634022912,2600468480,2466250752,2298478592,2046820352,1728053248,1409286144,1073741824,704643072,385875968,167772160,50331648,0,0,0,0,0,0,0,0,16777216,419430400,1342177280,1979711488,1862270976,1342177280,822083584,419430400,150994944,33554432,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,503316480,1677721600,2348810240,1744830464,637534208,67108864,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,50331648,234881024,419430400,536870912,637534208,738197504,822083584,855638016,872415232,838860800,788529152,687865856
      ,570425344,419430400,251658240,117440512,33554432,0,0,0,0,0,0,0,0,0,0,0,0,67108864,335544320,536870912,469762048,234881024,50331648,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,134217728,503316480,721420288,503316480,134217728,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]));
      return bmp;
   }
   
   private function onMouseDown(e:MouseEvent) : void
   {
      e.stopPropagation();
   }
   
   private function onClick(e:MouseEvent) : void
   {
      e.stopPropagation();
      try
      {
         navigateToURL(new URLRequest("http://alternativaplatform.com"),"_blank");
      }
      catch(e:Error)
      {
      }
   }
   
   private function onDoubleClick(e:MouseEvent) : void
   {
      e.stopPropagation();
   }
   
   private function onMouseMove(e:MouseEvent) : void
   {
      e.stopPropagation();
      transform.colorTransform = highlighted;
   }
   
   private function onMouseOut(e:MouseEvent) : void
   {
      e.stopPropagation();
      transform.colorTransform = normal;
   }
   
   private function onMouseWheel(e:MouseEvent) : void
   {
      e.stopPropagation();
   }
}
