components {
  id: "script"
  component: "/haxe/out/scripts/Hero.script"
  position {
    x: 0.0
    y: 0.0
    z: 0.0
  }
  rotation {
    x: 0.0
    y: 0.0
    z: 0.0
    w: 1.0
  }
}
embedded_components {
  id: "collisionobject"
  type: "collisionobject"
  data: "collision_shape: \"\"\ntype: COLLISION_OBJECT_TYPE_KINEMATIC\nmass: 0.0\nfriction: 0.1\nrestitution: 0.5\ngroup: \"hero\"\nmask: \"geometry\"\nmask: \"danger\"\nmask: \"pickup\"\nembedded_collision_shape {\n  shapes {\n    shape_type: TYPE_SPHERE\n    position {\n      x: 19.259203\n      y: 44.958054\n      z: 0.0\n    }\n    rotation {\n      x: 0.0\n      y: 0.0\n      z: 0.0\n      w: 1.0\n    }\n    index: 0\n    count: 1\n  }\n  shapes {\n    shape_type: TYPE_BOX\n    position {\n      x: 2.3038335\n      y: 20.081001\n      z: 0.0\n    }\n    rotation {\n      x: 0.0\n      y: 0.0\n      z: 0.0\n      w: 1.0\n    }\n    index: 1\n    count: 3\n  }\n  data: 24.378775\n  data: 20.268076\n  data: 25.022179\n  data: 10.0\n}\nlinear_damping: 0.0\nangular_damping: 0.0\nlocked_rotation: false\n"
  position {
    x: 0.0
    y: 0.0
    z: 0.0
  }
  rotation {
    x: 0.0
    y: 0.0
    z: 0.0
    w: 1.0
  }
}
embedded_components {
  id: "spinemodel"
  type: "spinemodel"
  data: "spine_scene: \"/hero/hero.spinescene\"\ndefault_animation: \"run_right\"\nskin: \"\"\nblend_mode: BLEND_MODE_ALPHA\nmaterial: \"/builtins/materials/spine.material\"\n"
  position {
    x: 0.0
    y: 0.0
    z: 0.0
  }
  rotation {
    x: 0.0
    y: 0.0
    z: 0.0
    w: 1.0
  }
}
