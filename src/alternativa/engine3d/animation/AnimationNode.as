package alternativa.engine3d.animation
{
   import alternativa.engine3d.alternativa3d;
   
   use namespace alternativa3d;
   
   public class AnimationNode
   {
      alternativa3d var §_-Eo§:Boolean = false;
      
      alternativa3d var _parent:AnimationNode;
      
      alternativa3d var controller:AnimationController;
      
      public var speed:Number = 1;
      
      public function AnimationNode()
      {
         super();
      }
      
      public function get isActive() : Boolean
      {
         return this.alternativa3d::_-Eo && this.alternativa3d::controller != null;
      }
      
      public function get parent() : AnimationNode
      {
         return this.alternativa3d::_parent;
      }
      
      alternativa3d function update(elapsed:Number, weight:Number) : void
      {
      }
      
      alternativa3d function setController(value:AnimationController) : void
      {
         this.alternativa3d::controller = value;
      }
      
      alternativa3d function addNode(node:AnimationNode) : void
      {
         if(node.alternativa3d::_parent != null)
         {
            node.alternativa3d::_parent.alternativa3d::removeNode(node);
         }
         node.alternativa3d::_parent = this;
         node.alternativa3d::setController(this.alternativa3d::controller);
      }
      
      alternativa3d function removeNode(node:AnimationNode) : void
      {
         node.alternativa3d::setController(null);
         node.alternativa3d::_-Eo = false;
         node.alternativa3d::_parent = null;
      }
   }
}

