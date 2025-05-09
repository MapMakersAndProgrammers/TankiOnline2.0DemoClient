package alternativa.physics.collision.colliders
{
   import alternativa.math.Matrix4;
   import alternativa.math.Vector3;
   import alternativa.physics.Contact;
   import alternativa.physics.ContactPoint;
   import alternativa.physics.collision.CollisionPrimitive;
   import alternativa.physics.collision.primitives.CollisionRect;
   import alternativa.physics.collision.primitives.name_311;
   
   public class BoxRectCollider extends BoxCollider
   {
      private var epsilon:Number = 0.001;
      
      private var vectorToBox:Vector3 = new Vector3();
      
      private var axis:Vector3 = new Vector3();
      
      private var axis10:Vector3 = new Vector3();
      
      private var axis11:Vector3 = new Vector3();
      
      private var axis12:Vector3 = new Vector3();
      
      private var axis20:Vector3 = new Vector3();
      
      private var axis21:Vector3 = new Vector3();
      
      private var axis22:Vector3 = new Vector3();
      
      private var var_675:int;
      
      private var var_676:Number;
      
      private var points1:Vector.<Vector3> = new Vector.<Vector3>(8,true);
      
      private var points2:Vector.<Vector3> = new Vector.<Vector3>(8,true);
      
      public function BoxRectCollider()
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
         var rect:CollisionRect = null;
         if(!this.haveCollision(prim1,prim2))
         {
            return false;
         }
         var box:name_311 = prim1 as name_311;
         if(box == null)
         {
            box = prim2 as name_311;
            rect = prim1 as CollisionRect;
         }
         else
         {
            rect = prim2 as CollisionRect;
         }
         if(this.var_675 < 4)
         {
            if(!this.findFaceContactPoints(box,rect,this.vectorToBox,this.var_675,contact))
            {
               return false;
            }
         }
         else
         {
            this.var_675 -= 4;
            if(!this.findEdgesIntersection(box,rect,this.vectorToBox,int(this.var_675 / 2),this.var_675 % 2,contact))
            {
               return false;
            }
         }
         contact.body1 = box.body;
         contact.body2 = rect.body;
         if(rect.transform.k > 0.99999)
         {
            contact.normal.x = 0;
            contact.normal.y = 0;
            contact.normal.z = 1;
         }
         return true;
      }
      
      override public function haveCollision(prim1:CollisionPrimitive, prim2:CollisionPrimitive) : Boolean
      {
         var box:name_311 = null;
         var rect:CollisionRect = null;
         var rectTransform:Matrix4 = null;
         this.var_676 = 10000000000;
         box = prim1 as name_311;
         if(box == null)
         {
            box = prim2 as name_311;
            rect = prim1 as CollisionRect;
         }
         else
         {
            rect = prim2 as CollisionRect;
         }
         var boxTransform:Matrix4 = box.transform;
         rectTransform = rect.transform;
         this.vectorToBox.x = boxTransform.d - rectTransform.d;
         this.vectorToBox.y = boxTransform.h - rectTransform.h;
         this.vectorToBox.z = boxTransform.l - rectTransform.l;
         rectTransform.getAxis(2,this.axis22);
         if(!this.testMainAxis(box,rect,this.axis22,0,this.vectorToBox))
         {
            return false;
         }
         boxTransform.getAxis(0,this.axis10);
         if(!this.testMainAxis(box,rect,this.axis10,1,this.vectorToBox))
         {
            return false;
         }
         boxTransform.getAxis(1,this.axis11);
         if(!this.testMainAxis(box,rect,this.axis11,2,this.vectorToBox))
         {
            return false;
         }
         boxTransform.getAxis(2,this.axis12);
         if(!this.testMainAxis(box,rect,this.axis12,3,this.vectorToBox))
         {
            return false;
         }
         rectTransform.getAxis(0,this.axis20);
         rectTransform.getAxis(1,this.axis21);
         if(!this.testDerivedAxis(box,rect,this.axis10,this.axis20,4,this.vectorToBox))
         {
            return false;
         }
         if(!this.testDerivedAxis(box,rect,this.axis10,this.axis21,5,this.vectorToBox))
         {
            return false;
         }
         if(!this.testDerivedAxis(box,rect,this.axis11,this.axis20,6,this.vectorToBox))
         {
            return false;
         }
         if(!this.testDerivedAxis(box,rect,this.axis11,this.axis21,7,this.vectorToBox))
         {
            return false;
         }
         if(!this.testDerivedAxis(box,rect,this.axis12,this.axis20,8,this.vectorToBox))
         {
            return false;
         }
         if(!this.testDerivedAxis(box,rect,this.axis12,this.axis21,9,this.vectorToBox))
         {
            return false;
         }
         return true;
      }
      
      private function findFaceContactPoints(box:name_311, rect:CollisionRect, vectorToBox:Vector3, faceAxisIdx:int, contact:Contact) : Boolean
      {
         var pnum:int = 0;
         var i:int = 0;
         var v:Vector3 = null;
         var cp:ContactPoint = null;
         var boxTransform:Matrix4 = null;
         var rectTransform:Matrix4 = null;
         var colAxis:Vector3 = null;
         var negativeFace:Boolean = false;
         var incidentAxisIdx:int = 0;
         var incidentAxisDot:Number = NaN;
         var maxDot:Number = NaN;
         var axisIdx:int = 0;
         var dot:Number = NaN;
         var absDot:Number = NaN;
         var cpPos:Vector3 = null;
         var _loc21_:Number = NaN;
         boxTransform = box.transform;
         rectTransform = rect.transform;
         colAxis = contact.normal;
         if(faceAxisIdx == 0)
         {
            colAxis.x = rectTransform.c;
            colAxis.y = rectTransform.g;
            colAxis.z = rectTransform.k;
            incidentAxisIdx = 0;
            maxDot = 0;
            for(axisIdx = 0; axisIdx < 3; )
            {
               boxTransform.getAxis(axisIdx,this.axis);
               dot = this.axis.x * colAxis.x + this.axis.y * colAxis.y + this.axis.z * colAxis.z;
               absDot = dot < 0 ? -dot : dot;
               if(absDot > maxDot)
               {
                  maxDot = absDot;
                  incidentAxisIdx = axisIdx;
                  incidentAxisDot = dot;
               }
               axisIdx++;
            }
            negativeFace = incidentAxisDot > 0;
            boxTransform.getAxis(incidentAxisIdx,this.axis);
            getFaceVertsByAxis(box.hs,incidentAxisIdx,negativeFace,this.points1);
            boxTransform.transformPointsN(this.points1,this.points2,4);
            rectTransform.transformPointsTransposedN(this.points2,this.points1,4);
            pnum = this.clipByRect(rect.hs);
            contact.name_506 = 0;
            for(i = 0; i < pnum; )
            {
               v = this.points1[i];
               if(v.z < this.epsilon)
               {
                  cp = contact.points[contact.name_506++];
                  cp.penetration = -v.z;
                  cpPos = cp.pos;
                  cpPos.x = rectTransform.a * v.x + rectTransform.b * v.y + rectTransform.c * v.z + rectTransform.d;
                  cpPos.y = rectTransform.e * v.x + rectTransform.f * v.y + rectTransform.g * v.z + rectTransform.h;
                  cpPos.z = rectTransform.i * v.x + rectTransform.j * v.y + rectTransform.k * v.z + rectTransform.l;
                  v = cp.r1;
                  v.x = cpPos.x - boxTransform.d;
                  v.y = cpPos.y - boxTransform.h;
                  v.z = cpPos.z - boxTransform.l;
                  v = cp.r2;
                  v.x = cpPos.x - rectTransform.d;
                  v.y = cpPos.y - rectTransform.h;
                  v.z = cpPos.z - rectTransform.l;
               }
               i++;
            }
         }
         else
         {
            faceAxisIdx--;
            boxTransform.getAxis(faceAxisIdx,colAxis);
            negativeFace = colAxis.x * vectorToBox.x + colAxis.y * vectorToBox.y + colAxis.z * vectorToBox.z > 0;
            if(!negativeFace)
            {
               colAxis.x = -colAxis.x;
               colAxis.y = -colAxis.y;
               colAxis.z = -colAxis.z;
            }
            if(rectTransform.c * colAxis.x + rectTransform.g * colAxis.y + rectTransform.k * colAxis.z < 0)
            {
               return false;
            }
            getFaceVertsByAxis(rect.hs,2,false,this.points1);
            rectTransform.transformPointsN(this.points1,this.points2,4);
            boxTransform.transformPointsTransposedN(this.points2,this.points1,4);
            pnum = this.clipByBox(box.hs,faceAxisIdx);
            contact.name_506 = 0;
            for(i = 0; i < pnum; )
            {
               v = this.points1[i];
               _loc21_ = this.getPointBoxPenetration(box.hs,v,faceAxisIdx,negativeFace);
               if(_loc21_ > -this.epsilon)
               {
                  cp = contact.points[contact.name_506++];
                  cp.penetration = _loc21_;
                  cpPos = cp.pos;
                  cpPos.x = boxTransform.a * v.x + boxTransform.b * v.y + boxTransform.c * v.z + boxTransform.d;
                  cpPos.y = boxTransform.e * v.x + boxTransform.f * v.y + boxTransform.g * v.z + boxTransform.h;
                  cpPos.z = boxTransform.i * v.x + boxTransform.j * v.y + boxTransform.k * v.z + boxTransform.l;
                  v = cp.r1;
                  v.x = cpPos.x - boxTransform.d;
                  v.y = cpPos.y - boxTransform.h;
                  v.z = cpPos.z - boxTransform.l;
                  v = cp.r2;
                  v.x = cpPos.x - rectTransform.d;
                  v.y = cpPos.y - rectTransform.h;
                  v.z = cpPos.z - rectTransform.l;
               }
               i++;
            }
         }
         return true;
      }
      
      private function getPointBoxPenetration(hs:Vector3, p:Vector3, faceAxisIdx:int, reverse:Boolean) : Number
      {
         switch(faceAxisIdx)
         {
            case 0:
               if(reverse)
               {
                  return p.x + hs.x;
               }
               return hs.x - p.x;
               break;
            case 1:
               if(reverse)
               {
                  return p.y + hs.y;
               }
               return hs.y - p.y;
               break;
            case 2:
               if(reverse)
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
         var pnum:int = 4;
         switch(faceAxisIdx)
         {
            case 0:
               pnum = clipLowZ(-hs.z,pnum,this.points1,this.points2,this.epsilon);
               if(pnum == 0)
               {
                  return 0;
               }
               pnum = clipHighZ(hs.z,pnum,this.points2,this.points1,this.epsilon);
               if(pnum == 0)
               {
                  return 0;
               }
               pnum = clipLowY(-hs.y,pnum,this.points1,this.points2,this.epsilon);
               if(pnum == 0)
               {
                  return 0;
               }
               return clipHighY(hs.y,pnum,this.points2,this.points1,this.epsilon);
               break;
            case 1:
               pnum = clipLowZ(-hs.z,pnum,this.points1,this.points2,this.epsilon);
               if(pnum == 0)
               {
                  return 0;
               }
               pnum = clipHighZ(hs.z,pnum,this.points2,this.points1,this.epsilon);
               if(pnum == 0)
               {
                  return 0;
               }
               pnum = clipLowX(-hs.x,pnum,this.points1,this.points2,this.epsilon);
               if(pnum == 0)
               {
                  return 0;
               }
               return clipHighX(hs.x,pnum,this.points2,this.points1,this.epsilon);
               break;
            case 2:
               pnum = clipLowX(-hs.x,pnum,this.points1,this.points2,this.epsilon);
               if(pnum == 0)
               {
                  return 0;
               }
               pnum = clipHighX(hs.x,pnum,this.points2,this.points1,this.epsilon);
               if(pnum == 0)
               {
                  return 0;
               }
               pnum = clipLowY(-hs.y,pnum,this.points1,this.points2,this.epsilon);
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
      
      private function clipByRect(hs:Vector3) : int
      {
         var pnum:int = 4;
         pnum = clipLowX(-hs.x,pnum,this.points1,this.points2,this.epsilon);
         if(pnum == 0)
         {
            return 0;
         }
         pnum = clipHighX(hs.x,pnum,this.points2,this.points1,this.epsilon);
         if(pnum == 0)
         {
            return 0;
         }
         pnum = clipLowY(-hs.y,pnum,this.points1,this.points2,this.epsilon);
         if(pnum == 0)
         {
            return 0;
         }
         return clipHighY(hs.y,pnum,this.points2,this.points1,this.epsilon);
      }
      
      private function findEdgesIntersection(box:name_311, rect:CollisionRect, vectorToBox:Vector3, axisIdx1:int, axisIdx2:int, contact:Contact) : Boolean
      {
         var halfLen1:Number = NaN;
         var halfLen2:Number = NaN;
         var boxTransform:Matrix4 = box.transform;
         var rectTransform:Matrix4 = rect.transform;
         boxTransform.getAxis(axisIdx1,this.axis10);
         rectTransform.getAxis(axisIdx2,this.axis20);
         var colAxis:Vector3 = contact.normal;
         colAxis.x = this.axis10.y * this.axis20.z - this.axis10.z * this.axis20.y;
         colAxis.y = this.axis10.z * this.axis20.x - this.axis10.x * this.axis20.z;
         colAxis.z = this.axis10.x * this.axis20.y - this.axis10.y * this.axis20.x;
         var k:Number = 1 / Math.sqrt(colAxis.x * colAxis.x + colAxis.y * colAxis.y + colAxis.z * colAxis.z);
         colAxis.x *= k;
         colAxis.y *= k;
         colAxis.z *= k;
         if(colAxis.x * vectorToBox.x + colAxis.y * vectorToBox.y + colAxis.z * vectorToBox.z < 0)
         {
            colAxis.x = -colAxis.x;
            colAxis.y = -colAxis.y;
            colAxis.z = -colAxis.z;
         }
         var vx:Number = Number(box.hs.x);
         var vy:Number = Number(box.hs.y);
         var vz:Number = Number(box.hs.z);
         var x2:Number = rect.hs.x;
         var y2:Number = rect.hs.y;
         var z2:Number = rect.hs.z;
         if(axisIdx1 == 0)
         {
            vx = 0;
            halfLen1 = Number(box.hs.x);
         }
         else if(boxTransform.a * colAxis.x + boxTransform.e * colAxis.y + boxTransform.i * colAxis.z > 0)
         {
            vx = -vx;
         }
         if(axisIdx2 == 0)
         {
            x2 = 0;
            halfLen2 = rect.hs.x;
         }
         else if(rectTransform.a * colAxis.x + rectTransform.e * colAxis.y + rectTransform.i * colAxis.z < 0)
         {
            x2 = -x2;
         }
         if(axisIdx1 == 1)
         {
            vy = 0;
            halfLen1 = Number(box.hs.y);
         }
         else if(boxTransform.b * colAxis.x + boxTransform.f * colAxis.y + boxTransform.j * colAxis.z > 0)
         {
            vy = -vy;
         }
         if(axisIdx2 == 1)
         {
            y2 = 0;
            halfLen2 = rect.hs.y;
         }
         else if(rectTransform.b * colAxis.x + rectTransform.f * colAxis.y + rectTransform.j * colAxis.z < 0)
         {
            y2 = -y2;
         }
         if(axisIdx1 == 2)
         {
            vz = 0;
            halfLen1 = Number(box.hs.z);
         }
         else if(boxTransform.c * colAxis.x + boxTransform.g * colAxis.y + boxTransform.k * colAxis.z > 0)
         {
            vz = -vz;
         }
         var x1:Number = boxTransform.a * vx + boxTransform.b * vy + boxTransform.c * vz + boxTransform.d;
         var y1:Number = boxTransform.e * vx + boxTransform.f * vy + boxTransform.g * vz + boxTransform.h;
         var z1:Number = boxTransform.i * vx + boxTransform.j * vy + boxTransform.k * vz + boxTransform.l;
         vx = x2;
         vy = y2;
         vz = z2;
         x2 = rectTransform.a * vx + rectTransform.b * vy + rectTransform.c * vz + rectTransform.d;
         y2 = rectTransform.e * vx + rectTransform.f * vy + rectTransform.g * vz + rectTransform.h;
         z2 = rectTransform.i * vx + rectTransform.j * vy + rectTransform.k * vz + rectTransform.l;
         k = this.axis10.x * this.axis20.x + this.axis10.y * this.axis20.y + this.axis10.z * this.axis20.z;
         var det:Number = k * k - 1;
         vx = x2 - x1;
         vy = y2 - y1;
         vz = z2 - z1;
         var c1:Number = this.axis10.x * vx + this.axis10.y * vy + this.axis10.z * vz;
         var c2:Number = this.axis20.x * vx + this.axis20.y * vy + this.axis20.z * vz;
         var t1:Number = (c2 * k - c1) / det;
         var t2:Number = (c2 - c1 * k) / det;
         contact.name_506 = 1;
         var cp:ContactPoint = contact.points[0];
         cp.penetration = this.var_676;
         var cpPos:Vector3 = cp.pos;
         cpPos.x = 0.5 * (x1 + this.axis10.x * t1 + x2 + this.axis20.x * t2);
         cpPos.y = 0.5 * (y1 + this.axis10.y * t1 + y2 + this.axis20.y * t2);
         cpPos.z = 0.5 * (z1 + this.axis10.z * t1 + z2 + this.axis20.z * t2);
         var v:Vector3 = cp.r1;
         v.x = cpPos.x - boxTransform.d;
         v.y = cpPos.y - boxTransform.h;
         v.z = cpPos.z - boxTransform.l;
         v = cp.r2;
         v.x = cpPos.x - rectTransform.d;
         v.y = cpPos.y - rectTransform.h;
         v.z = cpPos.z - rectTransform.l;
         return true;
      }
      
      private function testMainAxis(box:name_311, rect:CollisionRect, axis:Vector3, axisIndex:int, vectorToBox:Vector3) : Boolean
      {
         var overlap:Number = this.overlapOnAxis(box,rect,axis,vectorToBox);
         if(overlap < -this.epsilon)
         {
            return false;
         }
         if(overlap + this.epsilon < this.var_676)
         {
            this.var_676 = overlap;
            this.var_675 = axisIndex;
         }
         return true;
      }
      
      private function testDerivedAxis(box:name_311, rect:CollisionRect, axis1:Vector3, axis2:Vector3, axisIndex:int, vectorToBox:Vector3) : Boolean
      {
         this.axis.x = axis1.y * axis2.z - axis1.z * axis2.y;
         this.axis.y = axis1.z * axis2.x - axis1.x * axis2.z;
         this.axis.z = axis1.x * axis2.y - axis1.y * axis2.x;
         var lenSqr:Number = this.axis.x * this.axis.x + this.axis.y * this.axis.y + this.axis.z * this.axis.z;
         if(lenSqr < 0.0001)
         {
            return true;
         }
         var k:Number = 1 / Math.sqrt(lenSqr);
         this.axis.x *= k;
         this.axis.y *= k;
         this.axis.z *= k;
         var overlap:Number = this.overlapOnAxis(box,rect,this.axis,vectorToBox);
         if(overlap < -this.epsilon)
         {
            return false;
         }
         if(overlap + this.epsilon < this.var_676)
         {
            this.var_676 = overlap;
            this.var_675 = axisIndex;
         }
         return true;
      }
      
      public function overlapOnAxis(box:name_311, rect:CollisionRect, axis:Vector3, vectorToBox:Vector3) : Number
      {
         var m:Matrix4 = box.transform;
         var d:Number = (m.a * axis.x + m.e * axis.y + m.i * axis.z) * box.hs.x;
         if(d < 0)
         {
            d = -d;
         }
         var projection:Number = d;
         d = (m.b * axis.x + m.f * axis.y + m.j * axis.z) * box.hs.y;
         if(d < 0)
         {
            d = -d;
         }
         projection += d;
         d = (m.c * axis.x + m.g * axis.y + m.k * axis.z) * box.hs.z;
         if(d < 0)
         {
            d = -d;
         }
         projection += d;
         m = rect.transform;
         d = (m.a * axis.x + m.e * axis.y + m.i * axis.z) * rect.hs.x;
         if(d < 0)
         {
            d = -d;
         }
         projection += d;
         d = (m.b * axis.x + m.f * axis.y + m.j * axis.z) * rect.hs.y;
         if(d < 0)
         {
            d = -d;
         }
         projection += d;
         d = vectorToBox.x * axis.x + vectorToBox.y * axis.y + vectorToBox.z * axis.z;
         if(d < 0)
         {
            d = -d;
         }
         return projection - d;
      }
   }
}

