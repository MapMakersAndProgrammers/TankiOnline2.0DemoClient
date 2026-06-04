alternativaprotocol_sources = files(
    'platform/clients/fp10/libraries/alternativaprotocol/Activator.as',
    'alternativa/protocol/osgi/ProtocolActivator.as',
    
    'alternativa/protocol/CompressionType.as',
    'alternativa/protocol/ICodec.as',
    'alternativa/protocol/ICodecInfo.as',
    'alternativa/protocol/codec/OptionalCodecDecorator.as',
    
    'alternativa/protocol/codec/complex/ByteArrayCodec.as',
    'alternativa/protocol/codec/complex/SimpleStringCodec.as',
    'alternativa/protocol/codec/complex/StringCodec.as',
    
    'alternativa/protocol/codec/primitive/BooleanCodec.as',
    'alternativa/protocol/codec/primitive/ByteCodec.as',
    'alternativa/protocol/codec/primitive/DoubleCodec.as',
    'alternativa/protocol/codec/primitive/FloatCodec.as',
    'alternativa/protocol/codec/primitive/IntCodec.as',
    'alternativa/protocol/codec/primitive/IPrimitiveCodec.as',
    'alternativa/protocol/codec/primitive/LongCodec.as',
    'alternativa/protocol/codec/primitive/ShortCodec.as',
    'alternativa/protocol/codec/primitive/UByteCodec.as',
    'alternativa/protocol/codec/primitive/UIntCodec.as',
    'alternativa/protocol/codec/primitive/UShortCodec.as',
    
    'alternativa/protocol/IProtocol.as',
    'alternativa/protocol/OptionalMap.as',
    'alternativa/protocol/ProtocolBuffer.as',

    'alternativa/protocol/impl/LengthCodecHelper.as',
    'alternativa/protocol/impl/OptionalMapCodecHelper.as',
    'alternativa/protocol/impl/PacketHelper.as',
    'alternativa/protocol/impl/Protocol.as',

    'alternativa/protocol/info/CodecInfo.as',
    'alternativa/protocol/info/CollectionCodecInfo.as',
    'alternativa/protocol/info/EnumCodecInfo.as',
    'alternativa/protocol/info/TypeCodecInfo.as',
    
    'alternativa/types/Byte.as',
    'alternativa/types/Float.as',
    'alternativa/types/Long.as',
    'alternativa/types/Short.as',
    'alternativa/types/UByte.as',
    'alternativa/types/UShort.as',

    '_codec/unsigned/VectorCodecintLevel1.as',
    '_codec/unsigned/VectorCodecintLevel2.as',
    '_codec/unsigned/VectorCodecintLevel3.as',
    '_codec/unsigned/VectorCodeclongLevel1.as',
    '_codec/unsigned/VectorCodeclongLevel2.as',
    '_codec/unsigned/VectorCodeclongLevel3.as',
    '_codec/unsigned/VectorCodecshortLevel1.as',
    '_codec/unsigned/VectorCodecshortLevel2.as',
    '_codec/unsigned/VectorCodecshortLevel3.as',

    '_codec/VectorCodecbyteLevel1.as',
    '_codec/VectorCodecbyteLevel2.as',
    '_codec/VectorCodecbyteLevel3.as',
    '_codec/VectorCodecfloatLevel1.as',
    '_codec/VectorCodecfloatLevel2.as',
    '_codec/VectorCodecfloatLevel3.as',
    '_codec/VectorCodecintLevel1.as',
    '_codec/VectorCodecintLevel2.as',
    '_codec/VectorCodecintLevel3.as',
    '_codec/VectorCodeclongLevel1.as',
    '_codec/VectorCodeclongLevel2.as',
    '_codec/VectorCodeclongLevel3.as',
    '_codec/VectorCodecshortLevel1.as',
    '_codec/VectorCodecshortLevel2.as',
    '_codec/VectorCodecshortLevel3.as',
    '_codec/VectorCodecStringLevel1.as',
    '_codec/VectorCodecStringLevel2.as',
    '_codec/VectorCodecStringLevel3.as'
)

lib_alternativaprotocol = custom_target(
    'AlternativaProtocol.swc',
    output: 'AlternativaProtocol.swc',
    input: alternativaprotocol_sources,
    command: [
        compc,
        '-source-path=' + meson.current_source_dir(),
        '-output=@OUTPUT@',
        
        '-external-library-path',
        lib_osgibase,
        lib_alternativaosgi,
        
        '-include-sources',
        '@INPUT@',

        '--'
    ],
    build_by_default: true
)