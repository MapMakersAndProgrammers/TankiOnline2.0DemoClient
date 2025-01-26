package package_123
{
   import alternativa.engine3d.alternativa3d;
   import package_125.name_709;
   import package_125.name_760;
   import package_125.name_778;
   
   use namespace alternativa3d;
   
   public class name_742 extends class_43
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
      
      public var tracks:Vector.<name_709>;
      
      public var name_756:String = "undefined";
      
      public var method_872:String;
      
      public function name_742(data:XML, document:name_707)
      {
         super(data,document);
      }
      
      public function get node() : name_706
      {
         var targetParts:Array = null;
         var node:name_706 = null;
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
         this.method_895();
         this.method_894();
         return true;
      }
      
      private function method_895() : void
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
         var node:name_706 = this.node;
         if(node == null)
         {
            return;
         }
         this.method_872 = node.method_872;
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
                        this.name_756 = PARAM_TRANSLATE_X;
                        break loop1;
                     case "Y":
                        this.name_756 = PARAM_TRANSLATE_Y;
                        break loop1;
                     case "Z":
                        this.name_756 = PARAM_TRANSLATE_Z;
                  }
                  break;
               case "rotate":
                  axis = method_866(transformationXML);
                  switch(axis.indexOf(1))
                  {
                     case 0:
                        this.name_756 = PARAM_ROTATION_X;
                        break loop1;
                     case 1:
                        this.name_756 = PARAM_ROTATION_Y;
                        break loop1;
                     case 2:
                        this.name_756 = PARAM_ROTATION_Z;
                  }
                  break;
               case "scale":
                  switch(componentName)
                  {
                     case "X":
                        this.name_756 = PARAM_SCALE_X;
                        break loop1;
                     case "Y":
                        this.name_756 = PARAM_SCALE_Y;
                        break loop1;
                     case "Z":
                        this.name_756 = PARAM_SCALE_Z;
                  }
            }
         }
         else
         {
            switch(transformationName)
            {
               case "translate":
                  this.name_756 = PARAM_TRANSLATE;
                  break;
               case "scale":
                  this.name_756 = PARAM_SCALE;
                  break;
               case "matrix":
                  this.name_756 = PARAM_MATRIX;
            }
         }
      }
      
      private function method_894() : void
      {
         var track:name_760 = null;
         var toRad:Number = NaN;
         var key:name_778 = null;
         var sampler:name_739 = document.findSampler(data.@source[0]);
         if(sampler != null)
         {
            sampler.method_314();
            if(this.name_756 == PARAM_MATRIX)
            {
               this.tracks = Vector.<name_709>([sampler.name_782(this.method_872)]);
               return;
            }
            if(this.name_756 == PARAM_TRANSLATE)
            {
               this.tracks = sampler.name_779(this.method_872,"x","y","z");
               return;
            }
            if(this.name_756 == PARAM_SCALE)
            {
               this.tracks = sampler.name_779(this.method_872,"scaleX","scaleY","scaleZ");
               return;
            }
            if(this.name_756 == PARAM_ROTATION_X || this.name_756 == PARAM_ROTATION_Y || this.name_756 == PARAM_ROTATION_Z)
            {
               track = sampler.name_780(this.method_872,this.name_756);
               toRad = Math.PI / 180;
               for(key = track.alternativa3d::name_783; key != null; key = key.alternativa3d::next)
               {
                  key.alternativa3d::name_781 *= toRad;
               }
               this.tracks = Vector.<name_709>([track]);
               return;
            }
            if(this.name_756 == PARAM_TRANSLATE_X || this.name_756 == PARAM_TRANSLATE_Y || this.name_756 == PARAM_TRANSLATE_Z || this.name_756 == PARAM_SCALE_X || this.name_756 == PARAM_SCALE_Y || this.name_756 == PARAM_SCALE_Z)
            {
               this.tracks = Vector.<name_709>([sampler.name_780(this.method_872,this.name_756)]);
            }
         }
         else
         {
            document.logger.logNotFoundError(data.@source[0]);
         }
      }
   }
}

