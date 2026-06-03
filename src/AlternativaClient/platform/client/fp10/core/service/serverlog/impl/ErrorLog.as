package platform.client.fp10.core.service.serverlog.impl
{
   import flash.display.Graphics;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.system.System;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.ui.Keyboard;
   
   public class ErrorLog
   {
      
      private var textFormat:TextFormat = new TextFormat("Courier",14);
      
      private var textColor:uint = 0;
      
      private var bgColor:uint = 14540253;
      
      private var stage:Stage;
      
      private var btnShowLog:ErrorLogButton;
      
      private var btnCloseLog:ErrorLogButton;
      
      private var btnCopyLog:ErrorLogButton;
      
      private var btnClearLog:ErrorLogButton;
      
      private var container:Sprite;
      
      private var output:Sprite;
      
      private var levelFilter:Object = {};
      
      private var entries:Vector.<LogEntry> = new Vector.<LogEntry>();
      
      private var filteredEntries:Vector.<LogEntry> = new Vector.<LogEntry>();
      
      private var logLevels:Array = [];
      
      private var textFields:Vector.<TextField> = new Vector.<TextField>();
      
      private var filterButtons:Vector.<FilterButton> = new Vector.<FilterButton>();
      
      private var charWidth:int;
      
      private var charHeight:int;
      
      private var hSpacing:int = 2;
      
      private var numLines:int;
      
      private var lineWidth:int;
      
      private var currentLine:int;
      
      public function ErrorLog(param1:Stage)
      {
         super();
         this.stage = param1;
         this.container = new Sprite();
         this.btnShowLog = new ErrorLogButton("[Click to view server log messages]",16776960,16711680);
         this.btnShowLog.addEventListener(MouseEvent.CLICK,this.onBtnShowLogClick);
         this.btnCloseLog = new ErrorLogButton("[Close]",65280,0);
         this.btnCloseLog.addEventListener(MouseEvent.CLICK,this.onBtnCloseClick);
         this.container.addChild(this.btnCloseLog);
         this.btnCopyLog = new ErrorLogButton("[Copy to clipboard]",65280,0);
         this.btnCopyLog.addEventListener(MouseEvent.CLICK,this.onBtnCopyClick);
         this.btnCopyLog.x = this.btnCloseLog.width;
         this.container.addChild(this.btnCopyLog);
         this.btnClearLog = new ErrorLogButton("[Clear]",65280,0);
         this.btnClearLog.addEventListener(MouseEvent.CLICK,this.onBtnClearClick);
         this.btnClearLog.x = this.btnCopyLog.x + this.btnCopyLog.width;
         this.container.addChild(this.btnClearLog);
         this.container.addEventListener(KeyboardEvent.KEY_DOWN,this.onKey);
         this.container.addEventListener(MouseEvent.MOUSE_WHEEL,this.onMouseWheel);
         this.output = new Sprite();
         this.container.addChild(this.output);
         param1.addEventListener(Event.RESIZE,this.onStageResize);
         this.calcTextMetrics(param1);
         this.onStageResize(null);
      }
      
      public function addLogMessage(param1:String, param2:String) : void
      {
         var _loc6_:String = null;
         var _loc7_:int = 0;
         this.updateLogLevels(param1);
         var _loc3_:int = this.currentLine;
         var _loc4_:int = this.lineWidth - param1.length - 3;
         var _loc5_:Array = param2.split(/\n|\r|\n\r/);
         for each(_loc6_ in _loc5_)
         {
            _loc7_ = 0;
            while(_loc7_ < _loc6_.length)
            {
               this.addLogEntry(new LogEntry(param1,_loc6_.substr(_loc7_,_loc4_)));
               _loc7_ += _loc4_;
            }
         }
         if(this.container.parent == null)
         {
            this.stage.addChild(this.btnShowLog);
         }
         else if(_loc3_ != this.currentLine)
         {
            this.updateOutput();
         }
      }
      
      private function addLogEntry(param1:LogEntry) : void
      {
         this.entries.push(param1);
         if(this.levelFilter[param1.logLevel] != null)
         {
            this.filteredEntries.push(param1);
            if(this.currentLine == this.filteredEntries.length - 1)
            {
               this.currentLine = this.filteredEntries.length;
            }
         }
      }
      
      private function updateOutput() : void
      {
         if(this.container.parent != null)
         {
            this.printEntries(this.filteredEntries,this.currentLine);
         }
      }
      
      private function calcTextMetrics(param1:Stage) : void
      {
         var _loc2_:TextField = new TextField();
         _loc2_.defaultTextFormat = this.textFormat;
         _loc2_.text = "a";
         param1.addChild(_loc2_);
         this.charWidth = _loc2_.textWidth;
         this.charHeight = _loc2_.textHeight;
         param1.removeChild(_loc2_);
      }
      
      private function resizeOutput(param1:int, param2:int) : void
      {
         this.numLines = param2 / (this.charHeight + this.hSpacing);
         this.lineWidth = param1 / this.charWidth;
         this.updateTextFields(param1);
         this.scrollOutput(0);
         var _loc3_:Graphics = this.output.graphics;
         _loc3_.clear();
         _loc3_.beginFill(this.bgColor);
         _loc3_.drawRect(0,0,param1,param2);
         _loc3_.endFill();
      }
      
      private function updateTextFields(param1:int) : void
      {
         var _loc4_:TextField = null;
         while(this.textFields.length > this.numLines)
         {
            this.output.removeChild(this.textFields.pop());
         }
         while(this.textFields.length < this.numLines)
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
         _loc1_.textColor = this.textColor;
         _loc1_.defaultTextFormat = this.textFormat;
         this.output.addChild(_loc1_);
         this.textFields.push(_loc1_);
      }
      
      private function printEntries(param1:Vector.<LogEntry>, param2:int) : void
      {
         var _loc4_:int = 0;
         var _loc5_:LogEntry = null;
         var _loc3_:int = param2 - this.numLines;
         if(_loc3_ < 0)
         {
            _loc3_ = 0;
         }
         else
         {
            param2 = this.numLines;
         }
         _loc4_ = 0;
         while(_loc4_ < param2)
         {
            _loc5_ = param1[_loc3_ + _loc4_];
            this.textFields[_loc4_].text = _loc5_.toString();
            _loc4_++;
         }
         while(_loc4_ < this.numLines)
         {
            this.textFields[_loc4_++].text = "";
         }
      }
      
      private function filterByLevels() : void
      {
         var _loc1_:LogEntry = null;
         this.filteredEntries.length = 0;
         for each(_loc1_ in this.entries)
         {
            if(this.levelFilter[_loc1_.logLevel] != null)
            {
               this.filteredEntries.push(_loc1_);
            }
         }
         this.scrollOutput(0);
      }
      
      private function updateLogLevels(param1:String) : void
      {
         var _loc3_:FilterButton = null;
         var _loc2_:int = this.logLevels.indexOf(param1);
         if(_loc2_ < 0)
         {
            this.logLevels.push(param1);
            this.logLevels.sort();
            this.levelFilter[param1] = true;
            _loc3_ = new FilterButton("[" + param1 + "]",65280,21760,0,param1);
            this.container.addChild(_loc3_);
            _loc3_.addEventListener(MouseEvent.CLICK,this.onFilterButtonClick);
            _loc3_.y = 20;
            this.filterButtons.push(_loc3_);
            this.filterButtons.sort(this.filterSort);
            this.updateFilterButtons();
         }
      }
      
      private function updateFilterButtons() : void
      {
         var _loc2_:FilterButton = null;
         var _loc1_:int = 0;
         for each(_loc2_ in this.filterButtons)
         {
            _loc2_.x = _loc1_;
            _loc1_ += _loc2_.width;
         }
      }
      
      private function filterSort(param1:FilterButton, param2:FilterButton) : Number
      {
         if(param1.filterString == param2.filterString)
         {
            return 0;
         }
         if(param1.filterString > param2.filterString)
         {
            return 1;
         }
         return -1;
      }
      
      private function onFilterButtonClick(param1:MouseEvent) : void
      {
         var _loc2_:FilterButton = FilterButton(param1.target);
         _loc2_.active = !_loc2_.active;
         if(_loc2_.active)
         {
            this.levelFilter[_loc2_.filterString] = true;
         }
         else
         {
            delete this.levelFilter[_loc2_.filterString];
         }
         this.filterByLevels();
         this.updateOutput();
      }
      
      private function onBtnShowLogClick(param1:Event) : void
      {
         this.stage.removeChild(this.btnShowLog);
         this.stage.addChild(this.container);
         this.onStageResize(null);
      }
      
      private function onStageResize(param1:Event) : void
      {
         var _loc2_:int = 40;
         this.output.y = _loc2_;
         this.resizeOutput(this.stage.stageWidth,this.stage.stageHeight - _loc2_);
         this.printEntries(this.filteredEntries,this.currentLine);
      }
      
      private function onBtnCloseClick(param1:Event) : void
      {
         this.stage.removeChild(this.container);
         this.stage.focus = this.stage;
      }
      
      private function onBtnCopyClick(param1:Event) : void
      {
         var _loc3_:LogEntry = null;
         var _loc2_:String = "";
         for each(_loc3_ in this.filteredEntries)
         {
            _loc2_ += _loc3_.toString() + "\n";
         }
         System.setClipboard(_loc2_);
      }
      
      private function onBtnClearClick(param1:Event) : void
      {
         var _loc2_:FilterButton = null;
         this.entries.length = 0;
         this.filteredEntries.length = 0;
         for each(_loc2_ in this.filterButtons)
         {
            _loc2_.removeEventListener(MouseEvent.CLICK,this.onFilterButtonClick);
            this.container.removeChild(_loc2_);
         }
         this.filterButtons.length = 0;
         this.logLevels.length = 0;
         this.levelFilter = {};
         this.currentLine = 0;
         this.updateOutput();
      }
      
      private function onKey(param1:KeyboardEvent) : void
      {
         switch(param1.keyCode)
         {
            case Keyboard.PAGE_UP:
               this.scrollOutput(-this.numLines);
               break;
            case Keyboard.PAGE_DOWN:
               this.scrollOutput(this.numLines);
         }
      }
      
      private function scrollOutput(param1:int) : void
      {
         this.currentLine += param1;
         if(this.currentLine < this.numLines)
         {
            this.currentLine = this.numLines;
         }
         if(this.currentLine > this.filteredEntries.length)
         {
            this.currentLine = this.filteredEntries.length;
         }
         this.updateOutput();
      }
      
      private function onMouseWheel(param1:MouseEvent) : void
      {
         this.scrollOutput(-param1.delta);
      }
   }
}

