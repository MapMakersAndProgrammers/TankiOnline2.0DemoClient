package package_102
{
   import alternativa.engine3d.alternativa3d;
   import package_101.name_552;
   import package_33.name_130;
   
   use namespace alternativa3d;
   
   public class name_550 extends class_36
   {
      alternativa3d var var_348:Array;
      
      public var name:String;
      
      public var loop:Boolean = true;
      
      public var length:Number = 0;
      
      public var animated:Boolean = true;
      
      private var var_420:Number = 0;
      
      private var var_696:int = 0;
      
      private var var_389:Vector.<name_552> = new Vector.<name_552>();
      
      private var var_695:name_585;
      
      public function name_550(name:String = null)
      {
         super();
         this.name = name;
      }
      
      public function get objects() : Array
      {
         return this.alternativa3d::var_348 == null ? null : [].concat(this.alternativa3d::var_348);
      }
      
      public function set objects(value:Array) : void
      {
         this.method_354(this.alternativa3d::var_348,alternativa3d::controller,value,alternativa3d::controller);
         this.alternativa3d::var_348 = value == null ? null : [].concat(value);
      }
      
      override alternativa3d function setController(value:name_586) : void
      {
         this.method_354(this.alternativa3d::var_348,alternativa3d::controller,this.alternativa3d::var_348,value);
         this.alternativa3d::controller = value;
      }
      
      private function addObject(object:Object) : void
      {
         if(this.alternativa3d::var_348 == null)
         {
            this.alternativa3d::var_348 = [object];
         }
         else
         {
            this.alternativa3d::var_348.push(object);
         }
         if(alternativa3d::controller != null)
         {
            alternativa3d::controller.alternativa3d::addObject(object);
         }
      }
      
      private function method_354(oldObjects:Array, oldController:name_586, newObjects:Array, newController:name_586) : void
      {
         var i:int = 0;
         var count:int = 0;
         if(oldController != null && oldObjects != null)
         {
            for(i = 0,count = int(this.alternativa3d::var_348.length); i < count; i++)
            {
               oldController.alternativa3d::name_588(oldObjects[i]);
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
      
      public function method_361() : void
      {
         var track:name_552 = null;
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
      
      public function name_551(track:name_552) : name_552
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
      
      public function method_359(track:name_552) : name_552
      {
         var t:name_552 = null;
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
      
      public function name_553(index:int) : name_552
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
         var track:name_552 = null;
         var state:name_584 = null;
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
                  this.alternativa3d::method_353(oldTime,this.length);
                  this.var_420 = this.length <= 0 ? 0 : this.var_420 % this.length;
                  this.alternativa3d::method_353(0,this.var_420);
               }
               else
               {
                  this.alternativa3d::method_353(oldTime,this.var_420);
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
               this.alternativa3d::method_353(oldTime,this.var_420);
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
      
      public function get method_356() : Number
      {
         return this.length == 0 ? 0 : this.var_420 / this.length;
      }
      
      public function set method_356(value:Number) : void
      {
         this.var_420 = value * this.length;
      }
      
      private function method_358(object:Object) : int
      {
         if(object is name_130)
         {
            return name_130(object).numChildren;
         }
         return 0;
      }
      
      private function getChildAt(object:Object, index:int) : Object
      {
         if(object is name_130)
         {
            return name_130(object).getChildAt(index);
         }
         return null;
      }
      
      private function method_355(object:Object) : void
      {
         var child:Object = null;
         for(var i:int = 0,var numChildren:int = this.method_358(object); i < numChildren; i++)
         {
            child = this.getChildAt(object,i);
            this.addObject(child);
            this.method_355(child);
         }
      }
      
      public function method_360(object:Object, includeDescendants:Boolean) : void
      {
         this.method_354(this.alternativa3d::var_348,alternativa3d::controller,null,alternativa3d::controller);
         this.alternativa3d::var_348 = null;
         this.addObject(object);
         if(includeDescendants)
         {
            this.method_355(object);
         }
      }
      
      alternativa3d function method_353(start:Number, end:Number) : void
      {
         for(var notify:name_585 = this.var_695; notify != null; )
         {
            if(notify.alternativa3d::var_420 > start)
            {
               if(notify.alternativa3d::var_420 > end)
               {
                  notify = notify.alternativa3d::next;
                  continue;
               }
               notify.alternativa3d::name_587 = alternativa3d::controller.alternativa3d::nearestNotifyers;
               alternativa3d::controller.alternativa3d::nearestNotifyers = notify;
            }
            notify = notify.alternativa3d::next;
         }
      }
      
      public function method_357(time:Number, name:String = null) : name_585
      {
         var n:name_585 = null;
         time = time <= 0 ? 0 : (time >= this.length ? this.length : time);
         var notify:name_585 = new name_585(name);
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
      
      public function method_363(offsetFromEnd:Number = 0, name:String = null) : name_585
      {
         return this.method_357(this.length - offsetFromEnd,name);
      }
      
      public function method_362(notify:name_585) : name_585
      {
         var n:name_585 = null;
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
      
      public function get method_364() : Vector.<name_585>
      {
         var result:Vector.<name_585> = new Vector.<name_585>();
         var i:int = 0;
         for(var notify:name_585 = this.var_695; notify != null; notify = notify.alternativa3d::next)
         {
            result[i] = notify;
            i++;
         }
         return result;
      }
      
      public function slice(start:Number, end:Number = 1.7976931348623157e+308) : name_550
      {
         var sliced:name_550 = new name_550(this.name);
         sliced.alternativa3d::var_348 = this.alternativa3d::var_348 == null ? null : [].concat(this.alternativa3d::var_348);
         for(var i:int = 0; i < this.var_696; i++)
         {
            sliced.name_551(this.var_389[i].slice(start,end));
         }
         return sliced;
      }
      
      public function clone() : name_550
      {
         var cloned:name_550 = new name_550(this.name);
         cloned.alternativa3d::var_348 = this.alternativa3d::var_348 == null ? null : [].concat(this.alternativa3d::var_348);
         for(var i:int = 0; i < this.var_696; i++)
         {
            cloned.name_551(this.var_389[i]);
         }
         cloned.length = this.length;
         return cloned;
      }
   }
}

