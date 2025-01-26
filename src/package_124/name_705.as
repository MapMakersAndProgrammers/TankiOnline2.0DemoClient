package package_124
{
   import alternativa.engine3d.alternativa3d;
   import package_125.name_709;
   import package_21.name_78;
   
   use namespace alternativa3d;
   
   public class name_705 extends class_42
   {
      alternativa3d var var_346:Array;
      
      public var name:String;
      
      public var loop:Boolean = true;
      
      public var length:Number = 0;
      
      public var animated:Boolean = true;
      
      private var var_420:Number = 0;
      
      private var var_696:int = 0;
      
      private var var_389:Vector.<name_709> = new Vector.<name_709>();
      
      private var var_695:name_751;
      
      public function name_705(name:String = null)
      {
         super();
         this.name = name;
      }
      
      public function get objects() : Array
      {
         return this.alternativa3d::var_346 == null ? null : [].concat(this.alternativa3d::var_346);
      }
      
      public function set objects(value:Array) : void
      {
         this.method_855(this.alternativa3d::var_346,alternativa3d::controller,value,alternativa3d::controller);
         this.alternativa3d::var_346 = value == null ? null : [].concat(value);
      }
      
      override alternativa3d function setController(value:name_750) : void
      {
         this.method_855(this.alternativa3d::var_346,alternativa3d::controller,this.alternativa3d::var_346,value);
         this.alternativa3d::controller = value;
      }
      
      private function addObject(object:Object) : void
      {
         if(this.alternativa3d::var_346 == null)
         {
            this.alternativa3d::var_346 = [object];
         }
         else
         {
            this.alternativa3d::var_346.push(object);
         }
         if(alternativa3d::controller != null)
         {
            alternativa3d::controller.alternativa3d::addObject(object);
         }
      }
      
      private function method_855(oldObjects:Array, oldController:name_750, newObjects:Array, newController:name_750) : void
      {
         var i:int = 0;
         var count:int = 0;
         if(oldController != null && oldObjects != null)
         {
            for(i = 0,count = int(this.alternativa3d::var_346.length); i < count; i++)
            {
               oldController.alternativa3d::name_753(oldObjects[i]);
            }
         }
         if(newController != null && newObjects != null)
         {
            for(i = 0,count = int(newObjects.length); i < count; i++)
            {
               newController.alternativa3d::addObject(newObjects[i]);
            }
         }
      }
      
      public function method_862() : void
      {
         var track:name_709 = null;
         var len:Number = NaN;
         for(var i:int = 0; i < this.var_696; )
         {
            track = this.var_389[i];
            len = track.length;
            if(len > this.length)
            {
               this.length = len;
            }
            i++;
         }
      }
      
      public function name_712(track:name_709) : name_709
      {
         if(track == null)
         {
            throw new Error("Track can not be null");
         }
         var _loc2_:* = this.var_696++;
         this.var_389[_loc2_] = track;
         if(track.length > this.length)
         {
            this.length = track.length;
         }
         return track;
      }
      
      public function method_860(track:name_709) : name_709
      {
         var t:name_709 = null;
         var index:int = int(this.var_389.indexOf(track));
         if(index < 0)
         {
            throw new ArgumentError("Track not found");
         }
         --this.var_696;
         for(var j:int = index + 1; index < this.var_696; )
         {
            this.var_389[index] = this.var_389[j];
            index++;
            j++;
         }
         this.var_389.length = this.var_696;
         this.length = 0;
         for(var i:int = 0; i < this.var_696; )
         {
            t = this.var_389[i];
            if(t.length > this.length)
            {
               this.length = t.length;
            }
            i++;
         }
         return track;
      }
      
      public function name_716(index:int) : name_709
      {
         return this.var_389[index];
      }
      
      public function get numTracks() : int
      {
         return this.var_696;
      }
      
      override alternativa3d function update(interval:Number, weight:Number) : void
      {
         var i:int = 0;
         var track:name_709 = null;
         var state:name_749 = null;
         var oldTime:Number = this.var_420;
         if(this.animated)
         {
            this.var_420 += interval * speed;
            if(this.loop)
            {
               if(this.var_420 < 0)
               {
                  this.var_420 = 0;
               }
               else if(this.var_420 >= this.length)
               {
                  this.alternativa3d::method_854(oldTime,this.length);
                  this.var_420 = this.length <= 0 ? 0 : this.var_420 % this.length;
                  this.alternativa3d::method_854(0,this.var_420);
               }
               else
               {
                  this.alternativa3d::method_854(oldTime,this.var_420);
               }
            }
            else
            {
               if(this.var_420 < 0)
               {
                  this.var_420 = 0;
               }
               else if(this.var_420 >= this.length)
               {
                  this.var_420 = this.length;
               }
               this.alternativa3d::method_854(oldTime,this.var_420);
            }
         }
         if(weight > 0)
         {
            for(i = 0; i < this.var_696; )
            {
               track = this.var_389[i];
               if(track.object != null)
               {
                  state = alternativa3d::controller.alternativa3d::getState(track.object);
                  if(state != null)
                  {
                     track.alternativa3d::blend(this.var_420,weight,state);
                  }
               }
               i++;
            }
         }
      }
      
      public function get time() : Number
      {
         return this.var_420;
      }
      
      public function set time(value:Number) : void
      {
         this.var_420 = value;
      }
      
      public function get method_857() : Number
      {
         return this.length == 0 ? 0 : this.var_420 / this.length;
      }
      
      public function set method_857(value:Number) : void
      {
         this.var_420 = value * this.length;
      }
      
      private function method_859(object:Object) : int
      {
         if(object is name_78)
         {
            return name_78(object).numChildren;
         }
         return 0;
      }
      
      private function getChildAt(object:Object, index:int) : Object
      {
         if(object is name_78)
         {
            return name_78(object).getChildAt(index);
         }
         return null;
      }
      
      private function method_856(object:Object) : void
      {
         var child:Object = null;
         for(var i:int = 0,var numChildren:int = this.method_859(object); i < numChildren; i++)
         {
            child = this.getChildAt(object,i);
            this.addObject(child);
            this.method_856(child);
         }
      }
      
      public function method_861(object:Object, includeDescendants:Boolean) : void
      {
         this.method_855(this.alternativa3d::var_346,alternativa3d::controller,null,alternativa3d::controller);
         this.alternativa3d::var_346 = null;
         this.addObject(object);
         if(includeDescendants)
         {
            this.method_856(object);
         }
      }
      
      alternativa3d function method_854(start:Number, end:Number) : void
      {
         for(var notify:name_751 = this.var_695; notify != null; )
         {
            if(notify.alternativa3d::var_420 > start)
            {
               if(notify.alternativa3d::var_420 > end)
               {
                  notify = notify.alternativa3d::next;
                  continue;
               }
               notify.alternativa3d::name_752 = alternativa3d::controller.alternativa3d::nearestNotifyers;
               alternativa3d::controller.alternativa3d::nearestNotifyers = notify;
            }
            notify = notify.alternativa3d::next;
         }
      }
      
      public function method_858(time:Number, name:String = null) : name_751
      {
         var n:name_751 = null;
         time = time <= 0 ? 0 : (time >= this.length ? this.length : time);
         var notify:name_751 = new name_751(name);
         notify.alternativa3d::var_420 = time;
         if(this.var_695 == null)
         {
            this.var_695 = notify;
            return notify;
         }
         if(this.var_695.alternativa3d::var_420 > time)
         {
            notify.alternativa3d::next = this.var_695;
            this.var_695 = notify;
            return notify;
         }
         n = this.var_695;
         while(n.alternativa3d::next != null && n.alternativa3d::next.alternativa3d::var_420 <= time)
         {
            n = n.alternativa3d::next;
         }
         if(n.alternativa3d::next == null)
         {
            n.alternativa3d::next = notify;
         }
         else
         {
            notify.alternativa3d::next = n.alternativa3d::next;
            n.alternativa3d::next = notify;
         }
         return notify;
      }
      
      public function method_864(offsetFromEnd:Number = 0, name:String = null) : name_751
      {
         return this.method_858(this.length - offsetFromEnd,name);
      }
      
      public function method_863(notify:name_751) : name_751
      {
         var n:name_751 = null;
         if(this.var_695 != null)
         {
            if(this.var_695 == notify)
            {
               this.var_695 = this.var_695.alternativa3d::next;
               return notify;
            }
            n = this.var_695;
            while(n.alternativa3d::next != null && n.alternativa3d::next != notify)
            {
               n = n.alternativa3d::next;
            }
            if(n.alternativa3d::next == notify)
            {
               n.alternativa3d::next = notify.alternativa3d::next;
               return notify;
            }
         }
         throw new Error("Notify not found");
      }
      
      public function get method_865() : Vector.<name_751>
      {
         var result:Vector.<name_751> = new Vector.<name_751>();
         var i:int = 0;
         for(var notify:name_751 = this.var_695; notify != null; notify = notify.alternativa3d::next)
         {
            result[i] = notify;
            i++;
         }
         return result;
      }
      
      public function slice(start:Number, end:Number = 1.7976931348623157e+308) : name_705
      {
         var sliced:name_705 = new name_705(this.name);
         sliced.alternativa3d::var_346 = this.alternativa3d::var_346 == null ? null : [].concat(this.alternativa3d::var_346);
         for(var i:int = 0; i < this.var_696; i++)
         {
            sliced.name_712(this.var_389[i].slice(start,end));
         }
         return sliced;
      }
      
      public function clone() : name_705
      {
         var cloned:name_705 = new name_705(this.name);
         cloned.alternativa3d::var_346 = this.alternativa3d::var_346 == null ? null : [].concat(this.alternativa3d::var_346);
         for(var i:int = 0; i < this.var_696; i++)
         {
            cloned.name_712(this.var_389[i]);
         }
         cloned.length = this.length;
         return cloned;
      }
   }
}

