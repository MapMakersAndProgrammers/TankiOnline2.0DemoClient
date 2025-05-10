package versions.version2.a3d.objects
{
   import alternativa.types.Long;
   
   public class A3D2Skin
   {
      private var §_-jD§:int;
      
      private var §_-3I§:Long;
      
      private var §_-Hc§:int;
      
      private var §_-KB§:Vector.<A3D2JointBindTransform>;
      
      private var §_-26§:Vector.<Long>;
      
      private var _name:String;
      
      private var §_-Dr§:Vector.<uint>;
      
      private var §_-fP§:Long;
      
      private var §_-eW§:Vector.<A3D2Surface>;
      
      private var §_-bP§:A3D2Transform;
      
      private var §_-0B§:Vector.<int>;
      
      private var §_-1u§:Boolean;
      
      public function A3D2Skin(boundBoxId:int, id:Long, indexBufferId:int, jointBindTransforms:Vector.<A3D2JointBindTransform>, joints:Vector.<Long>, name:String, numJoints:Vector.<uint>, parentId:Long, surfaces:Vector.<A3D2Surface>, transform:A3D2Transform, vertexBuffers:Vector.<int>, visible:Boolean)
      {
         super();
         this.§_-jD§ = boundBoxId;
         this.§_-3I§ = id;
         this.§_-Hc§ = indexBufferId;
         this.§_-KB§ = jointBindTransforms;
         this.§_-26§ = joints;
         this._name = name;
         this.§_-Dr§ = numJoints;
         this.§_-fP§ = parentId;
         this.§_-eW§ = surfaces;
         this.§_-bP§ = transform;
         this.§_-0B§ = vertexBuffers;
         this.§_-1u§ = visible;
      }
      
      public function get boundBoxId() : int
      {
         return this.§_-jD§;
      }
      
      public function set boundBoxId(value:int) : void
      {
         this.§_-jD§ = value;
      }
      
      public function get id() : Long
      {
         return this.§_-3I§;
      }
      
      public function set id(value:Long) : void
      {
         this.§_-3I§ = value;
      }
      
      public function get indexBufferId() : int
      {
         return this.§_-Hc§;
      }
      
      public function set indexBufferId(value:int) : void
      {
         this.§_-Hc§ = value;
      }
      
      public function get jointBindTransforms() : Vector.<A3D2JointBindTransform>
      {
         return this.§_-KB§;
      }
      
      public function set jointBindTransforms(value:Vector.<A3D2JointBindTransform>) : void
      {
         this.§_-KB§ = value;
      }
      
      public function get joints() : Vector.<Long>
      {
         return this.§_-26§;
      }
      
      public function set joints(value:Vector.<Long>) : void
      {
         this.§_-26§ = value;
      }
      
      public function get name() : String
      {
         return this._name;
      }
      
      public function set name(value:String) : void
      {
         this._name = value;
      }
      
      public function get numJoints() : Vector.<uint>
      {
         return this.§_-Dr§;
      }
      
      public function set numJoints(value:Vector.<uint>) : void
      {
         this.§_-Dr§ = value;
      }
      
      public function get parentId() : Long
      {
         return this.§_-fP§;
      }
      
      public function set parentId(value:Long) : void
      {
         this.§_-fP§ = value;
      }
      
      public function get surfaces() : Vector.<A3D2Surface>
      {
         return this.§_-eW§;
      }
      
      public function set surfaces(value:Vector.<A3D2Surface>) : void
      {
         this.§_-eW§ = value;
      }
      
      public function get transform() : A3D2Transform
      {
         return this.§_-bP§;
      }
      
      public function set transform(value:A3D2Transform) : void
      {
         this.§_-bP§ = value;
      }
      
      public function get vertexBuffers() : Vector.<int>
      {
         return this.§_-0B§;
      }
      
      public function set vertexBuffers(value:Vector.<int>) : void
      {
         this.§_-0B§ = value;
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
         var result:String = "A3D2Skin [";
         result += "boundBoxId = " + this.boundBoxId + " ";
         result += "id = " + this.id + " ";
         result += "indexBufferId = " + this.indexBufferId + " ";
         result += "jointBindTransforms = " + this.jointBindTransforms + " ";
         result += "joints = " + this.joints + " ";
         result += "name = " + this.name + " ";
         result += "numJoints = " + this.numJoints + " ";
         result += "parentId = " + this.parentId + " ";
         result += "surfaces = " + this.surfaces + " ";
         result += "transform = " + this.transform + " ";
         result += "vertexBuffers = " + this.vertexBuffers + " ";
         result += "visible = " + this.visible + " ";
         return result + "]";
      }
   }
}

