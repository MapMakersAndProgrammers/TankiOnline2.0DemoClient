package alternativa.engine3d.loaders.collada
{
   import alternativa.engine3d.animation.keys.name_552;
   import alternativa.engine3d.animation.keys.name_590;
   import alternativa.engine3d.animation.keys.name_591;
   import flash.geom.Matrix3D;
   
   use namespace collada;
   
   public class DaeSampler extends DaeElement
   {
      private var var_719:Vector.<Number>;
      
      private var values:Vector.<Number>;
      
      private var var_720:int;
      
      private var var_721:int;
      
      public function DaeSampler(data:XML, document:DaeDocument)
      {
         super(data,document);
      }
      
      override protected function parseImplementation() : Boolean
      {
         var inputSource:DaeSource = null;
         var outputSource:DaeSource = null;
         var input:DaeInput = null;
         var semantic:String = null;
         var inputsList:XMLList = data.input;
         for(var i:int = 0,var count:int = int(inputsList.length()); i < count; i++)
         {
            input = new DaeInput(inputsList[i],document);
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
                     this.var_719 = inputSource.numbers;
                     this.var_720 = inputSource.stride;
                  }
                  break;
               case "OUTPUT":
                  outputSource = input.prepareSource(1);
                  if(outputSource != null)
                  {
                     this.values = outputSource.numbers;
                     this.var_721 = outputSource.stride;
                  }
                  break;
            }
         }
         return true;
      }
      
      public function parseNumbersTrack(objectName:String, property:String) : name_591
      {
         var track:name_591 = null;
         var count:int = 0;
         var i:int = 0;
         if(this.var_719 != null && this.values != null && this.var_720 > 0)
         {
            track = new name_591(objectName,property);
            count = this.var_719.length / this.var_720;
            for(i = 0; i < count; i++)
            {
               track.addKey(this.var_719[int(this.var_720 * i)],this.values[int(this.var_721 * i)]);
            }
            return track;
         }
         return null;
      }
      
      public function parseTransformationTrack(objectName:String) : name_552
      {
         var track:name_590 = null;
         var count:int = 0;
         var i:int = 0;
         var index:int = 0;
         var matrix:Matrix3D = null;
         if(this.var_719 != null && this.values != null && this.var_720 != 0)
         {
            track = new name_590(objectName);
            count = this.var_719.length / this.var_720;
            for(i = 0; i < count; i++)
            {
               index = this.var_721 * i;
               matrix = new Matrix3D(Vector.<Number>([this.values[index],this.values[index + 4],this.values[index + 8],this.values[index + 12],this.values[index + 1],this.values[index + 5],this.values[index + 9],this.values[index + 13],this.values[index + 2],this.values[index + 6],this.values[index + 10],this.values[index + 14],this.values[index + 3],this.values[index + 7],this.values[index + 11],this.values[index + 15]]));
               track.addKey(this.var_719[i * this.var_720],matrix);
            }
            return track;
         }
         return null;
      }
      
      public function parsePointsTracks(objectName:String, xProperty:String, yProperty:String, zProperty:String) : Vector.<name_552>
      {
         var xTrack:name_591 = null;
         var yTrack:name_591 = null;
         var zTrack:name_591 = null;
         var count:int = 0;
         var i:int = 0;
         var index:int = 0;
         var time:Number = NaN;
         if(this.var_719 != null && this.values != null && this.var_720 != 0)
         {
            xTrack = new name_591(objectName,xProperty);
            xTrack.object = objectName;
            yTrack = new name_591(objectName,yProperty);
            yTrack.object = objectName;
            zTrack = new name_591(objectName,zProperty);
            zTrack.object = objectName;
            count = this.var_719.length / this.var_720;
            for(i = 0; i < count; i++)
            {
               index = i * this.var_721;
               time = this.var_719[i * this.var_720];
               xTrack.addKey(time,this.values[index]);
               yTrack.addKey(time,this.values[index + 1]);
               zTrack.addKey(time,this.values[index + 2]);
            }
            return Vector.<name_552>([xTrack,yTrack,zTrack]);
         }
         return null;
      }
   }
}

