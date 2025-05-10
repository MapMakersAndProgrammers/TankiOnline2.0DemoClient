package alternativa.physics.collision.types
{
   import alternativa.math.Vector3;
   
   public class BoundBox
   {
      public var minX:Number = 1e+308;
      
      public var minY:Number = 1e+308;
      
      public var minZ:Number = 1e+308;
      
      public var maxX:Number = -1e+308;
      
      public var maxY:Number = -1e+308;
      
      public var maxZ:Number = -1e+308;
      
      public function BoundBox()
      {
         super();
      }
      
      public function setSize(minX:Number, minY:Number, minZ:Number, maxX:Number, maxY:Number, maxZ:Number) : void
      {
         this.minX = minX;
         this.minY = minY;
         this.minZ = minZ;
         this.maxX = maxX;
         this.maxY = maxY;
         this.maxZ = maxZ;
      }
      
      public function increase(delta:Number) : void
      {
         this.minX -= delta;
         this.minY -= delta;
         this.minZ -= delta;
         this.maxX += delta;
         this.maxY += delta;
         this.maxZ += delta;
      }
      
      public function addBoundBox(boundBox:BoundBox) : void
      {
         this.minX = boundBox.minX < this.minX ? boundBox.minX : this.minX;
         this.minY = boundBox.minY < this.minY ? boundBox.minY : this.minY;
         this.minZ = boundBox.minZ < this.minZ ? boundBox.minZ : this.minZ;
         this.maxX = boundBox.maxX > this.maxX ? boundBox.maxX : this.maxX;
         this.maxY = boundBox.maxY > this.maxY ? boundBox.maxY : this.maxY;
         this.maxZ = boundBox.maxZ > this.maxZ ? boundBox.maxZ : this.maxZ;
      }
      
      public function addPoint(x:Number, y:Number, z:Number) : void
      {
         if(x < this.minX)
         {
            this.minX = x;
         }
         if(x > this.maxX)
         {
            this.maxX = x;
         }
         if(y < this.minY)
         {
            this.minY = y;
         }
         if(y > this.maxY)
         {
            this.maxY = y;
         }
         if(z < this.minZ)
         {
            this.minZ = z;
         }
         if(z > this.maxZ)
         {
            this.maxZ = z;
         }
      }
      
      public function infinity() : void
      {
         this.minX = 1e+308;
         this.minY = 1e+308;
         this.minZ = 1e+308;
         this.maxX = -1e+308;
         this.maxY = -1e+308;
         this.maxZ = -1e+308;
      }
      
      public function intersects(bb:BoundBox, epsilon:Number) : Boolean
      {
         return !(this.minX > bb.maxX + epsilon || this.maxX < bb.minX - epsilon || this.minY > bb.maxY + epsilon || this.maxY < bb.minY - epsilon || this.minZ > bb.maxZ + epsilon || this.maxZ < bb.minZ - epsilon);
      }
      
      public function containsPoint(point:Vector3, epsilon:Number) : Boolean
      {
         return point.x > this.minX - epsilon && point.x < this.maxX + epsilon && point.y > this.minY - epsilon && point.y < this.maxY + epsilon && point.z > this.minZ - epsilon && point.z < this.maxZ + epsilon;
      }
      
      public function getSizeX() : Number
      {
         return this.maxX - this.minX;
      }
      
      public function getSizeY() : Number
      {
         return this.maxY - this.minY;
      }
      
      public function getSizeZ() : Number
      {
         return this.maxZ - this.minZ;
      }
      
      public function copyFrom(boundBox:BoundBox) : void
      {
         this.minX = boundBox.minX;
         this.minY = boundBox.minY;
         this.minZ = boundBox.minZ;
         this.maxX = boundBox.maxX;
         this.maxY = boundBox.maxY;
         this.maxZ = boundBox.maxZ;
      }
      
      public function clone() : BoundBox
      {
         var clone:BoundBox = new BoundBox();
         clone.copyFrom(this);
         return clone;
      }
      
      public function toString() : String
      {
         return "BoundBox [" + this.minX + ", " + this.minY + ", " + this.minZ + " : " + this.maxX + ", " + this.maxY + ", " + this.maxZ + "]";
      }
   }
}

