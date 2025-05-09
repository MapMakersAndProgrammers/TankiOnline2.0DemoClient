package versions.version2.a3d.objects
{
   import alternativa.types.Long;
   import commons.Id;
   
   public class A3D2Sprite
   {
      private var §_-CL§:Boolean;
      
      private var §_-jD§:int;
      
      private var _height:Number;
      
      private var §_-3I§:Long;
      
      private var §_-pS§:Id;
      
      private var _name:String;
      
      private var §_-4T§:Number;
      
      private var §_-TP§:Number;
      
      private var §_-fP§:Long;
      
      private var §_-2t§:Boolean;
      
      private var §_-Vd§:Number;
      
      private var §_-bP§:A3D2Transform;
      
      private var §_-1u§:Boolean;
      
      private var §_-qj§:Number;
      
      public function A3D2Sprite(alwaysOnTop:Boolean, boundBoxId:int, height:Number, id:Long, materialId:Id, name:String, originX:Number, originY:Number, parentId:Long, perspectiveScale:Boolean, rotation:Number, transform:A3D2Transform, visible:Boolean, width:Number)
      {
         super();
         this.§_-CL§ = alwaysOnTop;
         this.§_-jD§ = boundBoxId;
         this._height = height;
         this.§_-3I§ = id;
         this.§_-pS§ = materialId;
         this._name = name;
         this.§_-4T§ = originX;
         this.§_-TP§ = originY;
         this.§_-fP§ = parentId;
         this.§_-2t§ = perspectiveScale;
         this.§_-Vd§ = rotation;
         this.§_-bP§ = transform;
         this.§_-1u§ = visible;
         this.§_-qj§ = width;
      }
      
      public function get alwaysOnTop() : Boolean
      {
         return this.§_-CL§;
      }
      
      public function set alwaysOnTop(value:Boolean) : void
      {
         this.§_-CL§ = value;
      }
      
      public function get boundBoxId() : int
      {
         return this.§_-jD§;
      }
      
      public function set boundBoxId(value:int) : void
      {
         this.§_-jD§ = value;
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
         return this.§_-3I§;
      }
      
      public function set id(value:Long) : void
      {
         this.§_-3I§ = value;
      }
      
      public function get materialId() : Id
      {
         return this.§_-pS§;
      }
      
      public function set materialId(value:Id) : void
      {
         this.§_-pS§ = value;
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
         return this.§_-4T§;
      }
      
      public function set originX(value:Number) : void
      {
         this.§_-4T§ = value;
      }
      
      public function get originY() : Number
      {
         return this.§_-TP§;
      }
      
      public function set originY(value:Number) : void
      {
         this.§_-TP§ = value;
      }
      
      public function get parentId() : Long
      {
         return this.§_-fP§;
      }
      
      public function set parentId(value:Long) : void
      {
         this.§_-fP§ = value;
      }
      
      public function get perspectiveScale() : Boolean
      {
         return this.§_-2t§;
      }
      
      public function set perspectiveScale(value:Boolean) : void
      {
         this.§_-2t§ = value;
      }
      
      public function get rotation() : Number
      {
         return this.§_-Vd§;
      }
      
      public function set rotation(value:Number) : void
      {
         this.§_-Vd§ = value;
      }
      
      public function get transform() : A3D2Transform
      {
         return this.§_-bP§;
      }
      
      public function set transform(value:A3D2Transform) : void
      {
         this.§_-bP§ = value;
      }
      
      public function get visible() : Boolean
      {
         return this.§_-1u§;
      }
      
      public function set visible(value:Boolean) : void
      {
         this.§_-1u§ = value;
      }
      
      public function get width() : Number
      {
         return this.§_-qj§;
      }
      
      public function set width(value:Number) : void
      {
         this.§_-qj§ = value;
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

