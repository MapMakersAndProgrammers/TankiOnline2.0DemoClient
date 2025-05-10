package alternativa.engine3d.animation
{
   import alternativa.engine3d.alternativa3d;
   import alternativa.engine3d.animation.keys.Track;
   import alternativa.engine3d.core.Object3D;
   
   use namespace alternativa3d;
   
   public class AnimationClip extends AnimationNode
   {
      alternativa3d var name_Kq:Array;
      
      public var name:String;
      
      public var loop:Boolean = true;
      
      public var length:Number = 0;
      
      public var animated:Boolean = true;
      
      private var name_qC:Number = 0;
      
      private var name_Iv:int = 0;
      
      private var name_cT:Vector.<Track> = new Vector.<Track>();
      
      private var name_Ci:AnimationNotify;
      
      public function AnimationClip(name:String = null)
      {
         super();
         this.name = name;
      }
      
      public function get objects() : Array
      {
         return this.name_Kq == null ? null : [].concat(this.name_Kq);
      }
      
      public function set objects(value:Array) : void
      {
         this.updateObjects(this.name_Kq,alternativa3d::controller,value,alternativa3d::controller);
         this.name_Kq = value == null ? null : [].concat(value);
      }
      
      override alternativa3d function setController(value:AnimationController) : void
      {
         this.updateObjects(this.name_Kq,alternativa3d::controller,this.name_Kq,value);
         this.alternativa3d::controller = value;
      }
      
      private function addObject(object:Object) : void
      {
         if(this.name_Kq == null)
         {
            this.name_Kq = [object];
         }
         else
         {
            this.name_Kq.push(object);
         }
         if(alternativa3d::controller != null)
         {
            alternativa3d::controller.alternativa3d::addObject(object);
         }
      }
      
      private function updateObjects(oldObjects:Array, oldController:AnimationController, newObjects:Array, newController:AnimationController) : void
      {
         var i:int = 0;
         var count:int = 0;
         if(oldController != null && oldObjects != null)
         {
            for(i = 0,count = int(this.name_Kq.length); i < count; i++)
            {
               oldController.alternativa3d::removeObject(oldObjects[i]);
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
      
      public function updateLength() : void
      {
         var track:Track = null;
         var len:Number = NaN;
         for(var i:int = 0; i < this.name_Iv; )
         {
            track = this.name_cT[i];
            len = track.length;
            if(len > this.length)
            {
               this.length = len;
            }
            i++;
         }
      }
      
      public function addTrack(track:Track) : Track
      {
         if(track == null)
         {
            throw new Error("Track can not be null");
         }
         var _loc2_:* = this.name_Iv++;
         this.name_cT[_loc2_] = track;
         if(track.length > this.length)
         {
            this.length = track.length;
         }
         return track;
      }
      
      public function removeTrack(track:Track) : Track
      {
         var t:Track = null;
         var index:int = int(this.name_cT.indexOf(track));
         if(index < 0)
         {
            throw new ArgumentError("Track not found");
         }
         --this.name_Iv;
         for(var j:int = index + 1; index < this.name_Iv; )
         {
            this.name_cT[index] = this.name_cT[j];
            index++;
            j++;
         }
         this.name_cT.length = this.name_Iv;
         this.length = 0;
         for(var i:int = 0; i < this.name_Iv; )
         {
            t = this.name_cT[i];
            if(t.length > this.length)
            {
               this.length = t.length;
            }
            i++;
         }
         return track;
      }
      
      public function getTrackAt(index:int) : Track
      {
         return this.name_cT[index];
      }
      
      public function get numTracks() : int
      {
         return this.name_Iv;
      }
      
      override alternativa3d function update(interval:Number, weight:Number) : void
      {
         var i:int = 0;
         var track:Track = null;
         var state:AnimationState = null;
         var oldTime:Number = this.name_qC;
         if(this.animated)
         {
            this.name_qC += interval * speed;
            if(this.loop)
            {
               if(this.name_qC < 0)
               {
                  this.name_qC = 0;
               }
               else if(this.name_qC >= this.length)
               {
                  this.alternativa3d::collectNotifiers(oldTime,this.length);
                  this.name_qC = this.length <= 0 ? 0 : this.name_qC % this.length;
                  this.alternativa3d::collectNotifiers(0,this.name_qC);
               }
               else
               {
                  this.alternativa3d::collectNotifiers(oldTime,this.name_qC);
               }
            }
            else
            {
               if(this.name_qC < 0)
               {
                  this.name_qC = 0;
               }
               else if(this.name_qC >= this.length)
               {
                  this.name_qC = this.length;
               }
               this.alternativa3d::collectNotifiers(oldTime,this.name_qC);
            }
         }
         if(weight > 0)
         {
            for(i = 0; i < this.name_Iv; )
            {
               track = this.name_cT[i];
               if(track.object != null)
               {
                  state = alternativa3d::controller.alternativa3d::getState(track.object);
                  if(state != null)
                  {
                     track.alternativa3d::blend(this.name_qC,weight,state);
                  }
               }
               i++;
            }
         }
      }
      
      public function get time() : Number
      {
         return this.name_qC;
      }
      
      public function set time(value:Number) : void
      {
         this.name_qC = value;
      }
      
      public function get normalizedTime() : Number
      {
         return this.length == 0 ? 0 : this.name_qC / this.length;
      }
      
      public function set normalizedTime(value:Number) : void
      {
         this.name_qC = value * this.length;
      }
      
      private function getNumChildren(object:Object) : int
      {
         if(object is Object3D)
         {
            return Object3D(object).numChildren;
         }
         return 0;
      }
      
      private function getChildAt(object:Object, index:int) : Object
      {
         if(object is Object3D)
         {
            return Object3D(object).getChildAt(index);
         }
         return null;
      }
      
      private function addChildren(object:Object) : void
      {
         var child:Object = null;
         for(var i:int = 0, numChildren:int = this.getNumChildren(object); i < numChildren; i++)
         {
            child = this.getChildAt(object,i);
            this.addObject(child);
            this.addChildren(child);
         }
      }
      
      public function attach(object:Object, includeDescendants:Boolean) : void
      {
         this.updateObjects(this.name_Kq,alternativa3d::controller,null,alternativa3d::controller);
         this.name_Kq = null;
         this.addObject(object);
         if(includeDescendants)
         {
            this.addChildren(object);
         }
      }
      
      alternativa3d function collectNotifiers(start:Number, end:Number) : void
      {
         for(var notify:AnimationNotify = this.name_Ci; notify != null; )
         {
            if(notify.name_qC > start)
            {
               if(notify.name_qC > end)
               {
                  notify = notify.alternativa3d::next;
                  continue;
               }
               notify.name_XY = alternativa3d::controller.alternativa3d::nearestNotifyers;
               alternativa3d::controller.alternativa3d::nearestNotifyers = notify;
            }
            notify = notify.alternativa3d::next;
         }
      }
      
      public function addNotify(time:Number, name:String = null) : AnimationNotify
      {
         var _loc4_:AnimationNotify = null;
         time = time <= 0 ? 0 : (time >= this.length ? this.length : time);
         var notify:AnimationNotify = new AnimationNotify(name);
         notify.name_qC = time;
         if(this.name_Ci == null)
         {
            this.name_Ci = notify;
            return notify;
         }
         if(this.name_Ci.name_qC > time)
         {
            notify.alternativa3d::next = this.name_Ci;
            this.name_Ci = notify;
            return notify;
         }
         _loc4_ = this.name_Ci;
         while(_loc4_.alternativa3d::next != null && _loc4_.alternativa3d::next.name_qC <= time)
         {
            _loc4_ = _loc4_.alternativa3d::next;
         }
         if(_loc4_.alternativa3d::next == null)
         {
            _loc4_.alternativa3d::next = notify;
         }
         else
         {
            notify.alternativa3d::next = _loc4_.alternativa3d::next;
            _loc4_.alternativa3d::next = notify;
         }
         return notify;
      }
      
      public function addNotifyAtEnd(offsetFromEnd:Number = 0, name:String = null) : AnimationNotify
      {
         return this.addNotify(this.length - offsetFromEnd,name);
      }
      
      public function removeNotify(notify:AnimationNotify) : AnimationNotify
      {
         var n:AnimationNotify = null;
         if(this.name_Ci != null)
         {
            if(this.name_Ci == notify)
            {
               this.name_Ci = this.name_Ci.alternativa3d::next;
               return notify;
            }
            n = this.name_Ci;
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
      
      public function get notifiers() : Vector.<AnimationNotify>
      {
         var result:Vector.<AnimationNotify> = new Vector.<AnimationNotify>();
         var i:int = 0;
         for(var notify:AnimationNotify = this.name_Ci; notify != null; notify = notify.alternativa3d::next)
         {
            result[i] = notify;
            i++;
         }
         return result;
      }
      
      public function slice(start:Number, end:Number = 1.7976931348623157e+308) : AnimationClip
      {
         var sliced:AnimationClip = new AnimationClip(this.name);
         sliced.name_Kq = this.name_Kq == null ? null : [].concat(this.name_Kq);
         for(var i:int = 0; i < this.name_Iv; i++)
         {
            sliced.addTrack(this.name_cT[i].slice(start,end));
         }
         return sliced;
      }
      
      public function clone() : AnimationClip
      {
         var cloned:AnimationClip = new AnimationClip(this.name);
         cloned.name_Kq = this.name_Kq == null ? null : [].concat(this.name_Kq);
         for(var i:int = 0; i < this.name_Iv; i++)
         {
            cloned.addTrack(this.name_cT[i]);
         }
         cloned.length = this.length;
         return cloned;
      }
   }
}

