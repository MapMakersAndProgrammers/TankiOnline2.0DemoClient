package alternativa.osgi.service.console
{
   import alternativa.osgi.service.console.variables.ConsoleVar;
   import alternativa.utils.CircularStringBuffer;
   import alternativa.utils.ICircularStringBuffer;
   import alternativa.utils.IStringBufferIterator;
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
   
   public class Console implements IConsole
   {
      private static const DEFAULT_BG_COLOR:uint = 16777215;
      
      private static const DEFAULT_FONT_COLOR:uint = 0;
      
      private static const DEFAULT_TEXT_FORMAT:TextFormat = new TextFormat("Courier New",12,DEFAULT_FONT_COLOR);
      
      private static const INPUT_HEIGHT:int = 20;
      
      private static const LINE_SPLITTER:RegExp = /\n|\r|\n\r/;
      
      private static const TOKENIZER:RegExp = /(?:[^"\s]+)|(?:"[^"]*")/g;
      
      private var stage:Stage;
      
      private var container:Sprite = new Sprite();
      
      private var name_mB:Sprite;
      
      private var input:TextField;
      
      private var name_2O:Vector.<TextField> = new Vector.<TextField>();
      
      private var name_V8:int;
      
      private var name_k3:int;
      
      private var name_5f:int = 0;
      
      private var name_Y3:Boolean;
      
      private var visible:Boolean;
      
      private var name_Fe:Array = [];
      
      private var name_hY:int = 0;
      
      private var name_Pl:Object = {};
      
      private var name_I9:Object = {};
      
      private var name_HF:int;
      
      private var name_6U:int;
      
      private var name_gO:int;
      
      private var buffer:ICircularStringBuffer;
      
      private var name_Nl:int;
      
      private var name_Gl:int;
      
      private var align:int;
      
      private var name_0P:uint = 16777215;
      
      private var name_Su:uint = 0;
      
      private var name_S9:Number = 1;
      
      private var filter:String;
      
      public function Console(stage:Stage, widthPercent:int, heightPercent:int, hAlign:int, vAlign:int)
      {
         super();
         this.stage = stage;
         this.buffer = new CircularStringBuffer(1000);
         this.calcTextMetrics(stage);
         this.initInput();
         this.initOutput();
         this.setSize(widthPercent,heightPercent);
         this.horizontalAlignment = hAlign;
         this.vericalAlignment = vAlign;
         stage.addEventListener(KeyboardEvent.KEY_UP,this.onKeyUp);
         stage.addEventListener(Event.RESIZE,this.onResize);
         this.setCommandHandler("hide",this.onHide);
         this.setCommandHandler("copy",this.copyConsoleContent);
         this.setCommandHandler("clear",this.clearConsole);
         this.setCommandHandler("cmdlist",this.listCommands);
         this.setCommandHandler("con_height",this.onConsoleHeight);
         this.setCommandHandler("con_width",this.onConsoleWidth);
         this.setCommandHandler("con_halign",this.onHorizontalAlign);
         this.setCommandHandler("con_valign",this.onVerticalAlign);
         this.setCommandHandler("con_alpha",this.onAlpha);
         this.setCommandHandler("con_bg",this.onBackgroundColor);
         this.setCommandHandler("con_fg",this.onForegroundColor);
         this.setCommandHandler("filter",this.onFilterCommand);
         this.setCommandHandler("varlist",this.printVars);
         this.setCommandHandler("varlistv",this.printVarsValues);
      }
      
      public function addVariable(variable:ConsoleVar) : void
      {
         this.name_I9[variable.getName()] = variable;
      }
      
      public function removeVariable(variableName:String) : void
      {
         delete this.name_I9[variableName];
      }
      
      public function set horizontalAlignment(value:int) : void
      {
         value = this.clamp(value,1,3);
         this.align = this.align & ~3 | value;
         this.updateAlignment();
      }
      
      public function get horizontalAlignment() : int
      {
         return this.align & 3;
      }
      
      public function set vericalAlignment(value:int) : void
      {
         value = this.clamp(value,1,3);
         this.align = this.align & ~0x0C | value << 2;
         this.updateAlignment();
      }
      
      public function get vericalAlignment() : int
      {
         return this.align >> 2 & 3;
      }
      
      public function addText(text:String) : void
      {
         var needScroll:Boolean = this.buffer.size - this.name_gO <= this.name_HF;
         var linesAdded:int = this.addLine(text);
         if(needScroll)
         {
            this.scrollOutput(linesAdded);
         }
      }
      
      public function addPrefixedText(prefix:String, text:String) : void
      {
         var needScroll:Boolean = this.buffer.size - this.name_gO <= this.name_HF;
         var linesAdded:int = this.addPrefixedLine(prefix,text);
         if(needScroll)
         {
            this.scrollOutput(linesAdded);
         }
      }
      
      public function addLines(lines:Vector.<String>) : void
      {
         var linesAdded:int = 0;
         var line:String = null;
         var needScroll:Boolean = this.buffer.size - this.name_gO <= this.name_HF;
         for each(line in lines)
         {
            linesAdded += this.addLine(line);
         }
         if(needScroll)
         {
            this.scrollOutput(linesAdded);
         }
      }
      
      public function addPrefixedLines(prefix:String, lines:Vector.<String>) : void
      {
         var linesAdded:int = 0;
         var line:String = null;
         var needScroll:Boolean = this.buffer.size - this.name_gO <= this.name_HF;
         for each(line in lines)
         {
            linesAdded += this.addPrefixedLine(prefix,line);
         }
         if(needScroll)
         {
            this.scrollOutput(linesAdded);
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
         this.onResize(null);
         this.scrollOutput(0);
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
      
      public function isVisible() : Boolean
      {
         return this.visible;
      }
      
      public function setSize(widthPercent:int, heightPercent:int) : void
      {
         widthPercent = this.clamp(widthPercent,1,100);
         heightPercent = this.clamp(heightPercent,1,100);
         if(widthPercent == this.name_Nl && heightPercent == this.name_Gl)
         {
            return;
         }
         this.name_Nl = widthPercent;
         this.name_Gl = heightPercent;
         this.updateSize();
         this.updateAlignment();
      }
      
      public function set width(widthPercent:int) : void
      {
         this.setSize(widthPercent,this.name_Gl);
      }
      
      public function get width() : int
      {
         return this.name_Nl;
      }
      
      public function set height(heightPercent:int) : void
      {
         this.setSize(this.name_Nl,heightPercent);
      }
      
      public function get height() : int
      {
         return this.name_Gl;
      }
      
      public function setCommandHandler(commandName:String, handler:Function) : void
      {
         if(commandName == null || commandName == "")
         {
            throw new ArgumentError("Command name is null or empty");
         }
         if(handler == null)
         {
            throw new ArgumentError("Handler is null");
         }
         this.name_Pl[commandName] = handler;
      }
      
      public function removeCommandHandler(commandName:String) : void
      {
         if(commandName == null || commandName == "")
         {
            throw new ArgumentError("Command name is null or empty");
         }
         delete this.name_Pl[commandName];
      }
      
      public function hideDelayed(delay:uint) : void
      {
         setTimeout(this.hide,delay);
      }
      
      public function executeCommand(text:String) : void
      {
         var _loc6_:Function = null;
         if(Boolean(text.match(/^\s*$/)))
         {
            return;
         }
         var len:int = int(this.name_Fe.length);
         if(len == 0 || this.name_Fe[len - 1] != text)
         {
            this.name_Fe.push(text);
         }
         this.name_hY = len + 1;
         var tokens:Array = text.match(TOKENIZER);
         var commandName:String = tokens.shift();
         var variable:ConsoleVar = this.name_I9[commandName];
         if(variable != null)
         {
            variable.processConsoleInput(this,tokens);
         }
         else
         {
            _loc6_ = this.name_Pl[commandName];
            if(_loc6_ != null)
            {
               _loc6_.call(null,this,tokens);
            }
         }
      }
      
      public function set alpha(value:Number) : void
      {
         this.name_S9 = value;
         this.updateSize();
      }
      
      public function get alpha() : Number
      {
         return this.name_S9;
      }
      
      private function calcTextMetrics(stage:Stage) : void
      {
         var tf:TextField = new TextField();
         tf.defaultTextFormat = DEFAULT_TEXT_FORMAT;
         tf.text = "j";
         stage.addChild(tf);
         this.name_V8 = tf.textWidth;
         this.name_k3 = tf.textHeight + 4;
         stage.removeChild(tf);
      }
      
      private function initInput() : void
      {
         this.input = new TextField();
         this.input.defaultTextFormat = DEFAULT_TEXT_FORMAT;
         this.input.height = INPUT_HEIGHT;
         this.input.type = TextFieldType.INPUT;
         this.input.background = true;
         this.input.backgroundColor = DEFAULT_BG_COLOR;
         this.input.border = true;
         this.input.borderColor = DEFAULT_FONT_COLOR;
         this.input.addEventListener(KeyboardEvent.KEY_DOWN,this.onInputKeyDown);
         this.input.addEventListener(KeyboardEvent.KEY_UP,this.onInputKeyUp);
         this.input.addEventListener(TextEvent.TEXT_INPUT,this.onTextInput);
         this.container.addChild(this.input);
      }
      
      private function initOutput() : void
      {
         this.name_mB = new Sprite();
         this.name_mB.addEventListener(MouseEvent.MOUSE_WHEEL,this.onMouseWheel);
         this.container.addChild(this.name_mB);
      }
      
      private function resizeOutput(w:int, h:int) : void
      {
         this.name_HF = h / (this.name_k3 + this.name_5f);
         this.name_6U = w / this.name_V8 - 1;
         this.updateTextFields(w);
         this.scrollOutput(0);
         var g:Graphics = this.name_mB.graphics;
         g.clear();
         g.beginFill(this.name_0P,this.name_S9);
         g.drawRect(0,0,w,h);
         g.endFill();
      }
      
      private function updateTextFields(w:int) : void
      {
         for(var tf:TextField = null; this.name_2O.length > this.name_HF; )
         {
            this.name_mB.removeChild(this.name_2O.pop());
         }
         while(this.name_2O.length < this.name_HF)
         {
            this.createTextField();
         }
         var lineHeight:int = this.name_k3 + this.name_5f;
         for(var i:int = 0; i < this.name_2O.length; i++)
         {
            tf = this.name_2O[i];
            tf.y = i * lineHeight;
            tf.width = w;
         }
      }
      
      private function createTextField() : void
      {
         var tf:TextField = new TextField();
         tf.height = this.name_k3;
         tf.defaultTextFormat = DEFAULT_TEXT_FORMAT;
         tf.tabEnabled = false;
         tf.selectable = true;
         this.name_mB.addChild(tf);
         this.name_2O.push(tf);
      }
      
      private function scrollOutput(delta:int) : void
      {
         this.name_gO += delta;
         if(this.name_gO + this.name_HF > this.buffer.size)
         {
            this.name_gO = this.buffer.size - this.name_HF;
         }
         if(this.name_gO < 0)
         {
            this.name_gO = 0;
         }
         this.updateOutput();
      }
      
      private function updateOutput() : void
      {
         if(this.container.parent != null)
         {
            this.printPage();
         }
      }
      
      private function printPage() : void
      {
         var pageLineIndex:int = 0;
         var iterator:IStringBufferIterator = this.buffer.getIterator(this.name_gO);
         while(pageLineIndex < this.name_HF && Boolean(iterator.hasNext()))
         {
            TextField(this.name_2O[pageLineIndex++]).text = iterator.getNext();
         }
         while(pageLineIndex < this.name_HF)
         {
            TextField(this.name_2O[pageLineIndex++]).text = "";
         }
      }
      
      private function onInputKeyDown(e:KeyboardEvent) : void
      {
         if(this.isToggleKey(e))
         {
            this.name_Y3 = true;
         }
         switch(e.keyCode)
         {
            case Keyboard.ENTER:
               this.processInput();
               break;
            case Keyboard.ESCAPE:
               if(this.input.text != "")
               {
                  this.input.text = "";
                  break;
               }
               this.hideDelayed(50);
               break;
            case Keyboard.UP:
               this.historyUp();
               break;
            case Keyboard.DOWN:
               this.historyDown();
               break;
            case Keyboard.PAGE_UP:
               this.scrollOutput(-this.name_HF);
               break;
            case Keyboard.PAGE_DOWN:
               this.scrollOutput(this.name_HF);
         }
         e.stopPropagation();
      }
      
      private function onInputKeyUp(e:KeyboardEvent) : void
      {
         if(!this.isToggleKey(e))
         {
            e.stopPropagation();
         }
      }
      
      private function onTextInput(e:TextEvent) : void
      {
         if(this.name_Y3)
         {
            e.preventDefault();
            this.name_Y3 = false;
         }
      }
      
      private function isToggleKey(e:KeyboardEvent) : Boolean
      {
         return e.keyCode == 75 && Boolean(e.ctrlKey) && Boolean(e.shiftKey);
      }
      
      private function processInput() : void
      {
         this.scrollOutput(this.buffer.size);
         var text:String = this.input.text;
         this.input.text = "";
         this.addText("> " + text);
         this.executeCommand(text);
      }
      
      private function historyUp() : void
      {
         if(this.name_hY == 0)
         {
            return;
         }
         --this.name_hY;
         var command:String = this.name_Fe[this.name_hY];
         this.input.text = command == null ? "" : command;
      }
      
      private function historyDown() : void
      {
         ++this.name_hY;
         if(this.name_hY >= this.name_Fe.length)
         {
            this.name_hY = this.name_Fe.length;
            this.input.text = "";
         }
         else
         {
            this.input.text = this.name_Fe[this.name_hY];
         }
      }
      
      private function onKeyUp(e:KeyboardEvent) : void
      {
         if(this.isToggleKey(e))
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
      
      private function onResize(event:Event) : void
      {
         this.updateSize();
         this.updateAlignment();
      }
      
      private function addLine(s:String) : int
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
                  this.buffer.add(line.substr(i,this.name_6U));
                  linesAdded++;
                  i += this.name_6U;
               }
            }
         }
         return linesAdded;
      }
      
      private function addPrefixedLine(prefix:String, s:String) : int
      {
         var linesAdded:int = 0;
         var line:String = null;
         var i:int = 0;
         var lines:Array = s.split(LINE_SPLITTER);
         var effectiveLineWidth:int = this.name_6U - prefix.length;
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
         this.scrollOutput(-event.delta);
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
      
      private function updateSize() : void
      {
         var pixelHeight:int = 0.01 * this.name_Gl * this.stage.stageHeight;
         var pixelWidth:int = 0.01 * this.name_Nl * this.stage.stageWidth;
         var outputHeight:int = pixelHeight - INPUT_HEIGHT;
         this.resizeOutput(pixelWidth,outputHeight);
         this.input.y = outputHeight;
         this.input.width = pixelWidth;
      }
      
      private function updateAlignment() : void
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
      
      private function onHide(console:IConsole, params:Array) : void
      {
         this.hideDelayed(100);
      }
      
      private function copyConsoleContent(console:IConsole, params:Array) : void
      {
         var iterator:IStringBufferIterator = this.buffer.getIterator(0);
         var result:String = "Console content:\n";
         while(iterator.hasNext())
         {
            result += iterator.getNext() + "\n";
         }
         System.setClipboard(result);
         this.addText("Content has been copied to clipboard");
      }
      
      private function clearConsole(console:IConsole, params:Array) : void
      {
         this.buffer.clear();
         this.scrollOutput(0);
      }
      
      private function listCommands(console:IConsole, params:Array) : void
      {
         var commandName:String = null;
         var list:Array = [];
         for(commandName in this.name_Pl)
         {
            list.push(commandName);
         }
         list.sort();
         for each(commandName in list)
         {
            this.addText(commandName);
         }
      }
      
      private function onHorizontalAlign(console:IConsole, params:Array) : void
      {
         if(params.length == 0)
         {
            this.addText("Horizontal alignment=" + (this.align & 3));
         }
         else
         {
            this.horizontalAlignment = int(params[0]);
         }
      }
      
      private function onVerticalAlign(console:IConsole, params:Array) : void
      {
         if(params.length == 0)
         {
            this.addText("Vertical alignment=" + (this.align >> 2 & 3));
         }
         else
         {
            this.vericalAlignment = int(params[0]);
         }
      }
      
      private function onConsoleWidth(console:IConsole, params:Array) : void
      {
         if(params.length == 0)
         {
            this.addText("Width=" + this.name_Nl);
         }
         else
         {
            this.setSize(int(params[0]),this.name_Gl);
         }
      }
      
      private function onConsoleHeight(console:IConsole, params:Array) : void
      {
         if(params.length == 0)
         {
            this.addText("Height=" + this.name_Gl);
         }
         else
         {
            this.setSize(this.name_Nl,int(params[0]));
         }
      }
      
      private function onAlpha(console:IConsole, params:Array) : void
      {
         if(params.length == 0)
         {
            this.addText("Alpha=" + this.name_S9);
         }
         else
         {
            this.alpha = Number(params[0]);
         }
      }
      
      private function onBackgroundColor(console:IConsole, params:Array) : void
      {
         if(params.length == 0)
         {
            this.addText("Background color = " + this.name_0P);
         }
         else
         {
            this.name_0P = uint(params[0]);
            this.updateSize();
            this.input.backgroundColor = this.name_0P;
            this.addText("Background color set to " + this.name_0P);
         }
      }
      
      private function onForegroundColor(console:IConsole, params:Array) : void
      {
         var _loc3_:TextField = null;
         if(params.length == 0)
         {
            this.addText("Foreground color = " + this.name_Su);
         }
         else
         {
            this.name_Su = uint(params[0]);
            DEFAULT_TEXT_FORMAT.color = this.name_Su;
            this.input.textColor = this.name_Su;
            this.input.defaultTextFormat = DEFAULT_TEXT_FORMAT;
            for each(_loc3_ in this.name_2O)
            {
               _loc3_.textColor = this.name_Su;
               _loc3_.defaultTextFormat = DEFAULT_TEXT_FORMAT;
            }
            this.addText("Foreground color set to " + this.name_Su);
         }
      }
      
      private function onFilterCommand(console:IConsole, params:Array) : void
      {
         if(params.length < 2)
         {
            console.addText("Usage: filter <filter_string> <command>");
            return;
         }
         this.filter = params.shift();
         this.addLine("filter: " + this.filter);
         this.executeCommand(params.join(" "));
         this.filter = null;
      }
      
      private function printVars(console:IConsole, args:Array) : void
      {
         this.printVariables(args[0],false);
      }
      
      private function printVarsValues(console:IConsole, args:Array) : void
      {
         this.printVariables(args[0],true);
      }
      
      private function printVariables(start:String, showValues:Boolean) : void
      {
         var name:String = null;
         var variable:ConsoleVar = null;
         var s:String = null;
         var vars:Array = [];
         for(name in this.name_I9)
         {
            if(start == null || start == "" || name.indexOf(start) == 0)
            {
               variable = this.name_I9[name];
               vars.push(showValues ? name + " = " + variable.toString() : name);
            }
         }
         if(vars.length > 0)
         {
            vars.sort();
            for each(s in vars)
            {
               this.addText(s);
            }
         }
      }
   }
}

