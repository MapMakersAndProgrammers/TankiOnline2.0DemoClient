package alternativa.engine3d.loaders.collada
{
   use namespace collada;
   
   public class DaeVisualScene extends DaeElement
   {
      public var nodes:Vector.<DaeNode>;
      
      public function DaeVisualScene(data:XML, document:DaeDocument)
      {
         super(data,document);
         this.constructNodes();
      }
      
      public function constructNodes() : void
      {
         var node:DaeNode = null;
         var nodesList:XMLList = data.node;
         var count:int = int(nodesList.length());
         this.nodes = new Vector.<DaeNode>(count);
         for(var i:int = 0; i < count; i++)
         {
            node = new DaeNode(nodesList[i],document,this);
            if(node.id != null)
            {
               document.nodes[node.id] = node;
            }
            this.nodes[i] = node;
         }
      }
   }
}

