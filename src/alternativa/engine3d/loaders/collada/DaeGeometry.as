package alternativa.engine3d.loaders.collada
{
   import alternativa.engine3d.alternativa3d;
   import alternativa.engine3d.core.VertexAttributes;
   import alternativa.engine3d.loaders.ParserMaterial;
   import alternativa.engine3d.objects.Mesh;
   import alternativa.engine3d.resources.Geometry;
   import flash.utils.ByteArray;
   import flash.utils.Endian;
   
   use namespace collada;
   use namespace alternativa3d;
   
   public class DaeGeometry extends DaeElement
   {
      internal var §_-FV§:Vector.<DaeVertex>;
      
      internal var primitives:Vector.<DaePrimitive>;
      
      internal var geometry:Geometry;
      
      private var vertices:DaeVertices;
      
      public function DaeGeometry(data:XML, document:DaeDocument)
      {
         super(data,document);
         this.constructVertices();
      }
      
      private function constructVertices() : void
      {
         var verticesXML:XML = data.mesh.vertices[0];
         if(verticesXML != null)
         {
            this.vertices = new DaeVertices(verticesXML,document);
            document.vertices[this.vertices.id] = this.vertices;
         }
      }
      
      override protected function parseImplementation() : Boolean
      {
         var numVertices:int = 0;
         var i:int = 0;
         var p:DaePrimitive = null;
         var channels:uint = 0;
         var attributes:Array = null;
         var index:int = 0;
         var data:ByteArray = null;
         var numMappings:int = 0;
         var vertex:DaeVertex = null;
         var j:int = 0;
         if(this.vertices != null)
         {
            this.parsePrimitives();
            this.vertices.parse();
            numVertices = this.vertices.§_-E6§.numbers.length / this.vertices.§_-E6§.stride;
            this.geometry = new Geometry();
            this.§_-FV§ = new Vector.<DaeVertex>(numVertices);
            channels = 0;
            for(i = 0; i < this.primitives.length; )
            {
               p = this.primitives[i];
               p.parse();
               if(p.verticesEquals(this.vertices))
               {
                  numVertices = int(this.§_-FV§.length);
                  channels |= p.fillGeometry(this.geometry,this.§_-FV§);
               }
               i++;
            }
            attributes = new Array(3);
            attributes[0] = VertexAttributes.POSITION;
            attributes[1] = VertexAttributes.POSITION;
            attributes[2] = VertexAttributes.POSITION;
            index = 3;
            if(Boolean(channels & DaePrimitive.NORMALS))
            {
               var _loc11_:* = index++;
               attributes[_loc11_] = VertexAttributes.NORMAL;
               var _loc12_:* = index++;
               attributes[_loc12_] = VertexAttributes.NORMAL;
               var _loc13_:* = index++;
               attributes[_loc13_] = VertexAttributes.NORMAL;
            }
            if(Boolean(channels & DaePrimitive.TANGENT4))
            {
               _loc11_ = index++;
               attributes[_loc11_] = VertexAttributes.TANGENT4;
               _loc12_ = index++;
               attributes[_loc12_] = VertexAttributes.TANGENT4;
               _loc13_ = index++;
               attributes[_loc13_] = VertexAttributes.TANGENT4;
               var _loc14_:* = index++;
               attributes[_loc14_] = VertexAttributes.TANGENT4;
            }
            for(i = 0; i < 8; )
            {
               if(Boolean(channels & DaePrimitive.TEXCOORDS[i]))
               {
                  _loc11_ = index++;
                  attributes[_loc11_] = VertexAttributes.TEXCOORDS[i];
                  _loc12_ = index++;
                  attributes[_loc12_] = VertexAttributes.TEXCOORDS[i];
               }
               i++;
            }
            this.geometry.addVertexStream(attributes);
            numVertices = int(this.§_-FV§.length);
            data = new ByteArray();
            data.endian = Endian.LITTLE_ENDIAN;
            numMappings = int(attributes.length);
            data.length = 4 * numMappings * numVertices;
            for(i = 0; i < numVertices; )
            {
               vertex = this.§_-FV§[i];
               if(vertex != null)
               {
                  data.position = 4 * numMappings * i;
                  data.writeFloat(vertex.x);
                  data.writeFloat(vertex.y);
                  data.writeFloat(vertex.z);
                  if(vertex.normal != null)
                  {
                     data.writeFloat(vertex.normal.x);
                     data.writeFloat(vertex.normal.y);
                     data.writeFloat(vertex.normal.z);
                  }
                  if(vertex.§_-hC§ != null)
                  {
                     data.writeFloat(vertex.§_-hC§.x);
                     data.writeFloat(vertex.§_-hC§.y);
                     data.writeFloat(vertex.§_-hC§.z);
                     data.writeFloat(vertex.§_-hC§.w);
                  }
                  for(j = 0; j < vertex.uvs.length; )
                  {
                     data.writeFloat(vertex.uvs[j]);
                     j++;
                  }
               }
               i++;
            }
            this.geometry.alternativa3d::_vertexStreams[0].data = data;
            this.geometry.alternativa3d::_numVertices = numVertices;
            return true;
         }
         return false;
      }
      
      private function parsePrimitives() : void
      {
         var child:XML = null;
         var _loc5_:DaePrimitive = null;
         this.primitives = new Vector.<DaePrimitive>();
         var children:XMLList = data.mesh.children();
         for(var i:int = 0,var count:int = int(children.length()); i < count; )
         {
            child = children[i];
            switch(child.localName())
            {
               case "polygons":
               case "polylist":
               case "triangles":
               case "trifans":
               case "tristrips":
                  _loc5_ = new DaePrimitive(child,document);
                  this.primitives.push(_loc5_);
                  break;
            }
            i++;
         }
      }
      
      public function parseMesh(materials:Object) : Mesh
      {
         var mesh:Mesh = null;
         var i:int = 0;
         var p:DaePrimitive = null;
         var instanceMaterial:DaeInstanceMaterial = null;
         var material:ParserMaterial = null;
         var daeMaterial:DaeMaterial = null;
         if(data.mesh.length() > 0)
         {
            mesh = new Mesh();
            mesh.geometry = this.geometry;
            for(i = 0; i < this.primitives.length; i++)
            {
               p = this.primitives[i];
               instanceMaterial = materials[p.materialSymbol];
               if(instanceMaterial != null)
               {
                  daeMaterial = instanceMaterial.material;
                  if(daeMaterial != null)
                  {
                     daeMaterial.parse();
                     material = daeMaterial.material;
                     daeMaterial.used = true;
                  }
               }
               mesh.addSurface(material,p.indexBegin,p.numTriangles);
            }
            mesh.calculateBoundBox();
            return mesh;
         }
         return null;
      }
   }
}

