package versions.version2.a3d.animation
{
   import alternativa.types.Long;
   
   public class A3D2AnimationClip
   {
      private var var_101:int;
      
      private var var_388:Boolean;
      
      private var _name:String;
      
      private var var_387:Vector.<Long>;
      
      private var var_389:Vector.<int>;
      
      public function A3D2AnimationClip(id:int, loop:Boolean, name:String, objectIDs:Vector.<Long>, tracks:Vector.<int>)
      {
         super();
         this.var_101 = id;
         this.var_388 = loop;
         this._name = name;
         this.var_387 = objectIDs;
         this.var_389 = tracks;
      }
      
      public function get id() : int
      {
         return this.var_101;
      }
      
      public function set id(value:int) : void
      {
         this.var_101 = value;
      }
      
      public function get loop() : Boolean
      {
         return this.var_388;
      }
      
      public function set loop(value:Boolean) : void
      {
         this.var_388 = value;
      }
      
      public function get name() : String
      {
         return this._name;
      }
      
      public function set name(value:String) : void
      {
         this._name = value;
      }
      
      public function get objectIDs() : Vector.<Long>
      {
         return this.var_387;
      }
      
      public function set objectIDs(value:Vector.<Long>) : void
      {
         this.var_387 = value;
      }
      
      public function get tracks() : Vector.<int>
      {
         return this.var_389;
      }
      
      public function set tracks(value:Vector.<int>) : void
      {
         this.var_389 = value;
      }
      
      public function toString() : String
      {
         var result:String = "A3D2AnimationClip [";
         result += "id = " + this.id + " ";
         result += "loop = " + this.loop + " ";
         result += "name = " + this.name + " ";
         result += "objectIDs = " + this.objectIDs + " ";
         result += "tracks = " + this.tracks + " ";
         return result + "]";
      }
   }
}

