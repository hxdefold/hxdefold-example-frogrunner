package defold;

import haxe.extern.EitherType;

@:native("factory")
extern class Factory {
    static function create(url:EitherType<String,Url>, ?position:Vector3, ?rotation:Quaternion, ?properties:lua.Table.AnyTable, ?scale:EitherType<Float,Vector3>):Hash;
}
