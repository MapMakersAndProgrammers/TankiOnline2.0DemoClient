package alternativa.engine3d.core
{
   public class CullingPlane
   {
      public static var collector:CullingPlane;
      
      public var x:Number;
      
      public var y:Number;
      
      public var z:Number;
      
      public var offset:Number;
      
      public var next:CullingPlane;
      
      public function CullingPlane()
      {
         super();
      }
      
      public static function create() : CullingPlane
      {
         var res:CullingPlane = null;
         if(collector != null)
         {
            res = collector;
            collector = res.next;
            res.next = null;
            return res;
         }
         return new CullingPlane();
      }
      
      public function create() : CullingPlane
      {
         var res:CullingPlane = null;
         if(collector != null)
         {
            res = collector;
            collector = res.next;
            res.next = null;
            return res;
         }
         return new CullingPlane();
      }
   }
}

