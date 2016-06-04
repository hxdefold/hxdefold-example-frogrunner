package defold;

import haxe.extern.EitherType;

/**
    Manipulation of game objects and core hooks for Lua script logic.
**/
@:native("go")
extern class Go {
    static function animate(url:EitherType<Hash,EitherType<String,Url>>, property:EitherType<Hash,String>, playback:Playback, to:EitherType<Vector3,EitherType<Quaternion,Float>>, easing:EitherType<Easing,Vector3>, duration:Float, ?delay:Float, ?complete_function:Void->Void):Void;

    static function get_id(?path:String):Hash;
    static function get_position(?name:String):Vector3;
    static function set_position(pos:Vector3, ?name:String):Void;
    static function property(name:String, def:Dynamic):Void;
    @:overload(function(hash:Hash):Void {})
    static function delete():Void;
    static function set(url:EitherType<Hash,EitherType<String,Url>>, id:EitherType<String,Hash>, value:EitherType<Float,EitherType<Hash,EitherType<Url,EitherType<Vector3,EitherType<Quaternion,Bool>>>>>):Void;
}
