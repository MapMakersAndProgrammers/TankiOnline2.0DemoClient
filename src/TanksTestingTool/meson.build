tankstestingtool_sources = files(
    'TanksTestingTool.as',

    'Preloader_EmbedPreloader.as',
    'Preloader_EmbedPreloaderA.as',
    'Preloader_EmbedProgress.as',
    'Preloader.as',
    
    'tankshudDemo/TanksHudDemo.as',
    'tankshudDemo/TanksHudDemo_bottomLeftIconClass.as',
    'tankshudDemo/TanksHudDemo_fullScreenState1Class.as',
    'tankshudDemo/TanksHudDemo_fullScreenState2Class.as',
    'tankshudDemo/TanksHudDemo_nextTankState1Class.as',
    'tankshudDemo/TanksHudDemo_nextTankState2Class.as',
    'tankshudDemo/TanksHudDemo_topLeftIconClass.as',
    'tankshudDemo/TanksHudDemo_topRightIconClass.as',

    'alternativa/tanks/InitBattleTask.as',
    'alternativa/tanks/TankTestTask.as',
    'alternativa/tanks/TankParams.as',
    'alternativa/tanks/display/DebugPanel.as',
    
    'alternativa/tanks/config/BlobCategory.as',
    'alternativa/tanks/config/BlobGroup.as',
    'alternativa/tanks/config/BlobLibrary.as',
    'alternativa/tanks/config/Config.as',
    'alternativa/tanks/config/loaders/BlobsLoaderTask.as',
    'alternativa/tanks/config/loaders/ImageSequenceLoader.as',
    'alternativa/tanks/config/loaders/SoundsLibrary.as',
    'alternativa/tanks/config/loaders/tankparts/ITankPartLoaderFactory.as',
    'alternativa/tanks/config/loaders/tankparts/TankHullLoader.as',
    'alternativa/tanks/config/loaders/tankparts/TankHullLoaderFactory.as',
    'alternativa/tanks/config/loaders/tankparts/TankPartLoader.as',
    'alternativa/tanks/config/loaders/tankparts/TankTurretLoader.as',
    'alternativa/tanks/config/loaders/tankparts/TankTurretLoaderFactory.as',
    'alternativa/tanks/config/loaders/TankPartsBatchLoader.as',
    'alternativa/tanks/config/ResourceLoader.as',
    'alternativa/tanks/config/StringUtils.as',
    'alternativa/tanks/config/TankPartsLibrary.as',
    'alternativa/tanks/config/TextureLibrary.as',
    
    'alternativa/tanks/sounds/ChassisSoundCallback.as',
    'alternativa/tanks/sounds/FlamethrowerSoundWeaponCallback.as',
    'alternativa/tanks/sounds/SoundInstantShotWeaponCallback.as',
    'alternativa/tanks/sounds/TurretSoundCallback.as'
)

tankstestingtool = custom_target(
    'tanki2.swf',
    output: 'tanki2.swf',
    input: tankstestingtool_sources,
    command: [
        mxmlc,
        '-source-path=' + meson.current_source_dir(),
        '-output=@OUTPUT@',
        '-swf-version=13',
        
        '-include-libraries',
        lib_tanks,
        lib_alternativa3d,
        lib_alternativamath,
        lib_alternativaphysics,
        lib_alternativaosgi,
        lib_alternativaprotocol,
        lib_osgibase,
        lib_a3dmodelsbase,

        '--',
        meson.current_source_dir() / 'TanksTestingTool.as'
    ],
    build_by_default: true
)
