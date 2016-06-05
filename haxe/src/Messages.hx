@:publicFields
class Messages {
    // custom
    static var StartAnimation(default,never) = new Message<{delay:Float}>("start_animation");
    static var Reset(default,never) = new Message<Void>("reset");
    static var DeleteSpawn(default,never) = new Message<{id:Hash}>("delete_spawn");
    static var SetSpeed(default,never) = new Message<{speed:Float}>("set_speed");
}
