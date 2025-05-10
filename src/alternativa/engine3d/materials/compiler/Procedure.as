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
      
      public var §_-d2§:Vector.<Vector.<Variable>> = new Vector.<Vector.<Variable>>();
      
      public var §_-RT§:int = 0;
      
      public var §_-A§:int = 0;
      
      alternativa3d var §_-in§:uint = 0;
      
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
         var vars:Vector.<Variable> = this.§_-d2§[v.type];
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
         for(var v:Variable = this.§_-d2§[type][index]; v != null; )
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
            this.§_-d2§[i] = new Vector.<Variable>();
         }
         this.byteCode.length = 0;
         this.§_-A§ = 0;
         this.§_-RT§ = 0;
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
         this.alternativa3d::_-in = registersCount;
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
               ++this.§_-RT§;
               break;
            case "add":
               type = CommandType.ADD;
               source2 = new SourceVariable(operands[3]);
               this.addVariableUsage(source2);
               ++this.§_-RT§;
               break;
            case "sub":
               type = CommandType.SUB;
               source2 = new SourceVariable(operands[3]);
               this.addVariableUsage(source2);
               ++this.§_-RT§;
               break;
            case "mul":
               type = CommandType.MUL;
               source2 = new SourceVariable(operands[3]);
               this.addVariableUsage(source2);
               ++this.§_-RT§;
               break;
            case "div":
               type = CommandType.DIV;
               source2 = new SourceVariable(operands[3]);
               this.addVariableUsage(source2);
               ++this.§_-RT§;
               break;
            case "rcp":
               type = CommandType.RCP;
               ++this.§_-RT§;
               break;
            case "min":
               type = CommandType.MIN;
               source2 = new SourceVariable(operands[3]);
               this.addVariableUsage(source2);
               ++this.§_-RT§;
               break;
            case "max":
               type = CommandType.MAX;
               source2 = new SourceVariable(operands[3]);
               this.addVariableUsage(source2);
               ++this.§_-RT§;
               break;
            case "frc":
               type = CommandType.FRC;
               ++this.§_-RT§;
               break;
            case "sqt":
               type = CommandType.SQT;
               ++this.§_-RT§;
               break;
            case "rsq":
               type = CommandType.RSQ;
               ++this.§_-RT§;
               break;
            case "pow":
               type = CommandType.POW;
               source2 = new SourceVariable(operands[3]);
               this.addVariableUsage(source2);
               this.§_-RT§ += 3;
               break;
            case "log":
               type = CommandType.LOG;
               ++this.§_-RT§;
               break;
            case "exp":
               type = CommandType.EXP;
               ++this.§_-RT§;
               break;
            case "nrm":
               type = CommandType.NRM;
               this.§_-RT§ += 3;
               break;
            case "sin":
               type = CommandType.SIN;
               this.§_-RT§ += 8;
               break;
            case "cos":
               type = CommandType.COS;
               this.§_-RT§ += 8;
               break;
            case "crs":
               type = CommandType.CRS;
               source2 = new SourceVariable(operands[3]);
               this.addVariableUsage(source2);
               this.§_-RT§ += 2;
               break;
            case "dp3":
               type = CommandType.DP3;
               source2 = new SourceVariable(operands[3]);
               this.addVariableUsage(source2);
               ++this.§_-RT§;
               break;
            case "dp4":
               type = CommandType.DP4;
               source2 = new SourceVariable(operands[3]);
               this.addVariableUsage(source2);
               ++this.§_-RT§;
               break;
            case "abs":
               type = CommandType.ABS;
               ++this.§_-RT§;
               break;
            case "neg":
               type = CommandType.NEG;
               ++this.§_-RT§;
               break;
            case "sat":
               type = CommandType.SAT;
               ++this.§_-RT§;
               break;
            case "m33":
               type = CommandType.M33;
               source2 = new SourceVariable(operands[3]);
               this.addVariableUsage(source2);
               this.§_-RT§ += 3;
               break;
            case "m44":
               type = CommandType.M44;
               source2 = new SourceVariable(operands[3]);
               this.addVariableUsage(source2);
               this.§_-RT§ += 4;
               break;
            case "m34":
               type = CommandType.M34;
               source2 = new SourceVariable(operands[3]);
               this.addVariableUsage(source2);
               this.§_-RT§ += 3;
               break;
            case "kil":
               type = CommandType.KIL;
               ++this.§_-RT§;
               break;
            case "tex":
               type = CommandType.TEX;
               source2 = new SamplerVariable(operands[3]);
               this.addVariableUsage(source2);
               ++this.§_-RT§;
               break;
            case "sge":
               type = CommandType.SGE;
               source2 = new SourceVariable(operands[3]);
               this.addVariableUsage(source2);
               ++this.§_-RT§;
               break;
            case "slt":
               type = CommandType.SLT;
               source2 = new SourceVariable(operands[3]);
               this.addVariableUsage(source2);
               ++this.§_-RT§;
         }
         this.byteCode.writeUnsignedInt(type);
         if(destination != null)
         {
            destination.position = this.byteCode.position;
            this.byteCode.writeUnsignedInt(destination.§_-0J§);
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
         this.byteCode.writeUnsignedInt(source1.§_-0J§);
         this.byteCode.writeUnsignedInt(source1.§_-oc§);
         if(source2 != null)
         {
            s2v = source2 as SourceVariable;
            source2.position = this.byteCode.position;
            if(s2v != null && s2v.relative != null)
            {
               this.addVariableUsage(s2v.relative);
               s2v.relative.position = s2v.position;
            }
            this.byteCode.writeUnsignedInt(source2.§_-0J§);
            this.byteCode.writeUnsignedInt(source2.§_-oc§);
         }
         else
         {
            this.byteCode.position = this.byteCode.length = this.byteCode.length + 8;
         }
         ++this.§_-A§;
      }
      
      public function newInstance() : Procedure
      {
         var res:Procedure = new Procedure();
         res.byteCode = this.byteCode;
         res.§_-d2§ = this.§_-d2§;
         res.§_-RT§ = this.§_-RT§;
         res.alternativa3d::_-in = this.alternativa3d::_-in;
         res.§_-A§ = this.§_-A§;
         res.name = this.name;
         return res;
      }
   }
}

