package package_123
{
   import flash.geom.Matrix3D;
   import package_125.name_709;
   import package_125.name_759;
   import package_125.name_760;
   
   use namespace collada;
   
   public class name_739 extends class_43
   {
      private var var_720:Vector.<Number>;
      
      private var values:Vector.<Number>;
      
      private var var_721:int;
      
      private var var_722:int;
      
      public function name_739(data:XML, document:name_707)
      {
         super(data,document);
      }
      
      override protected function parseImplementation() : Boolean
      {
         var inputSource:name_740 = null;
         var outputSource:name_740 = null;
         var input:name_784 = null;
         var semantic:String = null;
         var inputsList:XMLList = data.input;
         for(var i:int = 0,var count:int = int(inputsList.length()); i < count; i++)
         {
            input = new name_784(inputsList[i],document);
            semantic = input.semantic;
            if(semantic == null)
            {
               continue;
            }
            switch(semantic)
            {
               case "INPUT":
                  inputSource = input.prepareSource(1);
                  if(inputSource != null)
                  {
                     this.var_720 = inputSource.numbers;
                     this.var_721 = inputSource.stride;
                  }
                  break;
               case "OUTPUT":
                  outputSource = input.prepareSource(1);
                  if(outputSource != null)
                  {
                     this.values = outputSource.numbers;
                     this.var_722 = outputSource.stride;
                  }
                  break;
            }
         }
         return true;
      }
      
      public function name_780(objectName:String, property:String) : name_760
      {
         var track:name_760 = null;
         var count:int = 0;
         var i:int = 0;
         if(this.var_720 != null && this.values != null && this.var_721 > 0)
         {
            track = new name_760(objectName,property);
            count = this.var_720.length / this.var_721;
            for(i = 0; i < count; i++)
            {
               track.method_257(this.var_720[int(this.var_721 * i)],this.values[int(this.var_722 * i)]);
            }
            return track;
         }
         return null;
      }
      
      public function name_782(objectName:String) : name_709
      {
         var track:name_759 = null;
         var count:int = 0;
         var i:int = 0;
         var index:int = 0;
         var matrix:Matrix3D = null;
         if(this.var_720 != null && this.values != null && this.var_721 != 0)
         {
            track = new name_759(objectName);
            count = this.var_720.length / this.var_721;
            for(i = 0; i < count; i++)
            {
               index = this.var_722 * i;
               matrix = new Matrix3D(Vector.<Number>([this.values[index],this.values[index + 4],this.values[index + 8],this.values[index + 12],this.values[index + 1],this.values[index + 5],this.values[index + 9],this.values[index + 13],this.values[index + 2],this.values[index + 6],this.values[index + 10],this.values[index + 14],this.values[index + 3],this.values[index + 7],this.values[index + 11],this.values[index + 15]]));
               track.method_257(this.var_720[i * this.var_721],matrix);
            }
            return track;
         }
         return null;
      }
      
      public function name_779(objectName:String, xProperty:String, yProperty:String, zProperty:String) : Vector.<name_709>
      {
         var xTrack:name_760 = null;
         var yTrack:name_760 = null;
         var zTrack:name_760 = null;
         var count:int = 0;
         var i:int = 0;
         var index:int = 0;
         var time:Number = NaN;
         if(this.var_720 != null && this.values != null && this.var_721 != 0)
         {
            xTrack = new name_760(objectName,xProperty);
            xTrack.object = objectName;
            yTrack = new name_760(objectName,yProperty);
            yTrack.object = objectName;
            zTrack = new name_760(objectName,zProperty);
            zTrack.object = objectName;
            count = this.var_720.length / this.var_721;
            for(i = 0; i < count; i++)
            {
               index = i * this.var_722;
               time = this.var_720[i * this.var_721];
               xTrack.method_257(time,this.values[index]);
               yTrack.method_257(time,this.values[index + 1]);
               zTrack.method_257(time,this.values[index + 2]);
            }
            return Vector.<name_709>([xTrack,yTrack,zTrack]);
         }
         return null;
      }
   }
}

