package versions.version1.a3d.objects
{
   import commons.Id;
   import versions.version1.a3d.id.ParentId;
   
   public class A3DObject
   {
      private var var_270:Id;
      
      private var var_335:Id;
      
      private var var_101:Id;
      
      private var _name:String;
      
      private var var_269:ParentId;
      
      private var var_92:Vector.<A3DSurface>;
      
      private var var_336:A3DTransformation;
      
      private var var_261:Boolean;
      
      public function A3DObject(boundBoxId:Id, geometryId:Id, id:Id, name:String, parentId:ParentId, surfaces:Vector.<A3DSurface>, transformation:A3DTransformation, visible:Boolean)
      {
         super();
         this.var_270 = boundBoxId;
         this.var_335 = geometryId;
         this.var_101 = id;
         this._name = name;
         this.var_269 = parentId;
         this.var_92 = surfaces;
         this.var_336 = transformation;
         this.var_261 = visible;
      }
      
      public function get boundBoxId() : Id
      {
         return this.var_270;
      }
      
      public function set boundBoxId(value:Id) : void
      {
         this.var_270 = value;
      }
      
      public function get geometryId() : Id
      {
         return this.var_335;
      }
      
      public function set geometryId(value:Id) : void
      {
         this.var_335 = value;
      }
      
      public function get id() : Id
      {
         return this.var_101;
      }
      
      public function set id(value:Id) : void
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
      
      public function get parentId() : ParentId
      {
         return this.var_269;
      }
      
      public function set parentId(value:ParentId) : void
      {
         this.var_269 = value;
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
         return this.var_336;
      }
      
      public function set transformation(value:A3DTransformation) : void
      {
         this.var_336 = value;
      }
      
      public function get visible() : Boolean
      {
         return this.var_261;
      }
      
      public function set visible(value:Boolean) : void
      {
         this.var_261 = value;
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

