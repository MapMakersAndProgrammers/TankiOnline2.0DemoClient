package versions.version2.a3d.objects
{
   import alternativa.types.Long;
   
   public class A3D2Skin
   {
      private var name_jD:int;
      
      private var name_3I:Long;
      
      private var name_Hc:int;
      
      private var name_KB:Vector.<A3D2JointBindTransform>;
      
      private var name_26:Vector.<Long>;
      
      private var _name:String;
      
      private var name_Dr:Vector.<uint>;
      
      private var name_fP:Long;
      
      private var name_eW:Vector.<A3D2Surface>;
      
      private var name_bP:A3D2Transform;
      
      private var name_0B:Vector.<int>;
      
      private var name_1u:Boolean;
      
      public function A3D2Skin(boundBoxId:int, id:Long, indexBufferId:int, jointBindTransforms:Vector.<A3D2JointBindTransform>, joints:Vector.<Long>, name:String, numJoints:Vector.<uint>, parentId:Long, surfaces:Vector.<A3D2Surface>, transform:A3D2Transform, vertexBuffers:Vector.<int>, visible:Boolean)
      {
         super();
         this.name_jD = boundBoxId;
         this.name_3I = id;
         this.name_Hc = indexBufferId;
         this.name_KB = jointBindTransforms;
         this.name_26 = joints;
         this._name = name;
         this.name_Dr = numJoints;
         this.name_fP = parentId;
         this.name_eW = surfaces;
         this.name_bP = transform;
         this.name_0B = vertexBuffers;
         this.name_1u = visible;
      }
      
      public function get boundBoxId() : int
      {
         return this.name_jD;
      }
      
      public function set boundBoxId(value:int) : void
      {
         this.name_jD = value;
      }
      
      public function get id() : Long
      {
         return this.name_3I;
      }
      
      public function set id(value:Long) : void
      {
         this.name_3I = value;
      }
      
      public function get indexBufferId() : int
      {
         return this.name_Hc;
      }
      
      public function set indexBufferId(value:int) : void
      {
         this.name_Hc = value;
      }
      
      public function get jointBindTransforms() : Vector.<A3D2JointBindTransform>
      {
         return this.name_KB;
      }
      
      public function set jointBindTransforms(value:Vector.<A3D2JointBindTransform>) : void
      {
         this.name_KB = value;
      }
      
      public function get joints() : Vector.<Long>
      {
         return this.name_26;
      }
      
      public function set joints(value:Vector.<Long>) : void
      {
         this.name_26 = value;
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
         return this.name_Dr;
      }
      
      public function set numJoints(value:Vector.<uint>) : void
      {
         this.name_Dr = value;
      }
      
      public function get parentId() : Long
      {
         return this.name_fP;
      }
      
      public function set parentId(value:Long) : void
      {
         this.name_fP = value;
      }
      
      public function get surfaces() : Vector.<A3D2Surface>
      {
         return this.name_eW;
      }
      
      public function set surfaces(value:Vector.<A3D2Surface>) : void
      {
         this.name_eW = value;
      }
      
      public function get transform() : A3D2Transform
      {
         return this.name_bP;
      }
      
      public function set transform(value:A3D2Transform) : void
      {
         this.name_bP = value;
      }
      
      public function get vertexBuffers() : Vector.<int>
      {
         return this.name_0B;
      }
      
      public function set vertexBuffers(value:Vector.<int>) : void
      {
         this.name_0B = value;
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

