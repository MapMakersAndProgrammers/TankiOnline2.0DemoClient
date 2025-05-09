package alternativa.tanks.game.subsystems.rendersystem
{
   import alternativa.engine3d.core.Object3D;
   import alternativa.tanks.game.utils.objectpool.ObjectPool;
   import alternativa.tanks.game.utils.objectpool.PooledObject;
   import flash.display.DisplayObjectContainer;
   import flash.geom.Vector3D;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   
   public class TextMarker extends PooledObject implements IGraphicEffect
   {
      private static const DEFAULT_TEXT_FORMAT:TextFormat = new TextFormat("Tahoma",12,16777215);
      
      private static var point1:Vector3D = new Vector3D();
      
      private static var point2:Vector3D = new Vector3D();
      
      private var tf:TextField;
      
      private var var_146:Boolean;
      
      private var anchor:Object3D;
      
      public function TextMarker(objectPool:ObjectPool)
      {
         super(objectPool);
         this.tf = new TextField();
         this.tf.defaultTextFormat = DEFAULT_TEXT_FORMAT;
         this.tf.autoSize = TextFieldAutoSize.LEFT;
      }
      
      public function init(overlay:DisplayObjectContainer, text:String, anchor:Object3D) : void
      {
         overlay.addChild(this.tf);
         this.tf.visible = false;
         this.anchor = anchor;
         this.tf.text = text;
         this.var_146 = true;
      }
      
      public function kill() : void
      {
         this.var_146 = false;
      }
      
      public function play(camera:GameCamera) : Boolean
      {
         point1.x = this.anchor.x;
         point1.y = this.anchor.y;
         point1.z = this.anchor.z;
         if(point2.z > 0 && point2.z > camera.nearClipping)
         {
            this.tf.x = point2.x;
            this.tf.y = point2.y;
            this.tf.visible = true;
         }
         else
         {
            this.tf.visible = false;
         }
         return this.var_146;
      }
      
      public function addedToRenderSystem(system:RenderSystem) : void
      {
      }
      
      public function destroy() : void
      {
         if(this.tf.parent != null)
         {
            this.tf.parent.removeChild(this.tf);
         }
         this.anchor = null;
         this.tf.text = "";
         storeInPool();
      }
   }
}

