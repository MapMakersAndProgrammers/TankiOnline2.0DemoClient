package versions.version2.a3d.objects
{
   import alternativa.types.Long;
   
   public class A3D2DirectionalLight
   {
      private var §_-jD§:int;
      
      private var §_-Tn§:uint;
      
      private var §_-3I§:Long;
      
      private var §_-74§:Number;
      
      private var _name:String;
      
      private var §_-fP§:Long;
      
      private var §_-bP§:A3D2Transform;
      
      private var §_-1u§:Boolean;
      
      public function A3D2DirectionalLight(boundBoxId:int, color:uint, id:Long, intensity:Number, name:String, parentId:Long, transform:A3D2Transform, visible:Boolean)
      {
         super();
         this.§_-jD§ = boundBoxId;
         this.§_-Tn§ = color;
         this.§_-3I§ = id;
         this.§_-74§ = intensity;
         this._name = name;
         this.§_-fP§ = parentId;
         this.§_-bP§ = transform;
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
      
      public function get color() : uint
      {
         return this.§_-Tn§;
      }
      
      public function set color(value:uint) : void
      {
         this.§_-Tn§ = value;
      }
      
      public function get id() : Long
      {
         return this.§_-3I§;
      }
      
      public function set id(value:Long) : void
      {
         this.§_-3I§ = value;
      }
      
      public function get intensity() : Number
      {
         return this.§_-74§;
      }
      
      public function set intensity(value:Number) : void
      {
         this.§_-74§ = value;
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
         return this.§_-fP§;
      }
      
      public function set parentId(value:Long) : void
      {
         this.§_-fP§ = value;
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

