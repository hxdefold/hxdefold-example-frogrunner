package defold;

extern class Vector4 {
    var x:Float;
    var y:Float;
    var z:Float;
    var w:Float;

    inline function add(other:Vector4):Vector4 {
        return untyped __lua__("({0}) + ({1})", this, other);
    }

    inline function sub(other:Vector4):Vector4 {
        return untyped __lua__("({0}) - ({1})", this, other);
    }

    inline function mul(v:Float):Vector4 {
        return untyped __lua__("({0}) * ({1})", this, v);
    }
}
