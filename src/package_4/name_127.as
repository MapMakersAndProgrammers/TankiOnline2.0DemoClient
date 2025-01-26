package package_4
{
   import flash.display3D.Context3D;
   import flash.display3D.Program3D;
   import package_30.name_121;
   
   public class name_127
   {
      public var program:Program3D;
      
      public var vertexShader:name_121;
      
      public var fragmentShader:name_121;
      
      public function name_127(vertexShader:name_121, fragmentShader:name_121)
      {
         super();
         this.vertexShader = vertexShader;
         this.fragmentShader = fragmentShader;
      }
      
      public function upload(context3D:Context3D) : void
      {
         if(this.program != null)
         {
            this.program.dispose();
         }
         if(this.vertexShader != null && this.fragmentShader != null)
         {
            this.program = context3D.createProgram();
            try
            {
               this.program.upload(this.vertexShader.name_206(),this.fragmentShader.name_206());
            }
            catch(e:Error)
            {
               trace(name_28.method_98(fragmentShader.name_206()));
               throw e;
            }
         }
         else
         {
            this.program = null;
         }
      }
      
      public function dispose() : void
      {
         if(this.program != null)
         {
            this.program.dispose();
            this.program = null;
         }
      }
   }
}

