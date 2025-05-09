package alternativa.engine3d.animation
{
   import alternativa.engine3d.alternativa3d;
   import alternativa.engine3d.animation.keys.TransformKey;
   import alternativa.engine3d.core.Object3D;
   import flash.geom.Vector3D;
   
   use namespace alternativa3d;
   
   public class AnimationState
   {
      public var var_731:int = 0;
      
      public var transform:TransformKey = new TransformKey();
      
      public var var_729:Number = 0;
      
      public var numbers:Object = new Object();
      
      public var var_730:Object = new Object();
      
      public function AnimationState()
      {
         super();
      }
      
      public function reset() : void
      {
         var key:String = null;
         this.var_729 = 0;
         for(key in this.numbers)
         {
            delete this.numbers[key];
            delete this.var_730[key];
         }
      }
      
      public function addWeightedTransform(key:TransformKey, weight:Number) : void
      {
         this.var_729 += weight;
         this.transform.interpolate(this.transform,key,weight / this.var_729);
      }
      
      public function addWeightedNumber(property:String, value:Number, weight:Number) : void
      {
         var current:Number = NaN;
         var sum:Number = Number(this.var_730[property]);
         if(sum == sum)
         {
            sum += weight;
            weight /= sum;
            current = Number(this.numbers[property]);
            this.numbers[property] = (1 - weight) * current + weight * value;
            this.var_730[property] = sum;
         }
         else
         {
            this.numbers[property] = value;
            this.var_730[property] = weight;
         }
      }
      
      public function apply(object:Object3D) : void
      {
         var sum:Number = NaN;
         var weight:Number = NaN;
         var key:String = null;
         if(this.var_729 > 0)
         {
            object.x = this.transform.alternativa3d::x;
            object.y = this.transform.alternativa3d::y;
            object.z = this.transform.alternativa3d::z;
            this.setEulerAngles(this.transform.alternativa3d::rotation,object);
            object.scaleX = this.transform.alternativa3d::scaleX;
            object.scaleY = this.transform.alternativa3d::scaleY;
            object.scaleZ = this.transform.alternativa3d::scaleZ;
         }
         for(key in this.numbers)
         {
            switch(key)
            {
               case "x":
                  sum = Number(this.var_730["x"]);
                  weight = sum / (sum + this.var_729);
                  object.x = (1 - weight) * object.x + weight * this.numbers["x"];
                  break;
               case "y":
                  sum = Number(this.var_730["y"]);
                  weight = sum / (sum + this.var_729);
                  object.y = (1 - weight) * object.y + weight * this.numbers["y"];
                  break;
               case "z":
                  sum = Number(this.var_730["z"]);
                  weight = sum / (sum + this.var_729);
                  object.z = (1 - weight) * object.z + weight * this.numbers["z"];
                  break;
               case "rotationX":
                  sum = Number(this.var_730["rotationX"]);
                  weight = sum / (sum + this.var_729);
                  object.rotationX = (1 - weight) * object.rotationX + weight * this.numbers["rotationX"];
                  break;
               case "rotationY":
                  sum = Number(this.var_730["rotationY"]);
                  weight = sum / (sum + this.var_729);
                  object.rotationY = (1 - weight) * object.rotationY + weight * this.numbers["rotationY"];
                  break;
               case "rotationZ":
                  sum = Number(this.var_730["rotationZ"]);
                  weight = sum / (sum + this.var_729);
                  object.rotationZ = (1 - weight) * object.rotationZ + weight * this.numbers["rotationZ"];
                  break;
               case "scaleX":
                  sum = Number(this.var_730["scaleX"]);
                  weight = sum / (sum + this.var_729);
                  object.scaleX = (1 - weight) * object.scaleX + weight * this.numbers["scaleX"];
                  break;
               case "scaleY":
                  sum = Number(this.var_730["scaleY"]);
                  weight = sum / (sum + this.var_729);
                  object.scaleY = (1 - weight) * object.scaleY + weight * this.numbers["scaleY"];
                  break;
               case "scaleZ":
                  sum = Number(this.var_730["scaleZ"]);
                  weight = sum / (sum + this.var_729);
                  object.scaleZ = (1 - weight) * object.scaleZ + weight * this.numbers["scaleZ"];
                  break;
               default:
                  object[key] = this.numbers[key];
                  break;
            }
         }
      }
      
      public function applyObject(object:Object) : void
      {
         var sum:Number = NaN;
         var weight:Number = NaN;
         var key:String = null;
         if(this.var_729 > 0)
         {
            object.x = this.transform.alternativa3d::x;
            object.y = this.transform.alternativa3d::y;
            object.z = this.transform.alternativa3d::z;
            this.setEulerAnglesObject(this.transform.alternativa3d::rotation,object);
            object.scaleX = this.transform.alternativa3d::scaleX;
            object.scaleY = this.transform.alternativa3d::scaleY;
            object.scaleZ = this.transform.alternativa3d::scaleZ;
         }
         for(key in this.numbers)
         {
            switch(key)
            {
               case "x":
                  sum = Number(this.var_730["x"]);
                  weight = sum / (sum + this.var_729);
                  object.x = (1 - weight) * object.x + weight * this.numbers["x"];
                  break;
               case "y":
                  sum = Number(this.var_730["y"]);
                  weight = sum / (sum + this.var_729);
                  object.y = (1 - weight) * object.y + weight * this.numbers["y"];
                  break;
               case "z":
                  sum = Number(this.var_730["z"]);
                  weight = sum / (sum + this.var_729);
                  object.z = (1 - weight) * object.z + weight * this.numbers["z"];
                  break;
               case "rotationX":
                  sum = Number(this.var_730["rotationX"]);
                  weight = sum / (sum + this.var_729);
                  object.rotationX = (1 - weight) * object.rotationX + weight * this.numbers["rotationX"];
                  break;
               case "rotationY":
                  sum = Number(this.var_730["rotationY"]);
                  weight = sum / (sum + this.var_729);
                  object.rotationY = (1 - weight) * object.rotationY + weight * this.numbers["rotationY"];
                  break;
               case "rotationZ":
                  sum = Number(this.var_730["rotationZ"]);
                  weight = sum / (sum + this.var_729);
                  object.rotationZ = (1 - weight) * object.rotationZ + weight * this.numbers["rotationZ"];
                  break;
               case "scaleX":
                  sum = Number(this.var_730["scaleX"]);
                  weight = sum / (sum + this.var_729);
                  object.scaleX = (1 - weight) * object.scaleX + weight * this.numbers["scaleX"];
                  break;
               case "scaleY":
                  sum = Number(this.var_730["scaleY"]);
                  weight = sum / (sum + this.var_729);
                  object.scaleY = (1 - weight) * object.scaleY + weight * this.numbers["scaleY"];
                  break;
               case "scaleZ":
                  sum = Number(this.var_730["scaleZ"]);
                  weight = sum / (sum + this.var_729);
                  object.scaleZ = (1 - weight) * object.scaleZ + weight * this.numbers["scaleZ"];
                  break;
               default:
                  object[key] = this.numbers[key];
                  break;
            }
         }
      }
      
      private function setEulerAngles(quat:Vector3D, object:Object3D) : void
      {
         var qi2:Number = 2 * quat.x * quat.x;
         var qj2:Number = 2 * quat.y * quat.y;
         var qk2:Number = 2 * quat.z * quat.z;
         var qij:Number = 2 * quat.x * quat.y;
         var qjk:Number = 2 * quat.y * quat.z;
         var qki:Number = 2 * quat.z * quat.x;
         var qri:Number = 2 * quat.w * quat.x;
         var qrj:Number = 2 * quat.w * quat.y;
         var qrk:Number = 2 * quat.w * quat.z;
         var aa:Number = 1 - qj2 - qk2;
         var bb:Number = qij - qrk;
         var ee:Number = qij + qrk;
         var ff:Number = 1 - qi2 - qk2;
         var ii:Number = qki - qrj;
         var jj:Number = qjk + qri;
         var kk:Number = 1 - qi2 - qj2;
         if(-1 < ii && ii < 1)
         {
            object.rotationX = Math.atan2(jj,kk);
            object.rotationY = -Math.asin(ii);
            object.rotationZ = Math.atan2(ee,aa);
         }
         else
         {
            object.rotationX = 0;
            object.rotationY = ii <= -1 ? Number(Math.PI) : -Math.PI;
            object.rotationY *= 0.5;
            object.rotationZ = Math.atan2(-bb,ff);
         }
      }
      
      private function setEulerAnglesObject(quat:Vector3D, object:Object) : void
      {
         var qi2:Number = 2 * quat.x * quat.x;
         var qj2:Number = 2 * quat.y * quat.y;
         var qk2:Number = 2 * quat.z * quat.z;
         var qij:Number = 2 * quat.x * quat.y;
         var qjk:Number = 2 * quat.y * quat.z;
         var qki:Number = 2 * quat.z * quat.x;
         var qri:Number = 2 * quat.w * quat.x;
         var qrj:Number = 2 * quat.w * quat.y;
         var qrk:Number = 2 * quat.w * quat.z;
         var aa:Number = 1 - qj2 - qk2;
         var bb:Number = qij - qrk;
         var ee:Number = qij + qrk;
         var ff:Number = 1 - qi2 - qk2;
         var ii:Number = qki - qrj;
         var jj:Number = qjk + qri;
         var kk:Number = 1 - qi2 - qj2;
         if(-1 < ii && ii < 1)
         {
            object.rotationX = Math.atan2(jj,kk);
            object.rotationY = -Math.asin(ii);
            object.rotationZ = Math.atan2(ee,aa);
         }
         else
         {
            object.rotationX = 0;
            object.rotationY = ii <= -1 ? Math.PI : -Math.PI;
            object.rotationY *= 0.5;
            object.rotationZ = Math.atan2(-bb,ff);
         }
      }
   }
}

