package alternativa.engine3d.materials.compiler
{
   import flash.utils.ByteArray;
   
   public class SamplerVariable extends Variable
   {
      public function SamplerVariable(source:String)
      {
         var opts:Array = null;
         var op:String = null;
         super();
         var strType:String = String(source.match(/[si]/g)[0]);
         switch(strType)
         {
            case "s":
               name_346 = VariableType.SAMPLER;
               break;
            case "i":
               name_346 = VariableType.INPUT;
         }
         index = parseInt(source.match(/\d+/g)[0],10);
         name_345 = index;
         var optsi:int = int(source.search(/<.*>/g));
         if(optsi != -1)
         {
            opts = source.substring(optsi).match(/(\w+)/g);
         }
         type = name_346;
         var optsLength:uint = uint(opts.length);
         for(var i:int = 0; i < optsLength; )
         {
            op = opts[i];
            switch(op)
            {
               case "2d":
                  name_346 &= ~0xF000;
                  break;
               case "3d":
                  name_346 &= ~0xF000;
                  name_346 |= 8192;
                  break;
               case "cube":
                  name_346 &= ~0xF000;
                  name_346 |= 4096;
                  break;
               case "mipnearest":
                  name_346 &= ~0x0F000000;
                  name_346 |= 16777216;
                  break;
               case "miplinear":
                  name_346 &= ~0x0F000000;
                  name_346 |= 33554432;
                  break;
               case "mipnone":
               case "nomip":
                  name_346 &= ~0x0F000000;
                  break;
               case "nearest":
                  name_346 &= ~4026531840;
                  break;
               case "linear":
                  name_346 &= ~4026531840;
                  name_346 |= 268435456;
                  break;
               case "centroid":
                  name_346 |= 4294967296;
                  break;
               case "single":
                  name_346 |= 8589934592;
                  break;
               case "depth":
                  name_346 |= 17179869184;
                  break;
               case "repeat":
               case "wrap":
                  name_346 &= ~0xF00000;
                  name_346 |= 1048576;
                  break;
               case "clamp":
                  name_346 &= ~0xF00000;
                  break;
            }
            i++;
         }
      }
      
      override public function writeToByteArray(byteCode:ByteArray, newIndex:int, newType:int) : void
      {
         super.writeToByteArray(byteCode,newIndex,newType);
         byteCode.position = position + 4;
      }
   }
}

