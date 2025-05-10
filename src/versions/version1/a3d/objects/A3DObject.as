package versions.version1.a3d.objects
{
   import commons.Id;
   import versions.version1.a3d.id.ParentId;
   
   public class A3DObject
   {
      private var name_jD:Id;
      
      private var name_16:Id;
      
      private var name_3I:Id;
      
      private var _name:String;
      
      private var name_fP:ParentId;
      
      private var name_eW:Vector.<A3DSurface>;
      
      private var name_UJ:A3DTransformation;
      
      private var name_1u:Boolean;
      
      public function A3DObject(boundBoxId:Id, geometryId:Id, id:Id, name:String, parentId:ParentId, surfaces:Vector.<A3DSurface>, transformation:A3DTransformation, visible:Boolean)
      {
         super();
         this.name_jD = boundBoxId;
         this.name_16 = geometryId;
         this.name_3I = id;
         this._name = name;
         this.name_fP = parentId;
         this.name_eW = surfaces;
         this.name_UJ = transformation;
         this.name_1u = visible;
      }
      
      public function get boundBoxId() : Id
      {
         return this.name_jD;
      }
      
      public function set boundBoxId(value:Id) : void
      {
         this.name_jD = value;
      }
      
      public function get geometryId() : Id
      {
         return this.name_16;
      }
      
      public function set geometryId(value:Id) : void
      {
         this.name_16 = value;
      }
      
      public function get id() : Id
      {
         return this.name_3I;
      }
      
      public function set id(value:Id) : void
      {
         this.name_3I = value;
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
         return this.name_fP;
      }
      
      public function set parentId(value:ParentId) : void
      {
         this.name_fP = value;
      }
      
      public function get surfaces() : Vector.<A3DSurface>
      {
         return this.name_eW;
      }
      
      public function set surfaces(value:Vector.<A3DSurface>) : void
      {
         this.name_eW = value;
      }
      
      public function get transformation() : A3DTransformation
      {
         return this.name_UJ;
      }
      
      public function set transformation(value:A3DTransformation) : void
      {
         this.name_UJ = value;
      }
      
      public function get visible() : Boolean
      {
         return this.name_1u;
      }
      
      public function set visible(value:Boolean) : void
      {
         this.name_1u = value;
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

