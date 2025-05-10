package alternativa.physics
{
   import alternativa.math.Vector3;
   
   public class Contact
   {
      public var body1:Body;
      
      public var body2:Body;
      
      public var name_Pe:Number;
      
      public var name_J1:Number;
      
      public var normal:Vector3 = new Vector3();
      
      public var points:Vector.<ContactPoint>;
      
      public var name_P3:int;
      
      public var name_HA:Number = 0;
      
      public var name_CV:Boolean;
      
      public var next:Contact;
      
      public var index:int;
      
      private const name_29:int = 8;
      
      public function Contact(index:int)
      {
         this.points = new Vector.<ContactPoint>(this.name_29,true);
         super();
         this.index = index;
         for(var i:int = 0; i < this.name_29; i++)
         {
            this.points[i] = new ContactPoint();
         }
      }
   }
}

