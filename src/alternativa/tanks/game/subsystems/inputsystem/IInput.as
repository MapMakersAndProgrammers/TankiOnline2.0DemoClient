package alternativa.tanks.game.subsystems.inputsystem
{
   public interface IInput
   {
      function addKeyboardListener(param1:KeyboardEventType, param2:Function, param3:uint = 0) : void;
      
      function removeKeyboardListener(param1:KeyboardEventType, param2:Function, param3:uint = 0) : void;
      
      function getKeyState(param1:uint) : int;
      
      function keyPressed(param1:uint) : Boolean;
      
      function mouseButtonPressed() : Boolean;
      
      function getMouseWheelDelta() : int;
      
      function wasMouseButtonPressed() : Boolean;
      
      function getMouseDeltaX() : int;
      
      function getMouseDeltaY() : int;
   }
}

