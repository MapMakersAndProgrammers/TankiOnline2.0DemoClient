package package_43
{
   import package_10.class_1;
   
   public class name_183 extends class_1
   {
      private var commands:name_190;
      
      public function name_183(priority:int)
      {
         super(priority);
      }
      
      public function name_187(command:name_190) : void
      {
         command.next = this.commands;
         this.commands = command;
      }
      
      override public function run() : void
      {
         for(var command:name_190 = null; this.commands != null; )
         {
            command = this.commands;
            this.commands = this.commands.next;
            command.next = null;
            command.execute();
            command.method_254();
         }
      }
   }
}

