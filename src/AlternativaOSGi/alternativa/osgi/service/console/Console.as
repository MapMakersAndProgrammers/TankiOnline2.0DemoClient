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
      
      private var outputContainer:Sprite;
      
      private var input:TextField;
      
      private var textFields:Vector.<TextField> = new Vector.<TextField>();
      
      private var charWidth:int;
      
      private var charHeight:int;
      
      private var hSpacing:int = 0;
      
      private var preventInput:Boolean;
      
      private var visible:Boolean;
      
      private var commandHistory:Array = [];
      
      private var commandHistoryIndex:int = 0;
      
      private var commandHandlers:Object = {};
      
      private var variables:Object = {};
      
      private var numPageLines:int;
      
      private var lineWidth:int;
      
      private var topPageLine:int;
      
      private var buffer:ICircularStringBuffer;
      
      private var _widthPercent:int;
      
      private var _heightPercent:int;
      
      private var align:int;
      
      private var consoleBackgroundColor:uint = 16777215;
      
      private var consoleForegroundColor:uint = 0;
      
      private var _alpha:Number = 1;
      
      private var filter:String;
      
      public function Console(param1:Stage, param2:int, param3:int, param4:int, param5:int)
      {
         super();
         this.stage = param1;
         this.buffer = new CircularStringBuffer(1000);
         this.calcTextMetrics(param1);
         this.initInput();
         this.initOutput();
         this.setSize(param2,param3);
         this.horizontalAlignment = param4;
         this.vericalAlignment = param5;
         param1.addEventListener(KeyboardEvent.KEY_UP,this.onKeyUp);
         param1.addEventListener(Event.RESIZE,this.onResize);
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
      
      public function addVariable(param1:ConsoleVar) : void
      {
         this.variables[param1.getName()] = param1;
      }
      
      public function removeVariable(param1:String) : void
      {
         delete this.variables[param1];
      }
      
      public function set horizontalAlignment(param1:int) : void
      {
         param1 = this.clamp(param1,1,3);
         this.align = this.align & ~3 | param1;
         this.updateAlignment();
      }
      
      public function get horizontalAlignment() : int
      {
         return this.align & 3;
      }
      
      public function set vericalAlignment(param1:int) : void
      {
         param1 = this.clamp(param1,1,3);
         this.align = this.align & ~0x0C | param1 << 2;
         this.updateAlignment();
      }
      
      public function get vericalAlignment() : int
      {
         return this.align >> 2 & 3;
      }
      
      public function addText(param1:String) : void
      {
         var _loc2_:Boolean = this.buffer.size - this.topPageLine <= this.numPageLines;
         var _loc3_:int = this.addLine(param1);
         if(_loc2_)
         {
            this.scrollOutput(_loc3_);
         }
      }
      
      public function addPrefixedText(param1:String, param2:String) : void
      {
         var _loc3_:Boolean = this.buffer.size - this.topPageLine <= this.numPageLines;
         var _loc4_:int = this.addPrefixedLine(param1,param2);
         if(_loc3_)
         {
            this.scrollOutput(_loc4_);
         }
      }
      
      public function addLines(param1:Vector.<String>) : void
      {
         var _loc3_:int = 0;
         var _loc4_:String = null;
         var _loc2_:Boolean = this.buffer.size - this.topPageLine <= this.numPageLines;
         for each(_loc4_ in param1)
         {
            _loc3_ += this.addLine(_loc4_);
         }
         if(_loc2_)
         {
            this.scrollOutput(_loc3_);
         }
      }
      
      public function addPrefixedLines(param1:String, param2:Vector.<String>) : void
      {
         var _loc4_:int = 0;
         var _loc5_:String = null;
         var _loc3_:Boolean = this.buffer.size - this.topPageLine <= this.numPageLines;
         for each(_loc5_ in param2)
         {
            _loc4_ += this.addPrefixedLine(param1,_loc5_);
         }
         if(_loc3_)
         {
            this.scrollOutput(_loc4_);
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
      
      public function setSize(param1:int, param2:int) : void
      {
         param1 = this.clamp(param1,1,100);
         param2 = this.clamp(param2,1,100);
         if(param1 == this._widthPercent && param2 == this._heightPercent)
         {
            return;
         }
         this._widthPercent = param1;
         this._heightPercent = param2;
         this.updateSize();
         this.updateAlignment();
      }
      
      public function set width(param1:int) : void
      {
         this.setSize(param1,this._heightPercent);
      }
      
      public function get width() : int
      {
         return this._widthPercent;
      }
      
      public function set height(param1:int) : void
      {
         this.setSize(this._widthPercent,param1);
      }
      
      public function get height() : int
      {
         return this._heightPercent;
      }
      
      public function setCommandHandler(param1:String, param2:Function) : void
      {
         if(param1 == null || param1 == "")
         {
            throw new ArgumentError("Command name is null or empty");
         }
         if(param2 == null)
         {
            throw new ArgumentError("Handler is null");
         }
         this.commandHandlers[param1] = param2;
      }
      
      public function removeCommandHandler(param1:String) : void
      {
         if(param1 == null || param1 == "")
         {
            throw new ArgumentError("Command name is null or empty");
         }
         delete this.commandHandlers[param1];
      }
      
      public function hideDelayed(param1:uint) : void
      {
         setTimeout(this.hide,param1);
      }
      
      public function executeCommand(param1:String) : void
      {
         var _loc6_:Function = null;
         if(Boolean(param1.match(/^\s*$/)))
         {
            return;
         }
         var _loc2_:int = int(this.commandHistory.length);
         if(_loc2_ == 0 || this.commandHistory[_loc2_ - 1] != param1)
         {
            this.commandHistory.push(param1);
         }
         this.commandHistoryIndex = _loc2_ + 1;
         var _loc3_:Array = param1.match(TOKENIZER);
         var _loc4_:String = _loc3_.shift();
         var _loc5_:ConsoleVar = this.variables[_loc4_];
         if(_loc5_ != null)
         {
            _loc5_.processConsoleInput(this,_loc3_);
         }
         else
         {
            _loc6_ = this.commandHandlers[_loc4_];
            if(_loc6_ != null)
            {
               _loc6_.call(null,this,_loc3_);
            }
         }
      }
      
      public function set alpha(param1:Number) : void
      {
         this._alpha = param1;
         this.updateSize();
      }
      
      public function get alpha() : Number
      {
         return this._alpha;
      }
      
      private function calcTextMetrics(param1:Stage) : void
      {
         var _loc2_:TextField = new TextField();
         _loc2_.defaultTextFormat = DEFAULT_TEXT_FORMAT;
         _loc2_.text = "j";
         param1.addChild(_loc2_);
         this.charWidth = _loc2_.textWidth;
         this.charHeight = _loc2_.textHeight + 4;
         param1.removeChild(_loc2_);
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
         this.outputContainer = new Sprite();
         this.outputContainer.addEventListener(MouseEvent.MOUSE_WHEEL,this.onMouseWheel);
         this.container.addChild(this.outputContainer);
      }
      
      private function resizeOutput(param1:int, param2:int) : void
      {
         this.numPageLines = param2 / (this.charHeight + this.hSpacing);
         this.lineWidth = param1 / this.charWidth - 1;
         this.updateTextFields(param1);
         this.scrollOutput(0);
         var _loc3_:Graphics = this.outputContainer.graphics;
         _loc3_.clear();
         _loc3_.beginFill(this.consoleBackgroundColor,this._alpha);
         _loc3_.drawRect(0,0,param1,param2);
         _loc3_.endFill();
      }
      
      private function updateTextFields(param1:int) : void
      {
         var _loc4_:TextField = null;
         while(this.textFields.length > this.numPageLines)
         {
            this.outputContainer.removeChild(this.textFields.pop());
         }
         while(this.textFields.length < this.numPageLines)
         {
            this.createTextField();
         }
         var _loc2_:int = this.charHeight + this.hSpacing;
         var _loc3_:int = 0;
         while(_loc3_ < this.textFields.length)
         {
            _loc4_ = this.textFields[_loc3_];
            _loc4_.y = _loc3_ * _loc2_;
            _loc4_.width = param1;
            _loc3_++;
         }
      }
      
      private function createTextField() : void
      {
         var _loc1_:TextField = new TextField();
         _loc1_.height = this.charHeight;
         _loc1_.defaultTextFormat = DEFAULT_TEXT_FORMAT;
         _loc1_.tabEnabled = false;
         _loc1_.selectable = true;
         this.outputContainer.addChild(_loc1_);
         this.textFields.push(_loc1_);
      }
      
      private function scrollOutput(param1:int) : void
      {
         this.topPageLine += param1;
         if(this.topPageLine + this.numPageLines > this.buffer.size)
         {
            this.topPageLine = this.buffer.size - this.numPageLines;
         }
         if(this.topPageLine < 0)
         {
            this.topPageLine = 0;
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
         var _loc2_:int = 0;
         var _loc1_:IStringBufferIterator = this.buffer.getIterator(this.topPageLine);
         while(_loc2_ < this.numPageLines && _loc1_.hasNext())
         {
            TextField(this.textFields[_loc2_++]).text = _loc1_.getNext();
         }
         while(_loc2_ < this.numPageLines)
         {
            TextField(this.textFields[_loc2_++]).text = "";
         }
      }
      
      private function onInputKeyDown(param1:KeyboardEvent) : void
      {
         if(this.isToggleKey(param1))
         {
            this.preventInput = true;
         }
         switch(param1.keyCode)
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
               this.scrollOutput(-this.numPageLines);
               break;
            case Keyboard.PAGE_DOWN:
               this.scrollOutput(this.numPageLines);
         }
         param1.stopPropagation();
      }
      
      private function onInputKeyUp(param1:KeyboardEvent) : void
      {
         if(!this.isToggleKey(param1))
         {
            param1.stopPropagation();
         }
      }
      
      private function onTextInput(param1:TextEvent) : void
      {
         if(this.preventInput)
         {
            param1.preventDefault();
            this.preventInput = false;
         }
      }
      
      private function isToggleKey(param1:KeyboardEvent) : Boolean
      {
         return param1.keyCode == 75 && param1.ctrlKey && param1.shiftKey;
      }
      
      private function processInput() : void
      {
         this.scrollOutput(this.buffer.size);
         var _loc1_:String = this.input.text;
         this.input.text = "";
         this.addText("> " + _loc1_);
         this.executeCommand(_loc1_);
      }
      
      private function historyUp() : void
      {
         if(this.commandHistoryIndex == 0)
         {
            return;
         }
         --this.commandHistoryIndex;
         var _loc1_:String = this.commandHistory[this.commandHistoryIndex];
         this.input.text = _loc1_ == null ? "" : _loc1_;
      }
      
      private function historyDown() : void
      {
         ++this.commandHistoryIndex;
         if(this.commandHistoryIndex >= this.commandHistory.length)
         {
            this.commandHistoryIndex = this.commandHistory.length;
            this.input.text = "";
         }
         else
         {
            this.input.text = this.commandHistory[this.commandHistoryIndex];
         }
      }
      
      private function onKeyUp(param1:KeyboardEvent) : void
      {
         if(this.isToggleKey(param1))
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
      
      private function onResize(param1:Event) : void
      {
         this.updateSize();
         this.updateAlignment();
      }
      
      private function addLine(param1:String) : int
      {
         var _loc2_:int = 0;
         var _loc4_:String = null;
         var _loc5_:int = 0;
         var _loc3_:Array = param1.split(LINE_SPLITTER);
         for each(_loc4_ in _loc3_)
         {
            if(!(Boolean(this.filter) && _loc4_.indexOf(this.filter) < 0))
            {
               _loc5_ = 0;
               while(_loc5_ < _loc4_.length)
               {
                  this.buffer.add(_loc4_.substr(_loc5_,this.lineWidth));
                  _loc2_++;
                  _loc5_ += this.lineWidth;
               }
            }
         }
         return _loc2_;
      }
      
      private function addPrefixedLine(param1:String, param2:String) : int
      {
         var _loc3_:int = 0;
         var _loc6_:String = null;
         var _loc7_:int = 0;
         var _loc4_:Array = param2.split(LINE_SPLITTER);
         var _loc5_:int = this.lineWidth - param1.length;
         for each(_loc6_ in _loc4_)
         {
            if(!(Boolean(this.filter) && _loc6_.indexOf(this.filter) < 0))
            {
               _loc7_ = 0;
               while(_loc7_ < _loc6_.length)
               {
                  this.buffer.add(param1 + _loc6_.substr(_loc7_,_loc5_));
                  _loc3_++;
                  _loc7_ += _loc5_;
               }
            }
         }
         return _loc3_;
      }
      
      private function onMouseWheel(param1:MouseEvent) : void
      {
         this.scrollOutput(-param1.delta);
      }
      
      private function clamp(param1:int, param2:int, param3:int) : int
      {
         if(param1 < param2)
         {
            return param2;
         }
         if(param1 > param3)
         {
            return param3;
         }
         return param1;
      }
      
      private function updateSize() : void
      {
         var _loc1_:int = 0.01 * this._heightPercent * this.stage.stageHeight;
         var _loc2_:int = 0.01 * this._widthPercent * this.stage.stageWidth;
         var _loc3_:int = _loc1_ - INPUT_HEIGHT;
         this.resizeOutput(_loc2_,_loc3_);
         this.input.y = _loc3_;
         this.input.width = _loc2_;
      }
      
      private function updateAlignment() : void
      {
         var _loc1_:int = this.align & 3;
         switch(_loc1_)
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
         var _loc2_:int = this.align >> 2 & 3;
         switch(_loc2_)
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
      
      private function onHide(param1:IConsole, param2:Array) : void
      {
         this.hideDelayed(100);
      }
      
      private function copyConsoleContent(param1:IConsole, param2:Array) : void
      {
         var _loc3_:IStringBufferIterator = this.buffer.getIterator(0);
         var _loc4_:String = "Console content:\n";
         while(_loc3_.hasNext())
         {
            _loc4_ += _loc3_.getNext() + "\n";
         }
         System.setClipboard(_loc4_);
         this.addText("Content has been copied to clipboard");
      }
      
      private function clearConsole(param1:IConsole, param2:Array) : void
      {
         this.buffer.clear();
         this.scrollOutput(0);
      }
      
      private function listCommands(param1:IConsole, param2:Array) : void
      {
         var _loc4_:String = null;
         var _loc3_:Array = [];
         for(_loc4_ in this.commandHandlers)
         {
            _loc3_.push(_loc4_);
         }
         _loc3_.sort();
         for each(_loc4_ in _loc3_)
         {
            this.addText(_loc4_);
         }
      }
      
      private function onHorizontalAlign(param1:IConsole, param2:Array) : void
      {
         if(param2.length == 0)
         {
            this.addText("Horizontal alignment=" + (this.align & 3));
         }
         else
         {
            this.horizontalAlignment = int(param2[0]);
         }
      }
      
      private function onVerticalAlign(param1:IConsole, param2:Array) : void
      {
         if(param2.length == 0)
         {
            this.addText("Vertical alignment=" + (this.align >> 2 & 3));
         }
         else
         {
            this.vericalAlignment = int(param2[0]);
         }
      }
      
      private function onConsoleWidth(param1:IConsole, param2:Array) : void
      {
         if(param2.length == 0)
         {
            this.addText("Width=" + this._widthPercent);
         }
         else
         {
            this.setSize(int(param2[0]),this._heightPercent);
         }
      }
      
      private function onConsoleHeight(param1:IConsole, param2:Array) : void
      {
         if(param2.length == 0)
         {
            this.addText("Height=" + this._heightPercent);
         }
         else
         {
            this.setSize(this._widthPercent,int(param2[0]));
         }
      }
      
      private function onAlpha(param1:IConsole, param2:Array) : void
      {
         if(param2.length == 0)
         {
            this.addText("Alpha=" + this._alpha);
         }
         else
         {
            this.alpha = Number(param2[0]);
         }
      }
      
      private function onBackgroundColor(param1:IConsole, param2:Array) : void
      {
         if(param2.length == 0)
         {
            this.addText("Background color = " + this.consoleBackgroundColor);
         }
         else
         {
            this.consoleBackgroundColor = uint(param2[0]);
            this.updateSize();
            this.input.backgroundColor = this.consoleBackgroundColor;
            this.addText("Background color set to " + this.consoleBackgroundColor);
         }
      }
      
      private function onForegroundColor(param1:IConsole, param2:Array) : void
      {
         var _loc3_:TextField = null;
         if(param2.length == 0)
         {
            this.addText("Foreground color = " + this.consoleForegroundColor);
         }
         else
         {
            this.consoleForegroundColor = uint(param2[0]);
            DEFAULT_TEXT_FORMAT.color = this.consoleForegroundColor;
            this.input.textColor = this.consoleForegroundColor;
            this.input.defaultTextFormat = DEFAULT_TEXT_FORMAT;
            for each(_loc3_ in this.textFields)
            {
               _loc3_.textColor = this.consoleForegroundColor;
               _loc3_.defaultTextFormat = DEFAULT_TEXT_FORMAT;
            }
            this.addText("Foreground color set to " + this.consoleForegroundColor);
         }
      }
      
      private function onFilterCommand(param1:IConsole, param2:Array) : void
      {
         if(param2.length < 2)
         {
            param1.addText("Usage: filter <filter_string> <command>");
            return;
         }
         this.filter = param2.shift();
         this.addLine("filter: " + this.filter);
         this.executeCommand(param2.join(" "));
         this.filter = null;
      }
      
      private function printVars(param1:IConsole, param2:Array) : void
      {
         this.printVariables(param2[0],false);
      }
      
      private function printVarsValues(param1:IConsole, param2:Array) : void
      {
         this.printVariables(param2[0],true);
      }
      
      private function printVariables(param1:String, param2:Boolean) : void
      {
         var _loc4_:String = null;
         var _loc5_:ConsoleVar = null;
         var _loc6_:String = null;
         var _loc3_:Array = [];
         for(_loc4_ in this.variables)
         {
            if(param1 == null || param1 == "" || _loc4_.indexOf(param1) == 0)
            {
               _loc5_ = this.variables[_loc4_];
               _loc3_.push(param2 ? _loc4_ + " = " + _loc5_.toString() : _loc4_);
            }
         }
         if(_loc3_.length > 0)
         {
            _loc3_.sort();
            for each(_loc6_ in _loc3_)
            {
               this.addText(_loc6_);
            }
         }
      }
   }
}

