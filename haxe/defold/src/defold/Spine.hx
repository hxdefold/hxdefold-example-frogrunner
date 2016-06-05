package defold;

import haxe.extern.EitherType;

@:native("spine")
extern class Spine {
    static function play(url:EitherType<String,Url>, animation_id:EitherType<String,Hash>, playback:Playback, blend_duration:Float, ?complete_function:Void->Void):Void;
}
