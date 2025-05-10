package alternativa.engine3d.effects
{
   import flash.utils.*;
   
   public class AGALMiniAssembler
   {
      private static var initialized:Boolean = false;
      
      private static const OPMAP:Dictionary = new Dictionary();
      
      private static const REGMAP:Dictionary = new Dictionary();
      
      private static const SAMPLEMAP:Dictionary = new Dictionary();
      
      private static const MAX_NESTING:int = 4;
      
      private static const MAX_OPCODES:int = 256;
      
      private static const FRAGMENT:String = "fragment";
      
      private static const VERTEX:String = "vertex";
      
      private static const SAMPLER_DIM_SHIFT:uint = 12;
      
      private static const SAMPLER_SPECIAL_SHIFT:uint = 16;
      
      private static const SAMPLER_REPEAT_SHIFT:uint = 20;
      
      private static const SAMPLER_MIPMAP_SHIFT:uint = 24;
      
      private static const SAMPLER_FILTER_SHIFT:uint = 28;
      
      private static const REG_WRITE:uint = 1;
      
      private static const REG_READ:uint = 2;
      
      private static const REG_FRAG:uint = 32;
      
      private static const REG_VERT:uint = 64;
      
      private static const OP_SCALAR:uint = 1;
      
      private static const OP_INC_NEST:uint = 2;
      
      private static const OP_DEC_NEST:uint = 4;
      
      private static const OP_SPECIAL_TEX:uint = 8;
      
      private static const OP_SPECIAL_MATRIX:uint = 16;
      
      private static const OP_FRAG_ONLY:uint = 32;
      
      private static const OP_VERT_ONLY:uint = 64;
      
      private static const OP_NO_DEST:uint = 128;
      
      private static const MOV:String = "mov";
      
      private static const ADD:String = "add";
      
      private static const SUB:String = "sub";
      
      private static const MUL:String = "mul";
      
      private static const DIV:String = "div";
      
      private static const RCP:String = "rcp";
      
      private static const MIN:String = "min";
      
      private static const MAX:String = "max";
      
      private static const FRC:String = "frc";
      
      private static const SQT:String = "sqt";
      
      private static const RSQ:String = "rsq";
      
      private static const POW:String = "pow";
      
      private static const LOG:String = "log";
      
      private static const EXP:String = "exp";
      
      private static const NRM:String = "nrm";
      
      private static const SIN:String = "sin";
      
      private static const COS:String = "cos";
      
      private static const CRS:String = "crs";
      
      private static const DP3:String = "dp3";
      
      private static const DP4:String = "dp4";
      
      private static const ABS:String = "abs";
      
      private static const NEG:String = "neg";
      
      private static const SAT:String = "sat";
      
      private static const M33:String = "m33";
      
      private static const M44:String = "m44";
      
      private static const M34:String = "m34";
      
      private static const IFZ:String = "ifz";
      
      private static const INZ:String = "inz";
      
      private static const IFE:String = "ife";
      
      private static const INE:String = "ine";
      
      private static const IFG:String = "ifg";
      
      private static const IFL:String = "ifl";
      
      private static const IEG:String = "ieg";
      
      private static const IEL:String = "iel";
      
      private static const ELS:String = "els";
      
      private static const EIF:String = "eif";
      
      private static const REP:String = "rep";
      
      private static const ERP:String = "erp";
      
      private static const BRK:String = "brk";
      
      private static const KIL:String = "kil";
      
      private static const TEX:String = "tex";
      
      private static const SGE:String = "sge";
      
      private static const SLT:String = "slt";
      
      private static const SGN:String = "sgn";
      
      private static const VA:String = "va";
      
      private static const VC:String = "vc";
      
      private static const VT:String = "vt";
      
      private static const OP:String = "op";
      
      private static const V:String = "v";
      
      private static const FC:String = "fc";
      
      private static const FT:String = "ft";
      
      private static const FS:String = "fs";
      
      private static const OC:String = "oc";
      
      private static const D2:String = "2d";
      
      private static const D3:String = "3d";
      
      private static const CUBE:String = "cube";
      
      private static const MIPNEAREST:String = "mipnearest";
      
      private static const MIPLINEAR:String = "miplinear";
      
      private static const MIPNONE:String = "mipnone";
      
      private static const NOMIP:String = "nomip";
      
      private static const NEAREST:String = "nearest";
      
      private static const LINEAR:String = "linear";
      
      private static const CENTROID:String = "centroid";
      
      private static const SINGLE:String = "single";
      
      private static const DEPTH:String = "depth";
      
      private static const REPEAT:String = "repeat";
      
      private static const WRAP:String = "wrap";
      
      private static const CLAMP:String = "clamp";
      
      private var name_0e:ByteArray = null;
      
      private var name_iF:String = "";
      
      private var name_9J:Boolean = false;
      
      public function AGALMiniAssembler(debugging:Boolean = false)
      {
         super();
         this.name_9J = debugging;
         if(!initialized)
         {
            init();
         }
      }
      
      private static function init() : void
      {
         initialized = true;
         OPMAP[MOV] = new OpCode(MOV,2,0,0);
         OPMAP[ADD] = new OpCode(ADD,3,1,0);
         OPMAP[SUB] = new OpCode(SUB,3,2,0);
         OPMAP[MUL] = new OpCode(MUL,3,3,0);
         OPMAP[DIV] = new OpCode(DIV,3,4,0);
         OPMAP[RCP] = new OpCode(RCP,2,5,0);
         OPMAP[MIN] = new OpCode(MIN,3,6,0);
         OPMAP[MAX] = new OpCode(MAX,3,7,0);
         OPMAP[FRC] = new OpCode(FRC,2,8,0);
         OPMAP[SQT] = new OpCode(SQT,2,9,0);
         OPMAP[RSQ] = new OpCode(RSQ,2,10,0);
         OPMAP[POW] = new OpCode(POW,3,11,0);
         OPMAP[LOG] = new OpCode(LOG,2,12,0);
         OPMAP[EXP] = new OpCode(EXP,2,13,0);
         OPMAP[NRM] = new OpCode(NRM,2,14,0);
         OPMAP[SIN] = new OpCode(SIN,2,15,0);
         OPMAP[COS] = new OpCode(COS,2,16,0);
         OPMAP[CRS] = new OpCode(CRS,3,17,0);
         OPMAP[DP3] = new OpCode(DP3,3,18,0);
         OPMAP[DP4] = new OpCode(DP4,3,19,0);
         OPMAP[ABS] = new OpCode(ABS,2,20,0);
         OPMAP[NEG] = new OpCode(NEG,2,21,0);
         OPMAP[SAT] = new OpCode(SAT,2,22,0);
         OPMAP[M33] = new OpCode(M33,3,23,OP_SPECIAL_MATRIX);
         OPMAP[M44] = new OpCode(M44,3,24,OP_SPECIAL_MATRIX);
         OPMAP[M34] = new OpCode(M34,3,25,OP_SPECIAL_MATRIX);
         OPMAP[IFZ] = new OpCode(IFZ,1,26,OP_NO_DEST | OP_INC_NEST | OP_SCALAR);
         OPMAP[INZ] = new OpCode(INZ,1,27,OP_NO_DEST | OP_INC_NEST | OP_SCALAR);
         OPMAP[IFE] = new OpCode(IFE,2,28,OP_NO_DEST | OP_INC_NEST | OP_SCALAR);
         OPMAP[INE] = new OpCode(INE,2,29,OP_NO_DEST | OP_INC_NEST | OP_SCALAR);
         OPMAP[IFG] = new OpCode(IFG,2,30,OP_NO_DEST | OP_INC_NEST | OP_SCALAR);
         OPMAP[IFL] = new OpCode(IFL,2,31,OP_NO_DEST | OP_INC_NEST | OP_SCALAR);
         OPMAP[IEG] = new OpCode(IEG,2,32,OP_NO_DEST | OP_INC_NEST | OP_SCALAR);
         OPMAP[IEL] = new OpCode(IEL,2,33,OP_NO_DEST | OP_INC_NEST | OP_SCALAR);
         OPMAP[ELS] = new OpCode(ELS,0,34,OP_NO_DEST | OP_INC_NEST | OP_DEC_NEST);
         OPMAP[EIF] = new OpCode(EIF,0,35,OP_NO_DEST | OP_DEC_NEST);
         OPMAP[REP] = new OpCode(REP,1,36,OP_NO_DEST | OP_INC_NEST | OP_SCALAR);
         OPMAP[ERP] = new OpCode(ERP,0,37,OP_NO_DEST | OP_DEC_NEST);
         OPMAP[BRK] = new OpCode(BRK,0,38,OP_NO_DEST);
         OPMAP[KIL] = new OpCode(KIL,1,39,OP_NO_DEST | OP_FRAG_ONLY);
         OPMAP[TEX] = new OpCode(TEX,3,40,OP_FRAG_ONLY | OP_SPECIAL_TEX);
         OPMAP[SGE] = new OpCode(SGE,3,41,0);
         OPMAP[SLT] = new OpCode(SLT,3,42,0);
         OPMAP[SGN] = new OpCode(SGN,2,43,0);
         REGMAP[VA] = new Register(VA,"vertex attribute",0,7,REG_VERT | REG_READ);
         REGMAP[VC] = new Register(VC,"vertex constant",1,127,REG_VERT | REG_READ);
         REGMAP[VT] = new Register(VT,"vertex temporary",2,7,REG_VERT | REG_WRITE | REG_READ);
         REGMAP[OP] = new Register(OP,"vertex output",3,0,REG_VERT | REG_WRITE);
         REGMAP[V] = new Register(V,"varying",4,7,REG_VERT | REG_FRAG | REG_READ | REG_WRITE);
         REGMAP[FC] = new Register(FC,"fragment constant",1,27,REG_FRAG | REG_READ);
         REGMAP[FT] = new Register(FT,"fragment temporary",2,7,REG_FRAG | REG_WRITE | REG_READ);
         REGMAP[FS] = new Register(FS,"texture sampler",5,7,REG_FRAG | REG_READ);
         REGMAP[OC] = new Register(OC,"fragment output",3,0,REG_FRAG | REG_WRITE);
         SAMPLEMAP[D2] = new Sampler(D2,SAMPLER_DIM_SHIFT,0);
         SAMPLEMAP[D3] = new Sampler(D3,SAMPLER_DIM_SHIFT,2);
         SAMPLEMAP[CUBE] = new Sampler(CUBE,SAMPLER_DIM_SHIFT,1);
         SAMPLEMAP[MIPNEAREST] = new Sampler(MIPNEAREST,SAMPLER_MIPMAP_SHIFT,1);
         SAMPLEMAP[MIPLINEAR] = new Sampler(MIPLINEAR,SAMPLER_MIPMAP_SHIFT,2);
         SAMPLEMAP[MIPNONE] = new Sampler(MIPNONE,SAMPLER_MIPMAP_SHIFT,0);
         SAMPLEMAP[NOMIP] = new Sampler(NOMIP,SAMPLER_MIPMAP_SHIFT,0);
         SAMPLEMAP[NEAREST] = new Sampler(NEAREST,SAMPLER_FILTER_SHIFT,0);
         SAMPLEMAP[LINEAR] = new Sampler(LINEAR,SAMPLER_FILTER_SHIFT,1);
         SAMPLEMAP[CENTROID] = new Sampler(CENTROID,SAMPLER_SPECIAL_SHIFT,1 << 0);
         SAMPLEMAP[SINGLE] = new Sampler(SINGLE,SAMPLER_SPECIAL_SHIFT,1 << 1);
         SAMPLEMAP[DEPTH] = new Sampler(DEPTH,SAMPLER_SPECIAL_SHIFT,1 << 2);
         SAMPLEMAP[REPEAT] = new Sampler(REPEAT,SAMPLER_REPEAT_SHIFT,1);
         SAMPLEMAP[WRAP] = new Sampler(WRAP,SAMPLER_REPEAT_SHIFT,1);
         SAMPLEMAP[CLAMP] = new Sampler(CLAMP,SAMPLER_REPEAT_SHIFT,0);
      }
      
      public function get error() : String
      {
         return this.name_iF;
      }
      
      public function get agalcode() : ByteArray
      {
         return this.name_0e;
      }
      
      public function assemble(mode:String, source:String, verbose:Boolean = false) : ByteArray
      {
         var i:int = 0;
         var line:String = null;
         var startcomment:int = 0;
         var optsi:int = 0;
         var opts:Array = null;
         var opCode:Array = null;
         var opFound:OpCode = null;
         var regs:Array = null;
         var badreg:Boolean = false;
         var pad:uint = 0;
         var regLength:uint = 0;
         var j:int = 0;
         var isRelative:Boolean = false;
         var relreg:Array = null;
         var res:Array = null;
         var regFound:Register = null;
         var idxmatch:Array = null;
         var regidx:uint = 0;
         var regmask:uint = 0;
         var maskmatch:Array = null;
         var isDest:Boolean = false;
         var isSampler:Boolean = false;
         var reltype:uint = 0;
         var relsel:uint = 0;
         var reloffset:int = 0;
         var cv:uint = 0;
         var maskLength:uint = 0;
         var k:int = 0;
         var relname:Array = null;
         var regFoundRel:Register = null;
         var selmatch:Array = null;
         var relofs:Array = null;
         var samplerbits:uint = 0;
         var optsLength:uint = 0;
         var bias:Number = NaN;
         var optfound:Sampler = null;
         var dbgLine:String = null;
         var agalLength:uint = 0;
         var index:uint = 0;
         var byteStr:String = null;
         var start:uint = uint(getTimer());
         this.name_0e = new ByteArray();
         this.name_iF = "";
         var isFrag:Boolean = false;
         if(mode == FRAGMENT)
         {
            isFrag = true;
         }
         else if(mode != VERTEX)
         {
            this.name_iF = "ERROR: mode needs to be \"" + FRAGMENT + "\" or \"" + VERTEX + "\" but is \"" + mode + "\".";
         }
         this.agalcode.endian = Endian.LITTLE_ENDIAN;
         this.agalcode.writeByte(160);
         this.agalcode.writeUnsignedInt(1);
         this.agalcode.writeByte(161);
         this.agalcode.writeByte(isFrag ? 1 : 0);
         var lines:Array = source.replace(/[\f\n\r\v]+/g,"\n").split("\n");
         var nest:int = 0;
         var nops:int = 0;
         var lng:int = int(lines.length);
         i = 0;
         while(i < lng && this.name_iF == "")
         {
            line = new String(lines[i]);
            startcomment = int(line.search("//"));
            if(startcomment != -1)
            {
               line = line.slice(0,startcomment);
            }
            optsi = int(line.search(/<.*>/g));
            if(optsi != -1)
            {
               opts = line.slice(optsi).match(/([\w\.\-\+]+)/gi);
               line = line.slice(0,optsi);
            }
            opCode = line.match(/^\w{3}/ig);
            opFound = OPMAP[opCode[0]];
            if(this.name_9J)
            {
               trace(opFound);
            }
            if(opFound == null)
            {
               if(line.length >= 3)
               {
                  trace("warning: bad line " + i + ": " + lines[i]);
               }
            }
            else
            {
               line = line.slice(line.search(opFound.name) + opFound.name.length);
               if(Boolean(opFound.flags & OP_DEC_NEST))
               {
                  nest--;
                  if(nest < 0)
                  {
                     this.name_iF = "error: conditional closes without open.";
                     break;
                  }
               }
               if(Boolean(opFound.flags & OP_INC_NEST))
               {
                  nest++;
                  if(nest > MAX_NESTING)
                  {
                     this.name_iF = "error: nesting to deep, maximum allowed is " + MAX_NESTING + ".";
                     break;
                  }
               }
               if(Boolean(opFound.flags & OP_FRAG_ONLY) && !isFrag)
               {
                  this.name_iF = "error: opcode is only allowed in fragment programs.";
                  break;
               }
               if(verbose)
               {
                  trace("emit opcode=" + opFound);
               }
               this.agalcode.writeUnsignedInt(opFound.emitCode);
               nops++;
               if(nops > MAX_OPCODES)
               {
                  this.name_iF = "error: too many opcodes. maximum is " + MAX_OPCODES + ".";
                  break;
               }
               regs = line.match(/vc\[([vof][actps]?)(\d*)?(\.[xyzw](\+\d{1,3})?)?\](\.[xyzw]{1,4})?|([vof][actps]?)(\d*)?(\.[xyzw]{1,4})?/gi);
               if(regs.length != opFound.numRegister)
               {
                  this.name_iF = "error: wrong number of operands. found " + regs.length + " but expected " + opFound.numRegister + ".";
                  break;
               }
               badreg = false;
               pad = uint(64 + 64 + 32);
               regLength = uint(regs.length);
               for(j = 0; j < regLength; j++)
               {
                  isRelative = false;
                  relreg = regs[j].match(/\[.*\]/ig);
                  if(relreg.length > 0)
                  {
                     regs[j] = regs[j].replace(relreg[0],"0");
                     if(verbose)
                     {
                        trace("IS REL");
                     }
                     isRelative = true;
                  }
                  res = regs[j].match(/^\b[A-Za-z]{1,2}/ig);
                  regFound = REGMAP[res[0]];
                  if(this.name_9J)
                  {
                     trace(regFound);
                  }
                  if(regFound == null)
                  {
                     this.name_iF = "error: could not parse operand " + j + " (" + regs[j] + ").";
                     badreg = true;
                     break;
                  }
                  if(isFrag)
                  {
                     if(!(regFound.flags & REG_FRAG))
                     {
                        this.name_iF = "error: register operand " + j + " (" + regs[j] + ") only allowed in vertex programs.";
                        badreg = true;
                        break;
                     }
                     if(isRelative)
                     {
                        this.name_iF = "error: register operand " + j + " (" + regs[j] + ") relative adressing not allowed in fragment programs.";
                        badreg = true;
                        break;
                     }
                  }
                  else if(!(regFound.flags & REG_VERT))
                  {
                     this.name_iF = "error: register operand " + j + " (" + regs[j] + ") only allowed in fragment programs.";
                     badreg = true;
                     break;
                  }
                  regs[j] = regs[j].slice(regs[j].search(regFound.name) + regFound.name.length);
                  idxmatch = isRelative ? relreg[0].match(/\d+/) : regs[j].match(/\d+/);
                  regidx = 0;
                  if(Boolean(idxmatch))
                  {
                     regidx = uint(uint(idxmatch[0]));
                  }
                  if(regFound.range < regidx)
                  {
                     this.name_iF = "error: register operand " + j + " (" + regs[j] + ") index exceeds limit of " + (regFound.range + 1) + ".";
                     badreg = true;
                     break;
                  }
                  regmask = 0;
                  maskmatch = regs[j].match(/(\.[xyzw]{1,4})/);
                  isDest = j == 0 && !(opFound.flags & OP_NO_DEST);
                  isSampler = j == 2 && Boolean(opFound.flags & OP_SPECIAL_TEX);
                  reltype = 0;
                  relsel = 0;
                  reloffset = 0;
                  if(isDest && isRelative)
                  {
                     this.name_iF = "error: relative can not be destination";
                     badreg = true;
                     break;
                  }
                  if(Boolean(maskmatch))
                  {
                     regmask = 0;
                     maskLength = uint(maskmatch[0].length);
                     for(k = 1; k < maskLength; k++)
                     {
                        cv = maskmatch[0].charCodeAt(k) - "x".charCodeAt(0);
                        if(cv > 2)
                        {
                           cv = 3;
                        }
                        if(isDest)
                        {
                           regmask |= 1 << cv;
                        }
                        else
                        {
                           regmask |= cv << (k - 1 << 1);
                        }
                     }
                     if(!isDest)
                     {
                        while(k <= 4)
                        {
                           regmask |= cv << (k - 1 << 1);
                           k++;
                        }
                     }
                  }
                  else
                  {
                     regmask = isDest ? 15 : 228;
                  }
                  if(isRelative)
                  {
                     relname = relreg[0].match(/[A-Za-z]{1,2}/ig);
                     regFoundRel = REGMAP[relname[0]];
                     if(regFoundRel == null)
                     {
                        this.name_iF = "error: bad index register";
                        badreg = true;
                        break;
                     }
                     reltype = regFoundRel.emitCode;
                     selmatch = relreg[0].match(/(\.[xyzw]{1,1})/);
                     if(selmatch.length == 0)
                     {
                        this.name_iF = "error: bad index register select";
                        badreg = true;
                        break;
                     }
                     relsel = selmatch[0].charCodeAt(1) - "x".charCodeAt(0);
                     if(relsel > 2)
                     {
                        relsel = 3;
                     }
                     relofs = relreg[0].match(/\+\d{1,3}/ig);
                     if(relofs.length > 0)
                     {
                        reloffset = int(relofs[0]);
                     }
                     if(reloffset < 0 || reloffset > 255)
                     {
                        this.name_iF = "error: index offset " + reloffset + " out of bounds. [0..255]";
                        badreg = true;
                        break;
                     }
                     if(verbose)
                     {
                        trace("RELATIVE: type=" + reltype + "==" + relname[0] + " sel=" + relsel + "==" + selmatch[0] + " idx=" + regidx + " offset=" + reloffset);
                     }
                  }
                  if(verbose)
                  {
                     trace("  emit argcode=" + regFound + "[" + regidx + "][" + regmask + "]");
                  }
                  if(isDest)
                  {
                     this.agalcode.writeShort(regidx);
                     this.agalcode.writeByte(regmask);
                     this.agalcode.writeByte(regFound.emitCode);
                     pad -= 32;
                  }
                  else if(isSampler)
                  {
                     if(verbose)
                     {
                        trace("  emit sampler");
                     }
                     samplerbits = 5;
                     optsLength = uint(opts.length);
                     bias = 0;
                     for(k = 0; k < optsLength; k++)
                     {
                        if(verbose)
                        {
                           trace("    opt: " + opts[k]);
                        }
                        optfound = SAMPLEMAP[opts[k]];
                        if(optfound == null)
                        {
                           bias = Number(Number(opts[k]));
                           if(verbose)
                           {
                              trace("    bias: " + bias);
                           }
                        }
                        else
                        {
                           if(optfound.flag != SAMPLER_SPECIAL_SHIFT)
                           {
                              samplerbits &= ~(15 << optfound.flag);
                           }
                           samplerbits |= uint(optfound.mask) << uint(optfound.flag);
                        }
                     }
                     this.agalcode.writeShort(regidx);
                     this.agalcode.writeByte(int(bias * 8));
                     this.agalcode.writeByte(0);
                     this.agalcode.writeUnsignedInt(samplerbits);
                     if(verbose)
                     {
                        trace("    bits: " + (samplerbits - 5));
                     }
                     pad -= 64;
                  }
                  else
                  {
                     if(j == 0)
                     {
                        this.agalcode.writeUnsignedInt(0);
                        pad -= 32;
                     }
                     this.agalcode.writeShort(regidx);
                     this.agalcode.writeByte(reloffset);
                     this.agalcode.writeByte(regmask);
                     this.agalcode.writeByte(regFound.emitCode);
                     this.agalcode.writeByte(reltype);
                     this.agalcode.writeShort(isRelative ? relsel | 1 << 15 : 0);
                     pad -= 64;
                  }
               }
               for(j = 0; j < pad; )
               {
                  this.agalcode.writeByte(0);
                  j += 8;
               }
               if(badreg)
               {
                  break;
               }
            }
            i++;
         }
         if(this.name_iF != "")
         {
            this.name_iF += "\n  at line " + i + " " + lines[i];
            this.agalcode.length = 0;
            trace(this.name_iF);
         }
         if(this.name_9J)
         {
            dbgLine = "generated bytecode:";
            agalLength = uint(this.agalcode.length);
            for(index = 0; index < agalLength; index++)
            {
               if(!(index % 16))
               {
                  dbgLine += "\n";
               }
               if(!(index % 4))
               {
                  dbgLine += " ";
               }
               byteStr = this.agalcode[index].toString(16);
               if(byteStr.length < 2)
               {
                  byteStr = "0" + byteStr;
               }
               dbgLine += byteStr;
            }
            trace(dbgLine);
         }
         if(verbose)
         {
            trace("AGALMiniAssembler.assemble time: " + (getTimer() - start) / 1000 + "s");
         }
         return this.agalcode;
      }
   }
}

