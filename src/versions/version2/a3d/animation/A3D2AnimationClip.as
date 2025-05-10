package versions.version2.a3d.animation
{
   import alternativa.types.Long;
   
   public class A3D2AnimationClip
   {
      private var name_3I:int;
      
      private var name_OV:Boolean;
      
      private var _name:String;
      
      private var name_Cp:Vector.<Long>;
      
      private var name_cT:Vector.<int>;
      
      public function A3D2AnimationClip(id:int, loop:Boolean, name:String, objectIDs:Vector.<Long>, tracks:Vector.<int>)
      {
         super();
         this.name_3I = id;
         this.name_OV = loop;
         this._name = name;
         this.name_Cp = objectIDs;
         this.name_cT = tracks;
      }
      
      public function get id() : int
      {
         return this.name_3I;
      }
      
      public function set id(value:int) : void
      {
         this.name_3I = value;
      }
      
      public function get loop() : Boolean
      {
         return this.name_OV;
      }
      
      public function set loop(value:Boolean) : void
      {
         this.name_OV = value;
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
         return this.name_Cp;
      }
      
      public function set objectIDs(value:Vector.<Long>) : void
      {
         this.name_Cp = value;
      }
      
      public function get tracks() : Vector.<int>
      {
         return this.name_cT;
      }
      
      public function set tracks(value:Vector.<int>) : void
      {
         this.name_cT = value;
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

