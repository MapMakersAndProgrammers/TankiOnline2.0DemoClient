package package_123
{
   import flash.geom.Vector3D;
   
   public class name_770
   {
      public var name_785:int;
      
      public var name_786:int;
      
      public var indices:Vector.<int> = new Vector.<int>();
      
      public var x:Number;
      
      public var y:Number;
      
      public var z:Number;
      
      public var uvs:Vector.<Number> = new Vector.<Number>();
      
      public var normal:Vector3D;
      
      public var name_769:Vector3D;
      
      public function name_770()
      {
         super();
      }
      
      public function method_933(data:Vector.<Number>, dataIndex:int, stride:int, unitScaleFactor:Number) : void
      {
         this.indices.push(dataIndex);
         var offset:int = stride * dataIndex;
         this.x = data[int(offset)] * unitScaleFactor;
         this.y = data[int(offset + 1)] * unitScaleFactor;
         this.z = data[int(offset + 2)] * unitScaleFactor;
      }
      
      public function method_935(data:Vector.<Number>, dataIndex:int, stride:int) : void
      {
         this.indices.push(dataIndex);
         var offset:int = stride * dataIndex;
         this.normal = new Vector3D();
         this.normal.x = data[int(offset++)];
         this.normal.y = data[int(offset++)];
         this.normal.z = data[offset];
      }
      
      public function method_932(tangentData:Vector.<Number>, tangentDataIndex:int, tangentStride:int, biNormalData:Vector.<Number>, biNormalDataIndex:int, biNormalStride:int) : void
      {
         this.indices.push(tangentDataIndex);
         this.indices.push(biNormalDataIndex);
         var tangentOffset:int = tangentStride * tangentDataIndex;
         var biNormalOffset:int = biNormalStride * biNormalDataIndex;
         var biNormalX:Number = biNormalData[int(biNormalOffset++)];
         var biNormalY:Number = biNormalData[int(biNormalOffset++)];
         var biNormalZ:Number = biNormalData[biNormalOffset];
         this.name_769 = new Vector3D(tangentData[int(tangentOffset++)],tangentData[int(tangentOffset++)],tangentData[tangentOffset]);
         var crossX:Number = this.normal.y * this.name_769.z - this.normal.z * this.name_769.y;
         var crossY:Number = this.normal.z * this.name_769.x - this.normal.x * this.name_769.z;
         var crossZ:Number = this.normal.x * this.name_769.y - this.normal.y * this.name_769.x;
         var dot:Number = crossX * biNormalX + crossY * biNormalY + crossZ * biNormalZ;
         this.name_769.w = dot < 0 ? -1 : 1;
      }
      
      public function method_934(data:Vector.<Number>, dataIndex:int, stride:int) : void
      {
         this.indices.push(dataIndex);
         this.uvs.push(data[int(dataIndex * stride)]);
         this.uvs.push(1 - data[int(dataIndex * stride + 1)]);
      }
   }
}

