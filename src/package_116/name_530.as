package package_116
{
   import alternativa.engine3d.alternativa3d;
   import flash.utils.Dictionary;
   import package_123.name_706;
   import package_123.name_707;
   import package_123.name_711;
   import package_123.name_713;
   import package_124.name_705;
   import package_125.name_709;
   import package_21.name_116;
   import package_21.name_78;
   import package_28.name_167;
   
   use namespace alternativa3d;
   
   public class name_530
   {
      public var hierarchy:Vector.<name_78>;
      
      public var objects:Vector.<name_78>;
      
      public var lights:Vector.<name_116>;
      
      public var materials:Vector.<name_641>;
      
      public var var_635:Vector.<name_705>;
      
      private var var_634:Dictionary;
      
      public function name_530()
      {
         super();
      }
      
      public static function method_747(data:XML) : name_705
      {
         var document:name_707 = new name_707(data,0);
         var clip:name_705 = new name_705();
         method_742(clip,document.scene.nodes);
         return clip.numTracks > 0 ? clip : null;
      }
      
      private static function method_742(clip:name_705, nodes:Vector.<name_706>) : void
      {
         var node:name_706 = null;
         var animation:name_705 = null;
         var t:int = 0;
         var numTracks:int = 0;
         var track:name_709 = null;
         for(var i:int = 0,var count:int = int(nodes.length); i < count; i++)
         {
            node = nodes[i];
            animation = node.method_747();
            if(animation != null)
            {
               for(t = 0,numTracks = animation.numTracks; t < numTracks; t++)
               {
                  track = animation.name_716(t);
                  clip.name_712(track);
               }
            }
            else
            {
               clip.name_712(node.name_715());
            }
            method_742(clip,node.nodes);
         }
      }
      
      public function method_750() : void
      {
         this.objects = null;
         this.hierarchy = null;
         this.lights = null;
         this.var_635 = null;
         this.materials = null;
         this.var_634 = null;
      }
      
      public function method_752(object:name_78) : String
      {
         return this.var_634[object];
      }
      
      private function init(data:XML, units:Number) : name_707
      {
         this.method_750();
         this.objects = new Vector.<name_78>();
         this.hierarchy = new Vector.<name_78>();
         this.lights = new Vector.<name_116>();
         this.var_635 = new Vector.<name_705>();
         this.materials = new Vector.<name_641>();
         this.var_634 = new Dictionary(true);
         return new name_707(data,units);
      }
      
      public function method_314(data:XML, baseURL:String = null, trimPaths:Boolean = false) : void
      {
         var i:int = 0;
         var count:int = 0;
         var document:name_707 = this.init(data,0);
         if(document.scene != null)
         {
            this.method_743(document.scene.nodes,null,false);
            this.method_748(document.materials,baseURL,trimPaths);
            for(i = 0,count = int(this.hierarchy.length); i < count; i++)
            {
               this.hierarchy[i].calculateBoundBox();
            }
         }
      }
      
      private function addObject(animatedObject:name_711, parent:name_78, layer:String) : name_78
      {
         var object:name_78 = name_78(animatedObject.object);
         this.objects.push(object);
         if(parent == null)
         {
            this.hierarchy.push(object);
         }
         else
         {
            parent.addChild(object);
         }
         if(object is name_116)
         {
            this.lights.push(name_116(object));
         }
         if(animatedObject.animation != null)
         {
            this.var_635.push(animatedObject.animation);
         }
         if(Boolean(layer))
         {
            this.var_634[object] = layer;
         }
         return object;
      }
      
      private function method_745(animatedObjects:Vector.<name_711>, parent:name_78, layer:String) : name_78
      {
         var first:name_78 = this.addObject(animatedObjects[0],parent,layer);
         for(var i:int = 1,var count:int = int(animatedObjects.length); i < count; i++)
         {
            this.addObject(animatedObjects[i],parent,layer);
         }
         return first;
      }
      
      private function method_746(node:name_706) : Boolean
      {
         var child:name_706 = null;
         var nodes:Vector.<name_706> = node.nodes;
         for(var i:int = 0,var count:int = int(nodes.length); i < count; )
         {
            child = nodes[i];
            child.method_314();
            if(child.skins != null)
            {
               return true;
            }
            if(this.method_746(child))
            {
               return true;
            }
            i++;
         }
         return false;
      }
      
      private function method_743(nodes:Vector.<name_706>, parent:name_78, skinsOnly:Boolean = false) : void
      {
         var node:name_706 = null;
         var container:name_78 = null;
         for(var i:int = 0,var count:int = int(nodes.length); i < count; )
         {
            node = nodes[i];
            node.method_314();
            container = null;
            if(node.skins != null)
            {
               container = this.method_745(node.skins,parent,node.layer);
            }
            else if(!skinsOnly && !node.skinOrTopmostJoint)
            {
               if(node.objects != null)
               {
                  container = this.method_745(node.objects,parent,node.layer);
               }
               else
               {
                  container = new name_78();
                  container.name = node.name_708(node.name);
                  this.addObject(node.name_714(node.name_710(container)),parent,node.layer);
               }
            }
            else if(this.method_746(node))
            {
               container = new name_78();
               container.name = node.name_708(node.name);
               this.addObject(node.name_714(node.name_710(container)),parent,node.layer);
               this.method_743(node.nodes,container,skinsOnly || node.skinOrTopmostJoint);
            }
            if(container != null)
            {
               this.method_743(node.nodes,container,skinsOnly || node.skinOrTopmostJoint);
            }
            i++;
         }
      }
      
      private function method_749(path:String) : String
      {
         var index:int = int(path.lastIndexOf("/"));
         return index < 0 ? path : path.substr(index + 1);
      }
      
      private function method_748(materials:Object, baseURL:String, trimPaths:Boolean) : void
      {
         var tmaterial:name_641 = null;
         var material:name_713 = null;
         var resource:name_167 = null;
         var base:String = null;
         var end:int = 0;
         for each(material in materials)
         {
            if(material.used)
            {
               material.method_314();
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
                     resource.url = this.method_749(this.method_744(resource.url));
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
                     resource.url = this.method_744(resource.url);
                  }
               }
            }
         }
         if(baseURL != null)
         {
            baseURL = this.method_744(baseURL);
            end = int(baseURL.lastIndexOf("/"));
            base = end < 0 ? "" : baseURL.substr(0,end);
            for each(tmaterial in this.materials)
            {
               for each(resource in tmaterial.textures)
               {
                  if(resource != null && resource.url != null)
                  {
                     resource.url = this.method_751(resource.url,base);
                  }
               }
            }
         }
      }
      
      private function method_744(url:String) : String
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
      
      private function method_741(path:String, base:String, relative:Boolean = false) : String
      {
         var part:String = null;
         var basePart:String = null;
         var baseParts:Array = base.split("/");
         var parts:Array = path.split("/");
         for(var i:int = 0,var count:int = int(parts.length); i < count; i++)
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
      
      private function method_751(url:String, base:String) : String
      {
         var queryAndFragmentIndex:int = 0;
         var path:String = null;
         var queryAndFragment:String = null;
         var bPath:String = null;
         var bSlashIndex:int = 0;
         var bShemeIndex:int = 0;
         var bAuthorityIndex:int = 0;
         var bSheme:String = null;
         var bAuthority:String = null;
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
                     return bSheme + "/" + this.method_741(path,bPath.substring(1),false) + queryAndFragment;
                  }
                  return bSheme + this.method_741(path,bPath,false) + queryAndFragment;
               }
               if(base.charAt(0) == "/")
               {
                  return "/" + this.method_741(path,base.substring(1),false) + queryAndFragment;
               }
               return this.method_741(path,base,true) + queryAndFragment;
            }
            bSlashIndex = int(base.indexOf("/",bAuthorityIndex + 2));
            if(bSlashIndex >= 0)
            {
               bAuthority = base.substring(0,bSlashIndex + 1);
               bPath = base.substring(bSlashIndex + 1);
               return bAuthority + this.method_741(path,bPath,false) + queryAndFragment;
            }
            bAuthority = base;
            return bAuthority + "/" + this.method_741(path,"",false);
         }
         var shemeIndex:int = int(url.indexOf(":"));
         var slashIndex:int = int(url.indexOf("/"));
         if(shemeIndex >= 0 && (shemeIndex < slashIndex || slashIndex < 0))
         {
            return url;
         }
         return base + "/" + url;
      }
      
      public function method_729(name:String) : name_78
      {
         var object:name_78 = null;
         for each(object in this.objects)
         {
            if(object.name == name)
            {
               return object;
            }
         }
         return null;
      }
      
      public function method_753(object:Object) : name_705
      {
         var animation:name_705 = null;
         var objects:Array = null;
         for each(animation in this.var_635)
         {
            objects = animation.alternativa3d::var_346;
            if(objects.indexOf(object) >= 0)
            {
               return animation;
            }
         }
         return null;
      }
   }
}

