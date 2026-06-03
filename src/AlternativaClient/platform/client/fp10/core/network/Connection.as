package platform.client.fp10.core.network
{
   import alternativa.osgi.service.clientlog.IClientLog;
   import alternativa.osgi.service.launcherparams.ILauncherParams;
   import alternativa.osgi.service.network.INetworkService;
   import alternativa.protocol.CompressionType;
   import alternativa.protocol.ICodec;
   import alternativa.protocol.IProtocol;
   import alternativa.protocol.OptionalMap;
   import alternativa.protocol.ProtocolBuffer;
   import flash.events.ErrorEvent;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.Socket;
   import flash.utils.ByteArray;
   import platform.client.fp10.core.service.messagebox.IMessageBoxService;
   import platform.client.fp10.core.service.messagebox.MessageBoxType;
   
   public class Connection implements ICommandSender
   {
      
      [Inject]
      public static var clientLog:IClientLog;
      
      [Inject]
      public static var messageBoxService:IMessageBoxService;
      
      [Inject]
      public static var networkService:INetworkService;
      
      [Inject]
      public static var loaderParams:ILauncherParams;
      
      private static var lastConnectionId:int;
      
      public static const LOG_CHANNEL:String = "connection";
      
      private static const PARAM_CLOSE_ON_ERROR:String = "closeonerror";
      
      private var _id:int;
      
      private var socket:Socket;
      
      private var protocol:IProtocol;
      
      private var commandHandler:ICommandHandler;
      
      private var host:String;
      
      private var ports:Vector.<int>;
      
      private var portIndex:int;
      
      private var connected:Boolean = false;
      
      private var dataBuffer:ByteArray = new ByteArray();
      
      private var currentPacketPosition:int;
      
      private var commandCodec:ICodec;
      
      public function Connection(param1:IProtocol, param2:ICodec, param3:ICommandHandler)
      {
         super();
         this.commandCodec = param2;
         this.protocol = param1;
         this.commandHandler = param3;
         this._id = lastConnectionId++;
         this.socket = new Socket();
         this.socket.addEventListener(Event.CLOSE,this.onSockedClose);
         this.socket.addEventListener(Event.CONNECT,this.onSocketConnect);
         this.socket.addEventListener(IOErrorEvent.IO_ERROR,this.onSocketError);
         this.socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onSocketError);
         this.socket.addEventListener(ProgressEvent.SOCKET_DATA,this.onSocketData);
      }
      
      public function connect(param1:String, param2:Vector.<int>) : void
      {
         this.host = param1;
         this.ports = param2;
         this.moveLastSuccessfulPortToFront();
         this.portIndex = -1;
         this.tryNextPort();
      }
      
      public function close(param1:ConnectionCloseStatus, param2:String = null) : void
      {
         this.connected = false;
         this.socket.flush();
         this.socket.close();
         this.commandHandler.onConnectionClose(param1,param2);
      }
      
      public function sendCommand(param1:Object) : void
      {
         var buffer:ByteArray = null;
         var protocolBuffer:ProtocolBuffer = null;
         var message:String = null;
         var command:Object = param1;
         if(this.connected)
         {
            try
            {
               buffer = new ByteArray();
               protocolBuffer = new ProtocolBuffer(buffer,buffer,new OptionalMap());
               this.commandCodec.encode(protocolBuffer,command);
               buffer.position = 0;
               this.protocol.wrapPacket(this.socket,protocolBuffer,CompressionType.DEFLATE_AUTO);
               this.socket.flush();
            }
            catch(error:Error)
            {
               message = "Connection::sendCommand(): " + error.message + ", " + error.getStackTrace();
               messageBoxService.showMessage(MessageBoxType.ERROR,"",message,0);
            }
         }
      }
      
      public function get id() : int
      {
         return this._id;
      }
      
      private function moveLastSuccessfulPortToFront() : void
      {
         var _loc2_:Number = NaN;
         var _loc1_:int = int(networkService.getLastPort(this.host));
         if(_loc1_ > 0)
         {
            _loc2_ = this.ports.indexOf(_loc1_);
            if(_loc2_ >= 0)
            {
               this.ports.splice(_loc2_,1);
               this.ports.unshift(_loc1_);
            }
         }
      }
      
      private function tryNextPort() : void
      {
         var _loc1_:String = null;
         ++this.portIndex;
         if(this.portIndex < this.ports.length)
         {
            this.socket.connect(this.host,this.ports[this.portIndex]);
         }
         else
         {
            _loc1_ = "Cannot establish connection (host: " + this.host + ", ports: " + this.ports + ")";
            messageBoxService.showMessage(MessageBoxType.ERROR,"",_loc1_,0);
         }
      }
      
      private function onSocketConnect(param1:Event) : void
      {
         this.connected = true;
         networkService.saveLastPort(this.host,this.ports[this.portIndex]);
         this.commandCodec.init(this.protocol);
         this.commandHandler.onConnectionOpen(this);
      }
      
      private function onSockedClose(param1:Event) : void
      {
         this.close(ConnectionCloseStatus.CLOSED_BY_SERVER);
      }
      
      private function onSocketData(param1:ProgressEvent) : void
      {
         this.socket.readBytes(this.dataBuffer,this.dataBuffer.length);
         this.processDataBuffer();
      }
      
      private function processDataBuffer() : void
      {
         var byteArray:ByteArray = null;
         var packetData:ProtocolBuffer = null;
         var command:Object = null;
         this.dataBuffer.position = this.currentPacketPosition;
         if(this.dataBuffer.bytesAvailable == 0)
         {
            return;
         }
         while(true)
         {
            byteArray = new ByteArray();
            packetData = new ProtocolBuffer(byteArray,byteArray,new OptionalMap());
            if(!this.protocol.unwrapPacket(this.dataBuffer,packetData))
            {
               return;
            }
            ByteArray(packetData.reader).position = 0;
            while(Boolean(packetData.reader.bytesAvailable))
            {
               command = null;
               try
               {
                  command = this.commandCodec.decode(packetData);
                  if(command == null)
                  {
                     throw new Error("Decoded command is null");
                  }
               }
               catch(e:Error)
               {
                  handleDataProcessingError("Connection::processDataBuffer() command decoding error: " + e.message + ", " + e.getStackTrace());
                  break;
               }
               this.commandHandler.executeCommand(command);
            }
            if(this.dataBuffer.bytesAvailable == 0)
            {
               this.dataBuffer.clear();
               this.currentPacketPosition = 0;
               return;
            }
            this.currentPacketPosition = this.dataBuffer.position;
         }
      }
      
      private function handleDataProcessingError(param1:String) : void
      {
         if(loaderParams.isDebug)
         {
            messageBoxService.showMessage(MessageBoxType.ERROR,"",param1,0);
         }
         if(Boolean(loaderParams.getParameter(PARAM_CLOSE_ON_ERROR)))
         {
            this.close(ConnectionCloseStatus.DATA_PROCESSING_ERROR,param1);
         }
      }
      
      private function onSocketError(param1:ErrorEvent) : void
      {
         if(this.connected)
         {
            this.connected = false;
            messageBoxService.showMessage(MessageBoxType.ERROR,"","Connection closed because of socket error.",0);
            this.commandHandler.onConnectionClose(ConnectionCloseStatus.CONNECTION_ERROR,param1.text);
         }
         else
         {
            this.tryNextPort();
         }
      }
   }
}

