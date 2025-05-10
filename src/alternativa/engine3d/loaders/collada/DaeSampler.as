package alternativa.engine3d.loaders.collada
{
   import alternativa.engine3d.animation.keys.NumberTrack;
   import alternativa.engine3d.animation.keys.Track;
   import alternativa.engine3d.animation.keys.TransformTrack;
   import flash.geom.Matrix3D;
   
   use namespace collada;
   
   public class DaeSampler extends DaeElement
   {
      private var name_G6:Vector.<Number>;
      
      private var values:Vector.<Number>;
      
      private var name_JC:int;
      
      private var name_7i:int;
      
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
         for(var i:int = 0, count:int = int(inputsList.length()); i < count; i++)
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
                     this.name_G6 = inputSource.numbers;
                     this.name_JC = inputSource.stride;
                  }
                  break;
               case "OUTPUT":
                  outputSource = input.prepareSource(1);
                  if(outputSource != null)
                  {
                     this.values = outputSource.numbers;
                     this.name_7i = outputSource.stride;
                  }
                  break;
            }
         }
         return true;
      }
      
      public function parseNumbersTrack(objectName:String, property:String) : NumberTrack
      {
         var track:NumberTrack = null;
         var count:int = 0;
         var i:int = 0;
         if(this.name_G6 != null && this.values != null && this.name_JC > 0)
         {
            track = new NumberTrack(objectName,property);
            count = this.name_G6.length / this.name_JC;
            for(i = 0; i < count; i++)
            {
               track.addKey(this.name_G6[int(this.name_JC * i)],this.values[int(this.name_7i * i)]);
            }
            return track;
         }
         return null;
      }
      
      public function parseTransformationTrack(objectName:String) : Track
      {
         var track:TransformTrack = null;
         var count:int = 0;
         var i:int = 0;
         var index:int = 0;
         var matrix:Matrix3D = null;
         if(this.name_G6 != null && this.values != null && this.name_JC != 0)
         {
            track = new TransformTrack(objectName);
            count = this.name_G6.length / this.name_JC;
            for(i = 0; i < count; i++)
            {
               index = this.name_7i * i;
               matrix = new Matrix3D(Vector.<Number>([this.values[index],this.values[index + 4],this.values[index + 8],this.values[index + 12],this.values[index + 1],this.values[index + 5],this.values[index + 9],this.values[index + 13],this.values[index + 2],this.values[index + 6],this.values[index + 10],this.values[index + 14],this.values[index + 3],this.values[index + 7],this.values[index + 11],this.values[index + 15]]));
               track.addKey(this.name_G6[i * this.name_JC],matrix);
            }
            return track;
         }
         return null;
      }
      
      public function parsePointsTracks(objectName:String, xProperty:String, yProperty:String, zProperty:String) : Vector.<Track>
      {
         var xTrack:NumberTrack = null;
         var yTrack:NumberTrack = null;
         var zTrack:NumberTrack = null;
         var count:int = 0;
         var i:int = 0;
         var index:int = 0;
         var time:Number = NaN;
         if(this.name_G6 != null && this.values != null && this.name_JC != 0)
         {
            xTrack = new NumberTrack(objectName,xProperty);
            xTrack.object = objectName;
            yTrack = new NumberTrack(objectName,yProperty);
            yTrack.object = objectName;
            zTrack = new NumberTrack(objectName,zProperty);
            zTrack.object = objectName;
            count = this.name_G6.length / this.name_JC;
            for(i = 0; i < count; i++)
            {
               index = i * this.name_7i;
               time = this.name_G6[i * this.name_JC];
               xTrack.addKey(time,this.values[index]);
               yTrack.addKey(time,this.values[index + 1]);
               zTrack.addKey(time,this.values[index + 2]);
            }
            return Vector.<Track>([xTrack,yTrack,zTrack]);
         }
         return null;
      }
   }
}

