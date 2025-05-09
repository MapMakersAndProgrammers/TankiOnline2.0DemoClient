package package_53
{
   import alternativa.engine3d.alternativa3d;
   import package_15.class_18;
   import package_15.name_17;
   import package_18.class_19;
   import package_18.name_51;
   import package_19.name_376;
   import package_3.name_234;
   import package_33.name_130;
   import package_38.Matrix4;
   import package_38.name_145;
   import package_39.name_161;
   import package_42.name_147;
   import package_42.name_377;
   import package_42.name_384;
   import package_52.name_166;
   import package_61.name_186;
   import package_61.name_380;
   import package_63.name_192;
   import package_65.name_195;
   import package_80.name_311;
   
   use namespace alternativa3d;
   
   public class name_241 extends class_18 implements class_19
   {
      private static var material:name_234 = new name_234(11141120);
      
      private static var bodyMaterial:name_234 = new name_234(43520);
      
      private static var eulerAngles:name_145 = new name_145();
      
      private var chassis:name_147;
      
      private var turret:name_192;
      
      private var var_444:Vector.<CollisionPrimitive3D>;
      
      private var var_443:name_130;
      
      private var rays:Vector.<RayEntry>;
      
      public function name_241()
      {
         super();
      }
      
      override public function initComponent() : void
      {
         var collisionBox:name_311 = null;
         var hs:name_145 = null;
         var box:name_195 = null;
         var wireFrame:name_376 = null;
         this.chassis = name_147(entity.getComponentStrict(name_147));
         this.turret = name_192(entity.getComponentStrict(name_192));
         this.var_444 = new Vector.<CollisionPrimitive3D>();
         var body:name_186 = this.chassis.getBody();
         for(var item:name_380 = body.collisionPrimitives.head; item != null; )
         {
            collisionBox = name_311(item.primitive);
            hs = collisionBox.hs.clone().scale(2);
            box = new name_195(hs.x,hs.y,hs.z);
            wireFrame = name_376.name_378(box,16711680);
            this.var_444.push(new CollisionPrimitive3D(collisionBox,wireFrame));
            item = item.next;
         }
         var trackedChassisGraphicsComponent:name_166 = name_166(entity.getComponentStrict(name_166));
         var hull:name_161 = trackedChassisGraphicsComponent.name_280();
         hs = hull.name_388.hs.clone().scale(2);
         box = new name_195(hs.x,hs.y,hs.z);
         this.var_443 = name_376.name_378(box,65280);
         this.method_168();
      }
      
      private function method_168() : void
      {
         this.rays = new Vector.<RayEntry>();
         this.method_167(this.chassis.name_261,this.rays);
         this.method_167(this.chassis.name_266,this.rays);
      }
      
      private function method_167(track:name_384, rays:Vector.<RayEntry>) : void
      {
         var ray:name_377 = null;
         var box:name_195 = null;
         var wireFrame1:name_376 = null;
         var wireFrame2:name_376 = null;
         for each(ray in track.rays)
         {
            box = new name_195(10,10,10);
            wireFrame1 = name_376.name_378(box,255);
            box = new name_195(10,10,10);
            wireFrame2 = name_376.name_378(box,65535);
            rays.push(new RayEntry(ray,wireFrame1,wireFrame2));
         }
      }
      
      override public function addToGame(gameKernel:name_17) : void
      {
         var collisionPrimitive3D:CollisionPrimitive3D = null;
         var rayEntry:RayEntry = null;
         var renderSystem:name_51 = gameKernel.name_5();
         for each(collisionPrimitive3D in this.var_444)
         {
            this.method_165(renderSystem,collisionPrimitive3D.skin);
         }
         this.method_165(renderSystem,this.var_443);
         for each(rayEntry in this.rays)
         {
            this.method_165(renderSystem,rayEntry.originSkin);
            this.method_165(renderSystem,rayEntry.endSkin);
         }
         renderSystem.name_387(this);
      }
      
      override public function removeFromGame(gameKernel:name_17) : void
      {
         var collisionPrimitive3D:CollisionPrimitive3D = null;
         var rayEntry:RayEntry = null;
         var renderSystem:name_51 = gameKernel.name_5();
         for each(collisionPrimitive3D in this.var_444)
         {
            this.method_166(renderSystem,collisionPrimitive3D.skin);
         }
         for each(rayEntry in this.rays)
         {
            this.method_166(renderSystem,rayEntry.originSkin);
            this.method_166(renderSystem,rayEntry.endSkin);
         }
         this.method_166(renderSystem,this.var_443);
         gameKernel.name_5().name_381(this);
      }
      
      private function method_165(renderSystem:name_51, object:name_130) : void
      {
         renderSystem.name_386().addChild(object);
         renderSystem.name_383(object.getResources());
      }
      
      private function method_166(renderSystem:name_51, object:name_130) : void
      {
         object.alternativa3d::removeFromParent();
         renderSystem.name_390(object.getResources());
      }
      
      public function render() : void
      {
         var entry:CollisionPrimitive3D = null;
         var body:name_186 = null;
         var rayEntry:RayEntry = null;
         var transform:Matrix4 = null;
         var skin:name_130 = null;
         var worldPos:name_145 = null;
         var rayLength:Number = NaN;
         for each(entry in this.var_444)
         {
            transform = entry.collisionPrimitive.transform;
            transform.name_267(eulerAngles);
            skin = entry.skin;
            skin.x = transform.d;
            skin.y = transform.h;
            skin.z = transform.l;
            skin.rotationX = eulerAngles.x;
            skin.rotationY = eulerAngles.y;
            skin.rotationZ = eulerAngles.z;
         }
         body = this.chassis.getBody();
         body.baseMatrix.name_267(eulerAngles);
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
            if(rayEntry.ray.name_382)
            {
               rayLength = Number(rayEntry.ray.name_385.t);
            }
            else
            {
               rayLength = Number(this.chassis.name_389.rayLength);
            }
            rayEntry.endSkin.x = worldPos.x + rayEntry.ray.name_379.x * rayLength;
            rayEntry.endSkin.y = worldPos.y + rayEntry.ray.name_379.y * rayLength;
            rayEntry.endSkin.z = worldPos.z + rayEntry.ray.name_379.z * rayLength;
         }
      }
   }
}

import package_33.name_130;
import package_42.name_377;
import package_51.name_276;

class CollisionPrimitive3D
{
   public var collisionPrimitive:name_276;
   
   public var skin:name_130;
   
   public function CollisionPrimitive3D(collisionPrimitive:name_276, skin:name_130)
   {
      super();
      this.collisionPrimitive = collisionPrimitive;
      this.skin = skin;
   }
}

class RayEntry
{
   public var ray:name_377;
   
   public var originSkin:name_130;
   
   public var endSkin:name_130;
   
   public function RayEntry(ray:name_377, originSkin:name_130, endSkin:name_130)
   {
      super();
      this.ray = ray;
      this.originSkin = originSkin;
      this.endSkin = endSkin;
   }
}
