package package_123
{
   import alternativa.engine3d.alternativa3d;
   import flash.utils.ByteArray;
   import flash.utils.Endian;
   import package_116.name_641;
   import package_19.name_380;
   import package_21.name_126;
   import package_28.name_119;
   
   use namespace collada;
   use namespace alternativa3d;
   
   public class name_736 extends class_43
   {
      internal var var_716:Vector.<name_770>;
      
      internal var primitives:Vector.<name_768>;
      
      internal var geometry:name_119;
      
      private var vertices:name_744;
      
      public function name_736(data:XML, document:name_707)
      {
         super(data,document);
         this.method_888();
      }
      
      private function method_888() : void
      {
         var verticesXML:XML = data.mesh.vertices[0];
         if(verticesXML != null)
         {
            this.vertices = new name_744(verticesXML,document);
            document.vertices[this.vertices.id] = this.vertices;
         }
      }
      
      override protected function parseImplementation() : Boolean
      {
         var numVertices:int = 0;
         var i:int = 0;
         var p:name_768 = null;
         var channels:uint = 0;
         var attributes:Array = null;
         var index:int = 0;
         var data:ByteArray = null;
         var numMappings:int = 0;
         var vertex:name_770 = null;
         var j:int = 0;
         if(this.vertices != null)
         {
            this.method_889();
            this.vertices.method_314();
            numVertices = this.vertices.name_771.numbers.length / this.vertices.name_771.stride;
            this.geometry = new name_119();
            this.var_716 = new Vector.<name_770>(numVertices);
            channels = 0;
            for(i = 0; i < this.primitives.length; )
            {
               p = this.primitives[i];
               p.method_314();
               if(p.name_772(this.vertices))
               {
                  numVertices = int(this.var_716.length);
                  channels |= p.name_773(this.geometry,this.var_716);
               }
               i++;
            }
            attributes = new Array(3);
            attributes[0] = name_126.POSITION;
            attributes[1] = name_126.POSITION;
            attributes[2] = name_126.POSITION;
            index = 3;
            if(Boolean(channels & name_768.NORMALS))
            {
               var _loc11_:* = index++;
               attributes[_loc11_] = name_126.NORMAL;
               var _loc12_:* = index++;
               attributes[_loc12_] = name_126.NORMAL;
               var _loc13_:* = index++;
               attributes[_loc13_] = name_126.NORMAL;
            }
            if(Boolean(channels & name_768.TANGENT4))
            {
               _loc11_ = index++;
               attributes[_loc11_] = name_126.TANGENT4;
               _loc12_ = index++;
               attributes[_loc12_] = name_126.TANGENT4;
               _loc13_ = index++;
               attributes[_loc13_] = name_126.TANGENT4;
               var _loc14_:* = index++;
               attributes[_loc14_] = name_126.TANGENT4;
            }
            for(i = 0; i < 8; )
            {
               if(Boolean(channels & name_768.TEXCOORDS[i]))
               {
                  _loc11_ = index++;
                  attributes[_loc11_] = name_126.TEXCOORDS[i];
                  _loc12_ = index++;
                  attributes[_loc12_] = name_126.TEXCOORDS[i];
               }
               i++;
            }
            this.geometry.addVertexStream(attributes);
            numVertices = int(this.var_716.length);
            data = new ByteArray();
            data.endian = Endian.LITTLE_ENDIAN;
            numMappings = int(attributes.length);
            data.length = 4 * numMappings * numVertices;
            for(i = 0; i < numVertices; )
            {
               vertex = this.var_716[i];
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
                  if(vertex.name_769 != null)
                  {
                     data.writeFloat(vertex.name_769.x);
                     data.writeFloat(vertex.name_769.y);
                     data.writeFloat(vertex.name_769.z);
                     data.writeFloat(vertex.name_769.w);
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
      
      private function method_889() : void
      {
         var child:XML = null;
         var p:name_768 = null;
         this.primitives = new Vector.<name_768>();
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
                  p = new name_768(child,document);
                  this.primitives.push(p);
                  break;
            }
            i++;
         }
      }
      
      public function method_727(materials:Object) : name_380
      {
         var mesh:name_380 = null;
         var i:int = 0;
         var p:name_768 = null;
         var instanceMaterial:name_758 = null;
         var material:name_641 = null;
         var daeMaterial:name_713 = null;
         if(data.mesh.length() > 0)
         {
            mesh = new name_380();
            mesh.geometry = this.geometry;
            for(i = 0; i < this.primitives.length; i++)
            {
               p = this.primitives[i];
               instanceMaterial = materials[p.name_774];
               if(instanceMaterial != null)
               {
                  daeMaterial = instanceMaterial.material;
                  if(daeMaterial != null)
                  {
                     daeMaterial.method_314();
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