class OpCode
{
   private var _emitCode:uint;
   
   private var _flags:uint;
   
   private var _name:String;
   
   private var _numRegister:uint;
   
   public function OpCode(name:String, numRegister:uint, emitCode:uint, flags:uint)
   {
      super();
      this._name = name;
      this._numRegister = numRegister;
      this._emitCode = emitCode;
      this._flags = flags;
   }
   
   public function get emitCode() : uint
   {
      return this._emitCode;
   }
   
   public function get flags() : uint
   {
      return this._flags;
   }
   
   public function get name() : String
   {
      return this._name;
   }
   
   public function get numRegister() : uint
   {
      return this._numRegister;
   }
   
   public function toString() : String
   {
      return "[OpCode name=\"" + this._name + "\", numRegister=" + this._numRegister + ", emitCode=" + this._emitCode + ", flags=" + this._flags + "]";
   }
}

class Register
{
   private var _emitCode:uint;
   
   private var _name:String;
   
   private var _longName:String;
   
   private var _flags:uint;
   
   private var _range:uint;
   
   public function Register(name:String, longName:String, emitCode:uint, range:uint, flags:uint)
   {
      super();
      this._name = name;
      this._longName = longName;
      this._emitCode = emitCode;
      this._range = range;
      this._flags = flags;
   }
   
   public function get emitCode() : uint
   {
      return this._emitCode;
   }
   
   public function get longName() : String
   {
      return this._longName;
   }
   
   public function get name() : String
   {
      return this._name;
   }
   
   public function get flags() : uint
   {
      return this._flags;
   }
   
   public function get range() : uint
   {
      return this._range;
   }
   
   public function toString() : String
   {
      return "[Register name=\"" + this._name + "\", longName=\"" + this._longName + "\", emitCode=" + this._emitCode + ", range=" + this._range + ", flags=" + this._flags + "]";
   }
}

class Sampler
{
   private var _flag:uint;
   
   private var _mask:uint;
   
   private var _name:String;
   
   public function Sampler(name:String, flag:uint, mask:uint)
   {
      super();
      this._name = name;
      this._flag = flag;
      this._mask = mask;
   }
   
   public function get flag() : uint
   {
      return this._flag;
   }
   
   public function get mask() : uint
   {
      return this._mask;
   }
   
   public function get name() : String
   {
      return this._name;
   }
   
   public function toString() : String
   {
      return "[Sampler name=\"" + this._name + "\", flag=\"" + this._flag + "\", mask=" + this.mask + "]";
   }
}
