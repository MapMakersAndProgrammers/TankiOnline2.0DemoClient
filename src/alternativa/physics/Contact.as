package alternativa.physics
{
   import alternativa.math.Vector3;
   
   public class Contact
   {
      public var body1:Body;
      
      public var body2:Body;
      
      public var §_-Pe§:Number;
      
      public var §_-J1§:Number;
      
      public var normal:Vector3 = new Vector3();
      
      public var points:Vector.<ContactPoint>;
      
      public var §_-P3§:int;
      
      public var §_-HA§:Number = 0;
      
      public var §_-CV§:Boolean;
      
      public var next:Contact;
      
      public var index:int;
      
      private const §_-29§:int = 8;
      
      public function Contact(index:int)
      {
         this.points = new Vector.<ContactPoint>(this.§_-29§,true);
         super();
         this.index = index;
         for(var i:int = 0; i < this.§_-29§; i++)
         {
            this.points[i] = new ContactPoint();
         }
      }
   }
}

