alternativamath_sources = files(
    'alternativa/math/Matrix3.as',
    'alternativa/math/Matrix4.as',
    'alternativa/math/Quaternion.as',
    'alternativa/math/Vector3.as'
)

lib_alternativamath = custom_target(
    'AlternativaMath.swc',
    output: 'AlternativaMath.swc',
    input: alternativamath_sources,
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