resourcemodelsbase_sources = files(
    'platform/client/core/general/resource/osgi/Activator.as',

    'platform/core/general/resource/types/image/ResourceImageParams.as',
    'platform/core/general/resource/types/imageframe/ResourceImageFrameParams.as',
    'platform/core/general/resource/types/l10n/protocol/BooleanPair.as',
    'platform/core/general/resource/types/l10n/protocol/DoublePair.as',
    'platform/core/general/resource/types/l10n/protocol/ImagePair.as',
    'platform/core/general/resource/types/l10n/protocol/IntPair.as',
    'platform/core/general/resource/types/l10n/protocol/LocaleStruct.as',
    'platform/core/general/resource/types/l10n/protocol/StringPair.as',
    'platform/core/general/resource/types/swf/ResourceSWFParams.as',
    
    '_codec/platform/core/general/resource/types/image/CodecResourceImageParams.as',
    '_codec/platform/core/general/resource/types/image/VectorCodecResourceImageParamsLevel1.as',
    '_codec/platform/core/general/resource/types/image/VectorCodecResourceImageParamsLevel2.as',
    '_codec/platform/core/general/resource/types/image/VectorCodecResourceImageParamsLevel3.as',
    '_codec/platform/core/general/resource/types/imageframe/CodecResourceImageFrameParams.as',
    '_codec/platform/core/general/resource/types/imageframe/VectorCodecResourceImageFrameParamsLevel1.as',
    '_codec/platform/core/general/resource/types/imageframe/VectorCodecResourceImageFrameParamsLevel2.as',
    '_codec/platform/core/general/resource/types/imageframe/VectorCodecResourceImageFrameParamsLevel3.as',
    '_codec/platform/core/general/resource/types/l10n/protocol/CodecBooleanPair.as',
    '_codec/platform/core/general/resource/types/l10n/protocol/CodecDoublePair.as',
    '_codec/platform/core/general/resource/types/l10n/protocol/CodecImagePair.as',
    '_codec/platform/core/general/resource/types/l10n/protocol/CodecIntPair.as',
    '_codec/platform/core/general/resource/types/l10n/protocol/CodecLocaleStruct.as',
    '_codec/platform/core/general/resource/types/l10n/protocol/CodecStringPair.as',
    '_codec/platform/core/general/resource/types/l10n/protocol/VectorCodecBooleanPairLevel1.as',
    '_codec/platform/core/general/resource/types/l10n/protocol/VectorCodecBooleanPairLevel2.as',
    '_codec/platform/core/general/resource/types/l10n/protocol/VectorCodecBooleanPairLevel3.as',
    '_codec/platform/core/general/resource/types/l10n/protocol/VectorCodecDoublePairLevel1.as',
    '_codec/platform/core/general/resource/types/l10n/protocol/VectorCodecDoublePairLevel2.as',
    '_codec/platform/core/general/resource/types/l10n/protocol/VectorCodecDoublePairLevel3.as',
    '_codec/platform/core/general/resource/types/l10n/protocol/VectorCodecImagePairLevel1.as',
    '_codec/platform/core/general/resource/types/l10n/protocol/VectorCodecImagePairLevel2.as',
    '_codec/platform/core/general/resource/types/l10n/protocol/VectorCodecImagePairLevel3.as',
    '_codec/platform/core/general/resource/types/l10n/protocol/VectorCodecIntPairLevel1.as',
    '_codec/platform/core/general/resource/types/l10n/protocol/VectorCodecIntPairLevel2.as',
    '_codec/platform/core/general/resource/types/l10n/protocol/VectorCodecIntPairLevel3.as',
    '_codec/platform/core/general/resource/types/l10n/protocol/VectorCodecLocaleStructLevel1.as',
    '_codec/platform/core/general/resource/types/l10n/protocol/VectorCodecLocaleStructLevel2.as',
    '_codec/platform/core/general/resource/types/l10n/protocol/VectorCodecLocaleStructLevel3.as',
    '_codec/platform/core/general/resource/types/l10n/protocol/VectorCodecStringPairLevel1.as',
    '_codec/platform/core/general/resource/types/l10n/protocol/VectorCodecStringPairLevel2.as',
    '_codec/platform/core/general/resource/types/l10n/protocol/VectorCodecStringPairLevel3.as',
    '_codec/platform/core/general/resource/types/swf/CodecResourceSWFParams.as',
    '_codec/platform/core/general/resource/types/swf/VectorCodecResourceSWFParamsLevel1.as',
    '_codec/platform/core/general/resource/types/swf/VectorCodecResourceSWFParamsLevel2.as',
    '_codec/platform/core/general/resource/types/swf/VectorCodecResourceSWFParamsLevel3.as'
)

lib_resourcemodelsbase = custom_target(
    'ResourceModelsBase.swc',
    output: 'ResourceModelsBase.swc',
    input: resourcemodelsbase_sources,
    command: [
        compc,
        '-source-path=' + meson.current_source_dir(),
        '-output=@OUTPUT@',
        
        '-external-library-path',
        lib_osgibase,
        lib_alternativaosgi,
        lib_alternativaprotocol,
        
        '-include-sources',
        '@INPUT@',

        '--'
    ],
    build_by_default: true
)
