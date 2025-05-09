package versions.version2.a3d.objects
{
   import alternativa.types.Long;
   import commons.Id;
   
   public class A3D2Sprite
   {
      private var var_376:Boolean;
      
      private var var_270:int;
      
      private var _height:Number;
      
      private var var_101:Long;
      
      private var var_301:Id;
      
      private var _name:String;
      
      private var var_375:Number;
      
      private var var_377:Number;
      
      private var var_269:Long;
      
      private var var_374:Boolean;
      
      private var var_378:Number;
      
      private var var_268:A3D2Transform;
      
      private var var_261:Boolean;
      
      private var var_110:Number;
      
      public function A3D2Sprite(alwaysOnTop:Boolean, boundBoxId:int, height:Number, id:Long, materialId:Id, name:String, originX:Number, originY:Number, parentId:Long, perspectiveScale:Boolean, rotation:Number, transform:A3D2Transform, visible:Boolean, width:Number)
      {
         super();
         this.var_376 = alwaysOnTop;
         this.var_270 = boundBoxId;
         this._height = height;
         this.var_101 = id;
         this.var_301 = materialId;
         this._name = name;
         this.var_375 = originX;
         this.var_377 = originY;
         this.var_269 = parentId;
         this.var_374 = perspectiveScale;
         this.var_378 = rotation;
         this.var_268 = transform;
         this.var_261 = visible;
         this.var_110 = width;
      }
      
      public function get alwaysOnTop() : Boolean
      {
         return this.var_376;
      }
      
      public function set alwaysOnTop(value:Boolean) : void
      {
         this.var_376 = value;
      }
      
      public function get boundBoxId() : int
      {
         return this.var_270;
      }
      
      public function set boundBoxId(value:int) : void
      {
         this.var_270 = value;
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
         return this.var_101;
      }
      
      public function set id(value:Long) : void
      {
         this.var_101 = value;
      }
      
      public function get materialId() : Id
      {
         return this.var_301;
      }
      
      public function set materialId(value:Id) : void
      {
         this.var_301 = value;
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
         return this.var_375;
      }
      
      public function set originX(value:Number) : void
      {
         this.var_375 = value;
      }
      
      public function get originY() : Number
      {
         return this.var_377;
      }
      
      public function set originY(value:Number) : void
      {
         this.var_377 = value;
      }
      
      public function get parentId() : Long
      {
         return this.var_269;
      }
      
      public function set parentId(value:Long) : void
      {
         this.var_269 = value;
      }
      
      public function get perspectiveScale() : Boolean
      {
         return this.var_374;
      }
      
      public function set perspectiveScale(value:Boolean) : void
      {
         this.var_374 = value;
      }
      
      public function get rotation() : Number
      {
         return this.var_378;
      }
      
      public function set rotation(value:Number) : void
      {
         this.var_378 = value;
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
      
      public function get width() : Number
      {
         return this.var_110;
      }
      
      public function set width(value:Number) : void
      {
         this.var_110 = value;
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

