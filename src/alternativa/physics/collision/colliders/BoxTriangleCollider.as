package alternativa.physics.collision.colliders
{
   import alternativa.physics.collision.CollisionPrimitive;
   import alternativa.physics.Contact;
   import alternativa.physics.ContactPoint;
   import alternativa.math.Matrix4;
   import alternativa.math.Vector3;
   import alternativa.physics.collision.primitives.CollisionTriangle;
   import alternativa.physics.collision.primitives.CollisionBox;
   
   public class BoxTriangleCollider extends BoxCollider
   {
      public var epsilon:Number = 0.001;
      
      private var name_Wt:int;
      
      private var name_hK:Number;
      
      private var toBox:Vector3 = new Vector3();
      
      private var axis:Vector3 = new Vector3();
      
      private var name_VZ:Vector3 = new Vector3();
      
      private var axis10:Vector3 = new Vector3();
      
      private var axis11:Vector3 = new Vector3();
      
      private var axis12:Vector3 = new Vector3();
      
      private var axis20:Vector3 = new Vector3();
      
      private var axis21:Vector3 = new Vector3();
      
      private var axis22:Vector3 = new Vector3();
      
      private var points1:Vector.<Vector3> = new Vector.<Vector3>(8,true);
      
      private var points2:Vector.<Vector3> = new Vector.<Vector3>(8,true);
      
      public function BoxTriangleCollider()
      {
         super();
         for(var i:int = 0; i < 8; i++)
         {
            this.points1[i] = new Vector3();
            this.points2[i] = new Vector3();
         }
      }
      
      override public function getContact(prim1:CollisionPrimitive, prim2:CollisionPrimitive, contact:Contact) : Boolean
      {
         var box:CollisionBox = null;
         if(!this.haveCollision(prim1,prim2))
         {
            return false;
         }
         var tri:CollisionTriangle = prim1 as CollisionTriangle;
         if(tri == null)
         {
            box = CollisionBox(prim1);
            tri = CollisionTriangle(prim2);
         }
         else
         {
            box = CollisionBox(prim2);
         }
         if(this.name_Wt < 4)
         {
            if(!this.findFaceContactPoints(box,tri,this.toBox,this.name_Wt,contact))
            {
               return false;
            }
         }
         else
         {
            this.name_Wt -= 4;
            if(!this.findEdgesIntersection(box,tri,this.toBox,this.name_Wt % 3,int(this.name_Wt / 3),contact))
            {
               return false;
            }
         }
         contact.body1 = box.body;
         contact.body2 = tri.body;
         if(tri.transform.k > 0.99999)
         {
            contact.normal.x = 0;
            contact.normal.y = 0;
            contact.normal.z = 1;
         }
         return true;
      }
      
      override public function haveCollision(prim1:CollisionPrimitive, prim2:CollisionPrimitive) : Boolean
      {
         var tri:CollisionTriangle = null;
         var box:CollisionBox = null;
         var triTransform:Matrix4 = null;
         var v:Vector3 = null;
         tri = prim1 as CollisionTriangle;
         if(tri == null)
         {
            box = CollisionBox(prim1);
            tri = CollisionTriangle(prim2);
         }
         else
         {
            box = CollisionBox(prim2);
         }
         var boxTransform:Matrix4 = box.transform;
         triTransform = tri.transform;
         this.toBox.x = boxTransform.d - triTransform.d;
         this.toBox.y = boxTransform.h - triTransform.h;
         this.toBox.z = boxTransform.l - triTransform.l;
         this.name_hK = 1e+308;
         this.axis.x = triTransform.c;
         this.axis.y = triTransform.g;
         this.axis.z = triTransform.k;
         if(!this.testMainAxis(box,tri,this.axis,0,this.toBox))
         {
            return false;
         }
         this.axis10.x = boxTransform.a;
         this.axis10.y = boxTransform.e;
         this.axis10.z = boxTransform.i;
         if(!this.testMainAxis(box,tri,this.axis10,1,this.toBox))
         {
            return false;
         }
         this.axis11.x = boxTransform.b;
         this.axis11.y = boxTransform.f;
         this.axis11.z = boxTransform.j;
         if(!this.testMainAxis(box,tri,this.axis11,2,this.toBox))
         {
            return false;
         }
         this.axis12.x = boxTransform.c;
         this.axis12.y = boxTransform.g;
         this.axis12.z = boxTransform.k;
         if(!this.testMainAxis(box,tri,this.axis12,3,this.toBox))
         {
            return false;
         }
         v = tri.e0;
         this.axis20.x = triTransform.a * v.x + triTransform.b * v.y + triTransform.c * v.z;
         this.axis20.y = triTransform.e * v.x + triTransform.f * v.y + triTransform.g * v.z;
         this.axis20.z = triTransform.i * v.x + triTransform.j * v.y + triTransform.k * v.z;
         if(!this.testDerivedAxis(box,tri,this.axis10,this.axis20,4,this.toBox))
         {
            return false;
         }
         if(!this.testDerivedAxis(box,tri,this.axis11,this.axis20,5,this.toBox))
         {
            return false;
         }
         if(!this.testDerivedAxis(box,tri,this.axis12,this.axis20,6,this.toBox))
         {
            return false;
         }
         v = tri.e1;
         this.axis21.x = triTransform.a * v.x + triTransform.b * v.y + triTransform.c * v.z;
         this.axis21.y = triTransform.e * v.x + triTransform.f * v.y + triTransform.g * v.z;
         this.axis21.z = triTransform.i * v.x + triTransform.j * v.y + triTransform.k * v.z;
         if(!this.testDerivedAxis(box,tri,this.axis10,this.axis21,7,this.toBox))
         {
            return false;
         }
         if(!this.testDerivedAxis(box,tri,this.axis11,this.axis21,8,this.toBox))
         {
            return false;
         }
         if(!this.testDerivedAxis(box,tri,this.axis12,this.axis21,9,this.toBox))
         {
            return false;
         }
         v = tri.e2;
         this.axis22.x = triTransform.a * v.x + triTransform.b * v.y + triTransform.c * v.z;
         this.axis22.y = triTransform.e * v.x + triTransform.f * v.y + triTransform.g * v.z;
         this.axis22.z = triTransform.i * v.x + triTransform.j * v.y + triTransform.k * v.z;
         if(!this.testDerivedAxis(box,tri,this.axis10,this.axis22,10,this.toBox))
         {
            return false;
         }
         if(!this.testDerivedAxis(box,tri,this.axis11,this.axis22,11,this.toBox))
         {
            return false;
         }
         if(!this.testDerivedAxis(box,tri,this.axis12,this.axis22,12,this.toBox))
         {
            return false;
         }
         return true;
      }
      
      private function testMainAxis(box:CollisionBox, tri:CollisionTriangle, axis:Vector3, axisIndex:int, toBox:Vector3) : Boolean
      {
         var overlap:Number = this.overlapOnAxis(box,tri,axis,toBox);
         if(overlap < -this.epsilon)
         {
            return false;
         }
         if(overlap + this.epsilon < this.name_hK)
         {
            this.name_hK = overlap;
            this.name_Wt = axisIndex;
         }
         return true;
      }
      
      private function testDerivedAxis(box:CollisionBox, tri:CollisionTriangle, axis1:Vector3, axis2:Vector3, axisIndex:int, toBox:Vector3) : Boolean
      {
         var k:Number = NaN;
         this.axis.x = axis1.y * axis2.z - axis1.z * axis2.y;
         this.axis.y = axis1.z * axis2.x - axis1.x * axis2.z;
         this.axis.z = axis1.x * axis2.y - axis1.y * axis2.x;
         var lenSqr:Number = this.axis.x * this.axis.x + this.axis.y * this.axis.y + this.axis.z * this.axis.z;
         if(lenSqr < 0.0001)
         {
            return true;
         }
         k = 1 / Math.sqrt(lenSqr);
         this.axis.x *= k;
         this.axis.y *= k;
         this.axis.z *= k;
         var overlap:Number = this.overlapOnAxis(box,tri,this.axis,toBox);
         if(overlap < -this.epsilon)
         {
            return false;
         }
         if(overlap + this.epsilon < this.name_hK)
         {
            this.name_hK = overlap;
            this.name_Wt = axisIndex;
         }
         return true;
      }
      
      private function overlapOnAxis(box:CollisionBox, tri:CollisionTriangle, axis:Vector3, toBox:Vector3) : Number
      {
         var t:Matrix4 = box.transform;
         var projection:Number = (t.a * axis.x + t.e * axis.y + t.i * axis.z) * box.hs.x;
         if(projection < 0)
         {
            projection = -projection;
         }
         var d:Number = (t.b * axis.x + t.f * axis.y + t.j * axis.z) * box.hs.y;
         projection += d < 0 ? -d : d;
         d = (t.c * axis.x + t.g * axis.y + t.k * axis.z) * box.hs.z;
         projection += d < 0 ? -d : d;
         var vectorProjection:Number = toBox.x * axis.x + toBox.y * axis.y + toBox.z * axis.z;
         t = tri.transform;
         var ax:Number = t.a * axis.x + t.e * axis.y + t.i * axis.z;
         var ay:Number = t.b * axis.x + t.f * axis.y + t.j * axis.z;
         var az:Number = t.c * axis.x + t.g * axis.y + t.k * axis.z;
         var max:Number = 0;
         if(vectorProjection < 0)
         {
            vectorProjection = -vectorProjection;
            d = tri.v0.x * ax + tri.v0.y * ay + tri.v0.z * az;
            if(d < max)
            {
               max = d;
            }
            d = tri.v1.x * ax + tri.v1.y * ay + tri.v1.z * az;
            if(d < max)
            {
               max = d;
            }
            d = tri.v2.x * ax + tri.v2.y * ay + tri.v2.z * az;
            if(d < max)
            {
               max = d;
            }
            max = -max;
         }
         else
         {
            d = tri.v0.x * ax + tri.v0.y * ay + tri.v0.z * az;
            if(d > max)
            {
               max = d;
            }
            d = tri.v1.x * ax + tri.v1.y * ay + tri.v1.z * az;
            if(d > max)
            {
               max = d;
            }
            d = tri.v2.x * ax + tri.v2.y * ay + tri.v2.z * az;
            if(d > max)
            {
               max = d;
            }
         }
         return projection + max - vectorProjection;
      }
      
      private function findFaceContactPoints(box:CollisionBox, tri:CollisionTriangle, toBox:Vector3, faceAxisIndex:int, contact:Contact) : Boolean
      {
         if(faceAxisIndex == 0)
         {
            return this.getBoxToTriContact(box,tri,toBox,contact);
         }
         return this.getTriToBoxContact(box,tri,toBox,faceAxisIndex,contact);
      }
      
      private function getBoxToTriContact(box:CollisionBox, tri:CollisionTriangle, toBox:Vector3, contact:Contact) : Boolean
      {
         var cp:ContactPoint = null;
         var dot:Number = NaN;
         var absDot:Number = NaN;
         var v:Vector3 = null;
         var cpPos:Vector3 = null;
         var r:Vector3 = null;
         var boxTransform:Matrix4 = box.transform;
         var triTransform:Matrix4 = tri.transform;
         this.name_VZ.x = triTransform.c;
         this.name_VZ.y = triTransform.g;
         this.name_VZ.z = triTransform.k;
         var over:Boolean = toBox.x * this.name_VZ.x + toBox.y * this.name_VZ.y + toBox.z * this.name_VZ.z > 0;
         if(!over)
         {
            this.name_VZ.x = -this.name_VZ.x;
            this.name_VZ.y = -this.name_VZ.y;
            this.name_VZ.z = -this.name_VZ.z;
         }
         var incFaceAxisIdx:int = 0;
         var incAxisDot:Number = 0;
         var maxDot:Number = 0;
         for(var axisIdx:int = 0; axisIdx < 3; )
         {
            boxTransform.getAxis(axisIdx,this.axis);
            dot = this.axis.x * this.name_VZ.x + this.axis.y * this.name_VZ.y + this.axis.z * this.name_VZ.z;
            absDot = dot < 0 ? -dot : dot;
            if(absDot > maxDot)
            {
               maxDot = absDot;
               incAxisDot = dot;
               incFaceAxisIdx = axisIdx;
            }
            axisIdx++;
         }
         var negativeFace:Boolean = incAxisDot > 0;
         getFaceVertsByAxis(box.hs,incFaceAxisIdx,negativeFace,this.points1);
         boxTransform.transformPointsN(this.points1,this.points2,4);
         triTransform.transformPointsTransposedN(this.points2,this.points1,4);
         var pnum:int = this.clipByTriangle(tri);
         contact.name_P3 = 0;
         for(var i:int = 0; i < pnum; )
         {
            v = this.points2[i];
            if(over && v.z < 0 || !over && v.z > 0)
            {
               cp = contact.points[contact.name_P3++];
               cpPos = cp.pos;
               cpPos.x = triTransform.a * v.x + triTransform.b * v.y + triTransform.c * v.z + triTransform.d;
               cpPos.y = triTransform.e * v.x + triTransform.f * v.y + triTransform.g * v.z + triTransform.h;
               cpPos.z = triTransform.i * v.x + triTransform.j * v.y + triTransform.k * v.z + triTransform.l;
               r = cp.r1;
               r.x = cpPos.x - boxTransform.d;
               r.y = cpPos.y - boxTransform.h;
               r.z = cpPos.z - boxTransform.l;
               r = cp.r2;
               r.x = cpPos.x - triTransform.d;
               r.y = cpPos.y - triTransform.h;
               r.z = cpPos.z - triTransform.l;
               cp.penetration = over ? -v.z : Number(v.z);
            }
            i++;
         }
         contact.normal.x = this.name_VZ.x;
         contact.normal.y = this.name_VZ.y;
         contact.normal.z = this.name_VZ.z;
         return true;
      }
      
      private function getTriToBoxContact(box:CollisionBox, tri:CollisionTriangle, toBox:Vector3, faceAxisIdx:int, contact:Contact) : Boolean
      {
         var penetration:Number = NaN;
         var cp:ContactPoint = null;
         var cpPos:Vector3 = null;
         var r:Vector3 = null;
         faceAxisIdx--;
         var boxTransform:Matrix4 = box.transform;
         var triTransform:Matrix4 = tri.transform;
         boxTransform.getAxis(faceAxisIdx,this.name_VZ);
         var negativeFace:Boolean = toBox.x * this.name_VZ.x + toBox.y * this.name_VZ.y + toBox.z * this.name_VZ.z > 0;
         if(!negativeFace)
         {
            this.name_VZ.x = -this.name_VZ.x;
            this.name_VZ.y = -this.name_VZ.y;
            this.name_VZ.z = -this.name_VZ.z;
         }
         var v:Vector3 = this.points1[0];
         v.x = tri.v0.x;
         v.y = tri.v0.y;
         v.z = tri.v0.z;
         v = this.points1[1];
         v.x = tri.v1.x;
         v.y = tri.v1.y;
         v.z = tri.v1.z;
         v = this.points1[2];
         v.x = tri.v2.x;
         v.y = tri.v2.y;
         v.z = tri.v2.z;
         triTransform.transformPointsN(this.points1,this.points2,3);
         boxTransform.transformPointsTransposedN(this.points2,this.points1,3);
         var pnum:int = this.clipByBox(box.hs,faceAxisIdx);
         contact.name_P3 = 0;
         for(var i:int = 0; i < pnum; )
         {
            v = this.points1[i];
            penetration = this.getPointBoxPenetration(box.hs,v,faceAxisIdx,negativeFace);
            if(penetration > -this.epsilon)
            {
               cp = contact.points[contact.name_P3++];
               cpPos = cp.pos;
               cpPos.x = boxTransform.a * v.x + boxTransform.b * v.y + boxTransform.c * v.z + boxTransform.d;
               cpPos.y = boxTransform.e * v.x + boxTransform.f * v.y + boxTransform.g * v.z + boxTransform.h;
               cpPos.z = boxTransform.i * v.x + boxTransform.j * v.y + boxTransform.k * v.z + boxTransform.l;
               r = cp.r1;
               r.x = cpPos.x - boxTransform.d;
               r.y = cpPos.y - boxTransform.h;
               r.z = cpPos.z - boxTransform.l;
               r = cp.r2;
               r.x = cpPos.x - triTransform.d;
               r.y = cpPos.y - triTransform.h;
               r.z = cpPos.z - triTransform.l;
               cp.penetration = penetration;
            }
            i++;
         }
         contact.normal.x = this.name_VZ.x;
         contact.normal.y = this.name_VZ.y;
         contact.normal.z = this.name_VZ.z;
         return true;
      }
      
      private function getPointBoxPenetration(hs:Vector3, p:Vector3, faceAxisIdx:int, negativeFace:Boolean) : Number
      {
         switch(faceAxisIdx)
         {
            case 0:
               if(negativeFace)
               {
                  return p.x + hs.x;
               }
               return hs.x - p.x;
               break;
            case 1:
               if(negativeFace)
               {
                  return p.y + hs.y;
               }
               return hs.y - p.y;
               break;
            case 2:
               if(negativeFace)
               {
                  return p.z + hs.z;
               }
               return hs.z - p.z;
               break;
            default:
               return 0;
         }
      }
      
      private function clipByBox(hs:Vector3, faceAxisIdx:int) : int
      {
         var pnum:int = 3;
         switch(faceAxisIdx)
         {
            case 0:
               pnum = int(clipLowZ(-hs.z,pnum,this.points1,this.points2,this.epsilon));
               if(pnum == 0)
               {
                  return 0;
               }
               pnum = int(clipHighZ(hs.z,pnum,this.points2,this.points1,this.epsilon));
               if(pnum == 0)
               {
                  return 0;
               }
               pnum = int(clipLowY(-hs.y,pnum,this.points1,this.points2,this.epsilon));
               if(pnum == 0)
               {
                  return 0;
               }
               return clipHighY(hs.y,pnum,this.points2,this.points1,this.epsilon);
               break;
            case 1:
               pnum = int(clipLowZ(-hs.z,pnum,this.points1,this.points2,this.epsilon));
               if(pnum == 0)
               {
                  return 0;
               }
               pnum = int(clipHighZ(hs.z,pnum,this.points2,this.points1,this.epsilon));
               if(pnum == 0)
               {
                  return 0;
               }
               pnum = int(clipLowX(-hs.x,pnum,this.points1,this.points2,this.epsilon));
               if(pnum == 0)
               {
                  return 0;
               }
               return clipHighX(hs.x,pnum,this.points2,this.points1,this.epsilon);
               break;
            case 2:
               pnum = int(clipLowX(-hs.x,pnum,this.points1,this.points2,this.epsilon));
               if(pnum == 0)
               {
                  return 0;
               }
               pnum = int(clipHighX(hs.x,pnum,this.points2,this.points1,this.epsilon));
               if(pnum == 0)
               {
                  return 0;
               }
               pnum = int(clipLowY(-hs.y,pnum,this.points1,this.points2,this.epsilon));
               if(pnum == 0)
               {
                  return 0;
               }
               return clipHighY(hs.y,pnum,this.points2,this.points1,this.epsilon);
               break;
            default:
               return 0;
         }
      }
      
      private function clipByTriangle(tri:CollisionTriangle) : int
      {
         var vnum:int = 4;
         vnum = this.clipByLine(tri.v0,tri.e0,this.points1,vnum,this.points2);
         if(vnum == 0)
         {
            return 0;
         }
         vnum = this.clipByLine(tri.v1,tri.e1,this.points2,vnum,this.points1);
         if(vnum == 0)
         {
            return 0;
         }
         return this.clipByLine(tri.v2,tri.e2,this.points1,vnum,this.points2);
      }
      
      private function clipByLine(linePoint:Vector3, lineDir:Vector3, verticesIn:Vector.<Vector3>, vnum:int, verticesOut:Vector.<Vector3>) : int
      {
         var t:Number = NaN;
         var v:Vector3 = null;
         var v2:Vector3 = null;
         var offset2:Number = NaN;
         var nx:Number = -lineDir.y;
         var ny:Number = Number(lineDir.x);
         var offset:Number = linePoint.x * nx + linePoint.y * ny;
         var v1:Vector3 = verticesIn[int(vnum - 1)];
         var offset1:Number = v1.x * nx + v1.y * ny;
         var num:int = 0;
         for(var i:int = 0; i < vnum; i++)
         {
            v2 = verticesIn[i];
            offset2 = v2.x * nx + v2.y * ny;
            if(offset1 < offset)
            {
               if(offset2 > offset)
               {
                  t = (offset - offset1) / (offset2 - offset1);
                  v = verticesOut[num];
                  v.x = v1.x + t * (v2.x - v1.x);
                  v.y = v1.y + t * (v2.y - v1.y);
                  v.z = v1.z + t * (v2.z - v1.z);
                  num++;
               }
            }
            else
            {
               v = verticesOut[num];
               v.x = v1.x;
               v.y = v1.y;
               v.z = v1.z;
               num++;
               if(offset2 < offset)
               {
                  t = (offset - offset1) / (offset2 - offset1);
                  v = verticesOut[num];
                  v.x = v1.x + t * (v2.x - v1.x);
                  v.y = v1.y + t * (v2.y - v1.y);
                  v.z = v1.z + t * (v2.z - v1.z);
                  num++;
               }
            }
            v1 = v2;
            offset1 = offset2;
         }
         return num;
      }
      
      private function findEdgesIntersection(box:CollisionBox, tri:CollisionTriangle, toBox:Vector3, boxAxisIdx:int, triAxisIdx:int, contact:Contact) : Boolean
      {
         var tmpx1:Number = NaN;
         var tmpy1:Number = NaN;
         var tmpz1:Number = NaN;
         var tmpx2:Number = NaN;
         var tmpy2:Number = NaN;
         var tmpz2:Number = NaN;
         var boxHalfLen:Number = NaN;
         var k:Number = NaN;
         switch(triAxisIdx)
         {
            case 0:
               tmpx1 = Number(tri.e0.x);
               tmpy1 = Number(tri.e0.y);
               tmpz1 = Number(tri.e0.z);
               tmpx2 = Number(tri.v0.x);
               tmpy2 = Number(tri.v0.y);
               tmpz2 = Number(tri.v0.z);
               break;
            case 1:
               tmpx1 = Number(tri.e1.x);
               tmpy1 = Number(tri.e1.y);
               tmpz1 = Number(tri.e1.z);
               tmpx2 = Number(tri.v1.x);
               tmpy2 = Number(tri.v1.y);
               tmpz2 = Number(tri.v1.z);
               break;
            case 2:
               tmpx1 = Number(tri.e2.x);
               tmpy1 = Number(tri.e2.y);
               tmpz1 = Number(tri.e2.z);
               tmpx2 = Number(tri.v2.x);
               tmpy2 = Number(tri.v2.y);
               tmpz2 = Number(tri.v2.z);
         }
         var triTransform:Matrix4 = tri.transform;
         this.axis20.x = triTransform.a * tmpx1 + triTransform.b * tmpy1 + triTransform.c * tmpz1;
         this.axis20.y = triTransform.e * tmpx1 + triTransform.f * tmpy1 + triTransform.g * tmpz1;
         this.axis20.z = triTransform.i * tmpx1 + triTransform.j * tmpy1 + triTransform.k * tmpz1;
         var x2:Number = triTransform.a * tmpx2 + triTransform.b * tmpy2 + triTransform.c * tmpz2 + triTransform.d;
         var y2:Number = triTransform.e * tmpx2 + triTransform.f * tmpy2 + triTransform.g * tmpz2 + triTransform.h;
         var z2:Number = triTransform.i * tmpx2 + triTransform.j * tmpy2 + triTransform.k * tmpz2 + triTransform.l;
         var boxTransform:Matrix4 = box.transform;
         boxTransform.getAxis(boxAxisIdx,this.axis10);
         var v:Vector3 = contact.normal;
         v.x = this.axis10.y * this.axis20.z - this.axis10.z * this.axis20.y;
         v.y = this.axis10.z * this.axis20.x - this.axis10.x * this.axis20.z;
         v.z = this.axis10.x * this.axis20.y - this.axis10.y * this.axis20.x;
         k = 1 / Math.sqrt(v.x * v.x + v.y * v.y + v.z * v.z);
         v.x *= k;
         v.y *= k;
         v.z *= k;
         if(v.x * toBox.x + v.y * toBox.y + v.z * toBox.z < 0)
         {
            v.x = -v.x;
            v.y = -v.y;
            v.z = -v.z;
         }
         tmpx1 = Number(box.hs.x);
         tmpy1 = Number(box.hs.y);
         tmpz1 = Number(box.hs.z);
         if(boxAxisIdx == 0)
         {
            tmpx1 = 0;
            boxHalfLen = Number(box.hs.x);
         }
         else if(boxTransform.a * v.x + boxTransform.e * v.y + boxTransform.i * v.z > 0)
         {
            tmpx1 = -tmpx1;
         }
         if(boxAxisIdx == 1)
         {
            tmpy1 = 0;
            boxHalfLen = Number(box.hs.y);
         }
         else if(boxTransform.b * v.x + boxTransform.f * v.y + boxTransform.j * v.z > 0)
         {
            tmpy1 = -tmpy1;
         }
         if(boxAxisIdx == 2)
         {
            tmpz1 = 0;
            boxHalfLen = Number(box.hs.z);
         }
         else if(boxTransform.c * v.x + boxTransform.g * v.y + boxTransform.k * v.z > 0)
         {
            tmpz1 = -tmpz1;
         }
         var x1:Number = boxTransform.a * tmpx1 + boxTransform.b * tmpy1 + boxTransform.c * tmpz1 + boxTransform.d;
         var y1:Number = boxTransform.e * tmpx1 + boxTransform.f * tmpy1 + boxTransform.g * tmpz1 + boxTransform.h;
         var z1:Number = boxTransform.i * tmpx1 + boxTransform.j * tmpy1 + boxTransform.k * tmpz1 + boxTransform.l;
         k = this.axis10.x * this.axis20.x + this.axis10.y * this.axis20.y + this.axis10.z * this.axis20.z;
         var det:Number = k * k - 1;
         var vx:Number = x2 - x1;
         var vy:Number = y2 - y1;
         var vz:Number = z2 - z1;
         var c1:Number = this.axis10.x * vx + this.axis10.y * vy + this.axis10.z * vz;
         var c2:Number = this.axis20.x * vx + this.axis20.y * vy + this.axis20.z * vz;
         var t1:Number = (c2 * k - c1) / det;
         var t2:Number = (c2 - c1 * k) / det;
         contact.name_P3 = 1;
         var cp:ContactPoint = contact.points[0];
         cp.penetration = this.name_hK;
         v = cp.pos;
         v.x = 0.5 * (x1 + this.axis10.x * t1 + x2 + this.axis20.x * t2);
         v.y = 0.5 * (y1 + this.axis10.y * t1 + y2 + this.axis20.y * t2);
         v.z = 0.5 * (z1 + this.axis10.z * t1 + z2 + this.axis20.z * t2);
         var r:Vector3 = cp.r1;
         r.x = v.x - boxTransform.d;
         r.y = v.y - boxTransform.h;
         r.z = v.z - boxTransform.l;
         r = cp.r2;
         r.x = v.x - triTransform.d;
         r.y = v.y - triTransform.h;
         r.z = v.z - triTransform.l;
         return true;
      }
   }
}

