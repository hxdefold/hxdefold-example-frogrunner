package defold;

extern class Vector3 {
    var x:Float;
    var y:Float;
    var z:Float;

    inline function add(other:Vector3):Vector3 {
        return untyped __lua__("({0}) + ({1})", this, other);
    }

    inline function sub(other:Vector3):Vector3 {
        return untyped __lua__("({0}) - ({1})", this, other);
    }

    inline function mul(v:Float):Vector3 {
        return untyped __lua__("({0}) * ({1})", this, v);
    }
}
