package package_48
{
   import package_33.name_155;
   
   public class A3D2Decal
   {
      private var var_268:int;
      
      private var var_101:name_155;
      
      private var var_276:int;
      
      private var _name:String;
      
      private var var_285:Number;
      
      private var var_270:name_155;
      
      private var var_92:Vector.<A3D2Surface>;
      
      private var var_262:A3D2Transform;
      
      private var var_277:Vector.<int>;
      
      private var var_267:Boolean;
      
      public function A3D2Decal(boundBoxId:int, id:name_155, indexBufferId:int, name:String, offset:Number, parentId:name_155, surfaces:Vector.<A3D2Surface>, transform:A3D2Transform, vertexBuffers:Vector.<int>, visible:Boolean)
      {
         super();
         this.var_268 = boundBoxId;
         this.var_101 = id;
         this.var_276 = indexBufferId;
         this._name = name;
         this.var_285 = offset;
         this.var_270 = parentId;
         this.var_92 = surfaces;
         this.var_262 = transform;
         this.var_277 = vertexBuffers;
         this.var_267 = visible;
      }
      
      public function get boundBoxId() : int
      {
         return this.var_268;
      }
      
      public function set boundBoxId(value:int) : void
      {
         this.var_268 = value;
      }
      
      public function get id() : name_155
      {
         return this.var_101;
      }
      
      public function set id(value:name_155) : void
      {
         this.var_101 = value;
      }
      
      public function get indexBufferId() : int
      {
         return this.var_276;
      }
      
      public function set indexBufferId(value:int) : void
      {
         this.var_276 = value;
      }
      
      public function get name() : String
      {
         return this._name;
      }
      
      public function set name(value:String) : void
      {
         this._name = value;
      }
      
      public function get offset() : Number
      {
         return this.var_285;
      }
      
      public function set offset(value:Number) : void
      {
         this.var_285 = value;
      }
      
      public function get parentId() : name_155
      {
         return this.var_270;
      }
      
      public function set parentId(value:name_155) : void
      {
         this.var_270 = value;
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
         return this.var_262;
      }
      
      public function set transform(value:A3D2Transform) : void
      {
         this.var_262 = value;
      }
      
      public function get vertexBuffers() : Vector.<int>
      {
         return this.var_277;
      }
      
      public function set vertexBuffers(value:Vector.<int>) : void
      {
         this.var_277 = value;
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
         var result:String = "A3D2Decal [";
         result += "boundBoxId = " + this.boundBoxId + " ";
         result += "id = " + this.id + " ";
         result += "indexBufferId = " + this.indexBufferId + " ";
         result += "name = " + this.name + " ";
         result += "offset = " + this.offset + " ";
         result += "parentId = " + this.parentId + " ";
         result += "surfaces = " + this.surfaces + " ";
         result += "transform = " + this.transform + " ";
         result += "vertexBuffers = " + this.vertexBuffers + " ";
         result += "visible = " + this.visible + " ";
         return result + "]";
      }
   }
}

