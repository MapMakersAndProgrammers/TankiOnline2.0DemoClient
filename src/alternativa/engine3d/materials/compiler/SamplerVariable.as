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
               §_-oc§ = VariableType.SAMPLER;
               break;
            case "i":
               §_-oc§ = VariableType.INPUT;
         }
         index = parseInt(source.match(/\d+/g)[0],10);
         §_-0J§ = index;
         var optsi:int = int(source.search(/<.*>/g));
         if(optsi != -1)
         {
            opts = source.substring(optsi).match(/(\w+)/g);
         }
         type = §_-oc§;
         var optsLength:uint = uint(opts.length);
         for(var i:int = 0; i < optsLength; )
         {
            op = opts[i];
            switch(op)
            {
               case "2d":
                  §_-oc§ &= ~0xF000;
                  break;
               case "3d":
                  §_-oc§ &= ~0xF000;
                  §_-oc§ |= 8192;
                  break;
               case "cube":
                  §_-oc§ &= ~0xF000;
                  §_-oc§ |= 4096;
                  break;
               case "mipnearest":
                  §_-oc§ &= ~0x0F000000;
                  §_-oc§ |= 16777216;
                  break;
               case "miplinear":
                  §_-oc§ &= ~0x0F000000;
                  §_-oc§ |= 33554432;
                  break;
               case "mipnone":
               case "nomip":
                  §_-oc§ &= ~0x0F000000;
                  break;
               case "nearest":
                  §_-oc§ &= ~4026531840;
                  break;
               case "linear":
                  §_-oc§ &= ~4026531840;
                  §_-oc§ |= 268435456;
                  break;
               case "centroid":
                  §_-oc§ |= 4294967296;
                  break;
               case "single":
                  §_-oc§ |= 8589934592;
                  break;
               case "depth":
                  §_-oc§ |= 17179869184;
                  break;
               case "repeat":
               case "wrap":
                  §_-oc§ &= ~0xF00000;
                  §_-oc§ |= 1048576;
                  break;
               case "clamp":
                  §_-oc§ &= ~0xF00000;
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

