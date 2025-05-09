package alternativa.engine3d.materials
{
   import alternativa.engine3d.materials.compiler.Linker;
   import flash.display3D.Context3D;
   import flash.display3D.Program3D;
   
   public class ShaderProgram
   {
      public var program:Program3D;
      
      public var vertexShader:Linker;
      
      public var fragmentShader:Linker;
      
      public function ShaderProgram(vertexShader:Linker, fragmentShader:Linker)
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
               this.program.upload(this.vertexShader.getByteCode(),this.fragmentShader.getByteCode());
            }
            catch(e:Error)
            {
               trace(A3DUtils.disassemble(fragmentShader.getByteCode()));
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

