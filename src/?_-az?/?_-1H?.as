package §_-az§
{
   import §_-Lt§.§_-Fv§;
   import §_-Lt§.§_-x§;
   import flash.utils.Dictionary;
   import flash.utils.describeType;
   import flash.utils.getDefinitionByName;
   
   public class §_-1H§
   {
      private var §_-AF§:§_-Fv§ = new §_-Fv§();
      
      private var §_-Ey§:TaskArray = new TaskArray();
      
      private var §_-4z§:TaskArray = new TaskArray();
      
      private var §_-TV§:Dictionary = new Dictionary();
      
      public function §_-1H§()
      {
         super();
      }
      
      public function addTask(task:§_-ps§) : void
      {
         if(this.§_-AF§.contains(task))
         {
            throw new Error("Task is already active");
         }
         if(this.§_-Ey§.contains(task))
         {
            throw new Error("Task has been already scheduled for addition");
         }
         this.§_-Ey§.add(task);
      }
      
      public function killTask(task:§_-ps§) : void
      {
         if(Boolean(this.§_-AF§.contains(task)) && !this.§_-4z§.contains(task))
         {
            this.§_-4z§.add(task);
         }
      }
      
      public function §_-h3§() : void
      {
         var task:§_-ps§ = null;
         this.§_-db§();
         var iterator:§_-x§ = this.§_-AF§.listIterator();
         while(iterator.hasNext())
         {
            task = §_-ps§(iterator.next());
            if(!task.§_-DX§)
            {
               task.run();
            }
         }
         this.§_-4g§();
      }
      
      public function getTaskInterface(taskInterface:Class) : Object
      {
         return this.§_-TV§[taskInterface];
      }
      
      public function §_-Ap§() : void
      {
         var task:§_-ps§ = null;
         var listIterator:§_-x§ = this.§_-AF§.listIterator();
         while(listIterator.hasNext())
         {
            task = §_-ps§(listIterator.next());
            this.killTask(task);
         }
      }
      
      private function §_-db§() : void
      {
         var task:§_-ps§ = null;
         var taskInterfaces:Vector.<Class> = null;
         var taskInterface:Class = null;
         var activeTasksIterator:§_-x§ = null;
         var activeTask:§_-ps§ = null;
         for(var i:int = 0; i < this.§_-Ey§.numTasks; i++)
         {
            task = this.§_-Ey§.tasks[i];
            task.§_-Uw§ = this;
            task.start();
            taskInterfaces = this.§_-8q§(task);
            for each(taskInterface in taskInterfaces)
            {
               this.§_-TV§[taskInterface] = task;
            }
            activeTasksIterator = this.§_-AF§.listIterator();
            while(activeTasksIterator.hasNext())
            {
               activeTask = §_-ps§(activeTasksIterator.next());
               if(activeTask.priority > task.priority)
               {
                  activeTasksIterator.§_-q9§();
                  break;
               }
            }
            activeTasksIterator.add(task);
         }
         this.§_-Ey§.clear();
      }
      
      private function §_-4g§() : void
      {
         var task:§_-ps§ = null;
         var taskInterfaces:Vector.<Class> = null;
         var taskInterface:Class = null;
         for(var i:int = 0; i < this.§_-4z§.numTasks; i++)
         {
            task = this.§_-4z§.tasks[i];
            this.§_-AF§.remove(task);
            task.stop();
            taskInterfaces = this.§_-8q§(task);
            for each(taskInterface in taskInterfaces)
            {
               delete this.§_-TV§[taskInterface];
            }
            task.§_-Uw§ = null;
         }
         this.§_-4z§.clear();
      }
      
      private function §_-8q§(object:Object) : Vector.<Class>
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
   public var tasks:Vector.<§_-ps§> = new Vector.<§_-ps§>();
   
   public var numTasks:int;
   
   public function TaskArray()
   {
      super();
   }
   
   public function add(task:§_-ps§) : void
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
   
   public function contains(task:§_-ps§) : Boolean
   {
      return this.tasks.indexOf(task) >= 0;
   }
}
