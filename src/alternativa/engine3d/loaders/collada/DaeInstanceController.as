package alternativa.engine3d.loaders.collada
{
   import flash.utils.Dictionary;
   
   use namespace collada;
   
   public class DaeInstanceController extends DaeElement
   {
      public var node:DaeNode;
      
      public var topmostJoints:Vector.<DaeNode>;
      
      public function DaeInstanceController(data:XML, document:DaeDocument, node:DaeNode)
      {
         super(data,document);
         this.node = node;
      }
      
      override protected function parseImplementation() : Boolean
      {
         var controller:DaeController = this.controller;
         if(controller != null)
         {
            this.topmostJoints = controller.findRootJointNodes(this.skeletons);
            if(this.topmostJoints != null && this.topmostJoints.length > 1)
            {
               this.replaceNodesByTopmost(this.topmostJoints);
            }
         }
         return this.topmostJoints != null;
      }
      
      private function replaceNodesByTopmost(nodes:Vector.<DaeNode>) : void
      {
         var i:int = 0;
         var node:DaeNode = null;
         var parent:DaeNode = null;
         var numNodes:int = int(nodes.length);
         var parents:Dictionary = new Dictionary();
         for(i = 0; i < numNodes; i++)
         {
            node = nodes[i];
            for(parent = node.parent; parent != null; parent = parent.parent)
            {
               if(Boolean(parents[parent]))
               {
                  ++parents[parent];
               }
               else
               {
                  parents[parent] = 1;
               }
            }
         }
         for(i = 0; i < numNodes; i++)
         {
            node = nodes[i];
            while(true)
            {
               parent = node.parent;
               if(!(parent != null && parents[parent] != numNodes))
               {
                  break;
               }
               node = node.parent;
            }
            nodes[i] = node;
         }
      }
      
      private function get controller() : DaeController
      {
         var controller:DaeController = document.findController(data.@url[0]);
         if(controller == null)
         {
            document.logger.logNotFoundError(data.@url[0]);
         }
         return controller;
      }
      
      private function get skeletons() : Vector.<DaeNode>
      {
         var skeletons:Vector.<DaeNode> = null;
         var i:int = 0;
         var count:int = 0;
         var skeletonXML:XML = null;
         var skel:DaeNode = null;
         var list:XMLList = data.skeleton;
         if(list.length() > 0)
         {
            skeletons = new Vector.<DaeNode>();
            for(i = 0,count = int(list.length()); i < count; i++)
            {
               skeletonXML = list[i];
               skel = document.findNode(skeletonXML.text()[0]);
               if(skel != null)
               {
                  skeletons.push(skel);
               }
               else
               {
                  document.logger.logNotFoundError(skeletonXML);
               }
            }
            return skeletons;
         }
         return null;
      }
      
      public function parseSkin(materials:Object) : DaeObject
      {
         var controller:DaeController = this.controller;
         if(controller != null)
         {
            controller.parse();
            return controller.parseSkin(materials,this.topmostJoints,this.skeletons);
         }
         return null;
      }
   }
}

