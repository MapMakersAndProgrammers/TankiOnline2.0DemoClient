package package_6
{
   import flash.display.Graphics;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import flash.system.System;
   import flash.text.TextField;
   import flash.text.TextFieldType;
   import flash.text.TextFormat;
   import flash.ui.Keyboard;
   import flash.utils.setTimeout;
   import package_1.name_22;
   import package_15.name_632;
   import package_15.name_634;
   import package_15.name_635;
   
   public class name_354 implements name_4
   {
      private static const DEFAULT_BG_COLOR:uint = 16777215;
      
      private static const DEFAULT_FONT_COLOR:uint = 0;
      
      private static const DEFAULT_TEXT_FORMAT:TextFormat = new TextFormat("Courier New",12,DEFAULT_FONT_COLOR);
      
      private static const INPUT_HEIGHT:int = 20;
      
      private static const LINE_SPLITTER:RegExp = /\n|\r|\n\r/;
      
      private static const TOKENIZER:RegExp = /(?:[^"\s]+)|(?:"[^"]*")/g;
      
      private var stage:Stage;
      
      private var container:Sprite = new Sprite();
      
      private var var_538:Sprite;
      
      private var input:TextField;
      
      private var var_532:Vector.<TextField> = new Vector.<TextField>();
      
      private var var_546:int;
      
      private var var_543:int;
      
      private var var_545:int = 0;
      
      private var var_544:Boolean;
      
      private var visible:Boolean;
      
      private var var_533:Array = [];
      
      private var var_531:int = 0;
      
      private var var_540:Object = {};
      
      private var var_536:Object = {};
      
      private var var_529:int;
      
      private var var_542:int;
      
      private var var_530:int;
      
      private var buffer:name_635;
      
      private var var_535:int;
      
      private var var_534:int;
      
      private var align:int;
      
      private var var_539:uint = 16777215;
      
      private var var_537:uint = 0;
      
      private var var_541:Number = 1;
      
      private var filter:String;
      
      public function name_354(stage:Stage, widthPercent:int, heightPercent:int, hAlign:int, vAlign:int)
      {
         super();
         this.stage = stage;
         this.buffer = new name_634(1000);
         this.method_566(stage);
         this.method_584();
         this.method_580();
         this.method_140(widthPercent,heightPercent);
         this.method_138 = hAlign;
         this.method_137 = vAlign;
         stage.addEventListener(KeyboardEvent.KEY_UP,this.method_233);
         stage.addEventListener(Event.RESIZE,this.method_4);
         this.name_45("hide",this.method_571);
         this.name_45("copy",this.method_583);
         this.name_45("clear",this.method_577);
         this.name_45("cmdlist",this.method_574);
         this.name_45("con_height",this.method_573);
         this.name_45("con_width",this.method_564);
         this.name_45("con_halign",this.method_575);
         this.name_45("con_valign",this.method_572);
         this.name_45("con_alpha",this.method_569);
         this.name_45("con_bg",this.method_570);
         this.name_45("con_fg",this.method_589);
         this.name_45("filter",this.method_582);
         this.name_45("varlist",this.method_565);
         this.name_45("varlistv",this.method_579);
      }
      
      public function name_147(variable:name_22) : void
      {
         this.var_536[variable.name_32()] = variable;
      }
      
      public function name_146(variableName:String) : void
      {
         delete this.var_536[variableName];
      }
      
      public function set method_138(value:int) : void
      {
         value = this.clamp(value,1,3);
         this.align = this.align & ~3 | value;
         this.method_556();
      }
      
      public function get method_138() : int
      {
         return this.align & 3;
      }
      
      public function set method_137(value:int) : void
      {
         value = this.clamp(value,1,3);
         this.align = this.align & ~0x0C | value << 2;
         this.method_556();
      }
      
      public function get method_137() : int
      {
         return this.align >> 2 & 3;
      }
      
      public function name_145(text:String) : void
      {
         var needScroll:Boolean = this.buffer.size - this.var_530 <= this.var_529;
         var linesAdded:int = this.method_558(text);
         if(needScroll)
         {
            this.method_555(linesAdded);
         }
      }
      
      public function method_143(prefix:String, text:String) : void
      {
         var needScroll:Boolean = this.buffer.size - this.var_530 <= this.var_529;
         var linesAdded:int = this.method_560(prefix,text);
         if(needScroll)
         {
            this.method_555(linesAdded);
         }
      }
      
      public function method_145(lines:Vector.<String>) : void
      {
         var linesAdded:int = 0;
         var line:String = null;
         var needScroll:Boolean = this.buffer.size - this.var_530 <= this.var_529;
         for each(line in lines)
         {
            linesAdded += this.method_558(line);
         }
         if(needScroll)
         {
            this.method_555(linesAdded);
         }
      }
      
      public function method_142(prefix:String, lines:Vector.<String>) : void
      {
         var linesAdded:int = 0;
         var line:String = null;
         var needScroll:Boolean = this.buffer.size - this.var_530 <= this.var_529;
         for each(line in lines)
         {
            linesAdded += this.method_560(prefix,line);
         }
         if(needScroll)
         {
            this.method_555(linesAdded);
         }
      }
      
      public function show() : void
      {
         if(this.visible)
         {
            return;
         }
         this.stage.addChild(this.container);
         this.stage.focus = this.input;
         this.visible = true;
         this.method_4(null);
         this.method_555(0);
      }
      
      public function hide() : void
      {
         if(this.stage == null)
         {
            return;
         }
         if(this.visible)
         {
            this.stage.removeChild(this.container);
            this.stage.focus = this.stage;
            this.visible = false;
         }
      }
      
      public function method_141() : Boolean
      {
         return this.visible;
      }
      
      public function method_140(widthPercent:int, heightPercent:int) : void
      {
         widthPercent = this.clamp(widthPercent,1,100);
         heightPercent = this.clamp(heightPercent,1,100);
         if(widthPercent == this.var_535 && heightPercent == this.var_534)
         {
            return;
         }
         this.var_535 = widthPercent;
         this.var_534 = heightPercent;
         this.method_557();
         this.method_556();
      }
      
      public function set width(widthPercent:int) : void
      {
         this.method_140(widthPercent,this.var_534);
      }
      
      public function get width() : int
      {
         return this.var_535;
      }
      
      public function set height(heightPercent:int) : void
      {
         this.method_140(this.var_535,heightPercent);
      }
      
      public function get height() : int
      {
         return this.var_534;
      }
      
      public function name_45(commandName:String, handler:Function) : void
      {
         if(commandName == null || commandName == "")
         {
            throw new ArgumentError("Command name is null or empty");
         }
         if(handler == null)
         {
            throw new ArgumentError("Handler is null");
         }
         this.var_540[commandName] = handler;
      }
      
      public function method_144(commandName:String) : void
      {
         if(commandName == null || commandName == "")
         {
            throw new ArgumentError("Command name is null or empty");
         }
         delete this.var_540[commandName];
      }
      
      public function method_561(delay:uint) : void
      {
         setTimeout(this.hide,delay);
      }
      
      public function method_139(text:String) : void
      {
         var commandHandler:Function = null;
         if(Boolean(text.match(/^\s*$/)))
         {
            return;
         }
         var len:int = int(this.var_533.length);
         if(len == 0 || this.var_533[len - 1] != text)
         {
            this.var_533.push(text);
         }
         this.var_531 = len + 1;
         var tokens:Array = text.match(TOKENIZER);
         var commandName:String = tokens.shift();
         var variable:name_22 = this.var_536[commandName];
         if(variable != null)
         {
            variable.method_77(this,tokens);
         }
         else
         {
            commandHandler = this.var_540[commandName];
            if(commandHandler != null)
            {
               commandHandler.call(null,this,tokens);
            }
         }
      }
      
      public function set alpha(value:Number) : void
      {
         this.var_541 = value;
         this.method_557();
      }
      
      public function get alpha() : Number
      {
         return this.var_541;
      }
      
      private function method_566(stage:Stage) : void
      {
         var tf:TextField = new TextField();
         tf.defaultTextFormat = DEFAULT_TEXT_FORMAT;
         tf.text = "j";
         stage.addChild(tf);
         this.var_546 = tf.textWidth;
         this.var_543 = tf.textHeight + 4;
         stage.removeChild(tf);
      }
      
      private function method_584() : void
      {
         this.input = new TextField();
         this.input.defaultTextFormat = DEFAULT_TEXT_FORMAT;
         this.input.height = INPUT_HEIGHT;
         this.input.type = TextFieldType.INPUT;
         this.input.background = true;
         this.input.backgroundColor = DEFAULT_BG_COLOR;
         this.input.border = true;
         this.input.borderColor = DEFAULT_FONT_COLOR;
         this.input.addEventListener(KeyboardEvent.KEY_DOWN,this.method_568);
         this.input.addEventListener(KeyboardEvent.KEY_UP,this.method_585);
         this.input.addEventListener(TextEvent.TEXT_INPUT,this.method_567);
         this.container.addChild(this.input);
      }
      
      private function method_580() : void
      {
         this.var_538 = new Sprite();
         this.var_538.addEventListener(MouseEvent.MOUSE_WHEEL,this.onMouseWheel);
         this.container.addChild(this.var_538);
      }
      
      private function method_578(w:int, h:int) : void
      {
         this.var_529 = h / (this.var_543 + this.var_545);
         this.var_542 = w / this.var_546 - 1;
         this.method_581(w);
         this.method_555(0);
         var g:Graphics = this.var_538.graphics;
         g.clear();
         g.beginFill(this.var_539,this.var_541);
         g.drawRect(0,0,w,h);
         g.endFill();
      }
      
      private function method_581(w:int) : void
      {
         for(var tf:TextField = null; this.var_532.length > this.var_529; )
         {
            this.var_538.removeChild(this.var_532.pop());
         }
         while(this.var_532.length < this.var_529)
         {
            this.method_457();
         }
         var lineHeight:int = this.var_543 + this.var_545;
         for(var i:int = 0; i < this.var_532.length; i++)
         {
            tf = this.var_532[i];
            tf.y = i * lineHeight;
            tf.width = w;
         }
      }
      
      private function method_457() : void
      {
         var tf:TextField = new TextField();
         tf.height = this.var_543;
         tf.defaultTextFormat = DEFAULT_TEXT_FORMAT;
         tf.tabEnabled = false;
         tf.selectable = true;
         this.var_538.addChild(tf);
         this.var_532.push(tf);
      }
      
      private function method_555(delta:int) : void
      {
         this.var_530 += delta;
         if(this.var_530 + this.var_529 > this.buffer.size)
         {
            this.var_530 = this.buffer.size - this.var_529;
         }
         if(this.var_530 < 0)
         {
            this.var_530 = 0;
         }
         this.method_576();
      }
      
      private function method_576() : void
      {
         if(this.container.parent != null)
         {
            this.method_588();
         }
      }
      
      private function method_588() : void
      {
         var pageLineIndex:int = 0;
         var iterator:name_632 = this.buffer.name_633(this.var_530);
         while(pageLineIndex < this.var_529 && Boolean(iterator.hasNext()))
         {
            TextField(this.var_532[pageLineIndex++]).text = iterator.getNext();
         }
         while(pageLineIndex < this.var_529)
         {
            TextField(this.var_532[pageLineIndex++]).text = "";
         }
      }
      
      private function method_568(e:KeyboardEvent) : void
      {
         if(this.method_559(e))
         {
            this.var_544 = true;
         }
         switch(e.keyCode)
         {
            case Keyboard.ENTER:
               this.method_587();
               break;
            case Keyboard.ESCAPE:
               if(this.input.text != "")
               {
                  this.input.text = "";
                  break;
               }
               this.method_561(50);
               break;
            case Keyboard.UP:
               this.method_563();
               break;
            case Keyboard.DOWN:
               this.method_586();
               break;
            case Keyboard.PAGE_UP:
               this.method_555(-this.var_529);
               break;
            case Keyboard.PAGE_DOWN:
               this.method_555(this.var_529);
         }
         e.stopPropagation();
      }
      
      private function method_585(e:KeyboardEvent) : void
      {
         if(!this.method_559(e))
         {
            e.stopPropagation();
         }
      }
      
      private function method_567(e:TextEvent) : void
      {
         if(this.var_544)
         {
            e.preventDefault();
            this.var_544 = false;
         }
      }
      
      private function method_559(e:KeyboardEvent) : Boolean
      {
         return e.keyCode == 75 && Boolean(e.ctrlKey) && Boolean(e.shiftKey);
      }
      
      private function method_587() : void
      {
         this.method_555(this.buffer.size);
         var text:String = this.input.text;
         this.input.text = "";
         this.name_145("> " + text);
         this.method_139(text);
      }
      
      private function method_563() : void
      {
         if(this.var_531 == 0)
         {
            return;
         }
         --this.var_531;
         var command:String = this.var_533[this.var_531];
         this.input.text = command == null ? "" : command;
      }
      
      private function method_586() : void
      {
         ++this.var_531;
         if(this.var_531 >= this.var_533.length)
         {
            this.var_531 = this.var_533.length;
            this.input.text = "";
         }
         else
         {
            this.input.text = this.var_533[this.var_531];
         }
      }
      
      private function method_233(e:KeyboardEvent) : void
      {
         if(this.method_559(e))
         {
            if(this.visible)
            {
               this.hide();
            }
            else
            {
               this.show();
            }
         }
      }
      
      private function method_4(event:Event) : void
      {
         this.method_557();
         this.method_556();
      }
      
      private function method_558(s:String) : int
      {
         var linesAdded:int = 0;
         var line:String = null;
         var i:int = 0;
         var lines:Array = s.split(LINE_SPLITTER);
         for each(line in lines)
         {
            if(!(Boolean(this.filter) && line.indexOf(this.filter) < 0))
            {
               for(i = 0; i < line.length; )
               {
                  this.buffer.add(line.substr(i,this.var_542));
                  linesAdded++;
                  i += this.var_542;
               }
            }
         }
         return linesAdded;
      }
      
      private function method_560(prefix:String, s:String) : int
      {
         var linesAdded:int = 0;
         var line:String = null;
         var i:int = 0;
         var lines:Array = s.split(LINE_SPLITTER);
         var effectiveLineWidth:int = this.var_542 - prefix.length;
         for each(line in lines)
         {
            if(!(Boolean(this.filter) && line.indexOf(this.filter) < 0))
            {
               for(i = 0; i < line.length; )
               {
                  this.buffer.add(prefix + line.substr(i,effectiveLineWidth));
                  linesAdded++;
                  i += effectiveLineWidth;
               }
            }
         }
         return linesAdded;
      }
      
      private function onMouseWheel(event:MouseEvent) : void
      {
         this.method_555(-event.delta);
      }
      
      private function clamp(value:int, min:int, max:int) : int
      {
         if(value < min)
         {
            return min;
         }
         if(value > max)
         {
            return max;
         }
         return value;
      }
      
      private function method_557() : void
      {
         var pixelHeight:int = 0.01 * this.var_534 * this.stage.stageHeight;
         var pixelWidth:int = 0.01 * this.var_535 * this.stage.stageWidth;
         var outputHeight:int = pixelHeight - INPUT_HEIGHT;
         this.method_578(pixelWidth,outputHeight);
         this.input.y = outputHeight;
         this.input.width = pixelWidth;
      }
      
      private function method_556() : void
      {
         var hAlign:int = this.align & 3;
         switch(hAlign)
         {
            case 1:
               this.container.x = 0;
               break;
            case 2:
               this.container.x = this.stage.stageWidth - this.container.width;
               break;
            case 3:
               this.container.x = this.stage.stageWidth - this.container.width >> 1;
         }
         var vAlign:int = this.align >> 2 & 3;
         switch(vAlign)
         {
            case 1:
               this.container.y = 0;
               break;
            case 2:
               this.container.y = this.stage.stageHeight - this.container.height;
               break;
            case 3:
               this.container.y = this.stage.stageHeight - this.container.height >> 1;
         }
      }
      
      private function method_571(console:name_4, params:Array) : void
      {
         this.method_561(100);
      }
      
      private function method_583(console:name_4, params:Array) : void
      {
         var iterator:name_632 = this.buffer.name_633(0);
         var result:String = "Console content:\n";
         while(iterator.hasNext())
         {
            result += iterator.getNext() + "\n";
         }
         System.setClipboard(result);
         this.name_145("Content has been copied to clipboard");
      }
      
      private function method_577(console:name_4, params:Array) : void
      {
         this.buffer.clear();
         this.method_555(0);
      }
      
      private function method_574(console:name_4, params:Array) : void
      {
         var commandName:String = null;
         var list:Array = [];
         for(commandName in this.var_540)
         {
            list.push(commandName);
         }
         list.sort();
         for each(commandName in list)
         {
            this.name_145(commandName);
         }
      }
      
      private function method_575(console:name_4, params:Array) : void
      {
         if(params.length == 0)
         {
            this.name_145("Horizontal alignment=" + (this.align & 3));
         }
         else
         {
            this.method_138 = int(params[0]);
         }
      }
      
      private function method_572(console:name_4, params:Array) : void
      {
         if(params.length == 0)
         {
            this.name_145("Vertical alignment=" + (this.align >> 2 & 3));
         }
         else
         {
            this.method_137 = int(params[0]);
         }
      }
      
      private function method_564(console:name_4, params:Array) : void
      {
         if(params.length == 0)
         {
            this.name_145("Width=" + this.var_535);
         }
         else
         {
            this.method_140(int(params[0]),this.var_534);
         }
      }
      
      private function method_573(console:name_4, params:Array) : void
      {
         if(params.length == 0)
         {
            this.name_145("Height=" + this.var_534);
         }
         else
         {
            this.method_140(this.var_535,int(params[0]));
         }
      }
      
      private function method_569(console:name_4, params:Array) : void
      {
         if(params.length == 0)
         {
            this.name_145("Alpha=" + this.var_541);
         }
         else
         {
            this.alpha = Number(params[0]);
         }
      }
      
      private function method_570(console:name_4, params:Array) : void
      {
         if(params.length == 0)
         {
            this.name_145("Background color = " + this.var_539);
         }
         else
         {
            this.var_539 = uint(params[0]);
            this.method_557();
            this.input.backgroundColor = this.var_539;
            this.name_145("Background color set to " + this.var_539);
         }
      }
      
      private function method_589(console:name_4, params:Array) : void
      {
         var tf:TextField = null;
         if(params.length == 0)
         {
            this.name_145("Foreground color = " + this.var_537);
         }
         else
         {
            this.var_537 = uint(params[0]);
            DEFAULT_TEXT_FORMAT.color = this.var_537;
            this.input.textColor = this.var_537;
            this.input.defaultTextFormat = DEFAULT_TEXT_FORMAT;
            for each(tf in this.var_532)
            {
               tf.textColor = this.var_537;
               tf.defaultTextFormat = DEFAULT_TEXT_FORMAT;
            }
            this.name_145("Foreground color set to " + this.var_537);
         }
      }
      
      private function method_582(console:name_4, params:Array) : void
      {
         if(params.length < 2)
         {
            console.name_145("Usage: filter <filter_string> <command>");
            return;
         }
         this.filter = params.shift();
         this.method_558("filter: " + this.filter);
         this.method_139(params.join(" "));
         this.filter = null;
      }
      
      private function method_565(console:name_4, args:Array) : void
      {
         this.method_562(args[0],false);
      }
      
      private function method_579(console:name_4, args:Array) : void
      {
         this.method_562(args[0],true);
      }
      
      private function method_562(start:String, showValues:Boolean) : void
      {
         var name:String = null;
         var variable:name_22 = null;
         var s:String = null;
         var vars:Array = [];
         for(name in this.var_536)
         {
            if(start == null || start == "" || name.indexOf(start) == 0)
            {
               variable = this.var_536[name];
               vars.push(showValues ? name + " = " + variable.toString() : name);
            }
         }
         if(vars.length > 0)
         {
            vars.sort();
            for each(s in vars)
            {
               this.name_145(s);
            }
         }
      }
   }
}

