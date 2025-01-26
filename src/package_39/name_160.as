package package_39
{
   public interface name_160 extends name_203
   {
      function logError(param1:String, param2:String, ... rest) : void;
      
      function getChannelStrings(param1:String) : Vector.<String>;
      
      function addLogListener(param1:name_450) : void;
      
      function removeLogListener(param1:name_450) : void;
      
      function addLogChannelListener(param1:String, param2:name_450) : void;
      
      function removeLogChannelListener(param1:String, param2:name_450) : void;
      
      function getChannelNames() : Vector.<String>;
   }
}

