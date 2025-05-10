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
      private var name_cn:AnimationNode;
      
      private var name_Kq:Vector.<Object>;
      
      private var name_62:Vector.<Object3D> = new Vector.<Object3D>();
      
      private var name_oX:Dictionary = new Dictionary();
      
      private var name_eB:Object = new Object();
      
      private var name_Jl:int = -1;
      
      alternativa3d var nearestNotifyers:AnimationNotify;
      
      public function AnimationController()
      {
         super();
      }
      
      public function get root() : AnimationNode
      {
         return this.name_cn;
      }
      
      public function set root(value:AnimationNode) : void
      {
         if(this.name_cn != value)
         {
            if(this.name_cn != null)
            {
               this.name_cn.alternativa3d::setController(null);
               this.name_cn.name_Eo = false;
            }
            if(value != null)
            {
               value.alternativa3d::setController(this);
               value.name_Eo = true;
            }
            this.name_cn = value;
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
         if(this.name_Jl < 0)
         {
            this.name_Jl = getTimer();
            interval = 0;
         }
         else
         {
            _loc6_ = int(getTimer());
            interval = 0.001 * (_loc6_ - this.name_Jl);
            this.name_Jl = _loc6_;
         }
         if(this.name_cn == null)
         {
            return;
         }
         for each(data in this.name_eB)
         {
            data.reset();
         }
         this.name_cn.alternativa3d::update(interval,1);
         for(i = 0,count = int(this.name_62.length); i < count; )
         {
            object = this.name_62[i];
            data = this.name_eB[object.name];
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
            notify = notify.name_XY;
         }
         this.alternativa3d::nearestNotifyers = null;
      }
      
      alternativa3d function addObject(object:Object) : void
      {
         if(object in this.name_oX)
         {
            ++this.name_oX[object];
         }
         else
         {
            if(object is Object3D)
            {
               this.name_62.push(object);
            }
            else
            {
               this.name_Kq.push(object);
            }
            this.name_oX[object] = 1;
         }
      }
      
      alternativa3d function removeObject(object:Object) : void
      {
         var index:int = 0;
         var j:int = 0;
         var count:int = 0;
         var used:int = int(this.name_oX[object]);
         used--;
         if(used <= 0)
         {
            if(object is Object3D)
            {
               index = int(this.name_62.indexOf(object as Object3D));
               count = this.name_62.length - 1;
               for(j = index + 1; index < count; )
               {
                  this.name_62[index] = this.name_62[j];
                  index++;
                  j++;
               }
               this.name_62.length = count;
            }
            else
            {
               index = int(this.name_Kq.indexOf(object));
               count = this.name_Kq.length - 1;
               for(j = index + 1; index < count; )
               {
                  this.name_Kq[index] = this.name_Kq[j];
                  index++;
                  j++;
               }
               this.name_Kq.length = count;
            }
            delete this.name_oX[object];
         }
         else
         {
            this.name_oX[object] = used;
         }
      }
      
      alternativa3d function getState(name:String) : AnimationState
      {
         var state:AnimationState = this.name_eB[name];
         if(state == null)
         {
            state = new AnimationState();
            this.name_eB[name] = state;
         }
         return state;
      }
      
      public function freeze() : void
      {
         this.name_Jl = -1;
      }
   }
}

