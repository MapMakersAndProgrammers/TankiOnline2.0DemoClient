package alternativa.engine3d.materials.compiler
{
   import alternativa.engine3d.alternativa3d;
   import flash.utils.ByteArray;
   import flash.utils.Endian;
   
   use namespace alternativa3d;
   
   public class Procedure
   {
      public var name:String;
      
      public var byteCode:ByteArray = new ByteArray();
      
      public var name_343:Vector.<Vector.<Variable>> = new Vector.<Vector.<Variable>>();
      
      public var var_177:int = 0;
      
      public var var_176:int = 0;
      
      alternativa3d var name_344:uint = 0;
      
      public function Procedure(array:Array = null, name:String = null)
      {
         super();
         this.byteCode.endian = Endian.LITTLE_ENDIAN;
         this.name = name;
         if(array != null)
         {
            this.compileFromArray(array);
         }
      }
      
      public static function compileFromArray(source:Array, name:String = null) : Procedure
      {
         return new Procedure(source,name);
      }
      
      public static function compileFromString(source:String, name:String = null) : Procedure
      {
         var proc:Procedure = new Procedure(null,name);
         proc.compileFromString(source);
         return proc;
      }
      
      private function addVariableUsage(v:Variable) : void
      {
         var vars:Vector.<Variable> = this.name_343[v.type];
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
      
      public function assignVariableName(type:uint, index:uint, name:String, size:uint = 1) : void
      {
         for(var v:Variable = this.name_343[type][index]; v != null; )
         {
            v.size = size;
            v.name = name;
            v = v.next;
         }
      }
      
      public function compileFromString(source:String) : void
      {
         var commands:Array = source.split("\n");
         this.compileFromArray(commands);
      }
      
      public function compileFromArray(source:Array) : void
      {
         var cmd:String = null;
         var declaration:Array = null;
         var decArray:Array = null;
         var regType:String = null;
         var varIndex:int = 0;
         var varName:String = null;
         for(var i:int = 0; i < 7; i++)
         {
            this.name_343[i] = new Vector.<Variable>();
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
               this.writeCommand(cmd);
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
                  this.assignVariableName(VariableType.ATTRIBUTE,varIndex,varName);
                  break;
               case "c":
                  this.assignVariableName(VariableType.CONSTANT,varIndex,varName);
                  break;
               case "v":
                  this.assignVariableName(VariableType.VARYING,varIndex,varName);
                  break;
               case "s":
                  this.assignVariableName(VariableType.SAMPLER,varIndex,varName);
                  break;
            }
            i++;
         }
      }
      
      public function assignConstantsArray(registersCount:uint = 1) : void
      {
         this.alternativa3d::name_344 = registersCount;
      }
      
      private function writeCommand(source:String) : void
      {
         var destination:Variable = null;
         var source1:SourceVariable = null;
         var source2:Variable = null;
         var type:uint = 0;
         var s2v:SourceVariable = null;
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
            source1 = new SourceVariable(operands[1]);
         }
         else
         {
            destination = new DestinationVariable(operands[1]);
            source1 = new SourceVariable(operands[2]);
            this.addVariableUsage(destination);
         }
         this.addVariableUsage(source1);
         switch(opCode)
         {
            case "mov":
               type = CommandType.MOV;
               ++this.var_177;
               break;
            case "add":
               type = CommandType.ADD;
               source2 = new SourceVariable(operands[3]);
               this.addVariableUsage(source2);
               ++this.var_177;
               break;
            case "sub":
               type = CommandType.SUB;
               source2 = new SourceVariable(operands[3]);
               this.addVariableUsage(source2);
               ++this.var_177;
               break;
            case "mul":
               type = CommandType.MUL;
               source2 = new SourceVariable(operands[3]);
               this.addVariableUsage(source2);
               ++this.var_177;
               break;
            case "div":
               type = CommandType.DIV;
               source2 = new SourceVariable(operands[3]);
               this.addVariableUsage(source2);
               ++this.var_177;
               break;
            case "rcp":
               type = CommandType.RCP;
               ++this.var_177;
               break;
            case "min":
               type = CommandType.MIN;
               source2 = new SourceVariable(operands[3]);
               this.addVariableUsage(source2);
               ++this.var_177;
               break;
            case "max":
               type = CommandType.MAX;
               source2 = new SourceVariable(operands[3]);
               this.addVariableUsage(source2);
               ++this.var_177;
               break;
            case "frc":
               type = CommandType.FRC;
               ++this.var_177;
               break;
            case "sqt":
               type = CommandType.SQT;
               ++this.var_177;
               break;
            case "rsq":
               type = CommandType.RSQ;
               ++this.var_177;
               break;
            case "pow":
               type = CommandType.POW;
               source2 = new SourceVariable(operands[3]);
               this.addVariableUsage(source2);
               this.var_177 += 3;
               break;
            case "log":
               type = CommandType.LOG;
               ++this.var_177;
               break;
            case "exp":
               type = CommandType.EXP;
               ++this.var_177;
               break;
            case "nrm":
               type = CommandType.NRM;
               this.var_177 += 3;
               break;
            case "sin":
               type = CommandType.SIN;
               this.var_177 += 8;
               break;
            case "cos":
               type = CommandType.COS;
               this.var_177 += 8;
               break;
            case "crs":
               type = CommandType.CRS;
               source2 = new SourceVariable(operands[3]);
               this.addVariableUsage(source2);
               this.var_177 += 2;
               break;
            case "dp3":
               type = CommandType.DP3;
               source2 = new SourceVariable(operands[3]);
               this.addVariableUsage(source2);
               ++this.var_177;
               break;
            case "dp4":
               type = CommandType.DP4;
               source2 = new SourceVariable(operands[3]);
               this.addVariableUsage(source2);
               ++this.var_177;
               break;
            case "abs":
               type = CommandType.ABS;
               ++this.var_177;
               break;
            case "neg":
               type = CommandType.NEG;
               ++this.var_177;
               break;
            case "sat":
               type = CommandType.SAT;
               ++this.var_177;
               break;
            case "m33":
               type = CommandType.M33;
               source2 = new SourceVariable(operands[3]);
               this.addVariableUsage(source2);
               this.var_177 += 3;
               break;
            case "m44":
               type = CommandType.M44;
               source2 = new SourceVariable(operands[3]);
               this.addVariableUsage(source2);
               this.var_177 += 4;
               break;
            case "m34":
               type = CommandType.M34;
               source2 = new SourceVariable(operands[3]);
               this.addVariableUsage(source2);
               this.var_177 += 3;
               break;
            case "kil":
               type = CommandType.KIL;
               ++this.var_177;
               break;
            case "tex":
               type = CommandType.TEX;
               source2 = new SamplerVariable(operands[3]);
               this.addVariableUsage(source2);
               ++this.var_177;
               break;
            case "sge":
               type = CommandType.SGE;
               source2 = new SourceVariable(operands[3]);
               this.addVariableUsage(source2);
               ++this.var_177;
               break;
            case "slt":
               type = CommandType.SLT;
               source2 = new SourceVariable(operands[3]);
               this.addVariableUsage(source2);
               ++this.var_177;
         }
         this.byteCode.writeUnsignedInt(type);
         if(destination != null)
         {
            destination.position = this.byteCode.position;
            this.byteCode.writeUnsignedInt(destination.name_345);
         }
         else
         {
            this.byteCode.writeUnsignedInt(0);
         }
         source1.position = this.byteCode.position;
         if(source1.relative != null)
         {
            this.addVariableUsage(source1.relative);
            source1.relative.position = this.byteCode.position;
         }
         this.byteCode.writeUnsignedInt(source1.name_345);
         this.byteCode.writeUnsignedInt(source1.name_346);
         if(source2 != null)
         {
            s2v = source2 as SourceVariable;
            source2.position = this.byteCode.position;
            if(s2v != null && s2v.relative != null)
            {
               this.addVariableUsage(s2v.relative);
               s2v.relative.position = s2v.position;
            }
            this.byteCode.writeUnsignedInt(source2.name_345);
            this.byteCode.writeUnsignedInt(source2.name_346);
         }
         else
         {
            this.byteCode.position = this.byteCode.length = this.byteCode.length + 8;
         }
         ++this.var_176;
      }
      
      public function newInstance() : Procedure
      {
         var res:Procedure = new Procedure();
         res.byteCode = this.byteCode;
         res.name_343 = this.name_343;
         res.var_177 = this.var_177;
         res.alternativa3d::name_344 = this.alternativa3d::name_344;
         res.var_176 = this.var_176;
         res.name = this.name;
         return res;
      }
   }
}

