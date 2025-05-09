package versions.version2.a3d.geometry
{
   public class A3D2VertexAttributes
   {
      public static const POSITION:A3D2VertexAttributes = new A3D2VertexAttributes(0);
      
      public static const NORMAL:A3D2VertexAttributes = new A3D2VertexAttributes(1);
      
      public static const TANGENT4:A3D2VertexAttributes = new A3D2VertexAttributes(2);
      
      public static const JOINT:A3D2VertexAttributes = new A3D2VertexAttributes(3);
      
      public static const TEXCOORD:A3D2VertexAttributes = new A3D2VertexAttributes(4);
      
      public var value:int;
      
      public function A3D2VertexAttributes(value:int)
      {
         super();
         this.value = value;
      }
      
      public function toString() : String
      {
         var result:String = "A3D2VertexAttributes [";
         if(this.value == 0)
         {
            result += "POSITION";
         }
         if(this.value == 1)
         {
            result += "NORMAL";
         }
         if(this.value == 2)
         {
            result += "TANGENT4";
         }
         if(this.value == 3)
         {
            result += "JOINT";
         }
         if(this.value == 4)
         {
            result += "TEXCOORD";
         }
         return result + "]";
      }
   }
}

