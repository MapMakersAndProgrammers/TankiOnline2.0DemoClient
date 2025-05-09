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
      private var var_733:AnimationNode;
      
      private var var_348:Vector.<Object>;
      
      private var var_732:Vector.<Object3D> = new Vector.<Object3D>();
      
      private var var_734:Dictionary = new Dictionary();
      
      private var var_619:Object = new Object();
      
      private var var_210:int = -1;
      
      alternativa3d var nearestNotifyers:AnimationNotify;
      
      public function AnimationController()
      {
         super();
      }
      
      public function get root() : AnimationNode
      {
         return this.var_733;
      }
      
      public function set root(value:AnimationNode) : void
      {
         if(this.var_733 != value)
         {
            if(this.var_733 != null)
            {
               this.var_733.alternativa3d::setController(null);
               this.var_733.alternativa3d::var_694 = false;
            }
            if(value != null)
            {
               value.alternativa3d::setController(this);
               value.alternativa3d::var_694 = true;
            }
            this.var_733 = value;
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
         if(this.var_210 < 0)
         {
            this.var_210 = getTimer();
            interval = 0;
         }
         else
         {
            _loc6_ = int(getTimer());
            interval = 0.001 * (_loc6_ - this.var_210);
            this.var_210 = _loc6_;
         }
         if(this.var_733 == null)
         {
            return;
         }
         for each(data in this.var_619)
         {
            data.reset();
         }
         this.var_733.alternativa3d::update(interval,1);
         for(i = 0,count = int(this.var_732.length); i < count; )
         {
            object = this.var_732[i];
            data = this.var_619[object.name];
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
            notify = notify.alternativa3d::name_587;
         }
         this.alternativa3d::nearestNotifyers = null;
      }
      
      alternativa3d function addObject(object:Object) : void
      {
         if(object in this.var_734)
         {
            ++this.var_734[object];
         }
         else
         {
            if(object is Object3D)
            {
               this.var_732.push(object);
            }
            else
            {
               this.var_348.push(object);
            }
            this.var_734[object] = 1;
         }
      }
      
      alternativa3d function removeObject(object:Object) : void
      {
         var index:int = 0;
         var j:int = 0;
         var count:int = 0;
         var used:int = int(this.var_734[object]);
         used--;
         if(used <= 0)
         {
            if(object is Object3D)
            {
               index = int(this.var_732.indexOf(object));
               count = this.var_732.length - 1;
               for(j = index + 1; index < count; )
               {
                  this.var_732[index] = this.var_732[j];
                  index++;
                  j++;
               }
               this.var_732.length = count;
            }
            else
            {
               index = int(this.var_348.indexOf(object));
               count = this.var_348.length - 1;
               for(j = index + 1; index < count; )
               {
                  this.var_348[index] = this.var_348[j];
                  index++;
                  j++;
               }
               this.var_348.length = count;
            }
            delete this.var_734[object];
         }
         else
         {
            this.var_734[object] = used;
         }
      }
      
      alternativa3d function getState(name:String) : AnimationState
      {
         var state:AnimationState = this.var_619[name];
         if(state == null)
         {
            state = new AnimationState();
            this.var_619[name] = state;
         }
         return state;
      }
      
      public function freeze() : void
      {
         this.var_210 = -1;
      }
   }
}

