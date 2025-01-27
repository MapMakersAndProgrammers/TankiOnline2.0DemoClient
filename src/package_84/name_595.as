package package_84
{
   import package_19.name_380;
   import package_19.name_528;
   import package_21.name_78;
   import alternativa.tanks.game.entities.tank.graphics.materials.TracksMaterial2;
   import package_75.name_236;
   
   public class name_595
   {
      public var material:TracksMaterial2;
      
      public var physicsComponent:name_236;
      
      private var wheels:Vector.<name_380>;
      
      private var var_648:Vector.<Number>;
      
      private var var_647:Vector.<Number>;
      
      private var var_646:Vector.<Number>;
      
      private var dUdY:Number;
      
      private var var_645:Number = 0;
      
      private var trackSkin:name_528;
      
      public function name_595(trackSkin:name_528, wheels:Vector.<name_380>, dUdY:Number)
      {
         super();
         this.trackSkin = trackSkin;
         this.wheels = wheels;
         this.dUdY = dUdY;
         this.physicsComponent = this.physicsComponent;
         this.var_646 = new Vector.<Number>(wheels.length);
         for(var i:int = 0; i < wheels.length; i++)
         {
            this.var_646[i] = wheels[i].boundBox.maxY;
         }
         this.method_775();
      }
      
      public function name_598(period:Number, speed:Number, dt:Number) : void
      {
         var wheelMesh:name_380 = null;
         var wheelDeltaZ:Number = NaN;
         var bone:name_78 = null;
         var delta:Number = NaN;
         var newOffset:Number = NaN;
         var ds:Number = speed * dt;
         var numWheels:int = int(this.wheels.length);
         for(var i:int = 0; i < numWheels; )
         {
            wheelMesh = this.wheels[i];
            wheelMesh.rotationX -= ds / this.var_646[i];
            wheelDeltaZ = Number(this.physicsComponent.method_474(wheelMesh.name));
            wheelMesh.z = this.var_648[i] + wheelDeltaZ;
            bone = this.trackSkin.getChildByName(this.method_774(wheelMesh.name));
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
      
      private function method_775() : void
      {
         var bone:name_78 = null;
         this.var_648 = new Vector.<Number>(this.wheels.length);
         this.var_647 = new Vector.<Number>(this.wheels.length);
         for(var i:int = 0; i < this.wheels.length; )
         {
            this.var_648[i] = this.wheels[i].z;
            bone = this.trackSkin.getChildByName(this.method_774(this.wheels[i].name));
            if(bone != null)
            {
               this.var_647[i] = bone.z;
            }
            i++;
         }
      }
      
      private function method_774(wheelName:String) : String
      {
         return "bn" + wheelName.substr(2);
      }
   }
}

