package package_19
{
   import alternativa.engine3d.alternativa3d;
   import package_21.name_78;
   import package_4.class_4;
   
   use namespace alternativa3d;
   
   public class name_117
   {
      public var material:class_4;
      
      public var indexBegin:int = 0;
      
      public var numTriangles:int = 0;
      
      alternativa3d var object:name_78;
      
      public function name_117()
      {
         super();
      }
      
      public function clone() : name_117
      {
         var res:name_117 = new name_117();
         res.alternativa3d::object = this.alternativa3d::object;
         res.material = this.material;
         res.indexBegin = this.indexBegin;
         res.numTriangles = this.numTriangles;
         return res;
      }
   }
}

