package platform.client.fp10.core.registry.impl
{
   import alternativa.types.Long;
   import platform.client.fp10.core.registry.SpaceRegistry;
   import platform.client.fp10.core.type.ISpace;
   
   public class SpaceRegistryImpl implements SpaceRegistry
   {
      
      private var _spaces:Vector.<ISpace> = new Vector.<ISpace>();
      
      private var _currentSpace:ISpace;
      
      public function SpaceRegistryImpl()
      {
         super();
      }
      
      public function addSpace(param1:ISpace) : void
      {
         this._spaces.push(param1);
      }
      
      public function removeSpace(param1:ISpace) : void
      {
         var _loc2_:int = this._spaces.indexOf(param1);
         if(_loc2_ < 0)
         {
            throw new Error("Space not found: " + param1.id);
         }
         this._spaces.splice(_loc2_,1);
      }
      
      public function get spaces() : Vector.<ISpace>
      {
         return this._spaces;
      }
      
      public function getSpace(param1:Long) : ISpace
      {
         var _loc2_:ISpace = null;
         for each(_loc2_ in this._spaces)
         {
            if(_loc2_.id == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function get currentSpace() : ISpace
      {
         return this._currentSpace;
      }
      
      public function set currentSpace(param1:ISpace) : void
      {
         this._currentSpace = param1;
      }
   }
}

