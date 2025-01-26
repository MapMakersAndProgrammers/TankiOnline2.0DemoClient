package package_121
{
   import package_46.name_194;
   import package_76.name_235;
   import package_76.name_665;
   import package_92.name_630;
   
   public class class_41 implements name_665
   {
      public function class_41()
      {
         super();
      }
      
      public function getContact(prim1:name_235, prim2:name_235, contact:name_630) : Boolean
      {
         return false;
      }
      
      public function haveCollision(prim1:name_235, prim2:name_235) : Boolean
      {
         return false;
      }
      
      protected function method_824(hs:name_194, axisIdx:int, negativeFace:Boolean, result:Vector.<name_194>) : void
      {
         var v:name_194 = null;
         switch(axisIdx)
         {
            case 0:
               if(negativeFace)
               {
                  v = result[0];
                  v.x = -hs.x;
                  v.y = hs.y;
                  v.z = -hs.z;
                  v = result[1];
                  v.x = -hs.x;
                  v.y = -hs.y;
                  v.z = -hs.z;
                  v = result[2];
                  v.x = -hs.x;
                  v.y = -hs.y;
                  v.z = hs.z;
                  v = result[3];
                  v.x = -hs.x;
                  v.y = hs.y;
                  v.z = hs.z;
                  break;
               }
               v = result[0];
               v.x = hs.x;
               v.y = -hs.y;
               v.z = -hs.z;
               v = result[1];
               v.x = hs.x;
               v.y = hs.y;
               v.z = -hs.z;
               v = result[2];
               v.x = hs.x;
               v.y = hs.y;
               v.z = hs.z;
               v = result[3];
               v.x = hs.x;
               v.y = -hs.y;
               v.z = hs.z;
               break;
            case 1:
               if(negativeFace)
               {
                  v = result[0];
                  v.x = -hs.x;
                  v.y = -hs.y;
                  v.z = -hs.z;
                  v = result[1];
                  v.x = hs.x;
                  v.y = -hs.y;
                  v.z = -hs.z;
                  v = result[2];
                  v.x = hs.x;
                  v.y = -hs.y;
                  v.z = hs.z;
                  v = result[3];
                  v.x = -hs.x;
                  v.y = -hs.y;
                  v.z = hs.z;
                  break;
               }
               v = result[0];
               v.x = hs.x;
               v.y = hs.y;
               v.z = -hs.z;
               v = result[1];
               v.x = -hs.x;
               v.y = hs.y;
               v.z = -hs.z;
               v = result[2];
               v.x = -hs.x;
               v.y = hs.y;
               v.z = hs.z;
               v = result[3];
               v.x = hs.x;
               v.y = hs.y;
               v.z = hs.z;
               break;
            case 2:
               if(negativeFace)
               {
                  v = result[0];
                  v.x = -hs.x;
                  v.y = hs.y;
                  v.z = -hs.z;
                  v = result[1];
                  v.x = hs.x;
                  v.y = hs.y;
                  v.z = -hs.z;
                  v = result[2];
                  v.x = hs.x;
                  v.y = -hs.y;
                  v.z = -hs.z;
                  v = result[3];
                  v.x = -hs.x;
                  v.y = -hs.y;
                  v.z = -hs.z;
                  break;
               }
               v = result[0];
               v.x = -hs.x;
               v.y = -hs.y;
               v.z = hs.z;
               v = result[1];
               v.x = hs.x;
               v.y = -hs.y;
               v.z = hs.z;
               v = result[2];
               v.x = hs.x;
               v.y = hs.y;
               v.z = hs.z;
               v = result[3];
               v.x = -hs.x;
               v.y = hs.y;
               v.z = hs.z;
               break;
         }
      }
      
      protected function method_822(x:Number, pnum:int, points:Vector.<name_194>, result:Vector.<name_194>, epsilon:Number) : int
      {
         var x1:Number = NaN;
         var p2:name_194 = null;
         var dx:Number = NaN;
         var dy:Number = NaN;
         var dz:Number = NaN;
         var t:Number = NaN;
         var v:name_194 = null;
         x1 = x - epsilon;
         var num:int = 0;
         var p1:name_194 = points[int(pnum - 1)];
         for(var i:int = 0; i < pnum; i++)
         {
            p2 = points[i];
            if(p1.x > x1)
            {
               v = result[num];
               num++;
               v.x = p1.x;
               v.y = p1.y;
               v.z = p1.z;
               if(p2.x < x1)
               {
                  dx = p2.x - p1.x;
                  dy = p2.y - p1.y;
                  dz = p2.z - p1.z;
                  t = (x - p1.x) / dx;
                  v = result[num];
                  num++;
                  v.x = p1.x + t * dx;
                  v.y = p1.y + t * dy;
                  v.z = p1.z + t * dz;
               }
            }
            else if(p2.x > x1)
            {
               dx = p2.x - p1.x;
               dy = p2.y - p1.y;
               dz = p2.z - p1.z;
               t = (x - p1.x) / dx;
               v = result[num];
               num++;
               v.x = p1.x + t * dx;
               v.y = p1.y + t * dy;
               v.z = p1.z + t * dz;
            }
            p1 = p2;
         }
         return num;
      }
      
      protected function method_821(x:Number, pnum:int, points:Vector.<name_194>, result:Vector.<name_194>, epsilon:Number) : int
      {
         var p2:name_194 = null;
         var dx:Number = NaN;
         var dy:Number = NaN;
         var dz:Number = NaN;
         var t:Number = NaN;
         var v:name_194 = null;
         var x1:Number = x + epsilon;
         var num:int = 0;
         var p1:name_194 = points[int(pnum - 1)];
         for(var i:int = 0; i < pnum; i++)
         {
            p2 = points[i];
            if(p1.x < x1)
            {
               v = result[num];
               num++;
               v.x = p1.x;
               v.y = p1.y;
               v.z = p1.z;
               if(p2.x > x1)
               {
                  dx = p2.x - p1.x;
                  dy = p2.y - p1.y;
                  dz = p2.z - p1.z;
                  t = (x - p1.x) / dx;
                  v = result[num];
                  num++;
                  v.x = p1.x + t * dx;
                  v.y = p1.y + t * dy;
                  v.z = p1.z + t * dz;
               }
            }
            else if(p2.x < x1)
            {
               dx = p2.x - p1.x;
               dy = p2.y - p1.y;
               dz = p2.z - p1.z;
               t = (x - p1.x) / dx;
               v = result[num];
               num++;
               v.x = p1.x + t * dx;
               v.y = p1.y + t * dy;
               v.z = p1.z + t * dz;
            }
            p1 = p2;
         }
         return num;
      }
      
      protected function method_818(y:Number, pnum:int, points:Vector.<name_194>, result:Vector.<name_194>, epsilon:Number) : int
      {
         var p2:name_194 = null;
         var dx:Number = NaN;
         var dy:Number = NaN;
         var dz:Number = NaN;
         var t:Number = NaN;
         var v:name_194 = null;
         var y1:Number = y - epsilon;
         var num:int = 0;
         var p1:name_194 = points[int(pnum - 1)];
         for(var i:int = 0; i < pnum; i++)
         {
            p2 = points[i];
            if(p1.y > y1)
            {
               v = result[num];
               num++;
               v.x = p1.x;
               v.y = p1.y;
               v.z = p1.z;
               if(p2.y < y1)
               {
                  dx = p2.x - p1.x;
                  dy = p2.y - p1.y;
                  dz = p2.z - p1.z;
                  t = (y - p1.y) / dy;
                  v = result[num];
                  num++;
                  v.x = p1.x + t * dx;
                  v.y = p1.y + t * dy;
                  v.z = p1.z + t * dz;
               }
            }
            else if(p2.y > y1)
            {
               dx = p2.x - p1.x;
               dy = p2.y - p1.y;
               dz = p2.z - p1.z;
               t = (y - p1.y) / dy;
               v = result[num];
               num++;
               v.x = p1.x + t * dx;
               v.y = p1.y + t * dy;
               v.z = p1.z + t * dz;
            }
            p1 = p2;
         }
         return num;
      }
      
      protected function method_823(y:Number, pnum:int, points:Vector.<name_194>, result:Vector.<name_194>, epsilon:Number) : int
      {
         var p2:name_194 = null;
         var dx:Number = NaN;
         var dy:Number = NaN;
         var dz:Number = NaN;
         var t:Number = NaN;
         var v:name_194 = null;
         var y1:Number = y + epsilon;
         var num:int = 0;
         var p1:name_194 = points[int(pnum - 1)];
         for(var i:int = 0; i < pnum; i++)
         {
            p2 = points[i];
            if(p1.y < y1)
            {
               v = result[num];
               num++;
               v.x = p1.x;
               v.y = p1.y;
               v.z = p1.z;
               if(p2.y > y1)
               {
                  dx = p2.x - p1.x;
                  dy = p2.y - p1.y;
                  dz = p2.z - p1.z;
                  t = (y - p1.y) / dy;
                  v = result[num];
                  num++;
                  v.x = p1.x + t * dx;
                  v.y = p1.y + t * dy;
                  v.z = p1.z + t * dz;
               }
            }
            else if(p2.y < y1)
            {
               dx = p2.x - p1.x;
               dy = p2.y - p1.y;
               dz = p2.z - p1.z;
               t = (y - p1.y) / dy;
               v = result[num];
               num++;
               v.x = p1.x + t * dx;
               v.y = p1.y + t * dy;
               v.z = p1.z + t * dz;
            }
            p1 = p2;
         }
         return num;
      }
      
      protected function method_819(z:Number, pnum:int, points:Vector.<name_194>, result:Vector.<name_194>, epsilon:Number) : int
      {
         var p2:name_194 = null;
         var dx:Number = NaN;
         var dy:Number = NaN;
         var dz:Number = NaN;
         var t:Number = NaN;
         var v:name_194 = null;
         var z1:Number = z - epsilon;
         var num:int = 0;
         var p1:name_194 = points[int(pnum - 1)];
         for(var i:int = 0; i < pnum; i++)
         {
            p2 = points[i];
            if(p1.z > z1)
            {
               v = result[num];
               num++;
               v.x = p1.x;
               v.y = p1.y;
               v.z = p1.z;
               if(p2.z < z1)
               {
                  dx = p2.x - p1.x;
                  dy = p2.y - p1.y;
                  dz = p2.z - p1.z;
                  t = (z - p1.z) / dz;
                  v = result[num];
                  num++;
                  v.x = p1.x + t * dx;
                  v.y = p1.y + t * dy;
                  v.z = p1.z + t * dz;
               }
            }
            else if(p2.z > z1)
            {
               dx = p2.x - p1.x;
               dy = p2.y - p1.y;
               dz = p2.z - p1.z;
               t = (z - p1.z) / dz;
               v = result[num];
               num++;
               v.x = p1.x + t * dx;
               v.y = p1.y + t * dy;
               v.z = p1.z + t * dz;
            }
            p1 = p2;
         }
         return num;
      }
      
      protected function method_820(z:Number, pnum:int, points:Vector.<name_194>, result:Vector.<name_194>, epsilon:Number) : int
      {
         var p2:name_194 = null;
         var dx:Number = NaN;
         var dy:Number = NaN;
         var dz:Number = NaN;
         var t:Number = NaN;
         var v:name_194 = null;
         var z1:Number = z + epsilon;
         var num:int = 0;
         var p1:name_194 = points[int(pnum - 1)];
         for(var i:int = 0; i < pnum; i++)
         {
            p2 = points[i];
            if(p1.z < z1)
            {
               v = result[num];
               num++;
               v.x = p1.x;
               v.y = p1.y;
               v.z = p1.z;
               if(p2.z > z1)
               {
                  dx = p2.x - p1.x;
                  dy = p2.y - p1.y;
                  dz = p2.z - p1.z;
                  t = (z - p1.z) / dz;
                  v = result[num];
                  num++;
                  v.x = p1.x + t * dx;
                  v.y = p1.y + t * dy;
                  v.z = p1.z + t * dz;
               }
            }
            else if(p2.z < z1)
            {
               dx = p2.x - p1.x;
               dy = p2.y - p1.y;
               dz = p2.z - p1.z;
               t = (z - p1.z) / dz;
               v = result[num];
               num++;
               v.x = p1.x + t * dx;
               v.y = p1.y + t * dy;
               v.z = p1.z + t * dz;
            }
            p1 = p2;
         }
         return num;
      }
   }
}

