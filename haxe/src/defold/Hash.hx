package defold;

extern class Hash {
    static inline function hash(s:String):Hash {
        return untyped __lua__("hash({0})", s);
    }
}
