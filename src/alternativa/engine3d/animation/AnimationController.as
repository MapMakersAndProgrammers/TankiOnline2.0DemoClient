package alternativa.engine3d.animation
{
   import alternativa.engine3d.alternativa3d;
   import alternativa.engine3d.animation.events.NotifyEvent;
   import alternativa.engine3d.core.Object3D;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   
   use namespace alternativa3d;
   
   public class AnimationController
   {
      private var §_-cn§:AnimationNode;
      
      private var §_-Kq§:Vector.<Object>;
      
      private var §_-62§:Vector.<Object3D> = new Vector.<Object3D>();
      
      private var §_-oX§:Dictionary = new Dictionary();
      
      private var §_-eB§:Object = new Object();
      
      private var §_-Jl§:int = -1;
      
      alternativa3d var nearestNotifyers:AnimationNotify;
      
      public function AnimationController()
      {
         super();
      }
      
      public function get root() : AnimationNode
      {
         return this.§_-cn§;
      }
      
      public function set root(value:AnimationNode) : void
      {
         if(this.§_-cn§ != value)
         {
            if(this.§_-cn§ != null)
            {
               this.§_-cn§.alternativa3d::setController(null);
               this.§_-cn§.alternativa3d::_-Eo = false;
            }
            if(value != null)
            {
               value.alternativa3d::setController(this);
               value.alternativa3d::_-Eo = true;
            }
            this.§_-cn§ = value;
         }
      }
      
      public function update() : void
      {
         var interval:Number = NaN;
         var data:AnimationState = null;
         var i:int = 0;
         var count:int = 0;
         var _loc6_:int = 0;
         var object:Object3D = null;
         if(this.§_-Jl§ < 0)
         {
            this.§_-Jl§ = getTimer();
            interval = 0;
         }
         else
         {
            _loc6_ = int(getTimer());
            interval = 0.001 * (_loc6_ - this.§_-Jl§);
            this.§_-Jl§ = _loc6_;
         }
         if(this.§_-cn§ == null)
         {
            return;
         }
         for each(data in this.§_-eB§)
         {
            data.reset();
         }
         this.§_-cn§.alternativa3d::update(interval,1);
         for(i = 0,count = int(this.§_-62§.length); i < count; )
         {
            object = this.§_-62§[i];
            data = this.§_-eB§[object.name];
            if(data != null)
            {
               data.apply(object);
            }
            i++;
         }
         for(var notify:AnimationNotify = this.alternativa3d::nearestNotifyers; notify != null; )
         {
            if(notify.willTrigger(NotifyEvent.NOTIFY))
            {
               notify.dispatchEvent(new NotifyEvent(notify));
            }
            notify = notify.alternativa3d::_-XY;
         }
         this.alternativa3d::nearestNotifyers = null;
      }
      
      alternativa3d function addObject(object:Object) : void
      {
         if(object in this.§_-oX§)
         {
            ++this.§_-oX§[object];
         }
         else
         {
            if(object is Object3D)
            {
               this.§_-62§.push(object);
            }
            else
            {
               this.§_-Kq§.push(object);
            }
            this.§_-oX§[object] = 1;
         }
      }
      
      alternativa3d function removeObject(object:Object) : void
      {
         var index:int = 0;
         var j:int = 0;
         var count:int = 0;
         var used:int = int(this.§_-oX§[object]);
         used--;
         if(used <= 0)
         {
            if(object is Object3D)
            {
               index = int(this.§_-62§.indexOf(object));
               count = this.§_-62§.length - 1;
               for(j = index + 1; index < count; )
               {
                  this.§_-62§[index] = this.§_-62§[j];
                  index++;
                  j++;
               }
               this.§_-62§.length = count;
            }
            else
            {
               index = int(this.§_-Kq§.indexOf(object));
               count = this.§_-Kq§.length - 1;
               for(j = index + 1; index < count; )
               {
                  this.§_-Kq§[index] = this.§_-Kq§[j];
                  index++;
                  j++;
               }
               this.§_-Kq§.length = count;
            }
            delete this.§_-oX§[object];
         }
         else
         {
            this.§_-oX§[object] = used;
         }
      }
      
      alternativa3d function getState(name:String) : AnimationState
      {
         var state:AnimationState = this.§_-eB§[name];
         if(state == null)
         {
            state = new AnimationState();
            this.§_-eB§[name] = state;
         }
         return state;
      }
      
      public function freeze() : void
      {
         this.§_-Jl§ = -1;
      }
   }
}

