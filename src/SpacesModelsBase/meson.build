spacesmodelsbase_sources = files(
    'platform/client/core/general/spaces/osgi/Activator.as',
    
    'junit/model/ITestModelBase.as',
    'junit/model/TestModelBase.as',
    'junit/model/TestModelServer.as',
    'junit/persistent/collection/ITestRedisCollectionModelBase.as',
    'junit/persistent/collection/TestRedisCollectionModelBase.as',
    'junit/persistent/collection/TestRedisCollectionModelServer.as',

    'platform/client/core/general/spaces/models/dispatcher/DispatcherModelBase.as',
    'platform/client/core/general/spaces/models/dispatcher/DispatcherModelServer.as',
    'platform/client/core/general/spaces/models/dispatcher/IDispatcherModelBase.as',
    'platform/client/core/general/spaces/models/dispatcher/LoadObjectStruct.as',
    'platform/client/core/general/spaces/models/dispatcher/ModelData.as',

    'platform/client/core/general/spaces/models/quadro/IQuadroModelBase.as',
    'platform/client/core/general/spaces/models/quadro/QuadroModelBase.as',
    'platform/client/core/general/spaces/models/quadro/QuadroModelCC.as',
    'platform/client/core/general/spaces/models/quadro/QuadroModelServer.as',
    'platform/client/core/general/spaces/models/quadro/Test.as',
    'platform/client/core/general/spaces/models/quadrosimple/IQuadroSimpleModelBase.as',
    'platform/client/core/general/spaces/models/quadrosimple/QuadroSimpleModelBase.as',
    'platform/client/core/general/spaces/models/quadrosimple/QuadroSimpleModelCC.as',
    'platform/client/core/general/spaces/models/quadrosimple/QuadroSimpleModelServer.as',
    
    'platform/client/core/general/spaces/models/tests/mapping/IMappingModelBase.as',
    'platform/client/core/general/spaces/models/tests/mapping/MappingModelBase.as',
    'platform/client/core/general/spaces/models/tests/mapping/MappingModelServer.as',
    'platform/client/core/general/spaces/models/tests/pingpong/IPingPongModelBase.as',
    'platform/client/core/general/spaces/models/tests/pingpong/PingPongModelBase.as',
    'platform/client/core/general/spaces/models/tests/pingpong/PingPongModelServer.as',
    'platform/client/core/general/spaces/models/tests/selfunload/ISelfUnloadModelBase.as',
    'platform/client/core/general/spaces/models/tests/selfunload/SelfUnloadModelBase.as',
    'platform/client/core/general/spaces/models/tests/selfunload/SelfUnloadModelCC.as',
    'platform/client/core/general/spaces/models/tests/selfunload/SelfUnloadModelServer.as',
    
    '_codec/platform/client/core/general/spaces/models/dispatcher/CodecLoadObjectStruct.as',
    '_codec/platform/client/core/general/spaces/models/dispatcher/CodecModelData.as',
    '_codec/platform/client/core/general/spaces/models/dispatcher/VectorCodecLoadObjectStructLevel1.as',
    '_codec/platform/client/core/general/spaces/models/dispatcher/VectorCodecLoadObjectStructLevel2.as',
    '_codec/platform/client/core/general/spaces/models/dispatcher/VectorCodecLoadObjectStructLevel3.as',
    '_codec/platform/client/core/general/spaces/models/dispatcher/VectorCodecModelDataLevel1.as',
    '_codec/platform/client/core/general/spaces/models/dispatcher/VectorCodecModelDataLevel2.as',
    '_codec/platform/client/core/general/spaces/models/dispatcher/VectorCodecModelDataLevel3.as',
    '_codec/platform/client/core/general/spaces/models/quadro/CodecQuadroModelCC.as',
    '_codec/platform/client/core/general/spaces/models/quadro/CodecTest.as',
    '_codec/platform/client/core/general/spaces/models/quadro/VectorCodecQuadroModelCCLevel1.as',
    '_codec/platform/client/core/general/spaces/models/quadro/VectorCodecQuadroModelCCLevel2.as',
    '_codec/platform/client/core/general/spaces/models/quadro/VectorCodecQuadroModelCCLevel3.as',
    '_codec/platform/client/core/general/spaces/models/quadro/VectorCodecTestLevel1.as',
    '_codec/platform/client/core/general/spaces/models/quadro/VectorCodecTestLevel2.as',
    '_codec/platform/client/core/general/spaces/models/quadro/VectorCodecTestLevel3.as',
    '_codec/platform/client/core/general/spaces/models/quadrosimple/CodecQuadroSimpleModelCC.as',
    '_codec/platform/client/core/general/spaces/models/quadrosimple/VectorCodecQuadroSimpleModelCCLevel1.as',
    '_codec/platform/client/core/general/spaces/models/quadrosimple/VectorCodecQuadroSimpleModelCCLevel2.as',
    '_codec/platform/client/core/general/spaces/models/quadrosimple/VectorCodecQuadroSimpleModelCCLevel3.as',
    '_codec/platform/client/core/general/spaces/models/tests/selfunload/CodecSelfUnloadModelCC.as',
    '_codec/platform/client/core/general/spaces/models/tests/selfunload/VectorCodecSelfUnloadModelCCLevel1.as',
    '_codec/platform/client/core/general/spaces/models/tests/selfunload/VectorCodecSelfUnloadModelCCLevel2.as',
    '_codec/platform/client/core/general/spaces/models/tests/selfunload/VectorCodecSelfUnloadModelCCLevel3.as'
)

lib_spacesmodelsbase = custom_target(
    'SpacesModelsBase.swc',
    output: 'SpacesModelsBase.swc',
    input: spacesmodelsbase_sources,
    command: [
        compc,
        '-source-path=' + meson.current_source_dir(),
        '-output=@OUTPUT@',
        
        '-external-library-path',
        lib_osgibase,
        lib_alternativaosgi,
        lib_alternativaprotocol,
        lib_alternativaclient,
        lib_resourcemodelsbase,
        
        '-include-sources',
        '@INPUT@',

        '--'
    ],
    build_by_default: true
)
