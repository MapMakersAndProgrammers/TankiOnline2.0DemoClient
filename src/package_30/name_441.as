package package_30
{
   import flash.utils.ByteArray;
   
   public class name_441 extends name_434
   {
      public function name_441(source:String)
      {
         var opts:Array = null;
         var op:String = null;
         super();
         var strType:String = String(source.match(/[si]/g)[0]);
         switch(strType)
         {
            case "s":
               name_439 = name_115.SAMPLER;
               break;
            case "i":
               name_439 = name_115.INPUT;
         }
         index = parseInt(source.match(/\d+/g)[0],10);
         name_438 = index;
         var optsi:int = int(source.search(/<.*>/g));
         if(optsi != -1)
         {
            opts = source.substring(optsi).match(/(\w+)/g);
         }
         type = name_439;
         var optsLength:uint = uint(opts.length);
         for(var i:int = 0; i < optsLength; )
         {
            op = opts[i];
            switch(op)
            {
               case "2d":
                  name_439 &= ~0xF000;
                  break;
               case "3d":
                  name_439 &= ~0xF000;
                  name_439 |= 8192;
                  break;
               case "cube":
                  name_439 &= ~0xF000;
                  name_439 |= 4096;
                  break;
               case "mipnearest":
                  name_439 &= ~0x0F000000;
                  name_439 |= 16777216;
                  break;
               case "miplinear":
                  name_439 &= ~0x0F000000;
                  name_439 |= 33554432;
                  break;
               case "mipnone":
               case "nomip":
                  name_439 &= ~0x0F000000;
                  break;
               case "nearest":
                  name_439 &= ~4026531840;
                  break;
               case "linear":
                  name_439 &= ~4026531840;
                  name_439 |= 268435456;
                  break;
               case "centroid":
                  name_439 |= 4294967296;
                  break;
               case "single":
                  name_439 |= 8589934592;
                  break;
               case "depth":
                  name_439 |= 17179869184;
                  break;
               case "repeat":
               case "wrap":
                  name_439 &= ~0xF00000;
                  name_439 |= 1048576;
                  break;
               case "clamp":
                  name_439 &= ~0xF00000;
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

