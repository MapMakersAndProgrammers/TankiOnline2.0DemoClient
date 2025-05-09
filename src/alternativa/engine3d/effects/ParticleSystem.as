package alternativa.engine3d.effects
{
   import alternativa.engine3d.alternativa3d;
   import alternativa.engine3d.core.Camera3D;
   import alternativa.engine3d.core.Debug;
   import alternativa.engine3d.core.DrawUnit;
   import alternativa.engine3d.core.Light3D;
   import alternativa.engine3d.core.Object3D;
   import alternativa.engine3d.core.RenderPriority;
   import flash.display3D.Context3D;
   import flash.display3D.Context3DBlendFactor;
   import flash.display3D.Context3DProgramType;
   import flash.display3D.Context3DTriangleFace;
   import flash.display3D.Context3DVertexBufferFormat;
   import flash.display3D.IndexBuffer3D;
   import flash.display3D.Program3D;
   import flash.display3D.VertexBuffer3D;
   import flash.display3D.textures.TextureBase;
   import flash.geom.Vector3D;
   import flash.utils.ByteArray;
   import flash.utils.getTimer;
   
   use namespace alternativa3d;
   
   public class ParticleSystem extends Object3D
   {
      private static var vertexBuffer:VertexBuffer3D;
      
      private static var indexBuffer:IndexBuffer3D;
      
      private static var diffuseProgram:Program3D;
      
      private static var opacityProgram:Program3D;
      
      private static var diffuseBlendProgram:Program3D;
      
      private static var opacityBlendProgram:Program3D;
      
      private static const limit:int = 31;
      
      public var §_-jW§:Boolean = true;
      
      public var gravity:Vector3D = new Vector3D(0,0,-1);
      
      public var wind:Vector3D = new Vector3D();
      
      public var §_-IN§:int = 0;
      
      public var fogMaxDensity:Number = 0;
      
      public var fogNear:Number = 0;
      
      public var fogFar:Number = 0;
      
      alternativa3d var scale:Number = 1;
      
      alternativa3d var effectList:§_-SG§;
      
      private var drawUnit:DrawUnit = null;
      
      private var diffuse:TextureBase = null;
      
      private var opacity:TextureBase = null;
      
      private var blendSource:String = null;
      
      private var blendDestination:String = null;
      
      private var counter:int;
      
      private var §_-La§:Number;
      
      private var §_-p3§:Number;
      
      private var §_-ZN§:Vector.<Object3D> = new Vector.<Object3D>();
      
      private var §_-hr§:int = 0;
      
      private var pause:Boolean = false;
      
      private var §_-pK§:Number;
      
      private var §_-L5§:Number = 0;
      
      public function ParticleSystem()
      {
         super();
      }
      
      public function stop() : void
      {
         if(!this.pause)
         {
            this.§_-pK§ = getTimer() * 0.001;
            this.pause = true;
         }
      }
      
      public function play() : void
      {
         if(this.pause)
         {
            this.§_-L5§ += getTimer() * 0.001 - this.§_-pK§;
            this.pause = false;
         }
      }
      
      public function prevFrame() : void
      {
         this.§_-pK§ -= 0.001;
      }
      
      public function nextFrame() : void
      {
         this.§_-pK§ += 0.001;
      }
      
      public function each(effect:§_-SG§) : §_-SG§
      {
         if(effect.alternativa3d::system != null)
         {
            throw new Error("Cannot add the same effect twice.");
         }
         effect.alternativa3d::startTime = this.alternativa3d::getTime();
         effect.alternativa3d::system = this;
         effect.alternativa3d::_-is(0);
         effect.alternativa3d::_-Af(0);
         effect.alternativa3d::implements = this.alternativa3d::effectList;
         this.alternativa3d::effectList = effect;
         return effect;
      }
      
      public function getEffectByName(name:String) : §_-SG§
      {
         for(var effect:§_-SG§ = this.alternativa3d::effectList; effect != null; )
         {
            if(effect.name == name)
            {
               return effect;
            }
            effect = effect.alternativa3d::implements;
         }
         return null;
      }
      
      alternativa3d function getTime() : Number
      {
         return this.pause ? this.§_-pK§ - this.§_-L5§ : getTimer() * 0.001 - this.§_-L5§;
      }
      
      override alternativa3d function collectDraws(camera:Camera3D, lights:Vector.<Light3D>, lightsLength:int) : void
      {
         var visibleEffectList:§_-SG§ = null;
         var effectTime:Number = NaN;
         var culling:int = 0;
         var debug:int = 0;
         if(vertexBuffer == null)
         {
            this.createAndUpload(camera.alternativa3d::context3D);
         }
         this.alternativa3d::scale = Math.sqrt(alternativa3d::localToCameraTransform.a * alternativa3d::localToCameraTransform.a + alternativa3d::localToCameraTransform.e * alternativa3d::localToCameraTransform.e + alternativa3d::localToCameraTransform.i * alternativa3d::localToCameraTransform.i);
         this.alternativa3d::scale += Math.sqrt(alternativa3d::localToCameraTransform.b * alternativa3d::localToCameraTransform.b + alternativa3d::localToCameraTransform.f * alternativa3d::localToCameraTransform.f + alternativa3d::localToCameraTransform.j * alternativa3d::localToCameraTransform.j);
         this.alternativa3d::scale += Math.sqrt(alternativa3d::localToCameraTransform.c * alternativa3d::localToCameraTransform.c + alternativa3d::localToCameraTransform.g * alternativa3d::localToCameraTransform.g + alternativa3d::localToCameraTransform.k * alternativa3d::localToCameraTransform.k);
         this.alternativa3d::scale /= 3;
         camera.alternativa3d::calculateFrustum(alternativa3d::cameraToLocalTransform);
         var conflictAnyway:Boolean = false;
         var time:Number = this.alternativa3d::getTime();
         for(var effect:§_-SG§ = this.alternativa3d::effectList,var prev:§_-SG§ = null; effect != null; )
         {
            effectTime = time - effect.alternativa3d::startTime;
            if(effectTime <= effect.alternativa3d::lifeTime)
            {
               culling = 63;
               if(effect.boundBox != null)
               {
                  effect.alternativa3d::calculateAABB();
                  culling = int(effect.alternativa3d::aabb.alternativa3d::checkFrustumCulling(camera.alternativa3d::frustum,63));
               }
               if(culling >= 0)
               {
                  if(effect.alternativa3d::_-Xj(effectTime))
                  {
                     if(effect.alternativa3d::particleList != null)
                     {
                        effect.alternativa3d::next = visibleEffectList;
                        visibleEffectList = effect;
                        conflictAnyway ||= effect.boundBox == null;
                     }
                     prev = effect;
                     effect = effect.alternativa3d::implements;
                  }
                  else if(prev != null)
                  {
                     prev.alternativa3d::implements = effect.alternativa3d::implements;
                     effect = prev.alternativa3d::implements;
                  }
                  else
                  {
                     this.alternativa3d::effectList = effect.alternativa3d::implements;
                     effect = this.alternativa3d::effectList;
                  }
               }
               else
               {
                  prev = effect;
                  effect = effect.alternativa3d::implements;
               }
            }
            else if(prev != null)
            {
               prev.alternativa3d::implements = effect.alternativa3d::implements;
               effect = prev.alternativa3d::implements;
            }
            else
            {
               this.alternativa3d::effectList = effect.alternativa3d::implements;
               effect = this.alternativa3d::effectList;
            }
         }
         if(visibleEffectList != null)
         {
            if(visibleEffectList.alternativa3d::next != null)
            {
               this.drawConflictEffects(camera,visibleEffectList);
            }
            else
            {
               this.drawParticleList(camera,visibleEffectList.alternativa3d::particleList);
               visibleEffectList.alternativa3d::particleList = null;
               if(Boolean(camera.debug) && visibleEffectList.boundBox != null && Boolean(camera.alternativa3d::checkInDebug(this) & Debug.BOUNDS))
               {
                  Debug.alternativa3d::drawBoundBox(camera,visibleEffectList.alternativa3d::aabb,alternativa3d::localToCameraTransform);
               }
            }
            this.flush(camera);
            this.drawUnit = null;
            this.diffuse = null;
            this.opacity = null;
            this.blendSource = null;
            this.blendDestination = null;
            this.§_-hr§ = 0;
         }
         if(camera.debug)
         {
            debug = int(camera.alternativa3d::checkInDebug(this));
            if(Boolean(debug & Debug.BOUNDS) && boundBox != null)
            {
               Debug.alternativa3d::drawBoundBox(camera,boundBox,alternativa3d::localToCameraTransform);
            }
         }
      }
      
      private function createAndUpload(context:Context3D) : void
      {
         var vertices:Vector.<Number> = new Vector.<Number>();
         var indices:Vector.<uint> = new Vector.<uint>();
         for(var i:int = 0; i < limit; i++)
         {
            vertices.push(0,0,0,0,0,i * 4,0,1,0,0,1,i * 4,1,1,0,1,1,i * 4,1,0,0,1,0,i * 4);
            indices.push(i * 4,i * 4 + 1,i * 4 + 3,i * 4 + 2,i * 4 + 3,i * 4 + 1);
         }
         vertexBuffer = context.createVertexBuffer(limit * 4,6);
         vertexBuffer.uploadFromVector(vertices,0,limit * 4);
         indexBuffer = context.createIndexBuffer(limit * 6);
         indexBuffer.uploadFromVector(indices,0,limit * 6);
         var vertexProgram:Array = ["mov vt2, vc[va1.z]","sub vt0.z, va0.x, vt2.x","sub vt0.w, va0.y, vt2.y","mul vt0.z, vt0.z, vt2.z","mul vt0.w, vt0.w, vt2.w","mov vt2, vc[va1.z+1]","mov vt1.z, vt2.w","sin vt1.x, vt1.z","cos vt1.y, vt1.z","mul vt1.z, vt0.z, vt1.y","mul vt1.w, vt0.w, vt1.x","sub vt0.x, vt1.z, vt1.w","mul vt1.z, vt0.z, vt1.x","mul vt1.w, vt0.w, vt1.y","add vt0.y, vt1.z, vt1.w","add vt0.x, vt0.x, vt2.x","add vt0.y, vt0.y, vt2.y","add vt0.z, va0.z, vt2.z","mov vt0.w, va0.w","dp4 op.x, vt0, vc124","dp4 op.y, vt0, vc125","dp4 op.z, vt0, vc126","dp4 op.w, vt0, vc127","mov vt2, vc[va1.z+2]","mul vt1.x, va1.x, vt2.x","mul vt1.y, va1.y, vt2.y","add vt1.x, vt1.x, vt2.z","add vt1.y, vt1.y, vt2.w","mov v0, vt1","mov v1, vc[va1.z+3]","mov v2, vt0"];
         var fragmentDiffuseProgram:Array = ["tex ft0, v0, fs0 <2d,clamp,linear,miplinear>","mul ft0, ft0, v1","sub ft1.w, v2.z, fc1.x","div ft1.w, ft1.w, fc1.y","max ft1.w, ft1.w, fc1.z","min ft1.w, ft1.w, fc0.w","sub ft1.xyz, fc0.xyz, ft0.xyz","mul ft1.xyz, ft1.xyz, ft1.w","add ft0.xyz, ft0.xyz, ft1.xyz","mov oc, ft0"];
         var fragmentOpacityProgram:Array = ["tex ft0, v0, fs0 <2d,clamp,linear,miplinear>","tex ft1, v0, fs1 <2d,clamp,linear,miplinear>","mov ft0.w, ft1.x","mul ft0, ft0, v1","sub ft1.w, v2.z, fc1.x","div ft1.w, ft1.w, fc1.y","max ft1.w, ft1.w, fc1.z","min ft1.w, ft1.w, fc0.w","sub ft1.xyz, fc0.xyz, ft0.xyz","mul ft1.xyz, ft1.xyz, ft1.w","add ft0.xyz, ft0.xyz, ft1.xyz","mov oc, ft0"];
         var fragmentDiffuseBlendProgram:Array = ["tex ft0, v0, fs0 <2d,clamp,linear,miplinear>","mul ft0, ft0, v1","sub ft1.w, v2.z, fc1.x","div ft1.w, ft1.w, fc1.y","max ft1.w, ft1.w, fc1.z","min ft1.w, ft1.w, fc0.w","sub ft1.w, fc1.w, ft1.w","mul ft0.w, ft0.w, ft1.w","mov oc, ft0"];
         var fragmentOpacityBlendProgram:Array = ["tex ft0, v0, fs0 <2d,clamp,linear,miplinear>","tex ft1, v0, fs1 <2d,clamp,linear,miplinear>","mov ft0.w, ft1.x","mul ft0, ft0, v1","sub ft1.w, v2.z, fc1.x","div ft1.w, ft1.w, fc1.y","max ft1.w, ft1.w, fc1.z","min ft1.w, ft1.w, fc0.w","sub ft1.w, fc1.w, ft1.w","mul ft0.w, ft0.w, ft1.w","mov oc, ft0"];
         diffuseProgram = context.createProgram();
         opacityProgram = context.createProgram();
         diffuseBlendProgram = context.createProgram();
         opacityBlendProgram = context.createProgram();
         var compiledVertexProgram:ByteArray = this.compileProgram(Context3DProgramType.VERTEX,vertexProgram);
         diffuseProgram.upload(compiledVertexProgram,this.compileProgram(Context3DProgramType.FRAGMENT,fragmentDiffuseProgram));
         opacityProgram.upload(compiledVertexProgram,this.compileProgram(Context3DProgramType.FRAGMENT,fragmentOpacityProgram));
         diffuseBlendProgram.upload(compiledVertexProgram,this.compileProgram(Context3DProgramType.FRAGMENT,fragmentDiffuseBlendProgram));
         opacityBlendProgram.upload(compiledVertexProgram,this.compileProgram(Context3DProgramType.FRAGMENT,fragmentOpacityBlendProgram));
      }
      
      private function compileProgram(mode:String, program:Array) : ByteArray
      {
         var line:String = null;
         var string:String = "";
         var length:int = int(program.length);
         for(var i:int = 0; i < length; i++)
         {
            line = program[i];
            string += line + (i < length - 1 ? " \n" : "");
         }
         return new AGALMiniAssembler().assemble(mode,string,false);
      }
      
      private function flush(camera:Camera3D) : void
      {
         if(this.§_-hr§ == this.§_-ZN§.length)
         {
            this.§_-ZN§[this.§_-hr§] = new Object3D();
         }
         var object:Object3D = this.§_-ZN§[this.§_-hr§];
         ++this.§_-hr§;
         object.alternativa3d::localToCameraTransform.l = (this.§_-La§ + this.§_-p3§) / 2;
         this.drawUnit.alternativa3d::object = object;
         this.drawUnit.alternativa3d::numTriangles = this.counter << 1;
         if(this.blendDestination == Context3DBlendFactor.ONE_MINUS_SOURCE_ALPHA)
         {
            this.drawUnit.alternativa3d::program = this.opacity != null ? opacityProgram : diffuseProgram;
         }
         else
         {
            this.drawUnit.alternativa3d::program = this.opacity != null ? opacityBlendProgram : diffuseBlendProgram;
         }
         this.drawUnit.alternativa3d::setVertexBufferAt(0,vertexBuffer,0,Context3DVertexBufferFormat.FLOAT_3);
         this.drawUnit.alternativa3d::setVertexBufferAt(1,vertexBuffer,3,Context3DVertexBufferFormat.FLOAT_3);
         this.drawUnit.alternativa3d::setProjectionConstants(camera,124);
         this.drawUnit.alternativa3d::setFragmentConstantsFromNumbers(0,(this.§_-IN§ >> 16 & 0xFF) / 255,(this.§_-IN§ >> 8 & 0xFF) / 255,(this.§_-IN§ & 0xFF) / 255,this.fogMaxDensity);
         this.drawUnit.alternativa3d::setFragmentConstantsFromNumbers(1,this.fogNear,this.fogFar - this.fogNear,0,1);
         this.drawUnit.alternativa3d::setTextureAt(0,this.diffuse);
         if(this.opacity != null)
         {
            this.drawUnit.alternativa3d::setTextureAt(1,this.opacity);
         }
         this.drawUnit.alternativa3d::blendSource = this.blendSource;
         this.drawUnit.alternativa3d::blendDestination = this.blendDestination;
         this.drawUnit.alternativa3d::culling = Context3DTriangleFace.NONE;
         camera.alternativa3d::renderer.alternativa3d::addDrawUnit(this.drawUnit,RenderPriority.TRANSPARENT_SORT);
      }
      
      private function drawParticleList(camera:Camera3D, list:Particle) : void
      {
         var last:Particle = null;
         var offset:int = 0;
         if(list.next != null)
         {
            list = this.sortParticleList(list);
         }
         for(var particle:Particle = list; particle != null; )
         {
            if(this.counter >= limit || particle.diffuse != this.diffuse || particle.opacity != this.opacity || particle.blendSource != this.blendSource || particle.blendDestination != this.blendDestination)
            {
               if(this.drawUnit != null)
               {
                  this.flush(camera);
               }
               this.drawUnit = camera.alternativa3d::renderer.alternativa3d::createDrawUnit(null,null,indexBuffer,0,0);
               this.diffuse = particle.diffuse;
               this.opacity = particle.opacity;
               this.blendSource = particle.blendSource;
               this.blendDestination = particle.blendDestination;
               this.counter = 0;
               this.§_-La§ = particle.z;
            }
            offset = this.counter << 2;
            this.drawUnit.alternativa3d::setVertexConstantsFromNumbers(offset++,particle.originX,particle.originY,particle.width,particle.height);
            this.drawUnit.alternativa3d::setVertexConstantsFromNumbers(offset++,particle.x,particle.y,particle.z,particle.rotation);
            this.drawUnit.alternativa3d::setVertexConstantsFromNumbers(offset++,particle.§_-q§,particle.§_-Ts§,particle.§_-ej§,particle.§_-W5§);
            this.drawUnit.alternativa3d::setVertexConstantsFromNumbers(offset++,particle.red,particle.green,particle.blue,particle.alpha);
            ++this.counter;
            this.§_-p3§ = particle.z;
            last = particle;
            particle = particle.next;
         }
         last.next = Particle.collector;
         Particle.collector = list;
      }
      
      private function sortParticleList(list:Particle) : Particle
      {
         var left:Particle = list;
         var right:Particle = list.next;
         while(right != null && right.next != null)
         {
            list = list.next;
            right = right.next.next;
         }
         right = list.next;
         list.next = null;
         if(left.next != null)
         {
            left = this.sortParticleList(left);
         }
         if(right.next != null)
         {
            right = this.sortParticleList(right);
         }
         var flag:Boolean = left.z > right.z;
         if(flag)
         {
            list = left;
            left = left.next;
         }
         else
         {
            list = right;
            right = right.next;
         }
         var last:Particle = list;
         while(left != null)
         {
            if(right == null)
            {
               last.next = left;
               return list;
            }
            if(flag)
            {
               if(left.z > right.z)
               {
                  last = left;
                  left = left.next;
               }
               else
               {
                  last.next = right;
                  last = right;
                  right = right.next;
                  flag = false;
               }
            }
            else if(right.z > left.z)
            {
               last = right;
               right = right.next;
            }
            else
            {
               last.next = left;
               last = left;
               left = left.next;
               flag = true;
            }
         }
         last.next = right;
         return list;
      }
      
      private function drawConflictEffects(camera:Camera3D, effectList:§_-SG§) : void
      {
         var particleList:Particle = null;
         var next:§_-SG§ = null;
         var last:Particle = null;
         for(var effect:§_-SG§ = effectList; effect != null; )
         {
            next = effect.alternativa3d::next;
            effect.alternativa3d::next = null;
            for(last = effect.alternativa3d::particleList; last.next != null; )
            {
               last = last.next;
            }
            last.next = particleList;
            particleList = effect.alternativa3d::particleList;
            effect.alternativa3d::particleList = null;
            if(Boolean(camera.debug) && effect.boundBox != null && Boolean(camera.alternativa3d::checkInDebug(this) & Debug.BOUNDS))
            {
               Debug.alternativa3d::drawBoundBox(camera,effect.alternativa3d::aabb,alternativa3d::localToCameraTransform,16711680);
            }
            effect = next;
         }
         this.drawParticleList(camera,particleList);
      }
   }
}

