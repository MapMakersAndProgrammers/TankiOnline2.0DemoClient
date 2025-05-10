package alternativa.engine3d.loaders.collada
{
   import alternativa.engine3d.alternativa3d;
   import alternativa.engine3d.animation.keys.NumberKey;
   import alternativa.engine3d.animation.keys.NumberTrack;
   import alternativa.engine3d.animation.keys.Track;
   
   use namespace alternativa3d;
   
   public class DaeChannel extends DaeElement
   {
      public static const PARAM_UNDEFINED:String = "undefined";
      
      public static const PARAM_TRANSLATE_X:String = "x";
      
      public static const PARAM_TRANSLATE_Y:String = "y";
      
      public static const PARAM_TRANSLATE_Z:String = "z";
      
      public static const PARAM_SCALE_X:String = "scaleX";
      
      public static const PARAM_SCALE_Y:String = "scaleY";
      
      public static const PARAM_SCALE_Z:String = "scaleZ";
      
      public static const PARAM_ROTATION_X:String = "rotationX";
      
      public static const PARAM_ROTATION_Y:String = "rotationY";
      
      public static const PARAM_ROTATION_Z:String = "rotationZ";
      
      public static const PARAM_TRANSLATE:String = "translate";
      
      public static const PARAM_SCALE:String = "scale";
      
      public static const PARAM_MATRIX:String = "matrix";
      
      public var tracks:Vector.<Track>;
      
      public var §_-dS§:String = "undefined";
      
      public var animName:String;
      
      public function DaeChannel(data:XML, document:DaeDocument)
      {
         super(data,document);
      }
      
      public function get node() : DaeNode
      {
         var targetParts:Array = null;
         var node:DaeNode = null;
         var i:int = 0;
         var count:int = 0;
         var sid:String = null;
         var targetXML:XML = data.@target[0];
         if(targetXML != null)
         {
            targetParts = targetXML.toString().split("/");
            node = document.findNodeByID(targetParts[0]);
            if(node != null)
            {
               targetParts.pop();
               for(i = 1,count = int(targetParts.length); i < count; )
               {
                  sid = targetParts[i];
                  node = node.getNodeBySid(sid);
                  if(node == null)
                  {
                     return null;
                  }
                  i++;
               }
               return node;
            }
         }
         return null;
      }
      
      override protected function parseImplementation() : Boolean
      {
         this.parseTransformationType();
         this.parseSampler();
         return true;
      }
      
      private function parseTransformationType() : void
      {
         var transformationXML:XML = null;
         var child:XML = null;
         var attr:XML = null;
         var componentName:String = null;
         var axis:Array = null;
         var targetXML:XML = data.@target[0];
         if(targetXML == null)
         {
            return;
         }
         var targetParts:Array = targetXML.toString().split("/");
         var sid:String = targetParts.pop();
         var sidParts:Array = sid.split(".");
         var sidPartsCount:int = int(sidParts.length);
         var node:DaeNode = this.node;
         if(node == null)
         {
            return;
         }
         this.animName = node.animName;
         var children:XMLList = node.data.children();
         for(var i:int = 0,var count:int = int(children.length()); i < count; )
         {
            child = children[i];
            attr = child.@sid[0];
            if(attr != null && attr.toString() == sidParts[0])
            {
               transformationXML = child;
               break;
            }
            i++;
         }
         var transformationName:String = transformationXML != null ? transformationXML.localName() as String : null;
         if(sidPartsCount > 1)
         {
            componentName = sidParts[1];
            loop1:
            switch(transformationName)
            {
               case "translate":
                  switch(componentName)
                  {
                     case "X":
                        this.§_-dS§ = PARAM_TRANSLATE_X;
                        break loop1;
                     case "Y":
                        this.§_-dS§ = PARAM_TRANSLATE_Y;
                        break loop1;
                     case "Z":
                        this.§_-dS§ = PARAM_TRANSLATE_Z;
                  }
                  break;
               case "rotate":
                  axis = parseNumbersArray(transformationXML);
                  switch(axis.indexOf(1))
                  {
                     case 0:
                        this.§_-dS§ = PARAM_ROTATION_X;
                        break loop1;
                     case 1:
                        this.§_-dS§ = PARAM_ROTATION_Y;
                        break loop1;
                     case 2:
                        this.§_-dS§ = PARAM_ROTATION_Z;
                  }
                  break;
               case "scale":
                  switch(componentName)
                  {
                     case "X":
                        this.§_-dS§ = PARAM_SCALE_X;
                        break loop1;
                     case "Y":
                        this.§_-dS§ = PARAM_SCALE_Y;
                        break loop1;
                     case "Z":
                        this.§_-dS§ = PARAM_SCALE_Z;
                  }
            }
         }
         else
         {
            switch(transformationName)
            {
               case "translate":
                  this.§_-dS§ = PARAM_TRANSLATE;
                  break;
               case "scale":
                  this.§_-dS§ = PARAM_SCALE;
                  break;
               case "matrix":
                  this.§_-dS§ = PARAM_MATRIX;
            }
         }
      }
      
      private function parseSampler() : void
      {
         var track:NumberTrack = null;
         var toRad:Number = NaN;
         var key:NumberKey = null;
         var sampler:DaeSampler = document.findSampler(data.@source[0]);
         if(sampler != null)
         {
            sampler.parse();
            if(this.§_-dS§ == PARAM_MATRIX)
            {
               this.tracks = Vector.<Track>([sampler.parseTransformationTrack(this.animName)]);
               return;
            }
            if(this.§_-dS§ == PARAM_TRANSLATE)
            {
               this.tracks = sampler.parsePointsTracks(this.animName,"x","y","z");
               return;
            }
            if(this.§_-dS§ == PARAM_SCALE)
            {
               this.tracks = sampler.parsePointsTracks(this.animName,"scaleX","scaleY","scaleZ");
               return;
            }
            if(this.§_-dS§ == PARAM_ROTATION_X || this.§_-dS§ == PARAM_ROTATION_Y || this.§_-dS§ == PARAM_ROTATION_Z)
            {
               track = sampler.parseNumbersTrack(this.animName,this.§_-dS§);
               toRad = Math.PI / 180;
               for(key = track.alternativa3d::_-ku; key != null; key = key.alternativa3d::next)
               {
                  key.alternativa3d::_-4O *= toRad;
               }
               this.tracks = Vector.<Track>([track]);
               return;
            }
            if(this.§_-dS§ == PARAM_TRANSLATE_X || this.§_-dS§ == PARAM_TRANSLATE_Y || this.§_-dS§ == PARAM_TRANSLATE_Z || this.§_-dS§ == PARAM_SCALE_X || this.§_-dS§ == PARAM_SCALE_Y || this.§_-dS§ == PARAM_SCALE_Z)
            {
               this.tracks = Vector.<Track>([sampler.parseNumbersTrack(this.animName,this.§_-dS§)]);
            }
         }
         else
         {
            document.logger.logNotFoundError(data.@source[0]);
         }
      }
   }
}

