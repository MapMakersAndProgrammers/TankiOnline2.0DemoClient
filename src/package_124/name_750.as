package package_124
{
   import alternativa.engine3d.alternativa3d;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   import package_128.name_788;
   import package_21.name_78;
   
   use namespace alternativa3d;
   
   public class name_750
   {
      private var var_734:class_42;
      
      private var var_346:Vector.<Object>;
      
      private var var_733:Vector.<name_78> = new Vector.<name_78>();
      
      private var var_735:Dictionary = new Dictionary();
      
      private var var_619:Object = new Object();
      
      private var var_210:int = -1;
      
      alternativa3d var nearestNotifyers:name_751;
      
      public function name_750()
      {
         super();
      }
      
      public function get root() : class_42
      {
         return this.var_734;
      }
      
      public function set root(value:class_42) : void
      {
         if(this.var_734 != value)
         {
            if(this.var_734 != null)
            {
               this.var_734.alternativa3d::setController(null);
               this.var_734.alternativa3d::var_694 = false;
            }
            if(value != null)
            {
               value.alternativa3d::setController(this);
               value.alternativa3d::var_694 = true;
            }
            this.var_734 = value;
         }
      }
      
      public function update() : void
      {
         var interval:Number = NaN;
         var data:name_749 = null;
         var i:int = 0;
         var count:int = 0;
         var time:int = 0;
         var object:name_78 = null;
         if(this.var_210 < 0)
         {
            this.var_210 = getTimer();
            interval = 0;
         }
         else
         {
            time = int(getTimer());
            interval = 0.001 * (time - this.var_210);
            this.var_210 = time;
         }
         if(this.var_734 == null)
         {
            return;
         }
         for each(data in this.var_619)
         {
            data.reset();
         }
         this.var_734.alternativa3d::update(interval,1);
         for(i = 0,count = int(this.var_733.length); i < count; )
         {
            object = this.var_733[i];
            data = this.var_619[object.name];
            if(data != null)
            {
               data.name_683(object);
            }
            i++;
         }
         for(var notify:name_751 = this.alternativa3d::nearestNotifyers; notify != null; )
         {
            if(notify.willTrigger(name_788.NOTIFY))
            {
               notify.dispatchEvent(new name_788(notify));
            }
            notify = notify.alternativa3d::name_752;
         }
         this.alternativa3d::nearestNotifyers = null;
      }
      
      alternativa3d function addObject(object:Object) : void
      {
         if(object in this.var_735)
         {
            ++this.var_735[object];
         }
         else
         {
            if(object is name_78)
            {
               this.var_733.push(object);
            }
            else
            {
               this.var_346.push(object);
            }
            this.var_735[object] = 1;
         }
      }
      
      alternativa3d function name_753(object:Object) : void
      {
         var index:int = 0;
         var j:int = 0;
         var count:int = 0;
         var used:int = int(this.var_735[object]);
         used--;
         if(used <= 0)
         {
            if(object is name_78)
            {
               index = int(this.var_733.indexOf(object));
               count = this.var_733.length - 1;
               for(j = index + 1; index < count; )
               {
                  this.var_733[index] = this.var_733[j];
                  index++;
                  j++;
               }
               this.var_733.length = count;
            }
            else
            {
               index = int(this.var_346.indexOf(object));
               count = this.var_346.length - 1;
               for(j = index + 1; index < count; )
               {
                  this.var_346[index] = this.var_346[j];
                  index++;
                  j++;
               }
               this.var_346.length = count;
            }
            delete this.var_735[object];
         }
         else
         {
            this.var_735[object] = used;
         }
      }
      
      alternativa3d function getState(name:String) : name_749
      {
         var state:name_749 = this.var_619[name];
         if(state == null)
         {
            state = new name_749();
            this.var_619[name] = state;
         }
         return state;
      }
      
      public function method_922() : void
      {
         this.var_210 = -1;
      }
   }
}

