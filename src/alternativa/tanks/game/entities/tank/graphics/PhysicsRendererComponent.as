package alternativa.tanks.game.entities.tank.graphics
{
   import alternativa.engine3d.alternativa3d;
   import alternativa.engine3d.core.Object3D;
   import alternativa.engine3d.materials.FillMaterial;
   import alternativa.engine3d.objects.WireFrame;
   import alternativa.engine3d.primitives.Box;
   import alternativa.math.Matrix4;
   import alternativa.math.Vector3;
   import alternativa.physics.Body;
   import alternativa.physics.CollisionPrimitiveListItem;
   import alternativa.physics.collision.primitives.§_-m3§;
   import alternativa.tanks.game.EntityComponent;
   import alternativa.tanks.game.GameKernel;
   import alternativa.tanks.game.entities.tank.TankHull;
   import alternativa.tanks.game.entities.tank.graphics.chassis.tracked.TrackedChassisGraphicsComponent;
   import alternativa.tanks.game.entities.tank.physics.chassis.tracked.legacy.LegacySuspensionRay;
   import alternativa.tanks.game.entities.tank.physics.chassis.tracked.legacy.LegacyTrack;
   import alternativa.tanks.game.entities.tank.physics.chassis.tracked.legacy.LegacyTrackedChassisComponent;
   import alternativa.tanks.game.entities.tank.physics.turret.TurretPhysicsComponent;
   import alternativa.tanks.game.subsystems.rendersystem.IRenderer;
   import alternativa.tanks.game.subsystems.rendersystem.RenderSystem;
   
   use namespace alternativa3d;
   
   public class PhysicsRendererComponent extends EntityComponent implements IRenderer
   {
      private static var material:FillMaterial = new FillMaterial(11141120);
      
      private static var bodyMaterial:FillMaterial = new FillMaterial(43520);
      
      private static var eulerAngles:Vector3 = new Vector3();
      
      private var chassis:LegacyTrackedChassisComponent;
      
      private var turret:TurretPhysicsComponent;
      
      private var §_-hF§:Vector.<CollisionPrimitive3D>;
      
      private var §_-ec§:Object3D;
      
      private var rays:Vector.<RayEntry>;
      
      public function PhysicsRendererComponent()
      {
         super();
      }
      
      override public function initComponent() : void
      {
         var collisionBox:§_-m3§ = null;
         var hs:Vector3 = null;
         var box:Box = null;
         var wireFrame:WireFrame = null;
         this.chassis = LegacyTrackedChassisComponent(entity.getComponentStrict(LegacyTrackedChassisComponent));
         this.turret = TurretPhysicsComponent(entity.getComponentStrict(TurretPhysicsComponent));
         this.§_-hF§ = new Vector.<CollisionPrimitive3D>();
         var body:Body = this.chassis.getBody();
         for(var item:CollisionPrimitiveListItem = body.collisionPrimitives.head; item != null; )
         {
            collisionBox = §_-m3§(item.primitive);
            hs = collisionBox.hs.clone().scale(2);
            box = new Box(hs.x,hs.y,hs.z);
            wireFrame = WireFrame.createEdges(box,16711680);
            this.§_-hF§.push(new CollisionPrimitive3D(collisionBox,wireFrame));
            item = item.next;
         }
         var trackedChassisGraphicsComponent:TrackedChassisGraphicsComponent = TrackedChassisGraphicsComponent(entity.getComponentStrict(TrackedChassisGraphicsComponent));
         var hull:TankHull = trackedChassisGraphicsComponent.getHull();
         hs = hull.§_-eh§.hs.clone().scale(2);
         box = new Box(hs.x,hs.y,hs.z);
         this.§_-ec§ = WireFrame.createEdges(box,65280);
         this.initRays();
      }
      
      private function initRays() : void
      {
         this.rays = new Vector.<RayEntry>();
         this.addRays(this.chassis.§_-Ei§,this.rays);
         this.addRays(this.chassis.§_-iA§,this.rays);
      }
      
      private function addRays(track:LegacyTrack, rays:Vector.<RayEntry>) : void
      {
         var ray:LegacySuspensionRay = null;
         var box:Box = null;
         var wireFrame1:WireFrame = null;
         var wireFrame2:WireFrame = null;
         for each(ray in track.rays)
         {
            box = new Box(10,10,10);
            wireFrame1 = WireFrame.createEdges(box,255);
            box = new Box(10,10,10);
            wireFrame2 = WireFrame.createEdges(box,65535);
            rays.push(new RayEntry(ray,wireFrame1,wireFrame2));
         }
      }
      
      override public function addToGame(gameKernel:GameKernel) : void
      {
         var collisionPrimitive3D:CollisionPrimitive3D = null;
         var rayEntry:RayEntry = null;
         var renderSystem:RenderSystem = gameKernel.getRenderSystem();
         for each(collisionPrimitive3D in this.§_-hF§)
         {
            this.addObject3D(renderSystem,collisionPrimitive3D.skin);
         }
         this.addObject3D(renderSystem,this.§_-ec§);
         for each(rayEntry in this.rays)
         {
            this.addObject3D(renderSystem,rayEntry.originSkin);
            this.addObject3D(renderSystem,rayEntry.endSkin);
         }
         renderSystem.addRenderer(this);
      }
      
      override public function removeFromGame(gameKernel:GameKernel) : void
      {
         var collisionPrimitive3D:CollisionPrimitive3D = null;
         var rayEntry:RayEntry = null;
         var renderSystem:RenderSystem = gameKernel.getRenderSystem();
         for each(collisionPrimitive3D in this.§_-hF§)
         {
            this.removeObject3D(renderSystem,collisionPrimitive3D.skin);
         }
         for each(rayEntry in this.rays)
         {
            this.removeObject3D(renderSystem,rayEntry.originSkin);
            this.removeObject3D(renderSystem,rayEntry.endSkin);
         }
         this.removeObject3D(renderSystem,this.§_-ec§);
         gameKernel.getRenderSystem().removeRenderer(this);
      }
      
      private function addObject3D(renderSystem:RenderSystem, object:Object3D) : void
      {
         renderSystem.getDynamicObjectsContainer().addChild(object);
         renderSystem.useResources(object.getResources());
      }
      
      private function removeObject3D(renderSystem:RenderSystem, object:Object3D) : void
      {
         object.alternativa3d::removeFromParent();
         renderSystem.releaseResources(object.getResources());
      }
      
      public function render() : void
      {
         var entry:CollisionPrimitive3D = null;
         var body:Body = null;
         var rayEntry:RayEntry = null;
         var transform:Matrix4 = null;
         var skin:Object3D = null;
         var worldPos:Vector3 = null;
         var rayLength:Number = NaN;
         for each(entry in this.§_-hF§)
         {
            transform = entry.collisionPrimitive.transform;
            transform.getEulerAngles(eulerAngles);
            skin = entry.skin;
            skin.x = transform.d;
            skin.y = transform.h;
            skin.z = transform.l;
            skin.rotationX = eulerAngles.x;
            skin.rotationY = eulerAngles.y;
            skin.rotationZ = eulerAngles.z;
         }
         body = this.chassis.getBody();
         body.baseMatrix.getEulerAngles(eulerAngles);
         this.§_-ec§.rotationX = eulerAngles.x;
         this.§_-ec§.rotationY = eulerAngles.y;
         this.§_-ec§.rotationZ = eulerAngles.z;
         this.§_-ec§.x = body.state.position.x;
         this.§_-ec§.y = body.state.position.y;
         this.§_-ec§.z = body.state.position.z;
         for each(rayEntry in this.rays)
         {
            worldPos = rayEntry.ray.worldPos;
            rayEntry.originSkin.x = worldPos.x;
            rayEntry.originSkin.y = worldPos.y;
            rayEntry.originSkin.z = worldPos.z;
            if(rayEntry.ray.§_-n3§)
            {
               rayLength = rayEntry.ray.§_-ZA§.t;
            }
            else
            {
               rayLength = this.chassis.§_-CF§.rayLength;
            }
            rayEntry.endSkin.x = worldPos.x + rayEntry.ray.§_-Py§.x * rayLength;
            rayEntry.endSkin.y = worldPos.y + rayEntry.ray.§_-Py§.y * rayLength;
            rayEntry.endSkin.z = worldPos.z + rayEntry.ray.§_-Py§.z * rayLength;
         }
      }
   }
}

import alternativa.engine3d.core.Object3D;
import alternativa.physics.collision.CollisionPrimitive;
import alternativa.tanks.game.entities.tank.physics.chassis.tracked.legacy.LegacySuspensionRay;

class CollisionPrimitive3D
{
   public var collisionPrimitive:CollisionPrimitive;
   
   public var skin:Object3D;
   
   public function CollisionPrimitive3D(collisionPrimitive:CollisionPrimitive, skin:Object3D)
   {
      super();
      this.collisionPrimitive = collisionPrimitive;
      this.skin = skin;
   }
}

class RayEntry
{
   public var ray:LegacySuspensionRay;
   
   public var originSkin:Object3D;
   
   public var endSkin:Object3D;
   
   public function RayEntry(ray:LegacySuspensionRay, originSkin:Object3D, endSkin:Object3D)
   {
      super();
      this.ray = ray;
      this.originSkin = originSkin;
      this.endSkin = endSkin;
   }
}
