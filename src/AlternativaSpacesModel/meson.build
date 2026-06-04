alternativaspacesmodel_sources = files(
    'alternativa/init/SpacesModelsActivator.as',
    'platform/clients/fp10/models/alternativaspacesmodels/Activator.as',

    'alternativa/model/general/dispatcher/DispatcherModel.as',
    'alternativa/model/general/quadro/IQuadro.as',
    'alternativa/model/general/quadro/IQuadroAdapt.as',
    'alternativa/model/general/quadro/IQuadroEvents.as',
    'alternativa/model/general/quadro/QuadroModel.as',
    
    'alternativa/protocol/codec/ModelDataCodecHook.as',
)

lib_alternativaspacesmodel = custom_target(
    'AlternativaSpacesModel.swc',
    output: 'AlternativaSpacesModel.swc',
    input: alternativaspacesmodel_sources,
    command: [
        compc,
        '-source-path=' + meson.current_source_dir(),
        '-output=@OUTPUT@',
        
        '-external-library-path',
        lib_osgibase,
        lib_alternativaosgi,
        lib_alternativaprotocol,
        lib_alternativaclient,
        lib_spacesmodelsbase,
        lib_resourcemodelsbase,
        
        '-include-sources',
        '@INPUT@',

        '--'
    ],
    build_by_default: true
)
