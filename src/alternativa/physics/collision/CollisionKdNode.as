package alternativa.physics.collision
{
   import alternativa.physics.collision.types.BoundBox;
   
   public class CollisionKdNode
   {
      public var indices:Vector.<int>;
      
      public var name_Xt:Vector.<int>;
      
      public var boundBox:BoundBox;
      
      public var parent:CollisionKdNode;
      
      public var name_da:CollisionKdTree2D;
      
      public var axis:int = -1;
      
      public var coord:Number;
      
      public var name_75:CollisionKdNode;
      
      public var name_Gm:CollisionKdNode;
      
      public function CollisionKdNode()
      {
         super();
      }
   }
}

