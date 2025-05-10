package versions.version2.a3d.objects
{
   import alternativa.types.Long;
   
   public class A3D2DirectionalLight
   {
      private var name_jD:int;
      
      private var name_Tn:uint;
      
      private var name_3I:Long;
      
      private var name_74:Number;
      
      private var _name:String;
      
      private var name_fP:Long;
      
      private var name_bP:A3D2Transform;
      
      private var name_1u:Boolean;
      
      public function A3D2DirectionalLight(boundBoxId:int, color:uint, id:Long, intensity:Number, name:String, parentId:Long, transform:A3D2Transform, visible:Boolean)
      {
         super();
         this.name_jD = boundBoxId;
         this.name_Tn = color;
         this.name_3I = id;
         this.name_74 = intensity;
         this._name = name;
         this.name_fP = parentId;
         this.name_bP = transform;
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
      
      public function get color() : uint
      {
         return this.name_Tn;
      }
      
      public function set color(value:uint) : void
      {
         this.name_Tn = value;
      }
      
      public function get id() : Long
      {
         return this.name_3I;
      }
      
      public function set id(value:Long) : void
      {
         this.name_3I = value;
      }
      
      public function get intensity() : Number
      {
         return this.name_74;
      }
      
      public function set intensity(value:Number) : void
      {
         this.name_74 = value;
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
         return this.name_fP;
      }
      
      public function set parentId(value:Long) : void
      {
         this.name_fP = value;
      }
      
      public function get transform() : A3D2Transform
      {
         return this.name_bP;
      }
      
      public function set transform(value:A3D2Transform) : void
      {
         this.name_bP = value;
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

