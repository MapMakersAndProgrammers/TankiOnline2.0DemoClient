package package_48
{
   import package_33.name_155;
   
   public class A3D2SpotLight
   {
      private var var_266:Number;
      
      private var var_261:Number;
      
      private var var_268:int;
      
      private var var_265:uint;
      
      private var var_263:Number;
      
      private var var_269:Number;
      
      private var var_101:name_155;
      
      private var var_264:Number;
      
      private var _name:String;
      
      private var var_270:name_155;
      
      private var var_262:A3D2Transform;
      
      private var var_267:Boolean;
      
      public function A3D2SpotLight(attenuationBegin:Number, attenuationEnd:Number, boundBoxId:int, color:uint, falloff:Number, hotspot:Number, id:name_155, intensity:Number, name:String, parentId:name_155, transform:A3D2Transform, visible:Boolean)
      {
         super();
         this.var_266 = attenuationBegin;
         this.var_261 = attenuationEnd;
         this.var_268 = boundBoxId;
         this.var_265 = color;
         this.var_263 = falloff;
         this.var_269 = hotspot;
         this.var_101 = id;
         this.var_264 = intensity;
         this._name = name;
         this.var_270 = parentId;
         this.var_262 = transform;
         this.var_267 = visible;
      }
      
      public function get attenuationBegin() : Number
      {
         return this.var_266;
      }
      
      public function set attenuationBegin(value:Number) : void
      {
         this.var_266 = value;
      }
      
      public function get attenuationEnd() : Number
      {
         return this.var_261;
      }
      
      public function set attenuationEnd(value:Number) : void
      {
         this.var_261 = value;
      }
      
      public function get boundBoxId() : int
      {
         return this.var_268;
      }
      
      public function set boundBoxId(value:int) : void
      {
         this.var_268 = value;
      }
      
      public function get color() : uint
      {
         return this.var_265;
      }
      
      public function set color(value:uint) : void
      {
         this.var_265 = value;
      }
      
      public function get falloff() : Number
      {
         return this.var_263;
      }
      
      public function set falloff(value:Number) : void
      {
         this.var_263 = value;
      }
      
      public function get hotspot() : Number
      {
         return this.var_269;
      }
      
      public function set hotspot(value:Number) : void
      {
         this.var_269 = value;
      }
      
      public function get id() : name_155
      {
         return this.var_101;
      }
      
      public function set id(value:name_155) : void
      {
         this.var_101 = value;
      }
      
      public function get intensity() : Number
      {
         return this.var_264;
      }
      
      public function set intensity(value:Number) : void
      {
         this.var_264 = value;
      }
      
      public function get name() : String
      {
         return this._name;
      }
      
      public function set name(value:String) : void
      {
         this._name = value;
      }
      
      public function get parentId() : name_155
      {
         return this.var_270;
      }
      
      public function set parentId(value:name_155) : void
      {
         this.var_270 = value;
      }
      
      public function get transform() : A3D2Transform
      {
         return this.var_262;
      }
      
      public function set transform(value:A3D2Transform) : void
      {
         this.var_262 = value;
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
         var result:String = "A3D2SpotLight [";
         result += "attenuationBegin = " + this.attenuationBegin + " ";
         result += "attenuationEnd = " + this.attenuationEnd + " ";
         result += "boundBoxId = " + this.boundBoxId + " ";
         result += "color = " + this.color + " ";
         result += "falloff = " + this.falloff + " ";
         result += "hotspot = " + this.hotspot + " ";
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

