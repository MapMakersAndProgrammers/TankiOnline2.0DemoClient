package package_6
{
   import flash.display.DisplayObjectContainer;
   import package_12.name_54;
   import package_15.class_1;
   import package_15.name_17;
   import package_15.name_53;
   import package_16.name_18;
   import package_16.name_57;
   import package_16.name_69;
   import package_18.name_51;
   import package_19.name_52;
   import package_4.name_24;
   import package_5.A3DMapComponent;
   
   public class name_16 extends class_1
   {
      private var gameKernel:name_17;
      
      private var config:name_18;
      
      private var container:DisplayObjectContainer;
      
      private var preloader:Preloader;
      
      public function name_16(param1:name_17, param2:name_18, param3:DisplayObjectContainer, param4:Preloader)
      {
         super(name_17.EVENT_SYSTEM_PRIORITY + 1);
         this.gameKernel = param1;
         this.config = param2;
         this.preloader = param4;
         this.container = param3;
      }
      
      override public function run() : void
      {
         var _loc1_:name_51 = this.gameKernel.name_5();
         var _loc2_:name_24 = new name_24(_loc1_.name_20(),this.gameKernel.name_65());
         _loc1_.name_62(_loc2_);
         _loc2_.name_74(0,0,1000);
         _loc2_.name_75(0,2000,0);
         this.container.addChild(_loc1_.name_70());
         var _loc3_:name_53 = this.method_20();
         this.gameKernel.name_72(_loc3_);
         this.preloader.name_68(0.75);
         var_4.addTask(new name_50(name_17.INPUT_SYSTEM_PRIORITY + 1,this.config,this.gameKernel,_loc2_,this.preloader));
         var_4.killTask(this);
      }
      
      private function method_20() : name_53
      {
         var _loc2_:name_54 = null;
         var _loc6_:name_57 = null;
         var _loc7_:String = null;
         var _loc3_:name_69 = this.config.name_67.name_71("skybox");
         if(_loc3_ != null)
         {
            _loc2_ = new name_54();
            _loc6_ = _loc3_.name_61(this.config.name_66());
            for each(_loc7_ in [name_52.BACK,name_52.BOTTOM,name_52.FRONT,name_52.LEFT,name_52.RIGHT,name_52.TOP])
            {
               _loc2_.name_58(_loc7_,_loc6_.name_64(_loc7_));
            }
         }
         var _loc4_:name_53 = new name_53(name_53.name_73());
         var _loc5_:A3DMapComponent = new A3DMapComponent(this.config.mapData,_loc2_,1000000,new MapListener(this.gameKernel.name_60()));
         _loc4_.name_59(_loc5_);
         _loc4_.name_63();
         return _loc4_;
      }
   }
}

import package_15.name_56;
import package_20.name_55;
import package_5.class_2;

class MapListener implements class_2
{
   private var eventSystem:name_55;
   
   public function MapListener(param1:name_55)
   {
      super();
      this.eventSystem = param1;
   }
   
   public function onA3DMapComplete() : void
   {
      this.eventSystem.dispatchEvent(name_56.MAP_COMPLETE,null);
   }
}
