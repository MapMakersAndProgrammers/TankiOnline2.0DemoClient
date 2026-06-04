osgibase_sources = files(
    'alternativa/ILauncherListener.as',
    'alternativa/Launcher.as',

    'alternativa/osgi/OSGi.as',
    'alternativa/osgi/service/clientlog/IClientLogBase.as',
    'alternativa/osgi/bundle/IBundleActivator.as',
    'alternativa/osgi/bundle/IBundleDescriptor.as',

    'alternativa/startup/ConnectionParameters.as',
    'alternativa/startup/IClientConfigurator.as',
    'alternativa/startup/LibraryInfo.as',

    'alternativa/utils/LoaderUtils.as',
    'alternativa/utils/Properties.as'
)

lib_osgibase = custom_target(
    'OSGiBase.swc',
    output: 'OSGiBase.swc',
    input: osgibase_sources,
    command: [
        compc,
        '-source-path=' + meson.current_source_dir(),
        '-output=@OUTPUT@',

        '-include-sources',
        '@INPUT@',

        '--'
    ],
    build_by_default: true
)