package package_50
{
   import package_57.name_213;
   import package_64.name_212;
   
   public class A3DObject
   {
      private var var_268:name_213;
      
      private var var_336:name_213;
      
      private var var_101:name_213;
      
      private var _name:String;
      
      private var var_270:name_212;
      
      private var var_92:Vector.<A3DSurface>;
      
      private var var_335:A3DTransformation;
      
      private var var_267:Boolean;
      
      public function A3DObject(boundBoxId:name_213, geometryId:name_213, id:name_213, name:String, parentId:name_212, surfaces:Vector.<A3DSurface>, transformation:A3DTransformation, visible:Boolean)
      {
         super();
         this.var_268 = boundBoxId;
         this.var_336 = geometryId;
         this.var_101 = id;
         this._name = name;
         this.var_270 = parentId;
         this.var_92 = surfaces;
         this.var_335 = transformation;
         this.var_267 = visible;
      }
      
      public function get boundBoxId() : name_213
      {
         return this.var_268;
      }
      
      public function set boundBoxId(value:name_213) : void
      {
         this.var_268 = value;
      }
      
      public function get geometryId() : name_213
      {
         return this.var_336;
      }
      
      public function set geometryId(value:name_213) : void
      {
         this.var_336 = value;
      }
      
      public function get id() : name_213
      {
         return this.var_101;
      }
      
      public function set id(value:name_213) : void
      {
         this.var_101 = value;
      }
      
      public function get name() : String
      {
         return this._name;
      }
      
      public function set name(value:String) : void
      {
         this._name = value;
      }
      
      public function get parentId() : name_212
      {
         return this.var_270;
      }
      
      public function set parentId(value:name_212) : void
      {
         this.var_270 = value;
      }
      
      public function get surfaces() : Vector.<A3DSurface>
      {
         return this.var_92;
      }
      
      public function set surfaces(value:Vector.<A3DSurface>) : void
      {
         this.var_92 = value;
      }
      
      public function get transformation() : A3DTransformation
      {
         return this.var_335;
      }
      
      public function set transformation(value:A3DTransformation) : void
      {
         this.var_335 = value;
      }
      
      public function get visible() : Boolean
      {
         return this.var_267;
      }
      
      public function set visible(value:Boolean) : void
      {
         this.var_267 = value;
      }
      
      public function toString() : String
      {
         var result:String = "A3DObject [";
         result += "boundBoxId = " + this.boundBoxId + " ";
         result += "geometryId = " + this.geometryId + " ";
         result += "id = " + this.id + " ";
         result += "name = " + this.name + " ";
         result += "parentId = " + this.parentId + " ";
         result += "surfaces = " + this.surfaces + " ";
         result += "transformation = " + this.transformation + " ";
         result += "visible = " + this.visible + " ";
         return result + "]";
      }
   }
}

