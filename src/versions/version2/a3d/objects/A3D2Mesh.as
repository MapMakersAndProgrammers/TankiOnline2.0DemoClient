package versions.version2.a3d.objects
{
   import alternativa.types.Long;
   
   public class A3D2Mesh
   {
      private var var_270:int;
      
      private var var_101:Long;
      
      private var var_277:int;
      
      private var _name:String;
      
      private var var_269:Long;
      
      private var var_92:Vector.<A3D2Surface>;
      
      private var var_268:A3D2Transform;
      
      private var var_276:Vector.<int>;
      
      private var var_261:Boolean;
      
      public function A3D2Mesh(boundBoxId:int, id:Long, indexBufferId:int, name:String, parentId:Long, surfaces:Vector.<A3D2Surface>, transform:A3D2Transform, vertexBuffers:Vector.<int>, visible:Boolean)
      {
         super();
         this.var_270 = boundBoxId;
         this.var_101 = id;
         this.var_277 = indexBufferId;
         this._name = name;
         this.var_269 = parentId;
         this.var_92 = surfaces;
         this.var_268 = transform;
         this.var_276 = vertexBuffers;
         this.var_261 = visible;
      }
      
      public function get boundBoxId() : int
      {
         return this.var_270;
      }
      
      public function set boundBoxId(value:int) : void
      {
         this.var_270 = value;
      }
      
      public function get id() : Long
      {
         return this.var_101;
      }
      
      public function set id(value:Long) : void
      {
         this.var_101 = value;
      }
      
      public function get indexBufferId() : int
      {
         return this.var_277;
      }
      
      public function set indexBufferId(value:int) : void
      {
         this.var_277 = value;
      }
      
      public function get name() : String
      {
         return this._name;
      }
      
      public function set name(value:String) : void
      {
         this._name = value;
      }
      
      public function get parentId() : Long
      {
         return this.var_269;
      }
      
      public function set parentId(value:Long) : void
      {
         this.var_269 = value;
      }
      
      public function get surfaces() : Vector.<A3D2Surface>
      {
         return this.var_92;
      }
      
      public function set surfaces(value:Vector.<A3D2Surface>) : void
      {
         this.var_92 = value;
      }
      
      public function get transform() : A3D2Transform
      {
         return this.var_268;
      }
      
      public function set transform(value:A3D2Transform) : void
      {
         this.var_268 = value;
      }
      
      public function get vertexBuffers() : Vector.<int>
      {
         return this.var_276;
      }
      
      public function set vertexBuffers(value:Vector.<int>) : void
      {
         this.var_276 = value;
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
         var result:String = "A3D2Mesh [";
         result += "boundBoxId = " + this.boundBoxId + " ";
         result += "id = " + this.id + " ";
         result += "indexBufferId = " + this.indexBufferId + " ";
         result += "name = " + this.name + " ";
         result += "parentId = " + this.parentId + " ";
         result += "surfaces = " + this.surfaces + " ";
         result += "transform = " + this.transform + " ";
         result += "vertexBuffers = " + this.vertexBuffers + " ";
         result += "visible = " + this.visible + " ";
         return result + "]";
      }
   }
}

