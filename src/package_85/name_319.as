package package_85
{
   import alternativa.engine3d.alternativa3d;
   import alternativa.tanks.game.EntityComponent;
   import alternativa.tanks.game.GameKernel;
   import package_109.name_377;
   import alternativa.tanks.game.subsystems.rendersystem.RenderSystem;
   import alternativa.tanks.game.subsystems.rendersystem.IRenderer;
   import package_19.name_509;
   import package_21.name_78;
   import package_4.name_313;
   import package_46.Matrix4;
   import package_46.name_194;
   import package_71.name_249;
   import package_77.name_237;
   import package_77.name_510;
   import package_77.name_515;
   import package_84.name_253;
   import package_92.name_271;
   import package_92.name_513;
   import package_94.name_276;
   import package_96.name_279;
   
   use namespace alternativa3d;
   
   public class name_319 extends EntityComponent implements IRenderer
   {
      private static var material:name_313 = new name_313(11141120);
      
      private static var bodyMaterial:name_313 = new name_313(43520);
      
      private static var eulerAngles:name_194 = new name_194();
      
      private var chassis:name_237;
      
      private var turret:name_276;
      
      private var var_444:Vector.<CollisionPrimitive3D>;
      
      private var var_443:name_78;
      
      private var rays:Vector.<RayEntry>;
      
      public function name_319()
      {
         super();
      }
      
      override public function initComponent() : void
      {
         var collisionBox:name_377 = null;
         var hs:name_194 = null;
         var box:name_279 = null;
         var wireFrame:name_509 = null;
         this.chassis = name_237(entity.getComponentStrict(name_237));
         this.turret = name_276(entity.getComponentStrict(name_276));
         this.var_444 = new Vector.<CollisionPrimitive3D>();
         var body:name_271 = this.chassis.getBody();
         for(var item:name_513 = body.collisionPrimitives.head; item != null; )
         {
            collisionBox = name_377(item.primitive);
            hs = collisionBox.hs.clone().scale(2);
            box = new name_279(hs.x,hs.y,hs.z);
            wireFrame = name_509.name_511(box,16711680);
            this.var_444.push(new CollisionPrimitive3D(collisionBox,wireFrame));
            item = item.next;
         }
         var trackedChassisGraphicsComponent:name_253 = name_253(entity.getComponentStrict(name_253));
         var hull:name_249 = trackedChassisGraphicsComponent.name_351();
         hs = hull.name_517.hs.clone().scale(2);
         box = new name_279(hs.x,hs.y,hs.z);
         this.var_443 = name_509.name_511(box,65280);
         this.method_407();
      }
      
      private function method_407() : void
      {
         this.rays = new Vector.<RayEntry>();
         this.method_406(this.chassis.name_337,this.rays);
         this.method_406(this.chassis.name_340,this.rays);
      }
      
      private function method_406(track:name_515, rays:Vector.<RayEntry>) : void
      {
         var ray:name_510 = null;
         var box:name_279 = null;
         var wireFrame1:name_509 = null;
         var wireFrame2:name_509 = null;
         for each(ray in track.rays)
         {
            box = new name_279(10,10,10);
            wireFrame1 = name_509.name_511(box,255);
            box = new name_279(10,10,10);
            wireFrame2 = name_509.name_511(box,65535);
            rays.push(new RayEntry(ray,wireFrame1,wireFrame2));
         }
      }
      
      override public function addToGame(gameKernel:GameKernel) : void
      {
         var collisionPrimitive3D:CollisionPrimitive3D = null;
         var rayEntry:RayEntry = null;
         var renderSystem:RenderSystem = gameKernel.name_5();
         for each(collisionPrimitive3D in this.var_444)
         {
            this.method_404(renderSystem,collisionPrimitive3D.skin);
         }
         this.method_404(renderSystem,this.var_443);
         for each(rayEntry in this.rays)
         {
            this.method_404(renderSystem,rayEntry.originSkin);
            this.method_404(renderSystem,rayEntry.endSkin);
         }
         renderSystem.method_63(this);
      }
      
      override public function removeFromGame(gameKernel:GameKernel) : void
      {
         var collisionPrimitive3D:CollisionPrimitive3D = null;
         var rayEntry:RayEntry = null;
         var renderSystem:RenderSystem = gameKernel.name_5();
         for each(collisionPrimitive3D in this.var_444)
         {
            this.method_405(renderSystem,collisionPrimitive3D.skin);
         }
         for each(rayEntry in this.rays)
         {
            this.method_405(renderSystem,rayEntry.originSkin);
            this.method_405(renderSystem,rayEntry.endSkin);
         }
         this.method_405(renderSystem,this.var_443);
         gameKernel.name_5().method_64(this);
      }
      
      private function method_404(renderSystem:RenderSystem, object:name_78) : void
      {
         renderSystem.method_46().addChild(object);
         renderSystem.method_32(object.getResources());
      }
      
      private function method_405(renderSystem:RenderSystem, object:name_78) : void
      {
         object.alternativa3d::removeFromParent();
         renderSystem.method_31(object.getResources());
      }
      
      public function render() : void
      {
         var entry:CollisionPrimitive3D = null;
         var body:name_271 = null;
         var rayEntry:RayEntry = null;
         var transform:Matrix4 = null;
         var skin:name_78 = null;
         var worldPos:name_194 = null;
         var rayLength:Number = NaN;
         for each(entry in this.var_444)
         {
            transform = entry.collisionPrimitive.transform;
            transform.name_341(eulerAngles);
            skin = entry.skin;
            skin.x = transform.d;
            skin.y = transform.h;
            skin.z = transform.l;
            skin.rotationX = eulerAngles.x;
            skin.rotationY = eulerAngles.y;
            skin.rotationZ = eulerAngles.z;
         }
         body = this.chassis.getBody();
         body.baseMatrix.name_341(eulerAngles);
         this.var_443.rotationX = eulerAngles.x;
         this.var_443.rotationY = eulerAngles.y;
         this.var_443.rotationZ = eulerAngles.z;
         this.var_443.x = body.state.position.x;
         this.var_443.y = body.state.position.y;
         this.var_443.z = body.state.position.z;
         for each(rayEntry in this.rays)
         {
            worldPos = rayEntry.ray.worldPos;
            rayEntry.originSkin.x = worldPos.x;
            rayEntry.originSkin.y = worldPos.y;
            rayEntry.originSkin.z = worldPos.z;
            if(rayEntry.ray.name_514)
            {
               rayLength = rayEntry.ray.name_516.t;
            }
            else
            {
               rayLength = this.chassis.name_518.rayLength;
            }
            rayEntry.endSkin.x = worldPos.x + rayEntry.ray.name_512.x * rayLength;
            rayEntry.endSkin.y = worldPos.y + rayEntry.ray.name_512.y * rayLength;
            rayEntry.endSkin.z = worldPos.z + rayEntry.ray.name_512.z * rayLength;
         }
      }
   }
}

import package_21.name_78;
import package_76.name_235;
import package_77.name_510;

class CollisionPrimitive3D
{
   public var collisionPrimitive:name_235;
   
   public var skin:name_78;
   
   public function CollisionPrimitive3D(collisionPrimitive:name_235, skin:name_78)
   {
      super();
      this.collisionPrimitive = collisionPrimitive;
      this.skin = skin;
   }
}

class RayEntry
{
   public var ray:name_510;
   
   public var originSkin:name_78;
   
   public var endSkin:name_78;
   
   public function RayEntry(ray:name_510, originSkin:name_78, endSkin:name_78)
   {
      super();
      this.ray = ray;
      this.originSkin = originSkin;
      this.endSkin = endSkin;
   }
}
