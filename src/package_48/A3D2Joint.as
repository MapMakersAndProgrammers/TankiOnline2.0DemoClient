package package_48
{
   import package_33.name_155;
   
   public class A3D2Joint
   {
      private var var_268:int;
      
      private var var_101:name_155;
      
      private var _name:String;
      
      private var var_270:name_155;
      
      private var var_262:A3D2Transform;
      
      private var var_267:Boolean;
      
      public function A3D2Joint(boundBoxId:int, id:name_155, name:String, parentId:name_155, transform:A3D2Transform, visible:Boolean)
      {
         super();
         this.var_268 = boundBoxId;
         this.var_101 = id;
         this._name = name;
         this.var_270 = parentId;
         this.var_262 = transform;
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
         var result:String = "A3D2Joint [";
         result += "boundBoxId = " + this.boundBoxId + " ";
         result += "id = " + this.id + " ";
         result += "name = " + this.name + " ";
         result += "parentId = " + this.parentId + " ";
         result += "transform = " + this.transform + " ";
         result += "visible = " + this.visible + " ";
         return result + "]";
      }
   }
}

