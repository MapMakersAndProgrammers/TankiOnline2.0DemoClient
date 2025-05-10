package alternativa.engine3d.materials.compiler
{
   import alternativa.engine3d.alternativa3d;
   import flash.display3D.Context3DProgramType;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   import flash.utils.Endian;
   
   use namespace alternativa3d;
   
   public class Linker
   {
      public var name_RT:int = 0;
      
      public var name_A:int = 0;
      
      public var type:String;
      
      private var name_2L:Vector.<Procedure> = new Vector.<Procedure>();
      
      private var name_RU:ByteArray = new ByteArray();
      
      private var name_8Z:Boolean;
      
      alternativa3d var name_3r:Object;
      
      private var name_c:Object = new Object();
      
      private var name_T1:Linker;
      
      private var name_W8:Dictionary = new Dictionary();
      
      private var name_f:Dictionary = new Dictionary();
      
      private var name_Jf:Vector.<uint> = new Vector.<uint>(6,true);
      
      public function Linker(programType:String)
      {
         super();
         this.name_RU.endian = Endian.LITTLE_ENDIAN;
         this.type = programType;
         this.name_RU.writeByte(160);
         this.name_RU.writeUnsignedInt(1);
         this.name_RU.writeByte(161);
         this.name_RU.writeByte(programType == Context3DProgramType.FRAGMENT ? 1 : 0);
      }
      
      public function clear() : void
      {
         this.name_RU.length = 7;
         this.name_Jf[0] = this.name_Jf[1] = this.name_Jf[2] = this.name_Jf[3] = this.name_Jf[4] = this.name_Jf[5] = 0;
         this.name_2L.length = 0;
         this.name_8Z = false;
         this.name_A = 0;
         this.name_RT = 0;
         this.name_3r = null;
         this.name_W8 = new Dictionary();
         this.name_f = new Dictionary();
      }
      
      public function addProcedure(procedure:Procedure) : void
      {
         this.name_8Z = true;
         this.name_2L.push(procedure);
      }
      
      public function declareVariable(name:String, type:uint = 2) : void
      {
         var v:Variable = null;
         v = new Variable();
         v.index = -1;
         v.type = type;
         v.name = name;
         this.name_c[name] = v;
      }
      
      public function setInputParams(procedure:Procedure, ... args) : void
      {
         this.name_W8[procedure] = args;
      }
      
      public function setOutputParams(procedure:Procedure, ... args) : void
      {
         this.name_f[procedure] = args;
      }
      
      public function getVariableIndex(name:String) : int
      {
         if(this.name_8Z)
         {
            this.link();
         }
         var variable:Variable = this.name_3r[name];
         if(variable == null)
         {
            throw new Error("Variable \"" + name + "\" not found");
         }
         return variable.index;
      }
      
      public function findVariable(name:String) : int
      {
         if(this.name_8Z)
         {
            this.link();
         }
         var variable:Variable = this.name_3r[name];
         if(variable == null)
         {
            return -1;
         }
         return variable.index;
      }
      
      public function containsVariable(name:String) : Boolean
      {
         if(this.name_8Z)
         {
            this.link();
         }
         return this.name_3r[name] != null;
      }
      
      public function getByteCode() : ByteArray
      {
         if(this.name_8Z)
         {
            this.link();
         }
         return this.name_RU;
      }
      
      public function setOppositeLinker(linker:Linker) : void
      {
         this.name_T1 = linker;
         this.name_8Z = true;
      }
      
      public function link() : void
      {
         var v:Variable = null;
         var j:int = 0;
         var numParams:int = 0;
         var i:int = 0;
         var p:Procedure = null;
         var input:Array = null;
         var output:Array = null;
         var code:ByteArray = null;
         var param:String = null;
         var vars:Vector.<Variable> = null;
         var inParam:Variable = null;
         var outParam:Variable = null;
         if(this.name_8Z)
         {
            this.name_3r = new Object();
            this.name_RU.position = 7;
            this.name_Jf[0] = 0;
            this.name_Jf[1] = 0;
            this.name_Jf[3] = 0;
            this.name_Jf[4] = 0;
            this.name_Jf[5] = 0;
            this.name_A = 0;
            this.name_RT = 0;
            for each(v in this.name_c)
            {
               this.name_3r[v.name] = v;
            }
            for(i = 0; i < this.name_2L.length; i++)
            {
               p = this.name_2L[i];
               this.name_A += p.name_A;
               this.name_RT += p.name_RT;
               input = this.name_W8[p];
               output = this.name_f[p];
               code = new ByteArray();
               code.endian = Endian.LITTLE_ENDIAN;
               p.byteCode.position = 0;
               p.byteCode.readBytes(code,0,p.byteCode.length);
               if(input != null)
               {
                  numParams = int(input.length);
                  for(j = 0; j < numParams; )
                  {
                     param = input[j];
                     v = this.name_3r[param];
                     if(v == null)
                     {
                        throw new Error("Input parameter not set. paramName = " + param);
                     }
                     if(p.name_d2[6].length > j)
                     {
                        inParam = p.name_d2[6][j];
                        if(inParam == null)
                        {
                           throw new Error("Input parameter set, but not exist in code. paramName = " + param + ", register = i" + j.toString());
                        }
                        if(this.name_c[v.name] != null && v.index < 0)
                        {
                           v.index = int(this.name_Jf[v.type]++);
                        }
                        while(inParam != null)
                        {
                           inParam.writeToByteArray(code,v.index,v.type);
                           inParam = inParam.next;
                        }
                     }
                     j++;
                  }
               }
               if(output != null)
               {
                  numParams = int(output.length);
                  for(j = 0; j < numParams; j++)
                  {
                     param = output[j];
                     v = this.name_3r[param];
                     if(v == null)
                     {
                        if(!(j == 0 && i == this.name_2L.length - 1))
                        {
                           throw new Error("Output parameter have not declared. paramName = " + param);
                        }
                     }
                     else
                     {
                        if(this.name_c[v.name] != null && v.index < 0)
                        {
                           if(v.type != 2)
                           {
                              throw new Error("Wrong output type:" + VariableType.TYPE_NAMES[v.type]);
                           }
                           v.index = int(this.name_Jf[v.type]++);
                        }
                        outParam = p.name_d2[3][j];
                        if(outParam == null)
                        {
                           throw new Error("Output parameter set, but not exist in code. paramName = " + param + ", register = i" + j.toString());
                        }
                        while(outParam != null)
                        {
                           outParam.writeToByteArray(code,v.index,v.type);
                           outParam = outParam.next;
                        }
                     }
                  }
               }
               vars = p.name_d2[2];
               for(j = 0; j < vars.length; j++)
               {
                  v = vars[j];
                  if(v != null)
                  {
                     while(v != null)
                     {
                        v.writeToByteArray(code,v.index + this.name_Jf[2],VariableType.TEMPORARY);
                        v = v.next;
                     }
                  }
               }
               this.name_Jf[VariableType.CONSTANT] += p.name_in;
               this.resolveVariablesUsages(code,p.name_d2[0],VariableType.ATTRIBUTE);
               this.resolveVariablesUsages(code,p.name_d2[1],VariableType.CONSTANT);
               this.resolveVaryings(code,p.name_d2[4]);
               this.resolveVariablesUsages(code,p.name_d2[5],VariableType.SAMPLER);
               this.name_RU.writeBytes(code,0,code.length);
            }
            this.name_8Z = false;
         }
      }
      
      private function resolveVaryings(code:ByteArray, variableUsages:Vector.<Variable>) : void
      {
         var vUsage:Variable = null;
         var variable:Variable = null;
         var type:uint = VariableType.VARYING;
         if(this.name_T1 != null && this.name_T1.name_8Z)
         {
            this.name_T1.link();
         }
         var oppositeVariables:Object = this.name_T1 != null ? this.name_T1.name_3r : null;
         for(var j:uint = 0; j < variableUsages.length; j++)
         {
            vUsage = variableUsages[j];
            if(vUsage != null)
            {
               variable = this.name_3r[vUsage.name];
               if(variable == null)
               {
                  variable = Variable.create();
                  if(vUsage.name == null)
                  {
                     throw new Error("Varying is not assigned. Use \'assignVariableName\' method. register = " + vUsage.index);
                  }
                  this.name_3r[vUsage.name] = variable;
                  variable.name = vUsage.name;
                  if(oppositeVariables != null)
                  {
                     if(!(vUsage.name in oppositeVariables))
                     {
                        throw new Error("Varying with this name is not assigned to opposite linker. name = " + vUsage.name);
                     }
                     variable.index = Variable(oppositeVariables[vUsage.name]).index;
                  }
                  else
                  {
                     variable.index = this.name_Jf[type];
                     this.name_Jf[type] += vUsage.size;
                  }
                  variable.type = type;
               }
               while(Boolean(vUsage))
               {
                  vUsage.writeToByteArray(code,variable.index,variable.type);
                  vUsage = vUsage.next;
               }
            }
         }
      }
      
      private function resolveVariablesUsages(code:ByteArray, variableUsages:Vector.<Variable>, type:uint) : void
      {
         var vUsage:Variable = null;
         var variable:Variable = null;
         for(var j:int = 0; j < variableUsages.length; j++)
         {
            vUsage = variableUsages[j];
            if(vUsage != null)
            {
               variable = this.name_3r[vUsage.name];
               if(variable == null)
               {
                  variable = Variable.create();
                  if(vUsage.name != null)
                  {
                     this.name_3r[vUsage.name] = variable;
                  }
                  else if(!vUsage.isRelative)
                  {
                     throw new Error(VariableType.TYPE_NAMES[type] + " is not assigned. Use \"assignVariableName\" method. register = " + vUsage.index);
                  }
                  variable.name = vUsage.name;
                  variable.index = this.name_Jf[type];
                  this.name_Jf[type] += vUsage.size;
                  variable.type = type;
               }
               else if(variable.index < 0)
               {
                  variable.index = int(this.name_Jf[type]++);
               }
               while(vUsage != null)
               {
                  vUsage.writeToByteArray(code,variable.index,variable.type);
                  vUsage = vUsage.next;
               }
            }
         }
      }
      
      public function describeLinkageInfo() : String
      {
         var str:String = null;
         var p:Procedure = null;
         var args:* = undefined;
         var result:String = "LINKER:\n";
         var totalCodes:uint = 0;
         var totalCommands:uint = 0;
         for(var i:int = 0; i < this.name_2L.length; i++)
         {
            p = this.name_2L[i];
            if(p.name != null)
            {
               result += p.name + "(";
            }
            else
            {
               result += "#" + i.toString() + "(";
            }
            args = this.name_W8[p];
            if(args != null)
            {
               for each(str in args)
               {
                  result += str + ",";
               }
               result = result.substr(0,result.length - 1);
            }
            result += ")";
            args = this.name_f[p];
            if(args != null)
            {
               result += "->(";
               for each(str in args)
               {
                  result += str + ",";
               }
               result = result.substr(0,result.length - 1);
               result += ")";
            }
            result += " [IS:" + p.name_RT.toString() + ", CMDS:" + p.name_A.toString() + "]\n";
            totalCodes += p.name_RT;
            totalCommands += p.name_A;
         }
         return result + ("[IS:" + totalCodes.toString() + ", CMDS:" + totalCommands.toString() + "]\n");
      }
   }
}

