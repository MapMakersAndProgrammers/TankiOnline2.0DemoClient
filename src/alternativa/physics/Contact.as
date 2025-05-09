package alternativa.physics
{
   import alternativa.math.Vector3;
   
   public class Contact
   {
      public var body1:Body;
      
      public var body2:Body;
      
      public var name_501:Number;
      
      public var name_422:Number;
      
      public var normal:Vector3 = new Vector3();
      
      public var points:Vector.<ContactPoint>;
      
      public var name_506:int;
      
      public var var_663:Number = 0;
      
      public var name_507:Boolean;
      
      public var next:Contact;
      
      public var index:int;
      
      private const const_3:int = 8;
      
      public function Contact(index:int)
      {
         this.points = new Vector.<ContactPoint>(this.const_3,true);
         super();
         this.index = index;
         for(var i:int = 0; i < this.const_3; i++)
         {
            this.points[i] = new ContactPoint();
         }
      }
   }
}

