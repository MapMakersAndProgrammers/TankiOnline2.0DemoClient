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
      public var §_-RT§:int = 0;
      
      public var §_-A§:int = 0;
      
      public var type:String;
      
      private var §_-2L§:Vector.<Procedure> = new Vector.<Procedure>();
      
      private var §_-RU§:ByteArray = new ByteArray();
      
      private var §_-8Z§:Boolean;
      
      alternativa3d var §_-3r§:Object;
      
      private var §_-c§:Object = new Object();
      
      private var §_-T1§:Linker;
      
      private var §_-W8§:Dictionary = new Dictionary();
      
      private var §_-f-§:Dictionary = new Dictionary();
      
      private var §_-Jf§:Vector.<uint> = new Vector.<uint>(6,true);
      
      public function Linker(programType:String)
      {
         super();
         this.§_-RU§.endian = Endian.LITTLE_ENDIAN;
         this.type = programType;
         this.§_-RU§.writeByte(160);
         this.§_-RU§.writeUnsignedInt(1);
         this.§_-RU§.writeByte(161);
         this.§_-RU§.writeByte(programType == Context3DProgramType.FRAGMENT ? 1 : 0);
      }
      
      public function clear() : void
      {
         this.§_-RU§.length = 7;
         this.§_-Jf§[0] = this.§_-Jf§[1] = this.§_-Jf§[2] = this.§_-Jf§[3] = this.§_-Jf§[4] = this.§_-Jf§[5] = 0;
         this.§_-2L§.length = 0;
         this.§_-8Z§ = false;
         this.§_-A§ = 0;
         this.§_-RT§ = 0;
         this.alternativa3d::_-3r = null;
         this.§_-W8§ = new Dictionary();
         this.§_-f-§ = new Dictionary();
      }
      
      public function addProcedure(procedure:Procedure) : void
      {
         this.§_-8Z§ = true;
         this.§_-2L§.push(procedure);
      }
      
      public function declareVariable(name:String, type:uint = 2) : void
      {
         var v:Variable = null;
         v = new Variable();
         v.index = -1;
         v.type = type;
         v.name = name;
         this.§_-c§[name] = v;
      }
      
      public function setInputParams(procedure:Procedure, ... args) : void
      {
         this.§_-W8§[procedure] = args;
      }
      
      public function setOutputParams(procedure:Procedure, ... args) : void
      {
         this.§_-f-§[procedure] = args;
      }
      
      public function getVariableIndex(name:String) : int
      {
         if(this.§_-8Z§)
         {
            this.link();
         }
         var variable:Variable = this.alternativa3d::_-3r[name];
         if(variable == null)
         {
            throw new Error("Variable \"" + name + "\" not found");
         }
         return variable.index;
      }
      
      public function findVariable(name:String) : int
      {
         if(this.§_-8Z§)
         {
            this.link();
         }
         var variable:Variable = this.alternativa3d::_-3r[name];
         if(variable == null)
         {
            return -1;
         }
         return variable.index;
      }
      
      public function containsVariable(name:String) : Boolean
      {
         if(this.§_-8Z§)
         {
            this.link();
         }
         return this.alternativa3d::_-3r[name] != null;
      }
      
      public function getByteCode() : ByteArray
      {
         if(this.§_-8Z§)
         {
            this.link();
         }
         return this.§_-RU§;
      }
      
      public function setOppositeLinker(linker:Linker) : void
      {
         this.§_-T1§ = linker;
         this.§_-8Z§ = true;
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
         if(this.§_-8Z§)
         {
            this.alternativa3d::_-3r = new Object();
            this.§_-RU§.position = 7;
            this.§_-Jf§[0] = 0;
            this.§_-Jf§[1] = 0;
            this.§_-Jf§[3] = 0;
            this.§_-Jf§[4] = 0;
            this.§_-Jf§[5] = 0;
            this.§_-A§ = 0;
            this.§_-RT§ = 0;
            for each(v in this.§_-c§)
            {
               this.alternativa3d::_-3r[v.name] = v;
            }
            for(i = 0; i < this.§_-2L§.length; i++)
            {
               p = this.§_-2L§[i];
               this.§_-A§ += p.§_-A§;
               this.§_-RT§ += p.§_-RT§;
               input = this.§_-W8§[p];
               output = this.§_-f-§[p];
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
                     v = this.alternativa3d::_-3r[param];
                     if(v == null)
                     {
                        throw new Error("Input parameter not set. paramName = " + param);
                     }
                     if(p.§_-d2§[6].length > j)
                     {
                        inParam = p.§_-d2§[6][j];
                        if(inParam == null)
                        {
                           throw new Error("Input parameter set, but not exist in code. paramName = " + param + ", register = i" + j.toString());
                        }
                        if(this.§_-c§[v.name] != null && v.index < 0)
                        {
                           v.index = int(this.§_-Jf§[v.type]++);
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
                     v = this.alternativa3d::_-3r[param];
                     if(v == null)
                     {
                        if(!(j == 0 && i == this.§_-2L§.length - 1))
                        {
                           throw new Error("Output parameter have not declared. paramName = " + param);
                        }
                     }
                     else
                     {
                        if(this.§_-c§[v.name] != null && v.index < 0)
                        {
                           if(v.type != 2)
                           {
                              throw new Error("Wrong output type:" + VariableType.TYPE_NAMES[v.type]);
                           }
                           v.index = int(this.§_-Jf§[v.type]++);
                        }
                        outParam = p.§_-d2§[3][j];
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
               vars = p.§_-d2§[2];
               for(j = 0; j < vars.length; j++)
               {
                  v = vars[j];
                  if(v != null)
                  {
                     while(v != null)
                     {
                        v.writeToByteArray(code,v.index + this.§_-Jf§[2],VariableType.TEMPORARY);
                        v = v.next;
                     }
                  }
               }
               this.§_-Jf§[VariableType.CONSTANT] += p.alternativa3d::_-in;
               this.resolveVariablesUsages(code,p.§_-d2§[0],VariableType.ATTRIBUTE);
               this.resolveVariablesUsages(code,p.§_-d2§[1],VariableType.CONSTANT);
               this.resolveVaryings(code,p.§_-d2§[4]);
               this.resolveVariablesUsages(code,p.§_-d2§[5],VariableType.SAMPLER);
               this.§_-RU§.writeBytes(code,0,code.length);
            }
            this.§_-8Z§ = false;
         }
      }
      
      private function resolveVaryings(code:ByteArray, variableUsages:Vector.<Variable>) : void
      {
         var vUsage:Variable = null;
         var variable:Variable = null;
         var type:uint = VariableType.VARYING;
         if(this.§_-T1§ != null && this.§_-T1§.§_-8Z§)
         {
            this.§_-T1§.link();
         }
         var oppositeVariables:Object = this.§_-T1§ != null ? this.§_-T1§.alternativa3d::_-3r : null;
         for(var j:uint = 0; j < variableUsages.length; j++)
         {
            vUsage = variableUsages[j];
            if(vUsage != null)
            {
               variable = this.alternativa3d::_-3r[vUsage.name];
               if(variable == null)
               {
                  variable = Variable.create();
                  if(vUsage.name == null)
                  {
                     throw new Error("Varying is not assigned. Use \'assignVariableName\' method. register = " + vUsage.index);
                  }
                  this.alternativa3d::_-3r[vUsage.name] = variable;
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
                     variable.index = this.§_-Jf§[type];
                     this.§_-Jf§[type] += vUsage.size;
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
               variable = this.alternativa3d::_-3r[vUsage.name];
               if(variable == null)
               {
                  variable = Variable.create();
                  if(vUsage.name != null)
                  {
                     this.alternativa3d::_-3r[vUsage.name] = variable;
                  }
                  else if(!vUsage.isRelative)
                  {
                     throw new Error(VariableType.TYPE_NAMES[type] + " is not assigned. Use \"assignVariableName\" method. register = " + vUsage.index);
                  }
                  variable.name = vUsage.name;
                  variable.index = this.§_-Jf§[type];
                  this.§_-Jf§[type] += vUsage.size;
                  variable.type = type;
               }
               else if(variable.index < 0)
               {
                  variable.index = int(this.§_-Jf§[type]++);
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
         for(var i:int = 0; i < this.§_-2L§.length; i++)
         {
            p = this.§_-2L§[i];
            if(p.name != null)
            {
               result += p.name + "(";
            }
            else
            {
               result += "#" + i.toString() + "(";
            }
            args = this.§_-W8§[p];
            if(args != null)
            {
               for each(str in args)
               {
                  result += str + ",";
               }
               result = result.substr(0,result.length - 1);
            }
            result += ")";
            args = this.§_-f-§[p];
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
            result += " [IS:" + p.§_-RT§.toString() + ", CMDS:" + p.§_-A§.toString() + "]\n";
            totalCodes += p.§_-RT§;
            totalCommands += p.§_-A§;
         }
         return result + ("[IS:" + totalCodes.toString() + ", CMDS:" + totalCommands.toString() + "]\n");
      }
   }
}

