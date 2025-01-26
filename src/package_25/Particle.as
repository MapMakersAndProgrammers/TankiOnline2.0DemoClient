package package_25
{
   import flash.display3D.textures.TextureBase;
   
   public class Particle
   {
      public static var collector:Particle;
      
      public var diffuse:TextureBase;
      
      public var opacity:TextureBase;
      
      public var blendSource:String;
      
      public var blendDestination:String;
      
      public var x:Number;
      
      public var y:Number;
      
      public var z:Number;
      
      public var rotation:Number;
      
      public var width:Number;
      
      public var height:Number;
      
      public var originX:Number;
      
      public var originY:Number;
      
      public var name_420:Number;
      
      public var name_419:Number;
      
      public var name_417:Number;
      
      public var name_416:Number;
      
      public var red:Number;
      
      public var green:Number;
      
      public var blue:Number;
      
      public var alpha:Number;
      
      public var next:Particle;
      
      public function Particle()
      {
         super();
      }
      
      public static function create() : Particle
      {
         var res:Particle = null;
         if(collector != null)
         {
            res = collector;
            collector = collector.next;
            res.next = null;
         }
         else
         {
            res = new Particle();
         }
         return res;
      }
   }
}

