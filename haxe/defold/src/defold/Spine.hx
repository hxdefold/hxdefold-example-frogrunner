package defold;

import defold.support.HashOrString;

@:native("spine")
extern class Spine {
    static function cancel(url:Url):Void;
    static function get_go(url:Url, bone_id:HashOrString):Hash;
    static function play(url:Url, animation_id:HashOrString, playback:Playback, blend_duration:Float, ?complete_function:Void->Void):Void;
    static function reset_constant(url:Url, name:HashOrString):Void;
    static function set_constant(url:Url, name:HashOrString, value:Vector4):Void;
    static function set_ik_target(url:Url, ik_constraint_id:HashOrString, target_url:Url):Void;
    static function set_ik_target_position(url:Url, ik_constraint_id:HashOrString, position:Vector3):Void;
}
