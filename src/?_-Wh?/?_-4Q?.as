package §_-Wh§
{
   import §_-8D§.§_-OX§;
   import §_-Ex§.§_-2S§;
   import §_-LX§.§_-VO§;
   import §_-US§.§_-4q§;
   import §_-US§.§_-BV§;
   import §_-Vh§.§_-YD§;
   import §_-aG§.§_-7-§;
   import §_-az§.§_-2J§;
   import §_-az§.§_-AG§;
   import §_-e6§.§_-1I§;
   import §_-e6§.§_-Kn§;
   import §_-fj§.§_-cx§;
   import §_-fj§.§_-gd§;
   import §_-fj§.§_-nL§;
   import §_-jd§.§_-82§;
   import §_-nl§.Matrix4;
   import §_-nl§.§_-bj§;
   import §_-pe§.§_-m3§;
   import alternativa.engine3d.alternativa3d;
   import §default§.§_-dT§;
   
   use namespace alternativa3d;
   
   public class §_-4Q§ extends §_-2J§ implements §_-Kn§
   {
      private static var material:§_-YD§ = new §_-YD§(11141120);
      
      private static var bodyMaterial:§_-YD§ = new §_-YD§(43520);
      
      private static var eulerAngles:§_-bj§ = new §_-bj§();
      
      private var chassis:§_-cx§;
      
      private var turret:§_-82§;
      
      private var §_-hF§:Vector.<CollisionPrimitive3D>;
      
      private var §_-ec§:§_-OX§;
      
      private var rays:Vector.<RayEntry>;
      
      public function §_-4Q§()
      {
         super();
      }
      
      override public function initComponent() : void
      {
         var collisionBox:§_-m3§ = null;
         var hs:§_-bj§ = null;
         var box:§_-7-§ = null;
         var wireFrame:§_-2S§ = null;
         this.chassis = §_-cx§(entity.getComponentStrict(§_-cx§));
         this.turret = §_-82§(entity.getComponentStrict(§_-82§));
         this.§_-hF§ = new Vector.<CollisionPrimitive3D>();
         var body:§_-BV§ = this.chassis.getBody();
         for(var item:§_-4q§ = body.collisionPrimitives.head; item != null; )
         {
            collisionBox = §_-m3§(item.primitive);
            hs = collisionBox.hs.clone().scale(2);
            box = new §_-7-§(hs.x,hs.y,hs.z);
            wireFrame = §_-2S§.§_-LJ§(box,16711680);
            this.§_-hF§.push(new CollisionPrimitive3D(collisionBox,wireFrame));
            item = item.next;
         }
         var trackedChassisGraphicsComponent:§_-VO§ = §_-VO§(entity.getComponentStrict(§_-VO§));
         var hull:§_-dT§ = trackedChassisGraphicsComponent.§_-lD§();
         hs = hull.§_-eh§.hs.clone().scale(2);
         box = new §_-7-§(hs.x,hs.y,hs.z);
         this.§_-ec§ = §_-2S§.§_-LJ§(box,65280);
         this.§_-CT§();
      }
      
      private function §_-CT§() : void
      {
         this.rays = new Vector.<RayEntry>();
         this.§_-6S§(this.chassis.§_-Ei§,this.rays);
         this.§_-6S§(this.chassis.§_-iA§,this.rays);
      }
      
      private function §_-6S§(track:§_-nL§, rays:Vector.<RayEntry>) : void
      {
         var ray:§_-gd§ = null;
         var box:§_-7-§ = null;
         var wireFrame1:§_-2S§ = null;
         var wireFrame2:§_-2S§ = null;
         for each(ray in track.rays)
         {
            box = new §_-7-§(10,10,10);
            wireFrame1 = §_-2S§.§_-LJ§(box,255);
            box = new §_-7-§(10,10,10);
            wireFrame2 = §_-2S§.§_-LJ§(box,65535);
            rays.push(new RayEntry(ray,wireFrame1,wireFrame2));
         }
      }
      
      override public function addToGame(gameKernel:§_-AG§) : void
      {
         var collisionPrimitive3D:CollisionPrimitive3D = null;
         var rayEntry:RayEntry = null;
         var renderSystem:§_-1I§ = gameKernel.§_-DZ§();
         for each(collisionPrimitive3D in this.§_-hF§)
         {
            this.§_-Ab§(renderSystem,collisionPrimitive3D.skin);
         }
         this.§_-Ab§(renderSystem,this.§_-ec§);
         for each(rayEntry in this.rays)
         {
            this.§_-Ab§(renderSystem,rayEntry.originSkin);
            this.§_-Ab§(renderSystem,rayEntry.endSkin);
         }
         renderSystem.§_-mA§(this);
      }
      
      override public function removeFromGame(gameKernel:§_-AG§) : void
      {
         var collisionPrimitive3D:CollisionPrimitive3D = null;
         var rayEntry:RayEntry = null;
         var renderSystem:§_-1I§ = gameKernel.§_-DZ§();
         for each(collisionPrimitive3D in this.§_-hF§)
         {
            this.§_-Je§(renderSystem,collisionPrimitive3D.skin);
         }
         for each(rayEntry in this.rays)
         {
            this.§_-Je§(renderSystem,rayEntry.originSkin);
            this.§_-Je§(renderSystem,rayEntry.endSkin);
         }
         this.§_-Je§(renderSystem,this.§_-ec§);
         gameKernel.§_-DZ§().§_-EI§(this);
      }
      
      private function §_-Ab§(renderSystem:§_-1I§, object:§_-OX§) : void
      {
         renderSystem.§_-Bj§().addChild(object);
         renderSystem.§_-IL§(object.getResources());
      }
      
      private function §_-Je§(renderSystem:§_-1I§, object:§_-OX§) : void
      {
         object.alternativa3d::removeFromParent();
         renderSystem.§_-Jb§(object.getResources());
      }
      
      public function render() : void
      {
         var entry:CollisionPrimitive3D = null;
         var body:§_-BV§ = null;
         var rayEntry:RayEntry = null;
         var transform:Matrix4 = null;
         var skin:§_-OX§ = null;
         var worldPos:§_-bj§ = null;
         var rayLength:Number = NaN;
         for each(entry in this.§_-hF§)
         {
            transform = entry.collisionPrimitive.transform;
            transform.§_-fJ§(eulerAngles);
            skin = entry.skin;
            skin.x = transform.d;
            skin.y = transform.h;
            skin.z = transform.l;
            skin.rotationX = eulerAngles.x;
            skin.rotationY = eulerAngles.y;
            skin.rotationZ = eulerAngles.z;
         }
         body = this.chassis.getBody();
         body.baseMatrix.§_-fJ§(eulerAngles);
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
               rayLength = Number(rayEntry.ray.§_-ZA§.t);
            }
            else
            {
               rayLength = Number(this.chassis.§_-CF§.rayLength);
            }
            rayEntry.endSkin.x = worldPos.x + rayEntry.ray.§_-Py§.x * rayLength;
            rayEntry.endSkin.y = worldPos.y + rayEntry.ray.§_-Py§.y * rayLength;
            rayEntry.endSkin.z = worldPos.z + rayEntry.ray.§_-Py§.z * rayLength;
         }
      }
   }
}

import §_-1e§.§_-Nh§;
import §_-8D§.§_-OX§;
import §_-fj§.§_-gd§;

class CollisionPrimitive3D
{
   public var collisionPrimitive:§_-Nh§;
   
   public var skin:§_-OX§;
   
   public function CollisionPrimitive3D(collisionPrimitive:§_-Nh§, skin:§_-OX§)
   {
      super();
      this.collisionPrimitive = collisionPrimitive;
      this.skin = skin;
   }
}

class RayEntry
{
   public var ray:§_-gd§;
   
   public var originSkin:§_-OX§;
   
   public var endSkin:§_-OX§;
   
   public function RayEntry(ray:§_-gd§, originSkin:§_-OX§, endSkin:§_-OX§)
   {
      super();
      this.ray = ray;
      this.originSkin = originSkin;
      this.endSkin = endSkin;
   }
}
