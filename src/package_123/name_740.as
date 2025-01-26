package package_123
{
   use namespace collada;
   
   public class name_740 extends class_43
   {
      private const const_9:String = "float_array";
      
      private const const_7:String = "int_array";
      
      private const const_8:String = "Name_array";
      
      public var numbers:Vector.<Number>;
      
      public var var_549:Vector.<int>;
      
      public var names:Vector.<String>;
      
      public var stride:int;
      
      public function name_740(data:XML, document:name_707)
      {
         super(data,document);
         this.method_898();
      }
      
      private function method_898() : void
      {
         var child:XML = null;
         var array:name_746 = null;
         var children:XMLList = data.children();
         for(var i:int = 0,var count:int = int(children.length()); i < count; )
         {
            child = children[i];
            switch(child.localName())
            {
               case this.const_9:
               case this.const_7:
               case this.const_8:
                  array = new name_746(child,document);
                  if(array.id != null)
                  {
                     document.arrays[array.id] = array;
                  }
                  break;
            }
            i++;
         }
      }
      
      private function get accessor() : XML
      {
         return data.technique_common.accessor[0];
      }
      
      override protected function parseImplementation() : Boolean
      {
         var arrayXML:XML = null;
         var array:name_746 = null;
         var countXML:String = null;
         var count:int = 0;
         var offsetXML:XML = null;
         var strideXML:XML = null;
         var offset:int = 0;
         var stride:int = 0;
         var accessor:XML = this.accessor;
         if(accessor != null)
         {
            arrayXML = accessor.@source[0];
            array = arrayXML == null ? null : document.findArray(arrayXML);
            if(array != null)
            {
               countXML = accessor.@count[0];
               if(countXML != null)
               {
                  count = int(parseInt(countXML.toString(),10));
                  offsetXML = accessor.@offset[0];
                  strideXML = accessor.@stride[0];
                  offset = offsetXML == null ? 0 : int(parseInt(offsetXML.toString(),10));
                  stride = strideXML == null ? 1 : int(parseInt(strideXML.toString(),10));
                  array.method_314();
                  if(array.array.length < offset + count * stride)
                  {
                     document.logger.logNotEnoughDataError(accessor);
                     return false;
                  }
                  this.stride = this.method_900(offset,count,stride,array.array,array.type);
                  return true;
               }
            }
            else
            {
               document.logger.logNotFoundError(arrayXML);
            }
         }
         return false;
      }
      
      private function method_899(params:XMLList) : int
      {
         var res:int = 0;
         for(var i:int = 0,var count:int = int(params.length()); i < count; )
         {
            if(params[i].@name[0] != null)
            {
               res++;
            }
            i++;
         }
         return res;
      }
      
      private function method_900(offset:int, count:int, stride:int, array:Array, type:String) : int
      {
         var param:XML = null;
         var j:int = 0;
         var value:String = null;
         var params:XMLList = this.accessor.param;
         var arrStride:int = int(Math.max(this.method_899(params),stride));
         switch(type)
         {
            case this.const_9:
               this.numbers = new Vector.<Number>(int(arrStride * count));
               break;
            case this.const_7:
               this.var_549 = new Vector.<int>(int(arrStride * count));
               break;
            case this.const_8:
               this.names = new Vector.<String>(int(arrStride * count));
         }
         var curr:int = 0;
         for(var i:int = 0; i < arrStride; )
         {
            param = params[i];
            if(param == null || Boolean(param.hasOwnProperty("@name")))
            {
               switch(type)
               {
                  case this.const_9:
                     for(j = 0; j < count; j++)
                     {
                        value = array[int(offset + stride * j + i)];
                        if(value.indexOf(",") != -1)
                        {
                           value = value.replace(/,/,".");
                        }
                        this.numbers[int(arrStride * j + curr)] = parseFloat(value);
                     }
                     break;
                  case this.const_7:
                     for(j = 0; j < count; j++)
                     {
                        this.var_549[int(arrStride * j + curr)] = parseInt(array[int(offset + stride * j + i)],10);
                     }
                     break;
                  case this.const_8:
                     for(j = 0; j < count; j++)
                     {
                        this.names[int(arrStride * j + curr)] = array[int(offset + stride * j + i)];
                     }
               }
               curr++;
            }
            i++;
         }
         return arrStride;
      }
   }
}

