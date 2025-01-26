package alternativa.osgi.service.console
{
   import alternativa.osgi.service.console.variables.ConsoleVar;
   
   public interface IConsole
   {
      function show() : void;
      
      function hide() : void;
      
      function method_141() : Boolean;
      
      function name_145(param1:String) : void;
      
      function method_143(param1:String, param2:String) : void;
      
      function method_145(param1:Vector.<String>) : void;
      
      function method_142(param1:String, param2:Vector.<String>) : void;
      
      function method_140(param1:int, param2:int) : void;
      
      function set width(param1:int) : void;
      
      function get width() : int;
      
      function set height(param1:int) : void;
      
      function get height() : int;
      
      function set method_138(param1:int) : void;
      
      function get method_138() : int;
      
      function set method_137(param1:int) : void;
      
      function get method_137() : int;
      
      function set alpha(param1:Number) : void;
      
      function get alpha() : Number;
      
      function name_45(param1:String, param2:Function) : void;
      
      function method_144(param1:String) : void;
      
      function method_139(param1:String) : void;
      
      function name_147(param1:ConsoleVar) : void;
      
      function name_146(param1:String) : void;
   }
}

