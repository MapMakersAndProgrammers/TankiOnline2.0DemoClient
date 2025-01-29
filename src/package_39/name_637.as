package package_39
{
   import alternativa.utils.CircularStringBuffer;
   
   public class name_637
   {
      private var _name:String;
      
      private var buffer:CircularStringBuffer;
      
      private var listeners:Vector.<name_450> = new Vector.<name_450>();
      
      public function name_637(name:String, bufferSize:int)
      {
         super();
         this._name = name;
         this.buffer = new CircularStringBuffer(bufferSize);
      }
      
      public function get name() : String
      {
         return this._name;
      }
      
      public function log(text:String) : void
      {
         var listener:name_450 = null;
         this.buffer.add(text);
         for each(listener in this.listeners)
         {
            listener.method_622(this._name,text);
         }
      }
      
      public function name_638() : Vector.<String>
      {
         return this.buffer.name_638();
      }
      
      public function addLogListener(listener:name_450) : void
      {
         var i:int = int(this.listeners.indexOf(listener));
         if(i < 0)
         {
            this.listeners.push(listener);
         }
      }
      
      public function removeLogListener(listener:name_450) : void
      {
         var i:int = int(this.listeners.indexOf(listener));
         if(i > -1)
         {
            this.listeners.splice(i,1);
         }
      }
   }
}

