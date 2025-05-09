package alternativa.engine3d.loaders.collada
{
   import alternativa.engine3d.animation.§_-FA§;
   import alternativa.engine3d.animation.keys.§_-Np§;
   import alternativa.engine3d.animation.keys.§_-ew§;
   import alternativa.engine3d.animation.keys.§_-kB§;
   import alternativa.engine3d.core.Light3D;
   import alternativa.engine3d.core.Object3D;
   import alternativa.engine3d.objects.Mesh;
   import alternativa.engine3d.objects.Skin;
   import flash.geom.Matrix3D;
   import flash.geom.Vector3D;
   
   use namespace collada;
   
   public class DaeNode extends DaeElement
   {
      public var scene:DaeVisualScene;
      
      public var parent:DaeNode;
      
      public var skinOrTopmostJoint:Boolean = false;
      
      private var channels:Vector.<DaeChannel>;
      
      private var §_-DE§:Vector.<DaeInstanceController>;
      
      public var nodes:Vector.<DaeNode>;
      
      public var objects:Vector.<DaeObject>;
      
      public var skins:Vector.<DaeObject>;
      
      public function DaeNode(data:XML, document:DaeDocument, scene:DaeVisualScene = null, parent:DaeNode = null)
      {
         super(data,document);
         this.scene = scene;
         this.parent = parent;
         this.constructNodes();
      }
      
      public function get animName() : String
      {
         var n:String = this.name;
         return n == null ? this.id : n;
      }
      
      private function constructNodes() : void
      {
         var node:DaeNode = null;
         var nodesList:XMLList = data.node;
         var count:int = int(nodesList.length());
         this.nodes = new Vector.<DaeNode>(count);
         for(var i:int = 0; i < count; i++)
         {
            node = new DaeNode(nodesList[i],document,this.scene,this);
            if(node.id != null)
            {
               document.nodes[node.id] = node;
            }
            this.nodes[i] = node;
         }
      }
      
      internal function registerInstanceControllers() : void
      {
         var i:int = 0;
         var instanceControllerXML:XML = null;
         var instanceController:DaeInstanceController = null;
         var jointNodes:Vector.<DaeNode> = null;
         var numNodes:int = 0;
         var jointNode:DaeNode = null;
         var j:int = 0;
         var instanceControllerXMLs:XMLList = data.instance_controller;
         var count:int = int(instanceControllerXMLs.length());
         for(i = 0; i < count; )
         {
            this.skinOrTopmostJoint = true;
            instanceControllerXML = instanceControllerXMLs[i];
            instanceController = new DaeInstanceController(instanceControllerXML,document,this);
            if(instanceController.parse())
            {
               jointNodes = instanceController.topmostJoints;
               numNodes = int(jointNodes.length);
               if(numNodes > 0)
               {
                  jointNode = jointNodes[0];
                  jointNode.addInstanceController(instanceController);
                  for(j = 0; j < numNodes; j++)
                  {
                     jointNodes[j].skinOrTopmostJoint = true;
                  }
               }
            }
            i++;
         }
         count = int(this.nodes.length);
         for(i = 0; i < count; i++)
         {
            this.nodes[i].registerInstanceControllers();
         }
      }
      
      public function addChannel(channel:DaeChannel) : void
      {
         if(this.channels == null)
         {
            this.channels = new Vector.<DaeChannel>();
         }
         this.channels.push(channel);
      }
      
      public function addInstanceController(controller:DaeInstanceController) : void
      {
         if(this.§_-DE§ == null)
         {
            this.§_-DE§ = new Vector.<DaeInstanceController>();
         }
         this.§_-DE§.push(controller);
      }
      
      override protected function parseImplementation() : Boolean
      {
         this.skins = this.parseSkins();
         this.objects = this.parseObjects();
         return true;
      }
      
      private function parseInstanceMaterials(geometry:XML) : Object
      {
         var instance:DaeInstanceMaterial = null;
         var instances:Object = new Object();
         var list:XMLList = geometry.bind_material.technique_common.instance_material;
         for(var i:int = 0,var count:int = int(list.length()); i < count; i++)
         {
            instance = new DaeInstanceMaterial(list[i],document);
            instances[instance.symbol] = instance;
         }
         return instances;
      }
      
      public function getNodeBySid(sid:String) : DaeNode
      {
         var i:int = 0;
         var temp:Vector.<Vector.<DaeNode>> = null;
         var children:Vector.<DaeNode> = null;
         var count:int = 0;
         var j:int = 0;
         var node:DaeNode = null;
         if(sid == this.sid)
         {
            return this;
         }
         var levelNodes:Vector.<Vector.<DaeNode>> = new Vector.<Vector.<DaeNode>>();
         var levelNodes2:Vector.<Vector.<DaeNode>> = new Vector.<Vector.<DaeNode>>();
         levelNodes.push(this.nodes);
         for(var len:int = int(levelNodes.length); len > 0; )
         {
            for(i = 0; i < len; i++)
            {
               children = levelNodes[i];
               count = int(children.length);
               for(j = 0; j < count; )
               {
                  node = children[j];
                  if(node.sid == sid)
                  {
                     return node;
                  }
                  if(node.nodes.length > 0)
                  {
                     levelNodes2.push(node.nodes);
                  }
                  j++;
               }
            }
            temp = levelNodes;
            levelNodes = levelNodes2;
            levelNodes2 = temp;
            levelNodes2.length = 0;
            len = int(levelNodes.length);
         }
         return null;
      }
      
      public function parseSkins() : Vector.<DaeObject>
      {
         var instanceController:DaeInstanceController = null;
         var skinAndAnimatedJoints:DaeObject = null;
         var skin:Skin = null;
         if(this.§_-DE§ == null)
         {
            return null;
         }
         var skins:Vector.<DaeObject> = new Vector.<DaeObject>();
         for(var i:int = 0,var count:int = int(this.§_-DE§.length); i < count; )
         {
            instanceController = this.§_-DE§[i];
            instanceController.parse();
            skinAndAnimatedJoints = instanceController.parseSkin(this.parseInstanceMaterials(instanceController.data));
            if(skinAndAnimatedJoints != null)
            {
               skin = Skin(skinAndAnimatedJoints.object);
               skin.name = cloneString(instanceController.node.name);
               skins.push(skinAndAnimatedJoints);
            }
            i++;
         }
         return skins.length > 0 ? skins : null;
      }
      
      public function parseObjects() : Vector.<DaeObject>
      {
         var i:int = 0;
         var count:int = 0;
         var child:XML = null;
         var _loc6_:DaeLight = null;
         var _loc7_:DaeGeometry = null;
         var light:Light3D = null;
         var rotXMatrix:Matrix3D = null;
         var mesh:Mesh = null;
         var objects:Vector.<DaeObject> = new Vector.<DaeObject>();
         var children:XMLList = data.children();
         for(i = 0,count = int(children.length()); i < count; )
         {
            child = children[i];
            switch(child.localName())
            {
               case "instance_light":
                  _loc6_ = document.findLight(child.@url[0]);
                  if(_loc6_ != null)
                  {
                     light = _loc6_.parseLight();
                     if(light != null)
                     {
                        light.name = cloneString(name);
                        if(_loc6_.revertDirection)
                        {
                           rotXMatrix = new Matrix3D();
                           rotXMatrix.appendRotation(180,Vector3D.X_AXIS);
                           objects.push(new DaeObject(this.applyTransformations(light,rotXMatrix)));
                        }
                        else
                        {
                           objects.push(this.applyAnimation(this.applyTransformations(light)));
                        }
                     }
                  }
                  else
                  {
                     document.logger.logNotFoundError(child.@url[0]);
                  }
                  break;
               case "instance_geometry":
                  _loc7_ = document.findGeometry(child.@url[0]);
                  if(_loc7_ != null)
                  {
                     _loc7_.parse();
                     mesh = _loc7_.parseMesh(this.parseInstanceMaterials(child));
                     if(mesh != null)
                     {
                        mesh.name = cloneString(name);
                        objects.push(this.applyAnimation(this.applyTransformations(mesh)));
                     }
                  }
                  else
                  {
                     document.logger.logNotFoundError(child.@url[0]);
                  }
                  break;
               case "instance_node":
                  document.logger.logInstanceNodeError(child);
                  break;
            }
            i++;
         }
         return objects.length > 0 ? objects : null;
      }
      
      private function getMatrix(initialMatrix:Matrix3D = null) : Matrix3D
      {
         var components:Array = null;
         var child:XML = null;
         var sid:XML = null;
         var matrix:Matrix3D = initialMatrix == null ? new Matrix3D() : initialMatrix;
         var children:XMLList = data.children();
         for(var i:int = children.length() - 1; i >= 0; i--)
         {
            child = children[i];
            sid = child.@sid[0];
            if(sid != null && sid.toString() == "post-rotationY")
            {
               continue;
            }
            switch(child.localName())
            {
               case "scale":
                  components = parseNumbersArray(child);
                  matrix.appendScale(components[0],components[1],components[2]);
                  break;
               case "rotate":
                  components = parseNumbersArray(child);
                  matrix.appendRotation(components[3],new Vector3D(components[0],components[1],components[2]));
                  break;
               case "translate":
                  components = parseNumbersArray(child);
                  matrix.appendTranslation(components[0] * document.unitScaleFactor,components[1] * document.unitScaleFactor,components[2] * document.unitScaleFactor);
                  break;
               case "matrix":
                  components = parseNumbersArray(child);
                  matrix.append(new Matrix3D(Vector.<Number>([components[0],components[4],components[8],components[12],components[1],components[5],components[9],components[13],components[2],components[6],components[10],components[14],components[3] * document.unitScaleFactor,components[7] * document.unitScaleFactor,components[11] * document.unitScaleFactor,components[15]])));
                  break;
               case "lookat":
                  break;
               case "skew":
                  document.logger.logSkewError(child);
                  break;
            }
         }
         return matrix;
      }
      
      public function applyTransformations(object:Object3D, prepend:Matrix3D = null, append:Matrix3D = null) : Object3D
      {
         var matrix:Matrix3D = this.getMatrix(prepend);
         if(append != null)
         {
            matrix.append(append);
         }
         var vs:Vector.<Vector3D> = matrix.decompose();
         var t:Vector3D = vs[0];
         var r:Vector3D = vs[1];
         var s:Vector3D = vs[2];
         object.x = t.x;
         object.y = t.y;
         object.z = t.z;
         object.rotationX = r.x;
         object.rotationY = r.y;
         object.rotationZ = r.z;
         object.scaleX = s.x;
         object.scaleY = s.y;
         object.scaleZ = s.z;
         return object;
      }
      
      public function applyAnimation(object:Object3D) : DaeObject
      {
         var animation:§_-FA§ = this.parseAnimation(object);
         if(animation == null)
         {
            return new DaeObject(object);
         }
         object.name = this.animName;
         animation.§_-L6§(object,false);
         return new DaeObject(object,animation);
      }
      
      public function parseAnimation(object:Object3D = null) : §_-FA§
      {
         if(this.channels == null || !this.hasTransformationAnimation())
         {
            return null;
         }
         var channel:DaeChannel = this.getChannel(DaeChannel.PARAM_MATRIX);
         if(channel != null)
         {
            return this.createClip(channel.tracks);
         }
         var clip:§_-FA§ = new §_-FA§();
         var components:Vector.<Vector3D> = object != null ? null : this.getMatrix().decompose();
         channel = this.getChannel(DaeChannel.PARAM_TRANSLATE);
         if(channel != null)
         {
            this.addTracksToClip(clip,channel.tracks);
         }
         else
         {
            channel = this.getChannel(DaeChannel.PARAM_TRANSLATE_X);
            if(channel != null)
            {
               this.addTracksToClip(clip,channel.tracks);
            }
            else
            {
               clip.§_-nn§(this.createValueStaticTrack("x",object == null ? Number(components[0].x) : object.x));
            }
            channel = this.getChannel(DaeChannel.PARAM_TRANSLATE_Y);
            if(channel != null)
            {
               this.addTracksToClip(clip,channel.tracks);
            }
            else
            {
               clip.§_-nn§(this.createValueStaticTrack("y",object == null ? Number(components[0].y) : object.y));
            }
            channel = this.getChannel(DaeChannel.PARAM_TRANSLATE_Z);
            if(channel != null)
            {
               this.addTracksToClip(clip,channel.tracks);
            }
            else
            {
               clip.§_-nn§(this.createValueStaticTrack("z",object == null ? Number(components[0].z) : object.z));
            }
         }
         channel = this.getChannel(DaeChannel.PARAM_ROTATION_X);
         if(channel != null)
         {
            this.addTracksToClip(clip,channel.tracks);
         }
         else
         {
            clip.§_-nn§(this.createValueStaticTrack("rotationX",object == null ? Number(components[1].x) : object.rotationX));
         }
         channel = this.getChannel(DaeChannel.PARAM_ROTATION_Y);
         if(channel != null)
         {
            this.addTracksToClip(clip,channel.tracks);
         }
         else
         {
            clip.§_-nn§(this.createValueStaticTrack("rotationY",object == null ? Number(components[1].y) : object.rotationY));
         }
         channel = this.getChannel(DaeChannel.PARAM_ROTATION_Z);
         if(channel != null)
         {
            this.addTracksToClip(clip,channel.tracks);
         }
         else
         {
            clip.§_-nn§(this.createValueStaticTrack("rotationZ",object == null ? Number(components[1].z) : object.rotationZ));
         }
         channel = this.getChannel(DaeChannel.PARAM_SCALE);
         if(channel != null)
         {
            this.addTracksToClip(clip,channel.tracks);
         }
         else
         {
            channel = this.getChannel(DaeChannel.PARAM_SCALE_X);
            if(channel != null)
            {
               this.addTracksToClip(clip,channel.tracks);
            }
            else
            {
               clip.§_-nn§(this.createValueStaticTrack("scaleX",object == null ? Number(components[2].x) : object.scaleX));
            }
            channel = this.getChannel(DaeChannel.PARAM_SCALE_Y);
            if(channel != null)
            {
               this.addTracksToClip(clip,channel.tracks);
            }
            else
            {
               clip.§_-nn§(this.createValueStaticTrack("scaleY",object == null ? Number(components[2].y) : object.scaleY));
            }
            channel = this.getChannel(DaeChannel.PARAM_SCALE_Z);
            if(channel != null)
            {
               this.addTracksToClip(clip,channel.tracks);
            }
            else
            {
               clip.§_-nn§(this.createValueStaticTrack("scaleZ",object == null ? Number(components[2].z) : object.scaleZ));
            }
         }
         if(clip.numTracks > 0)
         {
            return clip;
         }
         return null;
      }
      
      private function createClip(tracks:Vector.<§_-Np§>) : §_-FA§
      {
         var clip:§_-FA§ = new §_-FA§();
         for(var i:int = 0,var count:int = int(tracks.length); i < count; i++)
         {
            clip.§_-nn§(tracks[i]);
         }
         return clip;
      }
      
      private function addTracksToClip(clip:§_-FA§, tracks:Vector.<§_-Np§>) : void
      {
         for(var i:int = 0,var count:int = int(tracks.length); i < count; i++)
         {
            clip.§_-nn§(tracks[i]);
         }
      }
      
      private function hasTransformationAnimation() : Boolean
      {
         var channel:DaeChannel = null;
         var result:Boolean = false;
         for(var i:int = 0,var count:int = int(this.channels.length); i < count; )
         {
            channel = this.channels[i];
            channel.parse();
            result = channel.§_-dS§ == DaeChannel.PARAM_MATRIX;
            result ||= channel.§_-dS§ == DaeChannel.PARAM_TRANSLATE;
            result ||= channel.§_-dS§ == DaeChannel.PARAM_TRANSLATE_X;
            result ||= channel.§_-dS§ == DaeChannel.PARAM_TRANSLATE_Y;
            result ||= channel.§_-dS§ == DaeChannel.PARAM_TRANSLATE_Z;
            result ||= channel.§_-dS§ == DaeChannel.PARAM_ROTATION_X;
            result ||= channel.§_-dS§ == DaeChannel.PARAM_ROTATION_Y;
            result ||= channel.§_-dS§ == DaeChannel.PARAM_ROTATION_Z;
            result ||= channel.§_-dS§ == DaeChannel.PARAM_SCALE;
            result ||= channel.§_-dS§ == DaeChannel.PARAM_SCALE_X;
            result ||= channel.§_-dS§ == DaeChannel.PARAM_SCALE_Y;
            result ||= channel.§_-dS§ == DaeChannel.PARAM_SCALE_Z;
            if(result)
            {
               return true;
            }
            i++;
         }
         return false;
      }
      
      private function getChannel(param:String) : DaeChannel
      {
         var channel:DaeChannel = null;
         for(var i:int = 0,var count:int = int(this.channels.length); i < count; )
         {
            channel = this.channels[i];
            channel.parse();
            if(channel.§_-dS§ == param)
            {
               return channel;
            }
            i++;
         }
         return null;
      }
      
      private function concatTracks(source:Vector.<§_-Np§>, dest:Vector.<§_-Np§>) : void
      {
         for(var i:int = 0,var count:int = int(source.length); i < count; i++)
         {
            dest.push(source[i]);
         }
      }
      
      private function createValueStaticTrack(property:String, value:Number) : §_-Np§
      {
         var track:§_-kB§ = new §_-kB§(this.animName,property);
         track.addKey(0,value);
         return track;
      }
      
      public function createStaticTransformTrack() : §_-ew§
      {
         var track:§_-ew§ = new §_-ew§(this.animName);
         track.addKey(0,this.getMatrix());
         return track;
      }
      
      public function get layer() : String
      {
         var layerXML:XML = data.@layer[0];
         return layerXML == null ? null : layerXML.toString();
      }
   }
}

