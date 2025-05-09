package package_103
{
   import alternativa.engine3d.alternativa3d;
   import alternativa.engine3d.loaders.collada.collada;
   import package_21.name_136;
   
   use namespace collada;
   use namespace alternativa3d;
   
   public class class_37 extends class_38
   {
      internal static const NORMALS:int = 1;
      
      internal static const TANGENT4:int = 2;
      
      internal static const TEXCOORDS:Vector.<uint> = Vector.<uint>([8,16,32,64,128,256,512,1024]);
      
      internal var var_739:name_606;
      
      internal var var_740:Vector.<name_606>;
      
      internal var var_742:name_606;
      
      internal var var_741:Vector.<name_606>;
      
      internal var var_743:Vector.<name_606>;
      
      internal var indices:Vector.<uint>;
      
      internal var var_728:int;
      
      public var indexBegin:int;
      
      public var numTriangles:int;
      
      public function class_37(data:XML, document:name_612)
      {
         super(data,document);
      }
      
      override protected function parseImplementation() : Boolean
      {
         this.method_373();
         this.method_376();
         return true;
      }
      
      private function get type() : String
      {
         return data.localName() as String;
      }
      
      private function method_373() : void
      {
         var input:name_606 = null;
         var semantic:String = null;
         var offset:int = 0;
         this.var_740 = new Vector.<name_606>();
         this.var_743 = new Vector.<name_606>();
         this.var_741 = new Vector.<name_606>();
         var inputsList:XMLList = data.input;
         var maxInputOffset:int = 0;
         for(var i:int = 0,var count:int = int(inputsList.length()); i < count; offset = int(input.offset),maxInputOffset = offset > maxInputOffset ? offset : maxInputOffset,i++)
         {
            input = new name_606(inputsList[i],document);
            semantic = input.semantic;
            if(semantic == null)
            {
               continue;
            }
            switch(semantic)
            {
               case "VERTEX":
                  if(this.var_739 == null)
                  {
                     this.var_739 = input;
                  }
                  break;
               case "TEXCOORD":
                  this.var_740.push(input);
                  break;
               case "NORMAL":
                  if(this.var_742 == null)
                  {
                     this.var_742 = input;
                  }
                  break;
               case "TEXTANGENT":
                  this.var_743.push(input);
                  break;
               case "TEXBINORMAL":
                  this.var_741.push(input);
                  break;
            }
         }
         this.var_728 = maxInputOffset + 1;
      }
      
      private function method_376() : void
      {
         var array:Array = null;
         var vcountXML:XMLList = null;
         var pList:XMLList = null;
         var j:int = 0;
         this.indices = new Vector.<uint>();
         var vcount:Vector.<int> = new Vector.<int>();
         var i:int = 0;
         var count:int = 0;
         switch(data.localName())
         {
            case "polylist":
            case "polygons":
               vcountXML = data.vcount;
               array = name_609(vcountXML[0]);
               i = 0;
               count = int(array.length);
               while(true)
               {
                  if(i < count)
                  {
                     vcount.push(parseInt(array[i]));
                     i++;
                     continue;
                  }
               }
            case "triangles":
               pList = data.p;
               for(i = 0,count = int(pList.length()); i < count; )
               {
                  array = name_609(pList[i]);
                  for(j = 0; j < array.length; j++)
                  {
                     this.indices.push(parseInt(array[j],10));
                  }
                  if(vcount.length > 0)
                  {
                     this.indices = this.method_374(this.indices,vcount);
                  }
                  i++;
               }
         }
      }
      
      private function method_374(input:Vector.<uint>, vcount:Vector.<int>) : Vector.<uint>
      {
         var indexIn:uint = 0;
         var i:int = 0;
         var j:int = 0;
         var k:int = 0;
         var count:int = 0;
         var verticesCount:int = 0;
         var attributesCount:int = 0;
         var res:Vector.<uint> = new Vector.<uint>();
         var indexOut:uint = 0;
         for(i = 0,count = int(vcount.length); i < count; i++)
         {
            verticesCount = vcount[i];
            attributesCount = verticesCount * this.var_728;
            if(verticesCount == 3)
            {
               j = 0;
               while(j < attributesCount)
               {
                  res[indexOut] = input[indexIn];
                  j++;
                  indexIn++;
                  indexOut++;
               }
            }
            else
            {
               for(j = 1; j < verticesCount - 1; )
               {
                  for(k = 0; k < this.var_728; k++,indexOut++)
                  {
                     res[indexOut] = input[int(indexIn + k)];
                  }
                  for(k = 0; k < this.var_728; k++,indexOut++)
                  {
                     res[indexOut] = input[int(indexIn + this.var_728 * j + k)];
                  }
                  for(k = 0; k < this.var_728; k++,indexOut++)
                  {
                     res[indexOut] = input[int(indexIn + this.var_728 * (j + 1) + k)];
                  }
                  j++;
               }
               indexIn += this.var_728 * verticesCount;
            }
         }
         return res;
      }
      
      public function method_380(geometry:name_136, vertices:Vector.<name_608>) : uint
      {
         var tangentSource:name_607 = null;
         var binormalSource:name_607 = null;
         var normalSource:name_607 = null;
         var index:uint = 0;
         var vertex:name_608 = null;
         var s:name_607 = null;
         var j:int = 0;
         if(this.var_739 == null)
         {
            return 0;
         }
         this.var_739.method_132();
         var numIndices:int = int(this.indices.length);
         var daeVertices:name_610 = document.findVertices(this.var_739.source);
         if(daeVertices == null)
         {
            document.logger.logNotFoundError(this.var_739.source);
            return 0;
         }
         daeVertices.method_132();
         var positionSource:name_607 = daeVertices.name_597;
         var vertexStride:int = 3;
         var mainSource:name_607 = positionSource;
         var mainInput:name_606 = this.var_739;
         var channels:uint = 0;
         var inputOffsets:Vector.<int> = new Vector.<int>();
         inputOffsets.push(this.var_739.offset);
         if(this.var_742 != null)
         {
            normalSource = this.var_742.prepareSource(3);
            inputOffsets.push(this.var_742.offset);
            vertexStride += 3;
            channels |= NORMALS;
            if(this.var_743.length > 0 && this.var_741.length > 0)
            {
               tangentSource = this.var_743[0].prepareSource(3);
               inputOffsets.push(this.var_743[0].offset);
               binormalSource = this.var_741[0].prepareSource(3);
               inputOffsets.push(this.var_741[0].offset);
               vertexStride += 4;
               channels |= TANGENT4;
            }
         }
         var textureSources:Vector.<name_607> = new Vector.<name_607>();
         var numTexCoordsInputs:int = int(this.var_740.length);
         if(numTexCoordsInputs > 8)
         {
            numTexCoordsInputs = 8;
         }
         for(var i:int = 0; i < numTexCoordsInputs; )
         {
            s = this.var_740[i].prepareSource(2);
            textureSources.push(s);
            inputOffsets.push(this.var_740[i].offset);
            vertexStride += 2;
            channels |= TEXCOORDS[i];
            i++;
         }
         var verticesLength:int = int(vertices.length);
         this.indexBegin = geometry.alternativa3d::_indices.length;
         for(i = 0; i < numIndices; i += this.var_728)
         {
            index = this.indices[int(i + mainInput.offset)];
            vertex = vertices[index];
            if(vertex == null || !this.method_377(vertex,this.indices,i,inputOffsets))
            {
               if(vertex != null)
               {
                  index = uint(verticesLength++);
               }
               vertex = new name_608();
               vertices[index] = vertex;
               vertex.name_600 = this.indices[int(i + this.var_739.offset)];
               vertex.name_614(positionSource.numbers,vertex.name_600,positionSource.stride,document.unitScaleFactor);
               if(normalSource != null)
               {
                  vertex.name_611(normalSource.numbers,this.indices[int(i + this.var_742.offset)],normalSource.stride);
               }
               if(tangentSource != null)
               {
                  vertex.name_613(tangentSource.numbers,this.indices[int(i + this.var_743[0].offset)],tangentSource.stride,binormalSource.numbers,this.indices[int(i + this.var_741[0].offset)],binormalSource.stride);
               }
               for(j = 0; j < textureSources.length; )
               {
                  vertex.name_615(textureSources[j].numbers,this.indices[int(i + this.var_740[j].offset)],textureSources[j].stride);
                  j++;
               }
            }
            vertex.name_601 = index;
            geometry.alternativa3d::_indices.push(index);
         }
         this.numTriangles = (geometry.alternativa3d::_indices.length - this.indexBegin) / 3;
         return channels;
      }
      
      private function method_377(vertex:name_608, indices:Vector.<uint>, index:int, offsets:Vector.<int>) : Boolean
      {
         var numOffsets:int = int(offsets.length);
         for(var j:int = 0; j < numOffsets; )
         {
            if(vertex.indices[j] != indices[int(index + offsets[j])])
            {
               return false;
            }
            j++;
         }
         return true;
      }
      
      private function method_375(inputs:Vector.<name_606>, setNum:int) : name_606
      {
         var input:name_606 = null;
         for(var i:int = 0,var numInputs:int = int(inputs.length); i < numInputs; )
         {
            input = inputs[i];
            if(input.setNum == setNum)
            {
               return input;
            }
            i++;
         }
         return null;
      }
      
      private function method_379(mainSetNum:int) : Vector.<VertexChannelData>
      {
         var i:int = 0;
         var texCoordsInput:name_606 = null;
         var texCoordsSource:name_607 = null;
         var data:VertexChannelData = null;
         var mainInput:name_606 = this.method_375(this.var_740,mainSetNum);
         var numInputs:int = int(this.var_740.length);
         var datas:Vector.<VertexChannelData> = new Vector.<VertexChannelData>();
         for(i = 0; i < numInputs; )
         {
            texCoordsInput = this.var_740[i];
            texCoordsSource = texCoordsInput.prepareSource(2);
            if(texCoordsSource != null)
            {
               data = new VertexChannelData(texCoordsSource.numbers,texCoordsSource.stride,texCoordsInput.offset,texCoordsInput.setNum);
               if(texCoordsInput == mainInput)
               {
                  datas.unshift(data);
               }
               else
               {
                  datas.push(data);
               }
            }
            i++;
         }
         return datas.length > 0 ? datas : null;
      }
      
      public function method_378(otherVertices:name_610) : Boolean
      {
         var vertices:name_610 = document.findVertices(this.var_739.source);
         if(vertices == null)
         {
            document.logger.logNotFoundError(this.var_739.source);
         }
         return vertices == otherVertices;
      }
      
      public function get method_381() : String
      {
         var attr:XML = data.@material[0];
         return attr == null ? null : attr.toString();
      }
   }
}

import flash.geom.Point;

class VertexChannelData
{
   public var values:Vector.<Number>;
   
   public var stride:int;
   
   public var offset:int;
   
   public var index:int;
   
   public var channel:Vector.<Point>;
   
   public var inputSet:int;
   
   public function VertexChannelData(values:Vector.<Number>, stride:int, offset:int, inputSet:int = 0)
   {
      super();
      this.values = values;
      this.stride = stride;
      this.offset = offset;
      this.inputSet = inputSet;
   }
}
