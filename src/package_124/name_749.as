package package_124
{
   import alternativa.engine3d.alternativa3d;
   import flash.geom.Vector3D;
   import package_125.name_787;
   import package_21.name_78;
   
   use namespace alternativa3d;
   
   public class name_749
   {
      public var var_732:int = 0;
      
      public var transform:name_787 = new name_787();
      
      public var var_730:Number = 0;
      
      public var numbers:Object = new Object();
      
      public var var_731:Object = new Object();
      
      public function name_749()
      {
         super();
      }
      
      public function reset() : void
      {
         var key:String = null;
         this.var_730 = 0;
         for(key in this.numbers)
         {
            delete this.numbers[key];
            delete this.var_731[key];
         }
      }
      
      public function method_920(key:name_787, weight:Number) : void
      {
         this.var_730 += weight;
         this.transform.interpolate(this.transform,key,weight / this.var_730);
      }
      
      public function method_919(property:String, value:Number, weight:Number) : void
      {
         var current:Number = NaN;
         var sum:Number = Number(this.var_731[property]);
         if(sum == sum)
         {
            sum += weight;
            weight /= sum;
            current = Number(this.numbers[property]);
            this.numbers[property] = (1 - weight) * current + weight * value;
            this.var_731[property] = sum;
         }
         else
         {
            this.numbers[property] = value;
            this.var_731[property] = weight;
         }
      }
      
      public function name_683(object:name_78) : void
      {
         var sum:Number = NaN;
         var weight:Number = NaN;
         var key:String = null;
         if(this.var_730 > 0)
         {
            object.x = this.transform.alternativa3d::x;
            object.y = this.transform.alternativa3d::y;
            object.z = this.transform.alternativa3d::z;
            this.method_917(this.transform.alternativa3d::rotation,object);
            object.scaleX = this.transform.alternativa3d::scaleX;
            object.scaleY = this.transform.alternativa3d::scaleY;
            object.scaleZ = this.transform.alternativa3d::scaleZ;
         }
         for(key in this.numbers)
         {
            switch(key)
            {
               case "x":
                  sum = Number(this.var_731["x"]);
                  weight = sum / (sum + this.var_730);
                  object.x = (1 - weight) * object.x + weight * this.numbers["x"];
                  break;
               case "y":
                  sum = Number(this.var_731["y"]);
                  weight = sum / (sum + this.var_730);
                  object.y = (1 - weight) * object.y + weight * this.numbers["y"];
                  break;
               case "z":
                  sum = Number(this.var_731["z"]);
                  weight = sum / (sum + this.var_730);
                  object.z = (1 - weight) * object.z + weight * this.numbers["z"];
                  break;
               case "rotationX":
                  sum = Number(this.var_731["rotationX"]);
                  weight = sum / (sum + this.var_730);
                  object.rotationX = (1 - weight) * object.rotationX + weight * this.numbers["rotationX"];
                  break;
               case "rotationY":
                  sum = Number(this.var_731["rotationY"]);
                  weight = sum / (sum + this.var_730);
                  object.rotationY = (1 - weight) * object.rotationY + weight * this.numbers["rotationY"];
                  break;
               case "rotationZ":
                  sum = Number(this.var_731["rotationZ"]);
                  weight = sum / (sum + this.var_730);
                  object.rotationZ = (1 - weight) * object.rotationZ + weight * this.numbers["rotationZ"];
                  break;
               case "scaleX":
                  sum = Number(this.var_731["scaleX"]);
                  weight = sum / (sum + this.var_730);
                  object.scaleX = (1 - weight) * object.scaleX + weight * this.numbers["scaleX"];
                  break;
               case "scaleY":
                  sum = Number(this.var_731["scaleY"]);
                  weight = sum / (sum + this.var_730);
                  object.scaleY = (1 - weight) * object.scaleY + weight * this.numbers["scaleY"];
                  break;
               case "scaleZ":
                  sum = Number(this.var_731["scaleZ"]);
                  weight = sum / (sum + this.var_730);
                  object.scaleZ = (1 - weight) * object.scaleZ + weight * this.numbers["scaleZ"];
                  break;
               default:
                  object[key] = this.numbers[key];
                  break;
            }
         }
      }
      
      public function method_921(object:Object) : void
      {
         var sum:Number = NaN;
         var weight:Number = NaN;
         var key:String = null;
         if(this.var_730 > 0)
         {
            object.x = this.transform.alternativa3d::x;
            object.y = this.transform.alternativa3d::y;
            object.z = this.transform.alternativa3d::z;
            this.method_918(this.transform.alternativa3d::rotation,object);
            object.scaleX = this.transform.alternativa3d::scaleX;
            object.scaleY = this.transform.alternativa3d::scaleY;
            object.scaleZ = this.transform.alternativa3d::scaleZ;
         }
         for(key in this.numbers)
         {
            switch(key)
            {
               case "x":
                  sum = Number(this.var_731["x"]);
                  weight = sum / (sum + this.var_730);
                  object.x = (1 - weight) * object.x + weight * this.numbers["x"];
                  break;
               case "y":
                  sum = Number(this.var_731["y"]);
                  weight = sum / (sum + this.var_730);
                  object.y = (1 - weight) * object.y + weight * this.numbers["y"];
                  break;
               case "z":
                  sum = Number(this.var_731["z"]);
                  weight = sum / (sum + this.var_730);
                  object.z = (1 - weight) * object.z + weight * this.numbers["z"];
                  break;
               case "rotationX":
                  sum = Number(this.var_731["rotationX"]);
                  weight = sum / (sum + this.var_730);
                  object.rotationX = (1 - weight) * object.rotationX + weight * this.numbers["rotationX"];
                  break;
               case "rotationY":
                  sum = Number(this.var_731["rotationY"]);
                  weight = sum / (sum + this.var_730);
                  object.rotationY = (1 - weight) * object.rotationY + weight * this.numbers["rotationY"];
                  break;
               case "rotationZ":
                  sum = Number(this.var_731["rotationZ"]);
                  weight = sum / (sum + this.var_730);
                  object.rotationZ = (1 - weight) * object.rotationZ + weight * this.numbers["rotationZ"];
                  break;
               case "scaleX":
                  sum = Number(this.var_731["scaleX"]);
                  weight = sum / (sum + this.var_730);
                  object.scaleX = (1 - weight) * object.scaleX + weight * this.numbers["scaleX"];
                  break;
               case "scaleY":
                  sum = Number(this.var_731["scaleY"]);
                  weight = sum / (sum + this.var_730);
                  object.scaleY = (1 - weight) * object.scaleY + weight * this.numbers["scaleY"];
                  break;
               case "scaleZ":
                  sum = Number(this.var_731["scaleZ"]);
                  weight = sum / (sum + this.var_730);
                  object.scaleZ = (1 - weight) * object.scaleZ + weight * this.numbers["scaleZ"];
                  break;
               default:
                  object[key] = this.numbers[key];
                  break;
            }
         }
      }
      
      private function method_917(quat:Vector3D, object:name_78) : void
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
      
      private function method_918(quat:Vector3D, object:Object) : void
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

