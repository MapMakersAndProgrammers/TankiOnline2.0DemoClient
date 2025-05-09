package versions.version2.a3d.objects
{
   import alternativa.types.Long;
   
   public class A3D2DirectionalLight
   {
      private var var_270:int;
      
      private var var_266:uint;
      
      private var var_101:Long;
      
      private var var_262:Number;
      
      private var _name:String;
      
      private var var_269:Long;
      
      private var var_268:A3D2Transform;
      
      private var var_261:Boolean;
      
      public function A3D2DirectionalLight(boundBoxId:int, color:uint, id:Long, intensity:Number, name:String, parentId:Long, transform:A3D2Transform, visible:Boolean)
      {
         super();
         this.var_270 = boundBoxId;
         this.var_266 = color;
         this.var_101 = id;
         this.var_262 = intensity;
         this._name = name;
         this.var_269 = parentId;
         this.var_268 = transform;
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
      
      public function get color() : uint
      {
         return this.var_266;
      }
      
      public function set color(value:uint) : void
      {
         this.var_266 = value;
      }
      
      public function get id() : Long
      {
         return this.var_101;
      }
      
      public function set id(value:Long) : void
      {
         this.var_101 = value;
      }
      
      public function get intensity() : Number
      {
         return this.var_262;
      }
      
      public function set intensity(value:Number) : void
      {
         this.var_262 = value;
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
      
      public function get transform() : A3D2Transform
      {
         return this.var_268;
      }
      
      public function set transform(value:A3D2Transform) : void
      {
         this.var_268 = value;
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
         var result:String = "A3D2DirectionalLight [";
         result += "boundBoxId = " + this.boundBoxId + " ";
         result += "color = " + this.color + " ";
         result += "id = " + this.id + " ";
         result += "intensity = " + this.intensity + " ";
         result += "name = " + this.name + " ";
         result += "parentId = " + this.parentId + " ";
         result += "transform = " + this.transform + " ";
         result += "visible = " + this.visible + " ";
         return result + "]";
      }
   }
}