import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.InteractiveObject;
import flash.display.Sprite;
import flash.events.EventDispatcher;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;

class LogEntry
{
   
   public var logLevel:String;
   
   public var text:String;
   
   public function LogEntry(param1:String, param2:String)
   {
      super();
      this.logLevel = param1;
      this.text = param2;
   }
   
   public function toString() : String
   {
      return "[" + this.logLevel + "] " + this.text;
   }
}

class ErrorLogButton extends Sprite
{
   
   private var label:TextField;
   
   public function ErrorLogButton(param1:String, param2:uint, param3:uint)
   {
      super();
      mouseChildren = false;
      buttonMode = true;
      this.label = new TextField();
      this.label.defaultTextFormat = new TextFormat("Tahoma",12,param2);
      this.label.autoSize = TextFieldAutoSize.LEFT;
      this.label.text = param1;
      this.label.background = true;
      this.label.backgroundColor = param3;
      addChild(this.label);
   }
}

class FilterButton extends Sprite
{
   
   public var filterString:String;
   
   private var _active:Boolean = true;
   
   private var label:TextField;
   
   private var activeBgColor:uint;
   
   private var inactiveBgColor:uint;
   
   public function FilterButton(param1:String, param2:uint, param3:uint, param4:uint, param5:String)
   {
      super();
      this.activeBgColor = param3;
      this.inactiveBgColor = param4;
      this.filterString = param5;
      mouseChildren = false;
      buttonMode = true;
      this.label = new TextField();
      this.label.defaultTextFormat = new TextFormat("Tahoma",12,param2);
      this.label.autoSize = TextFieldAutoSize.LEFT;
      this.label.text = param1;
      this.label.background = true;
      this.label.backgroundColor = param3;
      addChild(this.label);
   }
   
   public function get active() : Boolean
   {
      return this._active;
   }
   
   public function set active(param1:Boolean) : void
   {
      this._active = param1;
      this.label.backgroundColor = this._active ? uint(this.activeBgColor) : uint(this.inactiveBgColor);
   }
}
