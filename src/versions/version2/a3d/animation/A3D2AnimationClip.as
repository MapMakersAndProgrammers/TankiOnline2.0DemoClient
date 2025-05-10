package versions.version2.a3d.animation
{
   import alternativa.types.Long;
   
   public class A3D2AnimationClip
   {
      private var §_-3I§:int;
      
      private var §_-OV§:Boolean;
      
      private var _name:String;
      
      private var §_-Cp§:Vector.<Long>;
      
      private var §_-cT§:Vector.<int>;
      
      public function A3D2AnimationClip(id:int, loop:Boolean, name:String, objectIDs:Vector.<Long>, tracks:Vector.<int>)
      {
         super();
         this.§_-3I§ = id;
         this.§_-OV§ = loop;
         this._name = name;
         this.§_-Cp§ = objectIDs;
         this.§_-cT§ = tracks;
      }
      
      public function get id() : int
      {
         return this.§_-3I§;
      }
      
      public function set id(value:int) : void
      {
         this.§_-3I§ = value;
      }
      
      public function get loop() : Boolean
      {
         return this.§_-OV§;
      }
      
      public function set loop(value:Boolean) : void
      {
         this.§_-OV§ = value;
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
         return this.§_-Cp§;
      }
      
      public function set objectIDs(value:Vector.<Long>) : void
      {
         this.§_-Cp§ = value;
      }
      
      public function get tracks() : Vector.<int>
      {
         return this.§_-cT§;
      }
      
      public function set tracks(value:Vector.<int>) : void
      {
         this.§_-cT§ = value;
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

