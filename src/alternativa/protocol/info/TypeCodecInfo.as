package alternativa.protocol.info
{
   import flash.utils.getQualifiedClassName;
   
   public class TypeCodecInfo extends CodecInfo
   {
      private var §_-hx§:Class;
      
      public function TypeCodecInfo(type:Class, optional:Boolean)
      {
         super(optional);
         this.§_-hx§ = type;
      }
      
      public function get type() : Class
      {
         return this.§_-hx§;
      }
      
      override public function toString() : String
      {
         return "[TypeCodecInfo " + super.toString() + " type=" + getQualifiedClassName(this.type);
      }
   }
}

