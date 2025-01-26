package package_90
{
   import package_46.name_194;
   import package_76.name_235;
   
   public class name_273
   {
      public var t:Number = 0;
      
      public var position:name_194 = new name_194();
      
      public var normal:name_194 = new name_194();
      
      public var primitive:name_235;
      
      public function name_273()
      {
         super();
      }
      
      public function copy(source:name_273) : void
      {
         this.t = source.t;
         this.position.copy(source.position);
         this.normal.copy(source.normal);
         this.primitive = source.primitive;
      }
   }
}

