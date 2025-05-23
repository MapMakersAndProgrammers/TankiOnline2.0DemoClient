package alternativa.tanks.game.effects
{
   import alternativa.engine3d.core.VertexAttributes;
   import alternativa.engine3d.objects.Mesh;
   import alternativa.engine3d.resources.Geometry;
   
   public class Plane extends Mesh
   {
      public function Plane(sizeX:Number, sizeY:Number, offsetX:Number = 0, offsetY:Number = 0)
      {
         super();
         geometry = new Geometry();
         var attributes:Array = [];
         attributes[0] = VertexAttributes.POSITION;
         attributes[1] = VertexAttributes.POSITION;
         attributes[2] = VertexAttributes.POSITION;
         attributes[3] = VertexAttributes.TEXCOORDS[0];
         attributes[4] = VertexAttributes.TEXCOORDS[0];
         geometry.addVertexStream(attributes);
         geometry.numVertices = 4;
         var vc:Vector.<Number> = new Vector.<Number>(12);
         var hsx:Number = sizeX / 2;
         var hsy:Number = sizeY / 2;
         vc[0] = offsetX - hsx;
         vc[1] = offsetY - hsy;
         vc[2] = 0;
         vc[3] = offsetX + hsx;
         vc[4] = offsetY - hsy;
         vc[5] = 0;
         vc[6] = offsetX + hsx;
         vc[7] = offsetY + hsy;
         vc[8] = 0;
         vc[9] = offsetX - hsx;
         vc[10] = offsetY + hsy;
         vc[11] = 0;
         geometry.setAttributeValues(VertexAttributes.POSITION,vc);
         var uvs:Vector.<Number> = new Vector.<Number>(8);
         uvs[0] = 0;
         uvs[1] = 1;
         uvs[2] = 1;
         uvs[3] = 1;
         uvs[4] = 1;
         uvs[5] = 0;
         uvs[6] = 0;
         uvs[7] = 0;
         geometry.setAttributeValues(VertexAttributes.TEXCOORDS[0],uvs);
         geometry.indices = Vector.<uint>([0,1,2,0,2,3]);
         addSurface(null,0,2);
         calculateBoundBox();
      }
   }
}

