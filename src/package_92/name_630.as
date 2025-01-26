package package_92
{
   import package_46.name_194;
   
   public class name_630
   {
      public var body1:name_271;
      
      public var body2:name_271;
      
      public var name_673:Number;
      
      public var name_581:Number;
      
      public var normal:name_194 = new name_194();
      
      public var points:Vector.<name_674>;
      
      public var name_679:int;
      
      public var var_663:Number = 0;
      
      public var name_680:Boolean;
      
      public var next:name_630;
      
      public var index:int;
      
      private const const_3:int = 8;
      
      public function name_630(index:int)
      {
         this.points = new Vector.<name_674>(this.const_3,true);
         super();
         this.index = index;
         for(var i:int = 0; i < this.const_3; i++)
         {
            this.points[i] = new name_674();
         }
      }
   }
}

