package package_25
{
   import package_28.name_129;
   
   public class name_250
   {
      public var diffuse:name_129;
      
      public var opacity:name_129;
      
      public var columnsCount:int;
      
      public var rowsCount:int;
      
      public var rangeBegin:int;
      
      public var rangeLength:int;
      
      public var fps:int;
      
      public var loop:Boolean;
      
      public var originX:Number;
      
      public var originY:Number;
      
      public function name_250(diffuse:name_129, opacity:name_129 = null, columnsCount:int = 1, rowsCount:int = 1, rangeBegin:int = 0, rangeLength:int = 1, fps:int = 30, loop:Boolean = false, originX:Number = 0.5, originY:Number = 0.5)
      {
         super();
         this.diffuse = diffuse;
         this.opacity = opacity;
         this.columnsCount = columnsCount;
         this.rowsCount = rowsCount;
         this.rangeBegin = rangeBegin;
         this.rangeLength = rangeLength;
         this.fps = fps;
         this.loop = loop;
         this.originX = originX;
         this.originY = originY;
      }
   }
}

