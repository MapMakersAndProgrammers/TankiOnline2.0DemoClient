package versions.version1.a3d.objects
{
   import commons.Id;
   import versions.version1.a3d.id.ParentId;
   
   public class A3DObject
   {
      private var §_-jD§:Id;
      
      private var §_-16§:Id;
      
      private var §_-3I§:Id;
      
      private var _name:String;
      
      private var §_-fP§:ParentId;
      
      private var §_-eW§:Vector.<A3DSurface>;
      
      private var §_-UJ§:A3DTransformation;
      
      private var §_-1u§:Boolean;
      
      public function A3DObject(boundBoxId:Id, geometryId:Id, id:Id, name:String, parentId:ParentId, surfaces:Vector.<A3DSurface>, transformation:A3DTransformation, visible:Boolean)
      {
         super();
         this.§_-jD§ = boundBoxId;
         this.§_-16§ = geometryId;
         this.§_-3I§ = id;
         this._name = name;
         this.§_-fP§ = parentId;
         this.§_-eW§ = surfaces;
         this.§_-UJ§ = transformation;
         this.§_-1u§ = visible;
      }
      
      public function get boundBoxId() : Id
      {
         return this.§_-jD§;
      }
      
      public function set boundBoxId(value:Id) : void
      {
         this.§_-jD§ = value;
      }
      
      public function get geometryId() : Id
      {
         return this.§_-16§;
      }
      
      public function set geometryId(value:Id) : void
      {
         this.§_-16§ = value;
      }
      
      public function get id() : Id
      {
         return this.§_-3I§;
      }
      
      public function set id(value:Id) : void
      {
         this.§_-3I§ = value;
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
         return this.§_-fP§;
      }
      
      public function set parentId(value:ParentId) : void
      {
         this.§_-fP§ = value;
      }
      
      public function get surfaces() : Vector.<A3DSurface>
      {
         return this.§_-eW§;
      }
      
      public function set surfaces(value:Vector.<A3DSurface>) : void
      {
         this.§_-eW§ = value;
      }
      
      public function get transformation() : A3DTransformation
      {
         return this.§_-UJ§;
      }
      
      public function set transformation(value:A3DTransformation) : void
      {
         this.§_-UJ§ = value;
      }
      
      public function get visible() : Boolean
      {
         return this.§_-1u§;
      }
      
      public function set visible(value:Boolean) : void
      {
         this.§_-1u§ = value;
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

