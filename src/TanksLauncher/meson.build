tankslauncher_sources = files(
    'alternativa/tanks/services/background/BackgroundService.as',
    'alternativa/tanks/services/background/BackgroundService_bitmapBg.as',
    'alternativa/tanks/services/background/IBackgroundService.as',
    'IncludedLibrary.as',
    'ProgressBar.as',
    'TanksLauncher.as'
)

tankslauncher = custom_target(
    'Tanks.swc',
    output: 'Tanks.swc',
    input: tankslauncher_sources,
    command: [
        mxmlc,
        '-source-path=' + meson.current_source_dir(),
        '-output=@OUTPUT@',
        '-swf-version=13',
        
        '-include-libraries',
        lib_osgibase,
        lib_alternativaosgi,
        
        '--',
        meson.current_source_dir() / 'TanksLauncher.as'
    ],
    build_by_default: true
)
