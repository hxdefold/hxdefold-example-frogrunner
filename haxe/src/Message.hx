abstract Message<T>(haxe.extern.EitherType<Hash,String>) {
    public inline function new(s:String) this = Hash.hash(s);
}
