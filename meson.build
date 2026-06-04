project(
    'Tanki Online 2.0',
    version : '2.0.0',
    meson_version : '>=1.3'
)

compc = find_program('compc', required: true)
mxmlc = find_program('mxmlc', required: true)

#
# Projects
#
subdir('src/OSGiBase')
subdir('src/AlternativaOSGi')
subdir('src/AlternativaMath')
subdir('src/AlternativaPhysics')
subdir('src/AlternativaProtocol')
subdir('src/A3DModelsBase')
subdir('src/Alternativa3D')
subdir('src/ResourceModelsBase')
subdir('src/AlternativaClient')
subdir('src/SpacesModelsBase')
subdir('src/AlternativaSpacesModel')
subdir('src/Tanks')

subdir('src/TanksTestingTool')
subdir('src/TanksLauncher')