package package_124
{
   import alternativa.engine3d.alternativa3d;
   
   use namespace alternativa3d;
   
   public class class_42
   {
      alternativa3d var var_694:Boolean = false;
      
      alternativa3d var _parent:class_42;
      
      alternativa3d var controller:name_750;
      
      public var speed:Number = 1;
      
      public function class_42()
      {
         super();
      }
      
      public function get isActive() : Boolean
      {
         return this.alternativa3d::var_694 && this.alternativa3d::controller != null;
      }
      
      public function get parent() : class_42
      {
         return this.alternativa3d::_parent;
      }
      
      alternativa3d function update(elapsed:Number, weight:Number) : void
      {
      }
      
      alternativa3d function setController(value:name_750) : void
      {
         this.alternativa3d::controller = value;
      }
      
      alternativa3d function method_853(node:class_42) : void
      {
         if(node.alternativa3d::_parent != null)
         {
            node.alternativa3d::_parent.alternativa3d::method_852(node);
         }
         node.alternativa3d::_parent = this;
         node.alternativa3d::setController(this.alternativa3d::controller);
      }
      
      alternativa3d function method_852(node:class_42) : void
      {
         node.alternativa3d::setController(null);
         node.alternativa3d::var_694 = false;
         node.alternativa3d::_parent = null;
      }
   }
}

