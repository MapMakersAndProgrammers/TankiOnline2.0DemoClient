package alternativa.engine3d.loaders.collada
{
   use namespace collada;
   
   public class DaeSource extends DaeElement
   {
      private const §_-XM§:String = "float_array";
      
      private const §_-g6§:String = "int_array";
      
      private const §_-ZJ§:String = "Name_array";
      
      public var numbers:Vector.<Number>;
      
      public var §_-op§:Vector.<int>;
      
      public var names:Vector.<String>;
      
      public var stride:int;
      
      public function DaeSource(data:XML, document:DaeDocument)
      {
         super(data,document);
         this.constructArrays();
      }
      
      private function constructArrays() : void
      {
         var child:XML = null;
         var _loc5_:DaeArray = null;
         var children:XMLList = data.children();
         for(var i:int = 0,var count:int = int(children.length()); i < count; )
         {
            child = children[i];
            switch(child.localName())
            {
               case this.§_-XM§:
               case this.§_-g6§:
               case this.§_-ZJ§:
                  _loc5_ = new DaeArray(child,document);
                  if(_loc5_.id != null)
                  {
                     document.arrays[_loc5_.id] = _loc5_;
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
         var array:DaeArray = null;
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
                  array.parse();
                  if(array.array.length < offset + count * stride)
                  {
                     document.logger.logNotEnoughDataError(accessor);
                     return false;
                  }
                  this.stride = this.parseArray(offset,count,stride,array.array,array.type);
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
      
      private function numValidParams(params:XMLList) : int
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
      
      private function parseArray(offset:int, count:int, stride:int, array:Array, type:String) : int
      {
         var param:XML = null;
         var j:int = 0;
         var value:String = null;
         var params:XMLList = this.accessor.param;
         var arrStride:int = int(Math.max(this.numValidParams(params),stride));
         switch(type)
         {
            case this.§_-XM§:
               this.numbers = new Vector.<Number>(int(arrStride * count));
               break;
            case this.§_-g6§:
               this.§_-op§ = new Vector.<int>(int(arrStride * count));
               break;
            case this.§_-ZJ§:
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
                  case this.§_-XM§:
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
                  case this.§_-g6§:
                     for(j = 0; j < count; j++)
                     {
                        this.§_-op§[int(arrStride * j + curr)] = parseInt(array[int(offset + stride * j + i)],10);
                     }
                     break;
                  case this.§_-ZJ§:
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

