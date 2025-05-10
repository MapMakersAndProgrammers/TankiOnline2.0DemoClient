package alternativa.engine3d.loaders.collada
{
   import alternativa.engine3d.alternativa3d;
   import alternativa.engine3d.resources.Geometry;
   
   use namespace collada;
   use namespace alternativa3d;
   
   public class DaePrimitive extends DaeElement
   {
      internal static const NORMALS:int = 1;
      
      internal static const TANGENT4:int = 2;
      
      internal static const TEXCOORDS:Vector.<uint> = Vector.<uint>([8,16,32,64,128,256,512,1024]);
      
      internal var §_-2g§:DaeInput;
      
      internal var §_-aL§:Vector.<DaeInput>;
      
      internal var §_-Fl§:DaeInput;
      
      internal var §_-jU§:Vector.<DaeInput>;
      
      internal var §_-ly§:Vector.<DaeInput>;
      
      internal var indices:Vector.<uint>;
      
      internal var §_-5O§:int;
      
      public var indexBegin:int;
      
      public var numTriangles:int;
      
      public function DaePrimitive(data:XML, document:DaeDocument)
      {
         super(data,document);
      }
      
      override protected function parseImplementation() : Boolean
      {
         this.parseInputs();
         this.parseIndices();
         return true;
      }
      
      private function get type() : String
      {
         return data.localName() as String;
      }
      
      private function parseInputs() : void
      {
         var input:DaeInput = null;
         var semantic:String = null;
         var offset:int = 0;
         this.§_-aL§ = new Vector.<DaeInput>();
         this.§_-ly§ = new Vector.<DaeInput>();
         this.§_-jU§ = new Vector.<DaeInput>();
         var inputsList:XMLList = data.input;
         var maxInputOffset:int = 0;
         for(var i:int = 0,var count:int = int(inputsList.length()); i < count; offset = input.offset,maxInputOffset = offset > maxInputOffset ? offset : maxInputOffset,i++)
         {
            input = new DaeInput(inputsList[i],document);
            semantic = input.semantic;
            if(semantic == null)
            {
               continue;
            }
            switch(semantic)
            {
               case "VERTEX":
                  if(this.§_-2g§ == null)
                  {
                     this.§_-2g§ = input;
                  }
                  break;
               case "TEXCOORD":
                  this.§_-aL§.push(input);
                  break;
               case "NORMAL":
                  if(this.§_-Fl§ == null)
                  {
                     this.§_-Fl§ = input;
                  }
                  break;
               case "TEXTANGENT":
                  this.§_-ly§.push(input);
                  break;
               case "TEXBINORMAL":
                  this.§_-jU§.push(input);
                  break;
            }
         }
         this.§_-5O§ = maxInputOffset + 1;
      }
      
      private function parseIndices() : void
      {
         var array:Array = null;
         var _loc5_:XMLList = null;
         var _loc6_:XMLList = null;
         var j:int = 0;
         this.indices = new Vector.<uint>();
         var vcount:Vector.<int> = new Vector.<int>();
         var i:int = 0;
         var count:int = 0;
         switch(data.localName())
         {
            case "polylist":
            case "polygons":
               _loc5_ = data.vcount;
               array = parseStringArray(_loc5_[0]);
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
               _loc6_ = data.p;
               for(i = 0,count = int(_loc6_.length()); i < count; )
               {
                  array = parseStringArray(_loc6_[i]);
                  for(j = 0; j < array.length; j++)
                  {
                     this.indices.push(parseInt(array[j],10));
                  }
                  if(vcount.length > 0)
                  {
                     this.indices = this.triangulate(this.indices,vcount);
                  }
                  i++;
               }
         }
      }
      
      private function triangulate(input:Vector.<uint>, vcount:Vector.<int>) : Vector.<uint>
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
            attributesCount = verticesCount * this.§_-5O§;
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
                  for(k = 0; k < this.§_-5O§; k++,indexOut++)
                  {
                     res[indexOut] = input[int(indexIn + k)];
                  }
                  for(k = 0; k < this.§_-5O§; k++,indexOut++)
                  {
                     res[indexOut] = input[int(indexIn + this.§_-5O§ * j + k)];
                  }
                  for(k = 0; k < this.§_-5O§; k++,indexOut++)
                  {
                     res[indexOut] = input[int(indexIn + this.§_-5O§ * (j + 1) + k)];
                  }
                  j++;
               }
               indexIn += this.§_-5O§ * verticesCount;
            }
         }
         return res;
      }
      
      public function fillGeometry(geometry:Geometry, vertices:Vector.<DaeVertex>) : uint
      {
         var tangentSource:DaeSource = null;
         var binormalSource:DaeSource = null;
         var normalSource:DaeSource = null;
         var index:uint = 0;
         var vertex:DaeVertex = null;
         var s:DaeSource = null;
         var j:int = 0;
         if(this.§_-2g§ == null)
         {
            return 0;
         }
         this.§_-2g§.parse();
         var numIndices:int = int(this.indices.length);
         var daeVertices:DaeVertices = document.findVertices(this.§_-2g§.source);
         if(daeVertices == null)
         {
            document.logger.logNotFoundError(this.§_-2g§.source);
            return 0;
         }
         daeVertices.parse();
         var positionSource:DaeSource = daeVertices.§_-E6§;
         var vertexStride:int = 3;
         var mainSource:DaeSource = positionSource;
         var mainInput:DaeInput = this.§_-2g§;
         var channels:uint = 0;
         var inputOffsets:Vector.<int> = new Vector.<int>();
         inputOffsets.push(this.§_-2g§.offset);
         if(this.§_-Fl§ != null)
         {
            normalSource = this.§_-Fl§.prepareSource(3);
            inputOffsets.push(this.§_-Fl§.offset);
            vertexStride += 3;
            channels |= NORMALS;
            if(this.§_-ly§.length > 0 && this.§_-jU§.length > 0)
            {
               tangentSource = this.§_-ly§[0].prepareSource(3);
               inputOffsets.push(this.§_-ly§[0].offset);
               binormalSource = this.§_-jU§[0].prepareSource(3);
               inputOffsets.push(this.§_-jU§[0].offset);
               vertexStride += 4;
               channels |= TANGENT4;
            }
         }
         var textureSources:Vector.<DaeSource> = new Vector.<DaeSource>();
         var numTexCoordsInputs:int = int(this.§_-aL§.length);
         if(numTexCoordsInputs > 8)
         {
            numTexCoordsInputs = 8;
         }
         for(var i:int = 0; i < numTexCoordsInputs; )
         {
            s = this.§_-aL§[i].prepareSource(2);
            textureSources.push(s);
            inputOffsets.push(this.§_-aL§[i].offset);
            vertexStride += 2;
            channels |= TEXCOORDS[i];
            i++;
         }
         var verticesLength:int = int(vertices.length);
         this.indexBegin = geometry.alternativa3d::_indices.length;
         for(i = 0; i < numIndices; i += this.§_-5O§)
         {
            index = this.indices[int(i + mainInput.offset)];
            vertex = vertices[index];
            if(vertex == null || !this.isEqual(vertex,this.indices,i,inputOffsets))
            {
               if(vertex != null)
               {
                  index = uint(verticesLength++);
               }
               vertex = new DaeVertex();
               vertices[index] = vertex;
               vertex.§_-Eq§ = this.indices[int(i + this.§_-2g§.offset)];
               vertex.addPosition(positionSource.numbers,vertex.§_-Eq§,positionSource.stride,document.unitScaleFactor);
               if(normalSource != null)
               {
                  vertex.addNormal(normalSource.numbers,this.indices[int(i + this.§_-Fl§.offset)],normalSource.stride);
               }
               if(tangentSource != null)
               {
                  vertex.addTangentBiDirection(tangentSource.numbers,this.indices[int(i + this.§_-ly§[0].offset)],tangentSource.stride,binormalSource.numbers,this.indices[int(i + this.§_-jU§[0].offset)],binormalSource.stride);
               }
               for(j = 0; j < textureSources.length; )
               {
                  vertex.appendUV(textureSources[j].numbers,this.indices[int(i + this.§_-aL§[j].offset)],textureSources[j].stride);
                  j++;
               }
            }
            vertex.§_-AR§ = index;
            geometry.alternativa3d::_indices.push(index);
         }
         this.numTriangles = (geometry.alternativa3d::_indices.length - this.indexBegin) / 3;
         return channels;
      }
      
      private function isEqual(vertex:DaeVertex, indices:Vector.<uint>, index:int, offsets:Vector.<int>) : Boolean
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
      
      private function findInputBySet(inputs:Vector.<DaeInput>, setNum:int) : DaeInput
      {
         var input:DaeInput = null;
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
      
      private function getTexCoordsDatas(mainSetNum:int) : Vector.<VertexChannelData>
      {
         var i:int = 0;
         var texCoordsInput:DaeInput = null;
         var texCoordsSource:DaeSource = null;
         var data:VertexChannelData = null;
         var mainInput:DaeInput = this.findInputBySet(this.§_-aL§,mainSetNum);
         var numInputs:int = int(this.§_-aL§.length);
         var datas:Vector.<VertexChannelData> = new Vector.<VertexChannelData>();
         for(i = 0; i < numInputs; )
         {
            texCoordsInput = this.§_-aL§[i];
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
      
      public function verticesEquals(otherVertices:DaeVertices) : Boolean
      {
         var vertices:DaeVertices = document.findVertices(this.§_-2g§.source);
         if(vertices == null)
         {
            document.logger.logNotFoundError(this.§_-2g§.source);
         }
         return vertices == otherVertices;
      }
      
      public function get materialSymbol() : String
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
