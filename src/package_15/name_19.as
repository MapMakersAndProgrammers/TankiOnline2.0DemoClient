package package_15
{
   public class name_19
   {
      private var data:Object;
      
      public function name_19(data:Object = null)
      {
         super();
         this.data = data || new Object();
      }
      
      public function method_24(key:String) : String
      {
         return this.data[key];
      }
      
      public function method_25(key:String, defaultValue:String) : String
      {
         return this.data[key] || defaultValue;
      }
      
      public function method_27(key:String, value:String) : void
      {
         if(!value)
         {
            throw new ArgumentError("Empty values are not allowed");
         }
         this.data[key] = value;
      }
      
      public function get method_26() : Vector.<String>
      {
         var name:String = null;
         var names:Vector.<String> = new Vector.<String>();
         for(name in this.data)
         {
            names.push(name);
         }
         return names;
      }
      
      public function toString() : String
      {
         var key:String = null;
         var result:String = "";
         for(key in this.data)
         {
            if(Boolean(result))
            {
               result += ", ";
            }
            result += key + ": " + this.data[key];
         }
         return "[Properties " + result + "]";
      }
   }
}

