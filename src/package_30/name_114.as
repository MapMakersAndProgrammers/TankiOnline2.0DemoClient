package package_30
{
   import alternativa.engine3d.alternativa3d;
   import flash.utils.ByteArray;
   import flash.utils.Endian;
   
   use namespace alternativa3d;
   
   public class name_114
   {
      public var name:String;
      
      public var byteCode:ByteArray = new ByteArray();
      
      public var name_435:Vector.<Vector.<name_434>> = new Vector.<Vector.<name_434>>();
      
      public var var_177:int = 0;
      
      public var var_176:int = 0;
      
      alternativa3d var name_436:uint = 0;
      
      public function name_114(array:Array = null, name:String = null)
      {
         super();
         this.byteCode.endian = Endian.LITTLE_ENDIAN;
         this.name = name;
         if(array != null)
         {
            this.name_140(array);
         }
      }
      
      public static function name_140(source:Array, name:String = null) : name_114
      {
         return new name_114(source,name);
      }
      
      public static function method_288(source:String, name:String = null) : name_114
      {
         var proc:name_114 = new name_114(null,name);
         proc.method_288(source);
         return proc;
      }
      
      private function method_287(v:name_434) : void
      {
         var vars:Vector.<name_434> = this.name_435[v.type];
         var index:int = v.index;
         if(index >= vars.length)
         {
            vars.length = index + 1;
         }
         else
         {
            v.next = vars[index];
         }
         vars[index] = v;
      }
      
      public function name_122(type:uint, index:uint, name:String, size:uint = 1) : void
      {
         for(var v:name_434 = this.name_435[type][index]; v != null; )
         {
            v.size = size;
            v.name = name;
            v = v.next;
         }
      }
      
      public function method_288(source:String) : void
      {
         var commands:Array = source.split("\n");
         this.name_140(commands);
      }
      
      public function name_140(source:Array) : void
      {
         var cmd:String = null;
         var declaration:Array = null;
         var decArray:Array = null;
         var regType:String = null;
         var varIndex:int = 0;
         var varName:String = null;
         for(var i:int = 0; i < 7; i++)
         {
            this.name_435[i] = new Vector.<name_434>();
         }
         this.byteCode.length = 0;
         this.var_176 = 0;
         this.var_177 = 0;
         var declarationStrings:Vector.<String> = new Vector.<String>();
         var count:int = int(source.length);
         for(i = 0; i < count; i++)
         {
            cmd = source[i];
            declaration = cmd.match(/# *[acvs]\d{1,3} *= *[a-zA-Z0-9_]*/i);
            if(declaration != null && declaration.length > 0)
            {
               declarationStrings.push(declaration[0]);
            }
            else
            {
               this.method_289(cmd);
            }
         }
         for(i = 0,count = int(declarationStrings.length); i < count; )
         {
            decArray = declarationStrings[i].split("=");
            regType = decArray[0].match(/[acvs]/i);
            varIndex = int(int(decArray[0].match(/\d{1,3}/i)));
            varName = decArray[1].match(/[a-zA-Z0-9]*/i);
            switch(regType.toLowerCase())
            {
               case "a":
                  this.name_122(name_115.ATTRIBUTE,varIndex,varName);
                  break;
               case "c":
                  this.name_122(name_115.CONSTANT,varIndex,varName);
                  break;
               case "v":
                  this.name_122(name_115.VARYING,varIndex,varName);
                  break;
               case "s":
                  this.name_122(name_115.SAMPLER,varIndex,varName);
                  break;
            }
            i++;
         }
      }
      
      public function method_290(registersCount:uint = 1) : void
      {
         this.alternativa3d::name_436 = registersCount;
      }
      
      private function method_289(source:String) : void
      {
         var destination:name_434 = null;
         var source1:name_437 = null;
         var source2:name_434 = null;
         var type:uint = 0;
         var s2v:name_437 = null;
         var commentIndex:int = int(source.indexOf("//"));
         if(commentIndex >= 0)
         {
            source = source.substr(0,commentIndex);
         }
         var operands:Array = source.match(/[A-Za-z]+(((\[.+\])|(\d+))(\.[xyzw]{1,4})?(\ *\<.*>)?)?/g);
         if(operands.length < 2)
         {
            return;
         }
         var opCode:String = operands[0];
         if(opCode == "kil")
         {
            source1 = new name_437(operands[1]);
         }
         else
         {
            destination = new name_440(operands[1]);
            source1 = new name_437(operands[2]);
            this.method_287(destination);
         }
         this.method_287(source1);
         switch(opCode)
         {
            case "mov":
               type = name_168.MOV;
               ++this.var_177;
               break;
            case "add":
               type = name_168.ADD;
               source2 = new name_437(operands[3]);
               this.method_287(source2);
               ++this.var_177;
               break;
            case "sub":
               type = name_168.SUB;
               source2 = new name_437(operands[3]);
               this.method_287(source2);
               ++this.var_177;
               break;
            case "mul":
               type = name_168.MUL;
               source2 = new name_437(operands[3]);
               this.method_287(source2);
               ++this.var_177;
               break;
            case "div":
               type = name_168.DIV;
               source2 = new name_437(operands[3]);
               this.method_287(source2);
               ++this.var_177;
               break;
            case "rcp":
               type = name_168.RCP;
               ++this.var_177;
               break;
            case "min":
               type = name_168.MIN;
               source2 = new name_437(operands[3]);
               this.method_287(source2);
               ++this.var_177;
               break;
            case "max":
               type = name_168.MAX;
               source2 = new name_437(operands[3]);
               this.method_287(source2);
               ++this.var_177;
               break;
            case "frc":
               type = name_168.FRC;
               ++this.var_177;
               break;
            case "sqt":
               type = name_168.SQT;
               ++this.var_177;
               break;
            case "rsq":
               type = name_168.RSQ;
               ++this.var_177;
               break;
            case "pow":
               type = name_168.POW;
               source2 = new name_437(operands[3]);
               this.method_287(source2);
               this.var_177 += 3;
               break;
            case "log":
               type = name_168.LOG;
               ++this.var_177;
               break;
            case "exp":
               type = name_168.EXP;
               ++this.var_177;
               break;
            case "nrm":
               type = name_168.NRM;
               this.var_177 += 3;
               break;
            case "sin":
               type = name_168.SIN;
               this.var_177 += 8;
               break;
            case "cos":
               type = name_168.COS;
               this.var_177 += 8;
               break;
            case "crs":
               type = name_168.CRS;
               source2 = new name_437(operands[3]);
               this.method_287(source2);
               this.var_177 += 2;
               break;
            case "dp3":
               type = name_168.DP3;
               source2 = new name_437(operands[3]);
               this.method_287(source2);
               ++this.var_177;
               break;
            case "dp4":
               type = name_168.DP4;
               source2 = new name_437(operands[3]);
               this.method_287(source2);
               ++this.var_177;
               break;
            case "abs":
               type = name_168.ABS;
               ++this.var_177;
               break;
            case "neg":
               type = name_168.NEG;
               ++this.var_177;
               break;
            case "sat":
               type = name_168.SAT;
               ++this.var_177;
               break;
            case "m33":
               type = name_168.M33;
               source2 = new name_437(operands[3]);
               this.method_287(source2);
               this.var_177 += 3;
               break;
            case "m44":
               type = name_168.M44;
               source2 = new name_437(operands[3]);
               this.method_287(source2);
               this.var_177 += 4;
               break;
            case "m34":
               type = name_168.M34;
               source2 = new name_437(operands[3]);
               this.method_287(source2);
               this.var_177 += 3;
               break;
            case "kil":
               type = name_168.KIL;
               ++this.var_177;
               break;
            case "tex":
               type = name_168.TEX;
               source2 = new name_441(operands[3]);
               this.method_287(source2);
               ++this.var_177;
               break;
            case "sge":
               type = name_168.SGE;
               source2 = new name_437(operands[3]);
               this.method_287(source2);
               ++this.var_177;
               break;
            case "slt":
               type = name_168.SLT;
               source2 = new name_437(operands[3]);
               this.method_287(source2);
               ++this.var_177;
         }
         this.byteCode.writeUnsignedInt(type);
         if(destination != null)
         {
            destination.position = this.byteCode.position;
            this.byteCode.writeUnsignedInt(destination.name_438);
         }
         else
         {
            this.byteCode.writeUnsignedInt(0);
         }
         source1.position = this.byteCode.position;
         if(source1.relative != null)
         {
            this.method_287(source1.relative);
            source1.relative.position = this.byteCode.position;
         }
         this.byteCode.writeUnsignedInt(source1.name_438);
         this.byteCode.writeUnsignedInt(source1.name_439);
         if(source2 != null)
         {
            s2v = source2 as name_437;
            source2.position = this.byteCode.position;
            if(s2v != null && s2v.relative != null)
            {
               this.method_287(s2v.relative);
               s2v.relative.position = s2v.position;
            }
            this.byteCode.writeUnsignedInt(source2.name_438);
            this.byteCode.writeUnsignedInt(source2.name_439);
         }
         else
         {
            this.byteCode.position = this.byteCode.length = this.byteCode.length + 8;
         }
         ++this.var_176;
      }
      
      public function name_143() : name_114
      {
         var res:name_114 = new name_114();
         res.byteCode = this.byteCode;
         res.name_435 = this.name_435;
         res.var_177 = this.var_177;
         res.alternativa3d::name_436 = this.alternativa3d::name_436;
         res.var_176 = this.var_176;
         res.name = this.name;
         return res;
      }
   }
}

