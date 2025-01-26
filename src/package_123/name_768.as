package package_123
{
   import alternativa.engine3d.alternativa3d;
   import package_28.name_119;
   
   use namespace collada;
   use namespace alternativa3d;
   
   public class name_768 extends class_43
   {
      internal static const NORMALS:int = 1;
      
      internal static const TANGENT4:int = 2;
      
      internal static const TEXCOORDS:Vector.<uint> = Vector.<uint>([8,16,32,64,128,256,512,1024]);
      
      internal var var_740:name_784;
      
      internal var var_741:Vector.<name_784>;
      
      internal var var_743:name_784;
      
      internal var var_742:Vector.<name_784>;
      
      internal var var_744:Vector.<name_784>;
      
      internal var indices:Vector.<uint>;
      
      internal var var_729:int;
      
      public var indexBegin:int;
      
      public var numTriangles:int;
      
      public function name_768(data:XML, document:name_707)
      {
         super(data,document);
      }
      
      override protected function parseImplementation() : Boolean
      {
         this.method_909();
         this.method_938();
         return true;
      }
      
      private function get type() : String
      {
         return data.localName() as String;
      }
      
      private function method_909() : void
      {
         var input:name_784 = null;
         var semantic:String = null;
         var offset:int = 0;
         this.var_741 = new Vector.<name_784>();
         this.var_744 = new Vector.<name_784>();
         this.var_742 = new Vector.<name_784>();
         var inputsList:XMLList = data.input;
         var maxInputOffset:int = 0;
         for(var i:int = 0,var count:int = int(inputsList.length()); i < count; offset = input.offset,maxInputOffset = offset > maxInputOffset ? offset : maxInputOffset,i++)
         {
            input = new name_784(inputsList[i],document);
            semantic = input.semantic;
            if(semantic == null)
            {
               continue;
            }
            switch(semantic)
            {
               case "VERTEX":
                  if(this.var_740 == null)
                  {
                     this.var_740 = input;
                  }
                  break;
               case "TEXCOORD":
                  this.var_741.push(input);
                  break;
               case "NORMAL":
                  if(this.var_743 == null)
                  {
                     this.var_743 = input;
                  }
                  break;
               case "TEXTANGENT":
                  this.var_744.push(input);
                  break;
               case "TEXBINORMAL":
                  this.var_742.push(input);
                  break;
            }
         }
         this.var_729 = maxInputOffset + 1;
      }
      
      private function method_938() : void
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
               array = name_565(vcountXML[0]);
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
                  array = name_565(pList[i]);
                  for(j = 0; j < array.length; j++)
                  {
                     this.indices.push(parseInt(array[j],10));
                  }
                  if(vcount.length > 0)
                  {
                     this.indices = this.method_936(this.indices,vcount);
                  }
                  i++;
               }
         }
      }
      
      private function method_936(input:Vector.<uint>, vcount:Vector.<int>) : Vector.<uint>
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
            attributesCount = verticesCount * this.var_729;
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
                  for(k = 0; k < this.var_729; k++,indexOut++)
                  {
                     res[indexOut] = input[int(indexIn + k)];
                  }
                  for(k = 0; k < this.var_729; k++,indexOut++)
                  {
                     res[indexOut] = input[int(indexIn + this.var_729 * j + k)];
                  }
                  for(k = 0; k < this.var_729; k++,indexOut++)
                  {
                     res[indexOut] = input[int(indexIn + this.var_729 * (j + 1) + k)];
                  }
                  j++;
               }
               indexIn += this.var_729 * verticesCount;
            }
         }
         return res;
      }
      
      public function name_773(geometry:name_119, vertices:Vector.<name_770>) : uint
      {
         var tangentSource:name_740 = null;
         var binormalSource:name_740 = null;
         var normalSource:name_740 = null;
         var index:uint = 0;
         var vertex:name_770 = null;
         var s:name_740 = null;
         var j:int = 0;
         if(this.var_740 == null)
         {
            return 0;
         }
         this.var_740.method_314();
         var numIndices:int = int(this.indices.length);
         var daeVertices:name_744 = document.findVertices(this.var_740.source);
         if(daeVertices == null)
         {
            document.logger.logNotFoundError(this.var_740.source);
            return 0;
         }
         daeVertices.method_314();
         var positionSource:name_740 = daeVertices.name_771;
         var vertexStride:int = 3;
         var mainSource:name_740 = positionSource;
         var mainInput:name_784 = this.var_740;
         var channels:uint = 0;
         var inputOffsets:Vector.<int> = new Vector.<int>();
         inputOffsets.push(this.var_740.offset);
         if(this.var_743 != null)
         {
            normalSource = this.var_743.prepareSource(3);
            inputOffsets.push(this.var_743.offset);
            vertexStride += 3;
            channels |= NORMALS;
            if(this.var_744.length > 0 && this.var_742.length > 0)
            {
               tangentSource = this.var_744[0].prepareSource(3);
               inputOffsets.push(this.var_744[0].offset);
               binormalSource = this.var_742[0].prepareSource(3);
               inputOffsets.push(this.var_742[0].offset);
               vertexStride += 4;
               channels |= TANGENT4;
            }
         }
         var textureSources:Vector.<name_740> = new Vector.<name_740>();
         var numTexCoordsInputs:int = int(this.var_741.length);
         if(numTexCoordsInputs > 8)
         {
            numTexCoordsInputs = 8;
         }
         for(var i:int = 0; i < numTexCoordsInputs; )
         {
            s = this.var_741[i].prepareSource(2);
            textureSources.push(s);
            inputOffsets.push(this.var_741[i].offset);
            vertexStride += 2;
            channels |= TEXCOORDS[i];
            i++;
         }
         var verticesLength:int = int(vertices.length);
         this.indexBegin = geometry.alternativa3d::_indices.length;
         for(i = 0; i < numIndices; i += this.var_729)
         {
            index = this.indices[int(i + mainInput.offset)];
            vertex = vertices[index];
            if(vertex == null || !this.method_939(vertex,this.indices,i,inputOffsets))
            {
               if(vertex != null)
               {
                  index = uint(verticesLength++);
               }
               vertex = new name_770();
               vertices[index] = vertex;
               vertex.name_785 = this.indices[int(i + this.var_740.offset)];
               vertex.method_933(positionSource.numbers,vertex.name_785,positionSource.stride,document.unitScaleFactor);
               if(normalSource != null)
               {
                  vertex.method_935(normalSource.numbers,this.indices[int(i + this.var_743.offset)],normalSource.stride);
               }
               if(tangentSource != null)
               {
                  vertex.method_932(tangentSource.numbers,this.indices[int(i + this.var_744[0].offset)],tangentSource.stride,binormalSource.numbers,this.indices[int(i + this.var_742[0].offset)],binormalSource.stride);
               }
               for(j = 0; j < textureSources.length; )
               {
                  vertex.method_934(textureSources[j].numbers,this.indices[int(i + this.var_741[j].offset)],textureSources[j].stride);
                  j++;
               }
            }
            vertex.name_786 = index;
            geometry.alternativa3d::_indices.push(index);
         }
         this.numTriangles = (geometry.alternativa3d::_indices.length - this.indexBegin) / 3;
         return channels;
      }
      
      private function method_939(vertex:name_770, indices:Vector.<uint>, index:int, offsets:Vector.<int>) : Boolean
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
      
      private function method_937(inputs:Vector.<name_784>, setNum:int) : name_784
      {
         var input:name_784 = null;
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
      
      private function method_940(mainSetNum:int) : Vector.<VertexChannelData>
      {
         var i:int = 0;
         var texCoordsInput:name_784 = null;
         var texCoordsSource:name_740 = null;
         var data:VertexChannelData = null;
         var mainInput:name_784 = this.method_937(this.var_741,mainSetNum);
         var numInputs:int = int(this.var_741.length);
         var datas:Vector.<VertexChannelData> = new Vector.<VertexChannelData>();
         for(i = 0; i < numInputs; )
         {
            texCoordsInput = this.var_741[i];
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
      
      public function name_772(otherVertices:name_744) : Boolean
      {
         var vertices:name_744 = document.findVertices(this.var_740.source);
         if(vertices == null)
         {
            document.logger.logNotFoundError(this.var_740.source);
         }
         return vertices == otherVertices;
      }
      
      public function get name_774() : String
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
