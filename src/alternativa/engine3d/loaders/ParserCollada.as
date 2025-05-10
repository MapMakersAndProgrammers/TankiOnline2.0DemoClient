package alternativa.engine3d.loaders
{
   import alternativa.engine3d.alternativa3d;
   import alternativa.engine3d.animation.AnimationClip;
   import alternativa.engine3d.animation.keys.Track;
   import alternativa.engine3d.core.Light3D;
   import alternativa.engine3d.core.Object3D;
   import alternativa.engine3d.loaders.collada.DaeDocument;
   import alternativa.engine3d.loaders.collada.DaeMaterial;
   import alternativa.engine3d.loaders.collada.DaeNode;
   import alternativa.engine3d.loaders.collada.DaeObject;
   import alternativa.engine3d.resources.ExternalTextureResource;
   import flash.utils.Dictionary;
   
   use namespace alternativa3d;
   
   public class ParserCollada
   {
      public var hierarchy:Vector.<Object3D>;
      
      public var objects:Vector.<Object3D>;
      
      public var lights:Vector.<Light3D>;
      
      public var materials:Vector.<ParserMaterial>;
      
      public var name_eL:Vector.<AnimationClip>;
      
      private var name_W6:Dictionary;
      
      public function ParserCollada()
      {
         super();
      }
      
      public static function parseAnimation(data:XML) : AnimationClip
      {
         var document:DaeDocument = new DaeDocument(data,0);
         var clip:AnimationClip = new AnimationClip();
         collectAnimation(clip,document.scene.nodes);
         return clip.numTracks > 0 ? clip : null;
      }
      
      private static function collectAnimation(clip:AnimationClip, nodes:Vector.<DaeNode>) : void
      {
         var node:DaeNode = null;
         var animation:AnimationClip = null;
         var t:int = 0;
         var numTracks:int = 0;
         var track:Track = null;
         for(var i:int = 0, count:int = int(nodes.length); i < count; i++)
         {
            node = nodes[i];
            animation = node.parseAnimation();
            if(animation != null)
            {
               for(t = 0,numTracks = animation.numTracks; t < numTracks; t++)
               {
                  track = animation.getTrackAt(t);
                  clip.addTrack(track);
               }
            }
            else
            {
               clip.addTrack(node.createStaticTransformTrack());
            }
            collectAnimation(clip,node.nodes);
         }
      }
      
      public function clean() : void
      {
         this.objects = null;
         this.hierarchy = null;
         this.lights = null;
         this.name_eL = null;
         this.materials = null;
         this.name_W6 = null;
      }
      
      public function getObjectLayer(object:Object3D) : String
      {
         return this.name_W6[object];
      }
      
      private function init(data:XML, units:Number) : DaeDocument
      {
         this.clean();
         this.objects = new Vector.<Object3D>();
         this.hierarchy = new Vector.<Object3D>();
         this.lights = new Vector.<Light3D>();
         this.name_eL = new Vector.<AnimationClip>();
         this.materials = new Vector.<ParserMaterial>();
         this.name_W6 = new Dictionary(true);
         return new DaeDocument(data,units);
      }
      
      public function parse(data:XML, baseURL:String = null, trimPaths:Boolean = false) : void
      {
         var i:int = 0;
         var count:int = 0;
         var document:DaeDocument = this.init(data,0);
         if(document.scene != null)
         {
            this.parseNodes(document.scene.nodes,null,false);
            this.parseMaterials(document.materials,baseURL,trimPaths);
            for(i = 0,count = int(this.hierarchy.length); i < count; i++)
            {
               this.hierarchy[i].calculateBoundBox();
            }
         }
      }
      
      private function addObject(animatedObject:DaeObject, parent:Object3D, layer:String) : Object3D
      {
         var object:Object3D = Object3D(animatedObject.object);
         this.objects.push(object);
         if(parent == null)
         {
            this.hierarchy.push(object);
         }
         else
         {
            parent.addChild(object);
         }
         if(object is Light3D)
         {
            this.lights.push(Light3D(object));
         }
         if(animatedObject.animation != null)
         {
            this.name_eL.push(animatedObject.animation);
         }
         if(Boolean(layer))
         {
            this.name_W6[object] = layer;
         }
         return object;
      }
      
      private function addObjects(animatedObjects:Vector.<DaeObject>, parent:Object3D, layer:String) : Object3D
      {
         var first:Object3D = this.addObject(animatedObjects[0],parent,layer);
         for(var i:int = 1,var count:int = int(animatedObjects.length); i < count; i++)
         {
            this.addObject(animatedObjects[i],parent,layer);
         }
         return first;
      }
      
      private function hasSkinsInChildren(node:DaeNode) : Boolean
      {
         var child:DaeNode = null;
         var nodes:Vector.<DaeNode> = node.nodes;
         for(var i:int = 0, count:int = int(nodes.length); i < count; )
         {
            child = nodes[i];
            child.parse();
            if(child.skins != null)
            {
               return true;
            }
            if(this.hasSkinsInChildren(child))
            {
               return true;
            }
            i++;
         }
         return false;
      }
      
      private function parseNodes(nodes:Vector.<DaeNode>, parent:Object3D, skinsOnly:Boolean = false) : void
      {
         var node:DaeNode = null;
         var container:Object3D = null;
         for(var i:int = 0, count:int = int(nodes.length); i < count; )
         {
            node = nodes[i];
            node.parse();
            container = null;
            if(node.skins != null)
            {
               container = this.addObjects(node.skins,parent,node.layer);
            }
            else if(!skinsOnly && !node.skinOrTopmostJoint)
            {
               if(node.objects != null)
               {
                  container = this.addObjects(node.objects,parent,node.layer);
               }
               else
               {
                  container = new Object3D();
                  container.name = node.cloneString(node.name);
                  this.addObject(node.applyAnimation(node.applyTransformations(container)),parent,node.layer);
               }
            }
            else if(this.hasSkinsInChildren(node))
            {
               container = new Object3D();
               container.name = node.cloneString(node.name);
               this.addObject(node.applyAnimation(node.applyTransformations(container)),parent,node.layer);
               this.parseNodes(node.nodes,container,skinsOnly || node.skinOrTopmostJoint);
            }
            if(container != null)
            {
               this.parseNodes(node.nodes,container,skinsOnly || node.skinOrTopmostJoint);
            }
            i++;
         }
      }
      
      private function trimPath(path:String) : String
      {
         var index:int = int(path.lastIndexOf("/"));
         return index < 0 ? path : path.substr(index + 1);
      }
      
      private function parseMaterials(materials:Object, baseURL:String, trimPaths:Boolean) : void
      {
         var tmaterial:ParserMaterial = null;
         var material:DaeMaterial = null;
         var resource:ExternalTextureResource = null;
         var base:String = null;
         var end:int = 0;
         for each(material in materials)
         {
            if(material.used)
            {
               material.parse();
               this.materials.push(material.material);
            }
         }
         if(trimPaths)
         {
            for each(tmaterial in this.materials)
            {
               for each(resource in tmaterial.textures)
               {
                  if(resource != null && resource.url != null)
                  {
                     resource.url = this.trimPath(this.fixURL(resource.url));
                  }
               }
            }
         }
         else
         {
            for each(tmaterial in this.materials)
            {
               for each(resource in tmaterial.textures)
               {
                  if(resource != null && resource.url != null)
                  {
                     resource.url = this.fixURL(resource.url);
                  }
               }
            }
         }
         if(baseURL != null)
         {
            baseURL = this.fixURL(baseURL);
            end = int(baseURL.lastIndexOf("/"));
            base = end < 0 ? "" : baseURL.substr(0,end);
            for each(tmaterial in this.materials)
            {
               for each(resource in tmaterial.textures)
               {
                  if(resource != null && resource.url != null)
                  {
                     resource.url = this.resolveURL(resource.url,base);
                  }
               }
            }
         }
      }
      
      private function fixURL(url:String) : String
      {
         var pathStart:int = int(url.indexOf("://"));
         pathStart = pathStart < 0 ? 0 : pathStart + 3;
         var pathEnd:int = int(url.indexOf("?",pathStart));
         pathEnd = pathEnd < 0 ? int(url.indexOf("#",pathStart)) : pathEnd;
         var path:String = url.substring(pathStart,pathEnd < 0 ? 2147483647 : pathEnd);
         path = path.replace(/\\/g,"/");
         var fileIndex:int = int(url.indexOf("file://"));
         if(fileIndex >= 0)
         {
            if(url.charAt(pathStart) == "/")
            {
               return "file://" + path + (pathEnd >= 0 ? url.substring(pathEnd) : "");
            }
            return "file:///" + path + (pathEnd >= 0 ? url.substring(pathEnd) : "");
         }
         return url.substring(0,pathStart) + path + (pathEnd >= 0 ? url.substring(pathEnd) : "");
      }
      
      private function mergePath(path:String, base:String, relative:Boolean = false) : String
      {
         var part:String = null;
         var basePart:String = null;
         var baseParts:Array = base.split("/");
         var parts:Array = path.split("/");
         for(var i:int = 0, count:int = int(parts.length); i < count; i++)
         {
            part = parts[i];
            if(part == "..")
            {
               basePart = baseParts.pop();
               while(basePart == "." || basePart == "" && basePart != null)
               {
                  basePart = baseParts.pop();
               }
               if(relative)
               {
                  if(basePart == "..")
                  {
                     baseParts.push("..","..");
                  }
                  else if(basePart == null)
                  {
                     baseParts.push("..");
                  }
               }
            }
            else
            {
               baseParts.push(part);
            }
         }
         return baseParts.join("/");
      }
      
      private function resolveURL(url:String, base:String) : String
      {
         var queryAndFragmentIndex:int = 0;
         var path:String = null;
         var queryAndFragment:String = null;
         var bPath:String = null;
         var bSlashIndex:int = 0;
         var bShemeIndex:int = 0;
         var bAuthorityIndex:int = 0;
         var bSheme:String = null;
         var _loc13_:String = null;
         if(base == "")
         {
            return url;
         }
         if(url.charAt(0) == "." && url.charAt(1) == "/")
         {
            return base + url.substr(1);
         }
         if(url.charAt(0) == "/")
         {
            return url;
         }
         if(url.charAt(0) == "." && url.charAt(1) == ".")
         {
            queryAndFragmentIndex = int(url.indexOf("?"));
            queryAndFragmentIndex = queryAndFragmentIndex < 0 ? int(url.indexOf("#")) : queryAndFragmentIndex;
            if(queryAndFragmentIndex < 0)
            {
               queryAndFragment = "";
               path = url;
            }
            else
            {
               queryAndFragment = url.substring(queryAndFragmentIndex);
               path = url.substring(0,queryAndFragmentIndex);
            }
            bSlashIndex = int(base.indexOf("/"));
            bShemeIndex = int(base.indexOf(":"));
            bAuthorityIndex = int(base.indexOf("//"));
            if(bAuthorityIndex < 0 || bAuthorityIndex > bSlashIndex)
            {
               if(bShemeIndex >= 0 && bShemeIndex < bSlashIndex)
               {
                  bSheme = base.substring(0,bShemeIndex + 1);
                  bPath = base.substring(bShemeIndex + 1);
                  if(bPath.charAt(0) == "/")
                  {
                     return bSheme + "/" + this.mergePath(path,bPath.substring(1),false) + queryAndFragment;
                  }
                  return bSheme + this.mergePath(path,bPath,false) + queryAndFragment;
               }
               if(base.charAt(0) == "/")
               {
                  return "/" + this.mergePath(path,base.substring(1),false) + queryAndFragment;
               }
               return this.mergePath(path,base,true) + queryAndFragment;
            }
            bSlashIndex = int(base.indexOf("/",bAuthorityIndex + 2));
            if(bSlashIndex >= 0)
            {
               _loc13_ = base.substring(0,bSlashIndex + 1);
               bPath = base.substring(bSlashIndex + 1);
               return _loc13_ + this.mergePath(path,bPath,false) + queryAndFragment;
            }
            _loc13_ = base;
            return _loc13_ + "/" + this.mergePath(path,"",false);
         }
         var shemeIndex:int = int(url.indexOf(":"));
         var slashIndex:int = int(url.indexOf("/"));
         if(shemeIndex >= 0 && (shemeIndex < slashIndex || slashIndex < 0))
         {
            return url;
         }
         return base + "/" + url;
      }
      
      public function getObjectByName(name:String) : Object3D
      {
         var object:Object3D = null;
         for each(object in this.objects)
         {
            if(object.name == name)
            {
               return object;
            }
         }
         return null;
      }
      
      public function getAnimationByObject(object:Object) : AnimationClip
      {
         var animation:AnimationClip = null;
         var objects:Array = null;
         for each(animation in this.name_eL)
         {
            objects = animation.name_Kq;
            if(objects.indexOf(object) >= 0)
            {
               return animation;
            }
         }
         return null;
      }
   }
}

