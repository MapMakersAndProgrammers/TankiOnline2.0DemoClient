package alternativa.physics.collision
{
   import alternativa.physics.collision.types.BoundBox;
   
   public class CollisionKdNode
   {
      public var indices:Vector.<int>;
      
      public var var_674:Vector.<int>;
      
      public var boundBox:BoundBox;
      
      public var parent:CollisionKdNode;
      
      public var name_487:CollisionKdTree2D;
      
      public var axis:int = -1;
      
      public var coord:Number;
      
      public var name_484:CollisionKdNode;
      
      public var name_483:CollisionKdNode;
      
      public function CollisionKdNode()
      {
         super();
      }
   }
}

