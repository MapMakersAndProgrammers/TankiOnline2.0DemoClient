package versions.version2.a3d.objects
{
   import alternativa.types.Long;
   import commons.Id;
   
   public class A3D2Sprite
   {
      private var name_CL:Boolean;
      
      private var name_jD:int;
      
      private var _height:Number;
      
      private var name_3I:Long;
      
      private var name_pS:Id;
      
      private var _name:String;
      
      private var name_4T:Number;
      
      private var name_TP:Number;
      
      private var name_fP:Long;
      
      private var name_2t:Boolean;
      
      private var name_Vd:Number;
      
      private var name_bP:A3D2Transform;
      
      private var name_1u:Boolean;
      
      private var name_qj:Number;
      
      public function A3D2Sprite(alwaysOnTop:Boolean, boundBoxId:int, height:Number, id:Long, materialId:Id, name:String, originX:Number, originY:Number, parentId:Long, perspectiveScale:Boolean, rotation:Number, transform:A3D2Transform, visible:Boolean, width:Number)
      {
         super();
         this.name_CL = alwaysOnTop;
         this.name_jD = boundBoxId;
         this._height = height;
         this.name_3I = id;
         this.name_pS = materialId;
         this._name = name;
         this.name_4T = originX;
         this.name_TP = originY;
         this.name_fP = parentId;
         this.name_2t = perspectiveScale;
         this.name_Vd = rotation;
         this.name_bP = transform;
         this.name_1u = visible;
         this.name_qj = width;
      }
      
      public function get alwaysOnTop() : Boolean
      {
         return this.name_CL;
      }
      
      public function set alwaysOnTop(value:Boolean) : void
      {
         this.name_CL = value;
      }
      
      public function get boundBoxId() : int
      {
         return this.name_jD;
      }
      
      public function set boundBoxId(value:int) : void
      {
         this.name_jD = value;
      }
      
      public function get height() : Number
      {
         return this._height;
      }
      
      public function set height(value:Number) : void
      {
         this._height = value;
      }
      
      public function get id() : Long
      {
         return this.name_3I;
      }
      
      public function set id(value:Long) : void
      {
         this.name_3I = value;
      }
      
      public function get materialId() : Id
      {
         return this.name_pS;
      }
      
      public function set materialId(value:Id) : void
      {
         this.name_pS = value;
      }
      
      public function get name() : String
      {
         return this._name;
      }
      
      public function set name(value:String) : void
      {
         this._name = value;
      }
      
      public function get originX() : Number
      {
         return this.name_4T;
      }
      
      public function set originX(value:Number) : void
      {
         this.name_4T = value;
      }
      
      public function get originY() : Number
      {
         return this.name_TP;
      }
      
      public function set originY(value:Number) : void
      {
         this.name_TP = value;
      }
      
      public function get parentId() : Long
      {
         return this.name_fP;
      }
      
      public function set parentId(value:Long) : void
      {
         this.name_fP = value;
      }
      
      public function get perspectiveScale() : Boolean
      {
         return this.name_2t;
      }
      
      public function set perspectiveScale(value:Boolean) : void
      {
         this.name_2t = value;
      }
      
      public function get rotation() : Number
      {
         return this.name_Vd;
      }
      
      public function set rotation(value:Number) : void
      {
         this.name_Vd = value;
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
      
      public function get width() : Number
      {
         return this.name_qj;
      }
      
      public function set width(value:Number) : void
      {
         this.name_qj = value;
      }
      
      public function toString() : String
      {
         var result:String = "A3D2Sprite [";
         result += "alwaysOnTop = " + this.alwaysOnTop + " ";
         result += "boundBoxId = " + this.boundBoxId + " ";
         result += "height = " + this.height + " ";
         result += "id = " + this.id + " ";
         result += "materialId = " + this.materialId + " ";
         result += "name = " + this.name + " ";
         result += "originX = " + this.originX + " ";
         result += "originY = " + this.originY + " ";
         result += "parentId = " + this.parentId + " ";
         result += "perspectiveScale = " + this.perspectiveScale + " ";
         result += "rotation = " + this.rotation + " ";
         result += "transform = " + this.transform + " ";
         result += "visible = " + this.visible + " ";
         result += "width = " + this.width + " ";
         return result + "]";
      }
   }
}

