package package_10
{
   import flash.utils.Dictionary;
   import flash.utils.describeType;
   import flash.utils.getDefinitionByName;
   import package_108.name_373;
   import package_108.name_374;
   
   public class name_52
   {
      private var var_85:name_374 = new name_374();
      
      private var var_87:TaskArray = new TaskArray();
      
      private var var_86:TaskArray = new TaskArray();
      
      private var var_88:Dictionary = new Dictionary();
      
      public function name_52()
      {
         super();
      }
      
      public function addTask(task:class_1) : void
      {
         if(this.var_85.contains(task))
         {
            throw new Error("Task is already active");
         }
         if(this.var_87.contains(task))
         {
            throw new Error("Task has been already scheduled for addition");
         }
         this.var_87.add(task);
      }
      
      public function killTask(task:class_1) : void
      {
         if(this.var_85.contains(task) && !this.var_86.contains(task))
         {
            this.var_86.add(task);
         }
      }
      
      public function name_185() : void
      {
         var task:class_1 = null;
         this.method_196();
         var iterator:name_373 = this.var_85.listIterator();
         while(iterator.hasNext())
         {
            task = class_1(iterator.next());
            if(!task.method_20)
            {
               task.run();
            }
         }
         this.method_195();
      }
      
      public function getTaskInterface(taskInterface:Class) : Object
      {
         return this.var_88[taskInterface];
      }
      
      public function name_189() : void
      {
         var task:class_1 = null;
         var listIterator:name_373 = this.var_85.listIterator();
         while(listIterator.hasNext())
         {
            task = class_1(listIterator.next());
            this.killTask(task);
         }
      }
      
      private function method_196() : void
      {
         var task:class_1 = null;
         var taskInterfaces:Vector.<Class> = null;
         var taskInterface:Class = null;
         var activeTasksIterator:name_373 = null;
         var activeTask:class_1 = null;
         for(var i:int = 0; i < this.var_87.numTasks; i++)
         {
            task = this.var_87.tasks[i];
            task.var_4 = this;
            task.start();
            taskInterfaces = this.method_194(task);
            for each(taskInterface in taskInterfaces)
            {
               this.var_88[taskInterface] = task;
            }
            activeTasksIterator = this.var_85.listIterator();
            while(activeTasksIterator.hasNext())
            {
               activeTask = class_1(activeTasksIterator.next());
               if(activeTask.priority > task.priority)
               {
                  activeTasksIterator.name_375();
                  break;
               }
            }
            activeTasksIterator.add(task);
         }
         this.var_87.clear();
      }
      
      private function method_195() : void
      {
         var task:class_1 = null;
         var taskInterfaces:Vector.<Class> = null;
         var taskInterface:Class = null;
         for(var i:int = 0; i < this.var_86.numTasks; i++)
         {
            task = this.var_86.tasks[i];
            this.var_85.remove(task);
            task.stop();
            taskInterfaces = this.method_194(task);
            for each(taskInterface in taskInterfaces)
            {
               delete this.var_88[taskInterface];
            }
            task.var_4 = null;
         }
         this.var_86.clear();
      }
      
      private function method_194(object:Object) : Vector.<Class>
      {
         var interfaceXML:XML = null;
         var interfaceClass:Object = null;
         var result:Vector.<Class> = new Vector.<Class>();
         var xml:XML = describeType(object);
         for each(interfaceXML in xml.implementsInterface)
         {
            interfaceClass = getDefinitionByName(interfaceXML.@type);
            result.push(interfaceClass);
         }
         return result;
      }
   }
}

class TaskArray
{
   public var tasks:Vector.<class_1> = new Vector.<class_1>();
   
   public var numTasks:int;
   
   public function TaskArray()
   {
      super();
   }
   
   public function add(task:class_1) : void
   {
      var _loc2_:* = this.numTasks++;
      this.tasks[_loc2_] = task;
   }
   
   public function clear() : void
   {
      for(var i:int = 0; i < this.numTasks; i++)
      {
         this.tasks[i] = null;
      }
      this.numTasks = 0;
   }
   
   public function contains(task:class_1) : Boolean
   {
      return this.tasks.indexOf(task) >= 0;
   }
}
