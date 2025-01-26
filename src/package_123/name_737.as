package package_123
{
   use namespace collada;
   
   public class name_737 extends class_43
   {
      public var nodes:Vector.<name_706>;
      
      public function name_737(data:XML, document:name_707)
      {
         super(data,document);
         this.method_879();
      }
      
      public function method_879() : void
      {
         var node:name_706 = null;
         var nodesList:XMLList = data.node;
         var count:int = int(nodesList.length());
         this.nodes = new Vector.<name_706>(count);
         for(var i:int = 0; i < count; i++)
         {
            node = new name_706(nodesList[i],document,this);
            if(node.id != null)
            {
               document.nodes[node.id] = node;
            }
            this.nodes[i] = node;
         }
      }
   }
}

