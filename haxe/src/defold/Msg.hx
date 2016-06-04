package defold;

import haxe.extern.EitherType;

@:native("msg")
extern class Msg {
    static function post<T>(receiver:EitherType<Url,EitherType<String,Hash>>, message_id:Message<T>, ?message:T):Void;

    @:overload(function():Url {})
    @:overload(function(socket:String, path:EitherType<String,Hash>, fragment:EitherType<String,Hash>):Url {})
    static function url(urlstring:String):Url;
}
