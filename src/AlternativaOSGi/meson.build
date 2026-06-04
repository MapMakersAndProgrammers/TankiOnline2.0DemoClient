alternativaosgi_sources = files(
    'alternativa/ClientConfigurator.as',
    'alternativa/osgi/bundle/BundleDescriptor.as',
    
    'alternativa/osgi/service/clientlog/ClientLog.as',
    'alternativa/osgi/service/clientlog/ClientLogChannel.as',
    'alternativa/osgi/service/clientlog/IClientLog.as',
    'alternativa/osgi/service/clientlog/IClientLogChannelListener.as',
    
    'alternativa/osgi/service/console/ClientLogConnector.as',
    'alternativa/osgi/service/console/Console.as',
    'alternativa/osgi/service/console/IConsole.as',
    'alternativa/osgi/service/console/variables/ConsoleVar.as',
    'alternativa/osgi/service/console/variables/ConsoleVarFloat.as',
    'alternativa/osgi/service/console/variables/ConsoleVarInt.as',
    'alternativa/osgi/service/console/variables/ConsoleVarString.as',
    
    'alternativa/osgi/service/dump/dumper/BundleDumper.as',
    'alternativa/osgi/service/dump/dumper/ServiceDumper.as',
    'alternativa/osgi/service/dump/DumpService.as',
    'alternativa/osgi/service/dump/IDumper.as',
    'alternativa/osgi/service/dump/IDumpService.as',

    'alternativa/osgi/service/display/Display.as',
    'alternativa/osgi/service/display/IDisplay.as',
    
    'alternativa/osgi/service/launcherparams/ILauncherParams.as',
    'alternativa/osgi/service/launcherparams/LauncherParams.as',
    
    'alternativa/osgi/service/locale/ILocaleService.as',
    'alternativa/osgi/service/locale/LocaleService.as',
    
    'alternativa/osgi/service/network/INetworkService.as',
    'alternativa/osgi/service/network/NetworkService.as',
    
    'alternativa/utils/CircularStringBuffer.as',
    'alternativa/utils/ICircularStringBuffer.as',
    'alternativa/utils/IStringBufferIterator.as',
    'alternativa/utils/SharedObjectWrapper.as'
)

lib_alternativaosgi = custom_target(
    'AlternativaOSGi.swc',
    output: 'AlternativaOSGi.swc',
    input: alternativaosgi_sources,
    command: [
        compc,
        '-source-path=' + meson.current_source_dir(),
        '-output=@OUTPUT@',
        
        '-external-library-path',
        lib_osgibase,
        
        '-include-sources',
        '@INPUT@',

        '--'
    ],
    build_by_default: true
)