package alternativa.tanks.game.entities.tank.graphics.chassis.tracked
{
   import alternativa.engine3d.core.Object3D;
   import alternativa.engine3d.objects.Mesh;
   import alternativa.engine3d.objects.Skin;
   import alternativa.tanks.game.entities.tank.graphics.materials.TracksMaterial2;
   import alternativa.tanks.game.entities.tank.physics.IChassisPhysicsComponent;
   
   public class TrackAnimator
   {
      public var material:TracksMaterial2;
      
      public var physicsComponent:IChassisPhysicsComponent;
      
      private var wheels:Vector.<Mesh>;
      
      private var var_646:Vector.<Number>;
      
      private var var_647:Vector.<Number>;
      
      private var var_648:Vector.<Number>;
      
      private var dUdY:Number;
      
      private var var_645:Number = 0;
      
      private var trackSkin:Skin;
      
      public function TrackAnimator(trackSkin:Skin, wheels:Vector.<Mesh>, dUdY:Number)
      {
         super();
         this.trackSkin = trackSkin;
         this.wheels = wheels;
         this.dUdY = dUdY;
         this.physicsComponent = this.physicsComponent;
         this.var_648 = new Vector.<Number>(wheels.length);
         for(var i:int = 0; i < wheels.length; i++)
         {
            this.var_648[i] = wheels[i].boundBox.maxY;
         }
         this.initZCoords();
      }
      
      public function animate(period:Number, speed:Number, dt:Number) : void
      {
         var wheelMesh:Mesh = null;
         var wheelDeltaZ:Number = NaN;
         var bone:Object3D = null;
         var delta:Number = NaN;
         var newOffset:Number = NaN;
         var ds:Number = speed * dt;
         var numWheels:int = int(this.wheels.length);
         for(var i:int = 0; i < numWheels; )
         {
            wheelMesh = this.wheels[i];
            wheelMesh.rotationX -= ds / this.var_648[i];
            wheelDeltaZ = Number(this.physicsComponent.getWheelDeltaZ(wheelMesh.name));
            wheelMesh.z = this.var_646[i] + wheelDeltaZ;
            bone = this.trackSkin.getChildByName(this.getBoneName(wheelMesh.name));
            if(bone != null)
            {
               bone.z = this.var_647[i] + wheelDeltaZ;
            }
            i++;
         }
         if(period > 0)
         {
            delta = ds * this.dUdY;
            newOffset = this.var_645 + delta;
            if(newOffset < 0)
            {
               while(newOffset < 0)
               {
                  newOffset += period;
               }
               delta = newOffset - this.var_645;
               this.var_645 = newOffset;
            }
            else if(newOffset < period)
            {
               this.var_645 = newOffset;
            }
            else
            {
               while(newOffset >= period)
               {
                  newOffset -= period;
               }
               delta = newOffset - this.var_645;
               this.var_645 = newOffset;
            }
            this.material.vOffset = this.var_645;
         }
      }
      
      private function initZCoords() : void
      {
         var bone:Object3D = null;
         this.var_646 = new Vector.<Number>(this.wheels.length);
         this.var_647 = new Vector.<Number>(this.wheels.length);
         for(var i:int = 0; i < this.wheels.length; )
         {
            this.var_646[i] = this.wheels[i].z;
            bone = this.trackSkin.getChildByName(this.getBoneName(this.wheels[i].name));
            if(bone != null)
            {
               this.var_647[i] = bone.z;
            }
            i++;
         }
      }
      
      private function getBoneName(wheelName:String) : String
      {
         return "bn" + wheelName.substr(2);
      }
   }
}

