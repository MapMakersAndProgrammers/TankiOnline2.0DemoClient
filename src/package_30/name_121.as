package package_30
{
   import alternativa.engine3d.alternativa3d;
   import flash.display3D.Context3DProgramType;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   import flash.utils.Endian;
   
   use namespace alternativa3d;
   
   public class name_121
   {
      public var var_177:int = 0;
      
      public var var_176:int = 0;
      
      public var type:String;
      
      private var var_128:Vector.<name_114> = new Vector.<name_114>();
      
      private var var_174:ByteArray = new ByteArray();
      
      private var var_175:Boolean;
      
      alternativa3d var var_173:Object;
      
      private var var_180:Object = new Object();
      
      private var var_178:name_121;
      
      private var var_181:Dictionary = new Dictionary();
      
      private var var_179:Dictionary = new Dictionary();
      
      private var var_172:Vector.<uint> = new Vector.<uint>(6,true);
      
      public function name_121(programType:String)
      {
         super();
         this.var_174.endian = Endian.LITTLE_ENDIAN;
         this.type = programType;
         this.var_174.writeByte(160);
         this.var_174.writeUnsignedInt(1);
         this.var_174.writeByte(161);
         this.var_174.writeByte(programType == Context3DProgramType.FRAGMENT ? 1 : 0);
      }
      
      public function clear() : void
      {
         this.var_174.length = 7;
         this.var_172[0] = this.var_172[1] = this.var_172[2] = this.var_172[3] = this.var_172[4] = this.var_172[5] = 0;
         this.var_128.length = 0;
         this.var_175 = false;
         this.var_176 = 0;
         this.var_177 = 0;
         this.alternativa3d::var_173 = null;
         this.var_181 = new Dictionary();
         this.var_179 = new Dictionary();
      }
      
      public function name_123(procedure:name_114) : void
      {
         this.var_175 = true;
         this.var_128.push(procedure);
      }
      
      public function name_120(name:String, type:uint = 2) : void
      {
         var v:name_434 = null;
         v = new name_434();
         v.index = -1;
         v.type = type;
         v.name = name;
         this.var_180[name] = v;
      }
      
      public function name_118(procedure:name_114, ... args) : void
      {
         this.var_181[procedure] = args;
      }
      
      public function name_125(procedure:name_114, ... args) : void
      {
         this.var_179[procedure] = args;
      }
      
      public function getVariableIndex(name:String) : int
      {
         if(this.var_175)
         {
            this.name_142();
         }
         var variable:name_434 = this.alternativa3d::var_173[name];
         if(variable == null)
         {
            throw new Error("Variable \"" + name + "\" not found");
         }
         return variable.index;
      }
      
      public function name_207(name:String) : int
      {
         if(this.var_175)
         {
            this.name_142();
         }
         var variable:name_434 = this.alternativa3d::var_173[name];
         if(variable == null)
         {
            return -1;
         }
         return variable.index;
      }
      
      public function method_286(name:String) : Boolean
      {
         if(this.var_175)
         {
            this.name_142();
         }
         return this.alternativa3d::var_173[name] != null;
      }
      
      public function name_206() : ByteArray
      {
         if(this.var_175)
         {
            this.name_142();
         }
         return this.var_174;
      }
      
      public function name_133(linker:name_121) : void
      {
         this.var_178 = linker;
         this.var_175 = true;
      }
      
      public function name_142() : void
      {
         var v:name_434 = null;
         var j:int = 0;
         var numParams:int = 0;
         var i:int = 0;
         var p:name_114 = null;
         var input:Array = null;
         var output:Array = null;
         var code:ByteArray = null;
         var param:String = null;
         var vars:Vector.<name_434> = null;
         var inParam:name_434 = null;
         var outParam:name_434 = null;
         if(this.var_175)
         {
            this.alternativa3d::var_173 = new Object();
            this.var_174.position = 7;
            this.var_172[0] = 0;
            this.var_172[1] = 0;
            this.var_172[3] = 0;
            this.var_172[4] = 0;
            this.var_172[5] = 0;
            this.var_176 = 0;
            this.var_177 = 0;
            for each(v in this.var_180)
            {
               this.alternativa3d::var_173[v.name] = v;
            }
            for(i = 0; i < this.var_128.length; i++)
            {
               p = this.var_128[i];
               this.var_176 += p.var_176;
               this.var_177 += p.var_177;
               input = this.var_181[p];
               output = this.var_179[p];
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
                     v = this.alternativa3d::var_173[param];
                     if(v == null)
                     {
                        throw new Error("Input parameter not set. paramName = " + param);
                     }
                     if(p.name_435[6].length > j)
                     {
                        inParam = p.name_435[6][j];
                        if(inParam == null)
                        {
                           throw new Error("Input parameter set, but not exist in code. paramName = " + param + ", register = i" + j.toString());
                        }
                        if(this.var_180[v.name] != null && v.index < 0)
                        {
                           v.index = int(this.var_172[v.type]++);
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
                     v = this.alternativa3d::var_173[param];
                     if(v == null)
                     {
                        if(!(j == 0 && i == this.var_128.length - 1))
                        {
                           throw new Error("Output parameter have not declared. paramName = " + param);
                        }
                     }
                     else
                     {
                        if(this.var_180[v.name] != null && v.index < 0)
                        {
                           if(v.type != 2)
                           {
                              throw new Error("Wrong output type:" + name_115.TYPE_NAMES[v.type]);
                           }
                           v.index = int(this.var_172[v.type]++);
                        }
                        outParam = p.name_435[3][j];
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
               vars = p.name_435[2];
               for(j = 0; j < vars.length; j++)
               {
                  v = vars[j];
                  if(v != null)
                  {
                     while(v != null)
                     {
                        v.writeToByteArray(code,v.index + this.var_172[2],name_115.TEMPORARY);
                        v = v.next;
                     }
                  }
               }
               this.var_172[name_115.CONSTANT] += p.alternativa3d::name_436;
               this.method_283(code,p.name_435[0],name_115.ATTRIBUTE);
               this.method_283(code,p.name_435[1],name_115.CONSTANT);
               this.method_284(code,p.name_435[4]);
               this.method_283(code,p.name_435[5],name_115.SAMPLER);
               this.var_174.writeBytes(code,0,code.length);
            }
            this.var_175 = false;
         }
      }
      
      private function method_284(code:ByteArray, variableUsages:Vector.<name_434>) : void
      {
         var vUsage:name_434 = null;
         var variable:name_434 = null;
         var type:uint = name_115.VARYING;
         if(this.var_178 != null && this.var_178.var_175)
         {
            this.var_178.name_142();
         }
         var oppositeVariables:Object = this.var_178 != null ? this.var_178.alternativa3d::var_173 : null;
         for(var j:uint = 0; j < variableUsages.length; j++)
         {
            vUsage = variableUsages[j];
            if(vUsage != null)
            {
               variable = this.alternativa3d::var_173[vUsage.name];
               if(variable == null)
               {
                  variable = name_434.create();
                  if(vUsage.name == null)
                  {
                     throw new Error("Varying is not assigned. Use \'assignVariableName\' method. register = " + vUsage.index);
                  }
                  this.alternativa3d::var_173[vUsage.name] = variable;
                  variable.name = vUsage.name;
                  if(oppositeVariables != null)
                  {
                     if(!(vUsage.name in oppositeVariables))
                     {
                        throw new Error("Varying with this name is not assigned to opposite linker. name = " + vUsage.name);
                     }
                     variable.index = name_434(oppositeVariables[vUsage.name]).index;
                  }
                  else
                  {
                     variable.index = this.var_172[type];
                     this.var_172[type] += vUsage.size;
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
      
      private function method_283(code:ByteArray, variableUsages:Vector.<name_434>, type:uint) : void
      {
         var vUsage:name_434 = null;
         var variable:name_434 = null;
         for(var j:int = 0; j < variableUsages.length; j++)
         {
            vUsage = variableUsages[j];
            if(vUsage != null)
            {
               variable = this.alternativa3d::var_173[vUsage.name];
               if(variable == null)
               {
                  variable = name_434.create();
                  if(vUsage.name != null)
                  {
                     this.alternativa3d::var_173[vUsage.name] = variable;
                  }
                  else if(!vUsage.isRelative)
                  {
                     throw new Error(name_115.TYPE_NAMES[type] + " is not assigned. Use \"assignVariableName\" method. register = " + vUsage.index);
                  }
                  variable.name = vUsage.name;
                  variable.index = this.var_172[type];
                  this.var_172[type] += vUsage.size;
                  variable.type = type;
               }
               else if(variable.index < 0)
               {
                  variable.index = int(this.var_172[type]++);
               }
               while(vUsage != null)
               {
                  vUsage.writeToByteArray(code,variable.index,variable.type);
                  vUsage = vUsage.next;
               }
            }
         }
      }
      
      public function method_285() : String
      {
         var str:String = null;
         var p:name_114 = null;
         var args:* = undefined;
         var result:String = "LINKER:\n";
         var totalCodes:uint = 0;
         var totalCommands:uint = 0;
         for(var i:int = 0; i < this.var_128.length; i++)
         {
            p = this.var_128[i];
            if(p.name != null)
            {
               result += p.name + "(";
            }
            else
            {
               result += "#" + i.toString() + "(";
            }
            args = this.var_181[p];
            if(args != null)
            {
               for each(str in args)
               {
                  result += str + ",";
               }
               result = result.substr(0,result.length - 1);
            }
            result += ")";
            args = this.var_179[p];
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
            result += " [IS:" + p.var_177.toString() + ", CMDS:" + p.var_176.toString() + "]\n";
            totalCodes += p.var_177;
            totalCommands += p.var_176;
         }
         return result + ("[IS:" + totalCodes.toString() + ", CMDS:" + totalCommands.toString() + "]\n");
      }
   }
}

