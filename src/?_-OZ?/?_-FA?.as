package §_-OZ§
{
   import §_-8D§.§_-OX§;
   import §_-9n§.§_-Np§;
   import alternativa.engine3d.alternativa3d;
   
   use namespace alternativa3d;
   
   public class §_-FA§ extends §_-CO§
   {
      alternativa3d var §_-Kq§:Array;
      
      public var name:String;
      
      public var loop:Boolean = true;
      
      public var length:Number = 0;
      
      public var animated:Boolean = true;
      
      private var §_-qC§:Number = 0;
      
      private var §_-Iv§:int = 0;
      
      private var §_-cT§:Vector.<§_-Np§> = new Vector.<§_-Np§>();
      
      private var §_-Ci§:§_-Re§;
      
      public function §_-FA§(name:String = null)
      {
         super();
         this.name = name;
      }
      
      public function get objects() : Array
      {
         return this.alternativa3d::_-Kq == null ? null : [].concat(this.alternativa3d::_-Kq);
      }
      
      public function set objects(value:Array) : void
      {
         this.§_-R5§(this.alternativa3d::_-Kq,alternativa3d::controller,value,alternativa3d::controller);
         this.alternativa3d::_-Kq = value == null ? null : [].concat(value);
      }
      
      override alternativa3d function setController(value:§_-cK§) : void
      {
         this.§_-R5§(this.alternativa3d::_-Kq,alternativa3d::controller,this.alternativa3d::_-Kq,value);
         this.alternativa3d::controller = value;
      }
      
      private function addObject(object:Object) : void
      {
         if(this.alternativa3d::_-Kq == null)
         {
            this.alternativa3d::_-Kq = [object];
         }
         else
         {
            this.alternativa3d::_-Kq.push(object);
         }
         if(alternativa3d::controller != null)
         {
            alternativa3d::controller.alternativa3d::addObject(object);
         }
      }
      
      private function §_-R5§(oldObjects:Array, oldController:§_-cK§, newObjects:Array, newController:§_-cK§) : void
      {
         var i:int = 0;
         var count:int = 0;
         if(oldController != null && oldObjects != null)
         {
            for(i = 0,count = int(this.alternativa3d::_-Kq.length); i < count; i++)
            {
               oldController.alternativa3d::_-il(oldObjects[i]);
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
      
      public function §_-SR§() : void
      {
         var track:§_-Np§ = null;
         var len:Number = NaN;
         for(var i:int = 0; i < this.§_-Iv§; )
         {
            track = this.§_-cT§[i];
            len = track.length;
            if(len > this.length)
            {
               this.length = len;
            }
            i++;
         }
      }
      
      public function §_-nn§(track:§_-Np§) : §_-Np§
      {
         if(track == null)
         {
            throw new Error("Track can not be null");
         }
         var _loc2_:* = this.§_-Iv§++;
         this.§_-cT§[_loc2_] = track;
         if(track.length > this.length)
         {
            this.length = track.length;
         }
         return track;
      }
      
      public function §_-kS§(track:§_-Np§) : §_-Np§
      {
         var t:§_-Np§ = null;
         var index:int = int(this.§_-cT§.indexOf(track));
         if(index < 0)
         {
            throw new ArgumentError("Track not found");
         }
         --this.§_-Iv§;
         for(var j:int = index + 1; index < this.§_-Iv§; )
         {
            this.§_-cT§[index] = this.§_-cT§[j];
            index++;
            j++;
         }
         this.§_-cT§.length = this.§_-Iv§;
         this.length = 0;
         for(var i:int = 0; i < this.§_-Iv§; )
         {
            t = this.§_-cT§[i];
            if(t.length > this.length)
            {
               this.length = t.length;
            }
            i++;
         }
         return track;
      }
      
      public function §_-QA§(index:int) : §_-Np§
      {
         return this.§_-cT§[index];
      }
      
      public function get numTracks() : int
      {
         return this.§_-Iv§;
      }
      
      override alternativa3d function update(interval:Number, weight:Number) : void
      {
         var i:int = 0;
         var track:§_-Np§ = null;
         var state:§_-SK§ = null;
         var oldTime:Number = this.§_-qC§;
         if(this.animated)
         {
            this.§_-qC§ += interval * speed;
            if(this.loop)
            {
               if(this.§_-qC§ < 0)
               {
                  this.§_-qC§ = 0;
               }
               else if(this.§_-qC§ >= this.length)
               {
                  this.alternativa3d::_-D3(oldTime,this.length);
                  this.§_-qC§ = this.length <= 0 ? 0 : this.§_-qC§ % this.length;
                  this.alternativa3d::_-D3(0,this.§_-qC§);
               }
               else
               {
                  this.alternativa3d::_-D3(oldTime,this.§_-qC§);
               }
            }
            else
            {
               if(this.§_-qC§ < 0)
               {
                  this.§_-qC§ = 0;
               }
               else if(this.§_-qC§ >= this.length)
               {
                  this.§_-qC§ = this.length;
               }
               this.alternativa3d::_-D3(oldTime,this.§_-qC§);
            }
         }
         if(weight > 0)
         {
            for(i = 0; i < this.§_-Iv§; )
            {
               track = this.§_-cT§[i];
               if(track.object != null)
               {
                  state = alternativa3d::controller.alternativa3d::getState(track.object);
                  if(state != null)
                  {
                     track.alternativa3d::blend(this.§_-qC§,weight,state);
                  }
               }
               i++;
            }
         }
      }
      
      public function get time() : Number
      {
         return this.§_-qC§;
      }
      
      public function set time(value:Number) : void
      {
         this.§_-qC§ = value;
      }
      
      public function get §_-SA§() : Number
      {
         return this.length == 0 ? 0 : this.§_-qC§ / this.length;
      }
      
      public function set §_-SA§(value:Number) : void
      {
         this.§_-qC§ = value * this.length;
      }
      
      private function §_-8I§(object:Object) : int
      {
         if(object is §_-OX§)
         {
            return §_-OX§(object).numChildren;
         }
         return 0;
      }
      
      private function getChildAt(object:Object, index:int) : Object
      {
         if(object is §_-OX§)
         {
            return §_-OX§(object).getChildAt(index);
         }
         return null;
      }
      
      private function §_-Lo§(object:Object) : void
      {
         var child:Object = null;
         for(var i:int = 0,var numChildren:int = this.§_-8I§(object); i < numChildren; i++)
         {
            child = this.getChildAt(object,i);
            this.addObject(child);
            this.§_-Lo§(child);
         }
      }
      
      public function §_-L6§(object:Object, includeDescendants:Boolean) : void
      {
         this.§_-R5§(this.alternativa3d::_-Kq,alternativa3d::controller,null,alternativa3d::controller);
         this.alternativa3d::_-Kq = null;
         this.addObject(object);
         if(includeDescendants)
         {
            this.§_-Lo§(object);
         }
      }
      
      alternativa3d function §_-D3§(start:Number, end:Number) : void
      {
         for(var notify:§_-Re§ = this.§_-Ci§; notify != null; )
         {
            if(notify.alternativa3d::_-qC > start)
            {
               if(notify.alternativa3d::_-qC > end)
               {
                  notify = notify.alternativa3d::next;
                  continue;
               }
               notify.alternativa3d::_-XY = alternativa3d::controller.alternativa3d::nearestNotifyers;
               alternativa3d::controller.alternativa3d::nearestNotifyers = notify;
            }
            notify = notify.alternativa3d::next;
         }
      }
      
      public function §_-Bn§(time:Number, name:String = null) : §_-Re§
      {
         var n:§_-Re§ = null;
         time = time <= 0 ? 0 : (time >= this.length ? this.length : time);
         var notify:§_-Re§ = new §_-Re§(name);
         notify.alternativa3d::_-qC = time;
         if(this.§_-Ci§ == null)
         {
            this.§_-Ci§ = notify;
            return notify;
         }
         if(this.§_-Ci§.alternativa3d::_-qC > time)
         {
            notify.alternativa3d::next = this.§_-Ci§;
            this.§_-Ci§ = notify;
            return notify;
         }
         n = this.§_-Ci§;
         while(n.alternativa3d::next != null && n.alternativa3d::next.alternativa3d::_-qC <= time)
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
      
      public function §_-VB§(offsetFromEnd:Number = 0, name:String = null) : §_-Re§
      {
         return this.§_-Bn§(this.length - offsetFromEnd,name);
      }
      
      public function §_-LH§(notify:§_-Re§) : §_-Re§
      {
         var n:§_-Re§ = null;
         if(this.§_-Ci§ != null)
         {
            if(this.§_-Ci§ == notify)
            {
               this.§_-Ci§ = this.§_-Ci§.alternativa3d::next;
               return notify;
            }
            n = this.§_-Ci§;
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
      
      public function get §_-ZY§() : Vector.<§_-Re§>
      {
         var result:Vector.<§_-Re§> = new Vector.<§_-Re§>();
         var i:int = 0;
         for(var notify:§_-Re§ = this.§_-Ci§; notify != null; notify = notify.alternativa3d::next)
         {
            result[i] = notify;
            i++;
         }
         return result;
      }
      
      public function slice(start:Number, end:Number = 1.7976931348623157e+308) : §_-FA§
      {
         var sliced:§_-FA§ = new §_-FA§(this.name);
         sliced.alternativa3d::_-Kq = this.alternativa3d::_-Kq == null ? null : [].concat(this.alternativa3d::_-Kq);
         for(var i:int = 0; i < this.§_-Iv§; i++)
         {
            sliced.§_-nn§(this.§_-cT§[i].slice(start,end));
         }
         return sliced;
      }
      
      public function clone() : §_-FA§
      {
         var cloned:§_-FA§ = new §_-FA§(this.name);
         cloned.alternativa3d::_-Kq = this.alternativa3d::_-Kq == null ? null : [].concat(this.alternativa3d::_-Kq);
         for(var i:int = 0; i < this.§_-Iv§; i++)
         {
            cloned.§_-nn§(this.§_-cT§[i]);
         }
         cloned.length = this.length;
         return cloned;
      }
   }
}

