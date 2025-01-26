package package_123
{
   import flash.geom.Matrix3D;
   import flash.geom.Vector3D;
   import package_124.name_705;
   import package_125.name_709;
   import package_125.name_759;
   import package_125.name_760;
   import package_19.name_380;
   import package_19.name_528;
   import package_21.name_116;
   import package_21.name_78;
   
   use namespace collada;
   
   public class name_706 extends class_43
   {
      public var scene:name_737;
      
      public var parent:name_706;
      
      public var skinOrTopmostJoint:Boolean = false;
      
      private var channels:Vector.<name_742>;
      
      private var var_699:Vector.<name_757>;
      
      public var nodes:Vector.<name_706>;
      
      public var objects:Vector.<name_711>;
      
      public var skins:Vector.<name_711>;
      
      public function name_706(data:XML, document:name_707, scene:name_737 = null, parent:name_706 = null)
      {
         super(data,document);
         this.scene = scene;
         this.parent = parent;
         this.method_879();
      }
      
      public function get method_872() : String
      {
         var n:String = this.name;
         return n == null ? this.id : n;
      }
      
      private function method_879() : void
      {
         var node:name_706 = null;
         var nodesList:XMLList = data.node;
         var count:int = int(nodesList.length());
         this.nodes = new Vector.<name_706>(count);
         for(var i:int = 0; i < count; i++)
         {
            node = new name_706(nodesList[i],document,this.scene,this);
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
         var instanceController:name_757 = null;
         var jointNodes:Vector.<name_706> = null;
         var numNodes:int = 0;
         var jointNode:name_706 = null;
         var j:int = 0;
         var instanceControllerXMLs:XMLList = data.instance_controller;
         var count:int = int(instanceControllerXMLs.length());
         for(i = 0; i < count; )
         {
            this.skinOrTopmostJoint = true;
            instanceControllerXML = instanceControllerXMLs[i];
            instanceController = new name_757(instanceControllerXML,document,this);
            if(instanceController.method_314())
            {
               jointNodes = instanceController.topmostJoints;
               numNodes = int(jointNodes.length);
               if(numNodes > 0)
               {
                  jointNode = jointNodes[0];
                  jointNode.method_875(instanceController);
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
      
      public function name_747(channel:name_742) : void
      {
         if(this.channels == null)
         {
            this.channels = new Vector.<name_742>();
         }
         this.channels.push(channel);
      }
      
      public function method_875(controller:name_757) : void
      {
         if(this.var_699 == null)
         {
            this.var_699 = new Vector.<name_757>();
         }
         this.var_699.push(controller);
      }
      
      override protected function parseImplementation() : Boolean
      {
         this.skins = this.method_880();
         this.objects = this.method_878();
         return true;
      }
      
      private function method_874(geometry:XML) : Object
      {
         var instance:name_758 = null;
         var instances:Object = new Object();
         var list:XMLList = geometry.bind_material.technique_common.instance_material;
         for(var i:int = 0,var count:int = int(list.length()); i < count; i++)
         {
            instance = new name_758(list[i],document);
            instances[instance.symbol] = instance;
         }
         return instances;
      }
      
      public function getNodeBySid(sid:String) : name_706
      {
         var i:int = 0;
         var temp:Vector.<Vector.<name_706>> = null;
         var children:Vector.<name_706> = null;
         var count:int = 0;
         var j:int = 0;
         var node:name_706 = null;
         if(sid == this.sid)
         {
            return this;
         }
         var levelNodes:Vector.<Vector.<name_706>> = new Vector.<Vector.<name_706>>();
         var levelNodes2:Vector.<Vector.<name_706>> = new Vector.<Vector.<name_706>>();
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
      
      public function method_880() : Vector.<name_711>
      {
         var instanceController:name_757 = null;
         var skinAndAnimatedJoints:name_711 = null;
         var skin:name_528 = null;
         if(this.var_699 == null)
         {
            return null;
         }
         var skins:Vector.<name_711> = new Vector.<name_711>();
         for(var i:int = 0,var count:int = int(this.var_699.length); i < count; )
         {
            instanceController = this.var_699[i];
            instanceController.method_314();
            skinAndAnimatedJoints = instanceController.method_429(this.method_874(instanceController.data));
            if(skinAndAnimatedJoints != null)
            {
               skin = name_528(skinAndAnimatedJoints.object);
               skin.name = name_708(instanceController.node.name);
               skins.push(skinAndAnimatedJoints);
            }
            i++;
         }
         return skins.length > 0 ? skins : null;
      }
      
      public function method_878() : Vector.<name_711>
      {
         var i:int = 0;
         var count:int = 0;
         var child:XML = null;
         var lightInstance:name_741 = null;
         var geom:name_736 = null;
         var light:name_116 = null;
         var rotXMatrix:Matrix3D = null;
         var mesh:name_380 = null;
         var objects:Vector.<name_711> = new Vector.<name_711>();
         var children:XMLList = data.children();
         for(i = 0,count = int(children.length()); i < count; )
         {
            child = children[i];
            switch(child.localName())
            {
               case "instance_light":
                  lightInstance = document.findLight(child.@url[0]);
                  if(lightInstance != null)
                  {
                     light = lightInstance.name_762();
                     if(light != null)
                     {
                        light.name = name_708(name);
                        if(lightInstance.name_761)
                        {
                           rotXMatrix = new Matrix3D();
                           rotXMatrix.appendRotation(180,Vector3D.X_AXIS);
                           objects.push(new name_711(this.name_710(light,rotXMatrix)));
                        }
                        else
                        {
                           objects.push(this.name_714(this.name_710(light)));
                        }
                     }
                  }
                  else
                  {
                     document.logger.logNotFoundError(child.@url[0]);
                  }
                  break;
               case "instance_geometry":
                  geom = document.findGeometry(child.@url[0]);
                  if(geom != null)
                  {
                     geom.method_314();
                     mesh = geom.method_727(this.method_874(child));
                     if(mesh != null)
                     {
                        mesh.name = name_708(name);
                        objects.push(this.name_714(this.name_710(mesh)));
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
      
      private function method_873(initialMatrix:Matrix3D = null) : Matrix3D
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
                  components = method_866(child);
                  matrix.appendScale(components[0],components[1],components[2]);
                  break;
               case "rotate":
                  components = method_866(child);
                  matrix.appendRotation(components[3],new Vector3D(components[0],components[1],components[2]));
                  break;
               case "translate":
                  components = method_866(child);
                  matrix.appendTranslation(components[0] * document.unitScaleFactor,components[1] * document.unitScaleFactor,components[2] * document.unitScaleFactor);
                  break;
               case "matrix":
                  components = method_866(child);
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
      
      public function name_710(object:name_78, prepend:Matrix3D = null, append:Matrix3D = null) : name_78
      {
         var matrix:Matrix3D = this.method_873(prepend);
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
      
      public function name_714(object:name_78) : name_711
      {
         var animation:name_705 = this.method_747(object);
         if(animation == null)
         {
            return new name_711(object);
         }
         object.name = this.method_872;
         animation.method_861(object,false);
         return new name_711(object,animation);
      }
      
      public function method_747(object:name_78 = null) : name_705
      {
         if(this.channels == null || !this.method_877())
         {
            return null;
         }
         var channel:name_742 = this.method_620(name_742.PARAM_MATRIX);
         if(channel != null)
         {
            return this.method_876(channel.tracks);
         }
         var clip:name_705 = new name_705();
         var components:Vector.<Vector3D> = object != null ? null : this.method_873().decompose();
         channel = this.method_620(name_742.PARAM_TRANSLATE);
         if(channel != null)
         {
            this.method_870(clip,channel.tracks);
         }
         else
         {
            channel = this.method_620(name_742.PARAM_TRANSLATE_X);
            if(channel != null)
            {
               this.method_870(clip,channel.tracks);
            }
            else
            {
               clip.name_712(this.method_871("x",object == null ? Number(components[0].x) : object.x));
            }
            channel = this.method_620(name_742.PARAM_TRANSLATE_Y);
            if(channel != null)
            {
               this.method_870(clip,channel.tracks);
            }
            else
            {
               clip.name_712(this.method_871("y",object == null ? Number(components[0].y) : object.y));
            }
            channel = this.method_620(name_742.PARAM_TRANSLATE_Z);
            if(channel != null)
            {
               this.method_870(clip,channel.tracks);
            }
            else
            {
               clip.name_712(this.method_871("z",object == null ? Number(components[0].z) : object.z));
            }
         }
         channel = this.method_620(name_742.PARAM_ROTATION_X);
         if(channel != null)
         {
            this.method_870(clip,channel.tracks);
         }
         else
         {
            clip.name_712(this.method_871("rotationX",object == null ? Number(components[1].x) : object.rotationX));
         }
         channel = this.method_620(name_742.PARAM_ROTATION_Y);
         if(channel != null)
         {
            this.method_870(clip,channel.tracks);
         }
         else
         {
            clip.name_712(this.method_871("rotationY",object == null ? Number(components[1].y) : object.rotationY));
         }
         channel = this.method_620(name_742.PARAM_ROTATION_Z);
         if(channel != null)
         {
            this.method_870(clip,channel.tracks);
         }
         else
         {
            clip.name_712(this.method_871("rotationZ",object == null ? Number(components[1].z) : object.rotationZ));
         }
         channel = this.method_620(name_742.PARAM_SCALE);
         if(channel != null)
         {
            this.method_870(clip,channel.tracks);
         }
         else
         {
            channel = this.method_620(name_742.PARAM_SCALE_X);
            if(channel != null)
            {
               this.method_870(clip,channel.tracks);
            }
            else
            {
               clip.name_712(this.method_871("scaleX",object == null ? Number(components[2].x) : object.scaleX));
            }
            channel = this.method_620(name_742.PARAM_SCALE_Y);
            if(channel != null)
            {
               this.method_870(clip,channel.tracks);
            }
            else
            {
               clip.name_712(this.method_871("scaleY",object == null ? Number(components[2].y) : object.scaleY));
            }
            channel = this.method_620(name_742.PARAM_SCALE_Z);
            if(channel != null)
            {
               this.method_870(clip,channel.tracks);
            }
            else
            {
               clip.name_712(this.method_871("scaleZ",object == null ? Number(components[2].z) : object.scaleZ));
            }
         }
         if(clip.numTracks > 0)
         {
            return clip;
         }
         return null;
      }
      
      private function method_876(tracks:Vector.<name_709>) : name_705
      {
         var clip:name_705 = new name_705();
         for(var i:int = 0,var count:int = int(tracks.length); i < count; i++)
         {
            clip.name_712(tracks[i]);
         }
         return clip;
      }
      
      private function method_870(clip:name_705, tracks:Vector.<name_709>) : void
      {
         for(var i:int = 0,var count:int = int(tracks.length); i < count; i++)
         {
            clip.name_712(tracks[i]);
         }
      }
      
      private function method_877() : Boolean
      {
         var channel:name_742 = null;
         var result:Boolean = false;
         for(var i:int = 0,var count:int = int(this.channels.length); i < count; )
         {
            channel = this.channels[i];
            channel.method_314();
            result = channel.name_756 == name_742.PARAM_MATRIX;
            result ||= channel.name_756 == name_742.PARAM_TRANSLATE;
            result ||= channel.name_756 == name_742.PARAM_TRANSLATE_X;
            result ||= channel.name_756 == name_742.PARAM_TRANSLATE_Y;
            result ||= channel.name_756 == name_742.PARAM_TRANSLATE_Z;
            result ||= channel.name_756 == name_742.PARAM_ROTATION_X;
            result ||= channel.name_756 == name_742.PARAM_ROTATION_Y;
            result ||= channel.name_756 == name_742.PARAM_ROTATION_Z;
            result ||= channel.name_756 == name_742.PARAM_SCALE;
            result ||= channel.name_756 == name_742.PARAM_SCALE_X;
            result ||= channel.name_756 == name_742.PARAM_SCALE_Y;
            result ||= channel.name_756 == name_742.PARAM_SCALE_Z;
            if(result)
            {
               return true;
            }
            i++;
         }
         return false;
      }
      
      private function method_620(param:String) : name_742
      {
         var channel:name_742 = null;
         for(var i:int = 0,var count:int = int(this.channels.length); i < count; )
         {
            channel = this.channels[i];
            channel.method_314();
            if(channel.name_756 == param)
            {
               return channel;
            }
            i++;
         }
         return null;
      }
      
      private function method_881(source:Vector.<name_709>, dest:Vector.<name_709>) : void
      {
         for(var i:int = 0,var count:int = int(source.length); i < count; i++)
         {
            dest.push(source[i]);
         }
      }
      
      private function method_871(property:String, value:Number) : name_709
      {
         var track:name_760 = new name_760(this.method_872,property);
         track.method_257(0,value);
         return track;
      }
      
      public function name_715() : name_759
      {
         var track:name_759 = new name_759(this.method_872);
         track.method_257(0,this.method_873());
         return track;
      }
      
      public function get layer() : String
      {
         var layerXML:XML = data.@layer[0];
         return layerXML == null ? null : layerXML.toString();
      }
   }
}

