alternativaphysics_sources = files(
    'alternativa/physics/Body.as',
    'alternativa/physics/BodyList.as',
    'alternativa/physics/BodyListItem.as',
    'alternativa/physics/BodyMaterial.as',
    'alternativa/physics/BodyState.as',

    'alternativa/physics/Contact.as',
    'alternativa/physics/ContactPoint.as',
    'alternativa/physics/PhysicsScene.as',
    'alternativa/physics/PhysicsUtils.as',

    'alternativa/physics/collision/primitives/CollisionBox.as',
    'alternativa/physics/collision/primitives/CollisionRect.as',
    'alternativa/physics/collision/primitives/CollisionSphere.as',
    'alternativa/physics/collision/primitives/CollisionTriangle.as',

    'alternativa/physics/collision/colliders/BoxBoxCollider.as',
    'alternativa/physics/collision/colliders/BoxCollider.as',
    'alternativa/physics/collision/colliders/BoxRectCollider.as',
    'alternativa/physics/collision/colliders/BoxSphereCollider.as',
    'alternativa/physics/collision/colliders/BoxTriangleCollider.as',
    'alternativa/physics/collision/colliders/SphereSphereCollider.as',
    
    'alternativa/physics/collision/CollisionKdNode.as',
    'alternativa/physics/collision/CollisionKdTree.as',
    'alternativa/physics/collision/CollisionKdTree2D.as',
    'alternativa/physics/collision/CollisionPrimitive.as',
    'alternativa/physics/collision/IBodyCollisionFilter.as',
    'alternativa/physics/collision/ICollider.as',
    'alternativa/physics/collision/ICollisionDetector.as',
    'alternativa/physics/collision/IPrimitiveCollisionFilter.as',
    'alternativa/physics/collision/IRaycastFilter.as',
    'alternativa/physics/collision/KdTreeCollisionDetector.as',
    
    'alternativa/physics/collision/types/BoundBox.as',
    'alternativa/physics/collision/types/RayHit.as',
    
    'alternativa/physics/CollisionPrimitiveList.as',
    'alternativa/physics/CollisionPrimitiveListItem.as',
    
    'alternativa/physics/constraints/Constraint.as'
)

lib_alternativaphysics = custom_target(
    'AlternativaPhysics.swc',
    output: 'AlternativaPhysics.swc',
    input: alternativaphysics_sources,
    command: [
        compc,
        '-source-path=' + meson.current_source_dir(),
        '-output=@OUTPUT@',
        
        '-external-library-path',
        lib_alternativamath,
        
        '-include-sources',
        '@INPUT@',

        '--'
    ],
    build_by_default: true
)