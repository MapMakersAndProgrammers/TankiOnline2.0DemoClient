package alternativa.engine3d.loaders.collada
{
   import alternativa.engine3d.animation.keys.§_-Np§;
   import alternativa.engine3d.animation.keys.§_-ew§;
   import alternativa.engine3d.animation.keys.§_-kB§;
   import flash.geom.Matrix3D;
   
   use namespace collada;
   
   public class DaeSampler extends DaeElement
   {
      private var §_-G6§:Vector.<Number>;
      
      private var values:Vector.<Number>;
      
      private var §_-JC§:int;
      
      private var §_-7i§:int;
      
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
                     this.§_-G6§ = inputSource.numbers;
                     this.§_-JC§ = inputSource.stride;
                  }
                  break;
               case "OUTPUT":
                  outputSource = input.prepareSource(1);
                  if(outputSource != null)
                  {
                     this.values = outputSource.numbers;
                     this.§_-7i§ = outputSource.stride;
                  }
                  break;
            }
         }
         return true;
      }
      
      public function parseNumbersTrack(objectName:String, property:String) : §_-kB§
      {
         var track:§_-kB§ = null;
         var count:int = 0;
         var i:int = 0;
         if(this.§_-G6§ != null && this.values != null && this.§_-JC§ > 0)
         {
            track = new §_-kB§(objectName,property);
            count = this.§_-G6§.length / this.§_-JC§;
            for(i = 0; i < count; i++)
            {
               track.addKey(this.§_-G6§[int(this.§_-JC§ * i)],this.values[int(this.§_-7i§ * i)]);
            }
            return track;
         }
         return null;
      }
      
      public function parseTransformationTrack(objectName:String) : §_-Np§
      {
         var track:§_-ew§ = null;
         var count:int = 0;
         var i:int = 0;
         var index:int = 0;
         var matrix:Matrix3D = null;
         if(this.§_-G6§ != null && this.values != null && this.§_-JC§ != 0)
         {
            track = new §_-ew§(objectName);
            count = this.§_-G6§.length / this.§_-JC§;
            for(i = 0; i < count; i++)
            {
               index = this.§_-7i§ * i;
               matrix = new Matrix3D(Vector.<Number>([this.values[index],this.values[index + 4],this.values[index + 8],this.values[index + 12],this.values[index + 1],this.values[index + 5],this.values[index + 9],this.values[index + 13],this.values[index + 2],this.values[index + 6],this.values[index + 10],this.values[index + 14],this.values[index + 3],this.values[index + 7],this.values[index + 11],this.values[index + 15]]));
               track.addKey(this.§_-G6§[i * this.§_-JC§],matrix);
            }
            return track;
         }
         return null;
      }
      
      public function parsePointsTracks(objectName:String, xProperty:String, yProperty:String, zProperty:String) : Vector.<§_-Np§>
      {
         var xTrack:§_-kB§ = null;
         var yTrack:§_-kB§ = null;
         var zTrack:§_-kB§ = null;
         var count:int = 0;
         var i:int = 0;
         var index:int = 0;
         var time:Number = NaN;
         if(this.§_-G6§ != null && this.values != null && this.§_-JC§ != 0)
         {
            xTrack = new §_-kB§(objectName,xProperty);
            xTrack.object = objectName;
            yTrack = new §_-kB§(objectName,yProperty);
            yTrack.object = objectName;
            zTrack = new §_-kB§(objectName,zProperty);
            zTrack.object = objectName;
            count = this.§_-G6§.length / this.§_-JC§;
            for(i = 0; i < count; i++)
            {
               index = i * this.§_-7i§;
               time = this.§_-G6§[i * this.§_-JC§];
               xTrack.addKey(time,this.values[index]);
               yTrack.addKey(time,this.values[index + 1]);
               zTrack.addKey(time,this.values[index + 2]);
            }
            return Vector.<§_-Np§>([xTrack,yTrack,zTrack]);
         }
         return null;
      }
   }
}

