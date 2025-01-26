package package_123
{
   import flash.utils.Dictionary;
   
   use namespace collada;
   
   public class name_757 extends class_43
   {
      public var node:name_706;
      
      public var topmostJoints:Vector.<name_706>;
      
      public function name_757(data:XML, document:name_707, node:name_706)
      {
         super(data,document);
         this.node = node;
      }
      
      override protected function parseImplementation() : Boolean
      {
         var controller:name_735 = this.controller;
         if(controller != null)
         {
            this.topmostJoints = controller.method_916(this.skeletons);
            if(this.topmostJoints != null && this.topmostJoints.length > 1)
            {
               this.method_923(this.topmostJoints);
            }
         }
         return this.topmostJoints != null;
      }
      
      private function method_923(nodes:Vector.<name_706>) : void
      {
         var i:int = 0;
         var node:name_706 = null;
         var parent:name_706 = null;
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
      
      private function get controller() : name_735
      {
         var controller:name_735 = document.findController(data.@url[0]);
         if(controller == null)
         {
            document.logger.logNotFoundError(data.@url[0]);
         }
         return controller;
      }
      
      private function get skeletons() : Vector.<name_706>
      {
         var skeletons:Vector.<name_706> = null;
         var i:int = 0;
         var count:int = 0;
         var skeletonXML:XML = null;
         var skel:name_706 = null;
         var list:XMLList = data.skeleton;
         if(list.length() > 0)
         {
            skeletons = new Vector.<name_706>();
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
      
      public function method_429(materials:Object) : name_711
      {
         var controller:name_735 = this.controller;
         if(controller != null)
         {
            controller.method_314();
            return controller.method_429(materials,this.topmostJoints,this.skeletons);
         }
         return null;
      }
   }
}

