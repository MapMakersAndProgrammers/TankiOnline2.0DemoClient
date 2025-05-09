package alternativa.tanks.config
{
   import alternativa.tanks.utils.Task;
   
   public class ResourceLoader extends Task
   {
      public var config:Config;
      
      public var name:String;
      
      public function ResourceLoader(param1:String, param2:Config)
      {
         super();
         this.config = param2;
         this.name = param1;
      }
   }
}

