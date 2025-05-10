package alternativa.tanks.game
{
   import alternativa.tanks.game.utils.list.List;
   import alternativa.tanks.game.utils.list.ListIterator;
   import flash.utils.Dictionary;
   import flash.utils.describeType;
   import flash.utils.getDefinitionByName;
   
   public class TaskManager
   {
      private var name_AF:List = new List();
      
      private var name_Ey:TaskArray = new TaskArray();
      
      private var name_4z:TaskArray = new TaskArray();
      
      private var name_TV:Dictionary = new Dictionary();
      
      public function TaskManager()
      {
         super();
      }
      
      public function addTask(task:GameTask) : void
      {
         if(this.name_AF.contains(task))
         {
            throw new Error("Task is already active");
         }
         if(this.name_Ey.contains(task))
         {
            throw new Error("Task has been already scheduled for addition");
         }
         this.name_Ey.add(task);
      }
      
      public function killTask(task:GameTask) : void
      {
         if(this.name_AF.contains(task) && !this.name_4z.contains(task))
         {
            this.name_4z.add(task);
         }
      }
      
      public function runTasks() : void
      {
         var task:GameTask = null;
         this.startAddedTasks();
         var iterator:ListIterator = this.name_AF.listIterator();
         while(iterator.hasNext())
         {
            task = GameTask(iterator.next());
            if(!task.paused)
            {
               task.run();
            }
         }
         this.removeKilledTasks();
      }
      
      public function getTaskInterface(taskInterface:Class) : Object
      {
         return this.name_TV[taskInterface];
      }
      
      public function killAll() : void
      {
         var task:GameTask = null;
         var listIterator:ListIterator = this.name_AF.listIterator();
         while(listIterator.hasNext())
         {
            task = GameTask(listIterator.next());
            this.killTask(task);
         }
      }
      
      private function startAddedTasks() : void
      {
         var task:GameTask = null;
         var taskInterfaces:Vector.<Class> = null;
         var taskInterface:Class = null;
         var activeTasksIterator:ListIterator = null;
         var activeTask:GameTask = null;
         for(var i:int = 0; i < this.name_Ey.numTasks; i++)
         {
            task = this.name_Ey.tasks[i];
            task.name_Uw = this;
            task.start();
            taskInterfaces = this.getObjectInterfaces(task);
            for each(taskInterface in taskInterfaces)
            {
               this.name_TV[taskInterface] = task;
            }
            activeTasksIterator = this.name_AF.listIterator();
            while(activeTasksIterator.hasNext())
            {
               activeTask = GameTask(activeTasksIterator.next());
               if(activeTask.priority > task.priority)
               {
                  activeTasksIterator.previous();
                  break;
               }
            }
            activeTasksIterator.add(task);
         }
         this.name_Ey.clear();
      }
      
      private function removeKilledTasks() : void
      {
         var task:GameTask = null;
         var taskInterfaces:Vector.<Class> = null;
         var taskInterface:Class = null;
         for(var i:int = 0; i < this.name_4z.numTasks; i++)
         {
            task = this.name_4z.tasks[i];
            this.name_AF.remove(task);
            task.stop();
            taskInterfaces = this.getObjectInterfaces(task);
            for each(taskInterface in taskInterfaces)
            {
               delete this.name_TV[taskInterface];
            }
            task.name_Uw = null;
         }
         this.name_4z.clear();
      }
      
      private function getObjectInterfaces(object:Object) : Vector.<Class>
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

import alternativa.tanks.game.GameTask;

class TaskArray
{
   public var tasks:Vector.<GameTask> = new Vector.<GameTask>();
   
   public var numTasks:int;
   
   public function TaskArray()
   {
      super();
   }
   
   public function add(task:GameTask) : void
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
   
   public function contains(task:GameTask) : Boolean
   {
      return this.tasks.indexOf(task) >= 0;
   }
}
